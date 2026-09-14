package com.ruoyi.web.core.ecat;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;

/**
 * 备份快照的只读读取，以及「唤起守护工具」的落地动作。
 *
 * <p>快照由 EcatGuardian 生成，结构为 {@code {数据根}\ecat\backups\backup_yyyyMMdd_HHmmss\}，
 * 内含 {@code manifest.json} 与 {@code 还原说明.txt}。这里只读取、不写入、不删除，
 * 保证主程序侧不会破坏快照；真正的备份/还原动作全部交给守护工具。</p>
 */
public final class BackupSnapshotReader
{
    private static final String MANIFEST = "manifest.json";
    private static final String INSTRUCTIONS = "还原说明.txt";
    private static final String PREFIX = "backup_";
    private static final String TEMP_SUFFIX = ".tmp";

    private BackupSnapshotReader()
    {
    }

    /** 列出快照（最新在前）。目录不存在或无快照时返回空列表。 */
    public static List<Map<String, Object>> list(Path backupRoot)
    {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        if (backupRoot == null || !Files.isDirectory(backupRoot))
        {
            return result;
        }

        File[] dirs = backupRoot.toFile().listFiles();
        if (dirs == null)
        {
            return result;
        }

        for (File dir : dirs)
        {
            if (!dir.isDirectory() || !dir.getName().startsWith(PREFIX)
                    || dir.getName().endsWith(TEMP_SUFFIX))
            {
                continue;
            }
            result.add(readOne(dir));
        }

        Collections.sort(result, new Comparator<Map<String, Object>>()
        {
            @Override
            public int compare(Map<String, Object> left, Map<String, Object> right)
            {
                String a = String.valueOf(left.get("createdAt"));
                String b = String.valueOf(right.get("createdAt"));
                return b.compareTo(a);
            }
        });
        return result;
    }

    private static Map<String, Object> readOne(File dir)
    {
        Map<String, Object> item = new HashMap<String, Object>();
        item.put("id", dir.getName());
        item.put("directory", dir.getAbsolutePath());

        Path manifestPath = dir.toPath().resolve(MANIFEST);
        Path instructionsPath = dir.toPath().resolve(INSTRUCTIONS);
        item.put("instructionsPath", Files.isRegularFile(instructionsPath)
                ? instructionsPath.toAbsolutePath().toString() : null);
        item.put("hasInstructions", Files.isRegularFile(instructionsPath));

        JSONObject manifest = readJson(manifestPath);
        if (manifest == null)
        {
            item.put("valid", Boolean.FALSE);
            item.put("validationMessage", "缺少或无法解析 manifest.json");
            item.put("label", "");
            item.put("createdAt", "");
            item.put("totalBytes", 0L);
            item.put("totalFiles", 0);
            item.put("hasDatabase", Boolean.FALSE);
            item.put("includeMaven", Boolean.FALSE);
            return item;
        }

        String status = manifest.getString("status");
        boolean completed = "completed".equalsIgnoreCase(status);
        item.put("valid", completed);
        if (!completed)
        {
            item.put("validationMessage", "快照未完成（状态：" + status + "）");
        }

        item.put("label", manifest.getString("label"));
        item.put("createdAt", manifest.getString("createdAt"));
        item.put("appVersion", manifest.getString("appVersion"));
        item.put("ruoyiAdminVersion", manifest.getString("ruoyiAdminVersion"));
        item.put("pgDatabase", manifest.getString("pgDatabase"));
        item.put("pgHost", manifest.getString("pgHost"));
        item.put("pgPort", manifest.getString("pgPort"));
        item.put("includeMaven", manifest.getBooleanValue("includeMaven"));

        long totalBytes = manifest.getLongValue("totalBytes");
        int totalFiles = manifest.getIntValue("totalFiles");
        item.put("totalBytes", totalBytes);
        item.put("totalFiles", totalFiles);
        item.put("totalBytesText", formatBytes(totalBytes));

        JSONArray items = manifest.getJSONArray("items");
        List<String> kinds = new ArrayList<String>();
        if (items != null)
        {
            for (int i = 0; i < items.size(); i++)
            {
                JSONObject entry = items.getJSONObject(i);
                if (entry != null && entry.getString("kind") != null)
                {
                    kinds.add(entry.getString("kind"));
                }
            }
        }
        item.put("kinds", kinds);
        item.put("hasDatabase", kinds.contains("database"));
        return item;
    }

    private static JSONObject readJson(Path path)
    {
        if (path == null || !Files.isRegularFile(path))
        {
            return null;
        }
        try
        {
            byte[] bytes = Files.readAllBytes(path);
            String text = new String(bytes, StandardCharsets.UTF_8);
            // DataContractJsonSerializer 可能带 UTF-8 BOM
            if (!text.isEmpty() && text.charAt(0) == '\uFEFF')
            {
                text = text.substring(1);
            }
            return JSONObject.parseObject(text);
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    /** 维护锁存在时，主程序侧应提示「正在备份/还原中」。 */
    public static String describeMaintenanceLock(Path lock)
    {
        if (lock == null || !Files.isRegularFile(lock))
        {
            return null;
        }
        try
        {
            String content = new String(Files.readAllBytes(lock), StandardCharsets.UTF_8).trim();
            long ageMs = System.currentTimeMillis() - Files.getLastModifiedTime(lock).toMillis();
            return content + "（已持续 " + (ageMs / 1000) + " 秒）";
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    /** 守护工具进程是否在运行（按镜像名查询，避免依赖 WMI/Java 版本差异）。 */
    public static boolean isGuardianRunning()
    {
        try
        {
            Process process = new ProcessBuilder("tasklist.exe", "/FI",
                    "IMAGENAME eq " + EcatInstallPaths.GUARDIAN_EXE_NAME, "/NH")
                    .redirectErrorStream(true).start();
            String output = readAll(process, 8);
            process.waitFor(8, TimeUnit.SECONDS);
            return output != null && output.toLowerCase().contains(
                    EcatInstallPaths.GUARDIAN_EXE_NAME.toLowerCase());
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    /** 计划任务是否存在。 */
    public static boolean isGuardianTaskRegistered()
    {
        try
        {
            Process process = new ProcessBuilder("schtasks.exe", "/Query", "/TN",
                    EcatInstallPaths.GUARDIAN_TASK_NAME).redirectErrorStream(true).start();
            String output = readAll(process, 8);
            process.waitFor(8, TimeUnit.SECONDS);
            return process.exitValue() == 0 && output != null && !output.trim().isEmpty();
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    /** 触发已有的登录自启计划任务（在交互会话中启动守护工具）。 */
    public static boolean runGuardianTask()
    {
        try
        {
            Process process = new ProcessBuilder("schtasks.exe", "/Run", "/TN",
                    EcatInstallPaths.GUARDIAN_TASK_NAME).redirectErrorStream(true).start();
            String output = readAll(process, 10);
            process.waitFor(10, TimeUnit.SECONDS);
            int code = process.exitValue();
            return code == 0 && (output == null || !output.contains("错误") || !output.contains("ERROR"));
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    /** 直接启动守护工具（后备方案：仅当后端进程本身处于交互会话时才可见）。 */
    public static boolean startGuardianDirect(Path exe)
    {
        if (exe == null || !Files.isRegularFile(exe))
        {
            return false;
        }
        try
        {
            new ProcessBuilder(exe.toAbsolutePath().toString(), "--tab", "backup")
                    .directory(exe.getParent().toFile())
                    .start();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    private static String readAll(Process process, int timeoutSeconds)
    {
        StringBuilder sb = new StringBuilder();
        try (java.io.InputStream in = process.getInputStream();
                java.io.BufferedReader reader = new java.io.BufferedReader(
                        new java.io.InputStreamReader(in, StandardCharsets.UTF_8)))
        {
            String line;
            while ((line = reader.readLine()) != null)
            {
                sb.append(line).append('\n');
            }
        }
        catch (IOException ignored)
        {
            // 读取失败时按空输出处理
        }
        return sb.toString();
    }

    private static String formatBytes(long bytes)
    {
        if (bytes < 1024L)
        {
            return bytes + " B";
        }
        if (bytes < 1024L * 1024)
        {
            return String.format("%.1f KB", bytes / 1024.0);
        }
        if (bytes < 1024L * 1024 * 1024)
        {
            return String.format("%.1f MB", bytes / 1024.0 / 1024.0);
        }
        return String.format("%.2f GB", bytes / 1024.0 / 1024.0 / 1024.0);
    }
}
