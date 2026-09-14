package com.ruoyi.web.core.ecat;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * ECAT 安装路径解析，供「备份还原」引导页使用。
 *
 * <p>背景：后端（ecat-backend 服务）由 NSSM 以 {@code AppDirectory = {APP_ROOT}\app\backend\ecat-backend}
 * 启动，因此 JVM 的 {@code user.dir} 就是后端目录。这里自下而上探测安装根目录，而不是把层级写死，
 * 以免安装布局调整后静默失效。</p>
 *
 * <p>引导页只做两件事：展示快照信息、唤起守护工具的「备份还原」页。
 * 它<b>不</b>执行命令行备份——服务进程运行在会话 0，直接启动控制台程序既无界面也无法交互。</p>
 */
public final class EcatInstallPaths
{
    /** 守护工具（含备份还原页）。 */
    public static final String GUARDIAN_EXE_NAME = "EcatGuardian.exe";

    /** 控制台版备份工具：仅供脚本调用，本页不执行它，仅用于向用户提示其位置。 */
    public static final String CONSOLE_EXE_NAME = "ecat-backup.exe";

    /** 计划任务名（安装包在登录时创建，动作固定为 --autostart）。 */
    public static final String GUARDIAN_TASK_NAME = "EcatGuardian";

    /** 主程序页请求「打开备份还原页」的标记文件（与 EcatGuardian 约定）。 */
    public static final String OPEN_BACKUP_TAB_MARKER = ".open-backup-tab";

    /** 备份维护锁（与 EcatGuardian 约定，存在即表示正在备份/还原）。 */
    public static final String MAINTENANCE_LOCK = ".maintenance.lock";

    private static final String VERSION_FILE_RELATIVE = "system/config/EcatVersion.txt";
    private static final int MAX_WALK_UP = 6;

    private final Path appRoot;
    private final Path backendHome;
    private final Path ecatDataDir;

    private EcatInstallPaths(Path appRoot, Path backendHome, Path ecatDataDir)
    {
        this.appRoot = appRoot;
        this.backendHome = backendHome;
        this.ecatDataDir = ecatDataDir;
    }

    /**
     * 解析当前安装的路径。任何一项探测不到都会返回 {@code null}（例如开发环境直接跑 Spring Boot），
     * 调用方据此把引导页降级为「仅说明」，而不是抛异常。
     */
    public static EcatInstallPaths resolve()
    {
        Path backendHome = detectBackendHome();
        Path appRoot = detectAppRoot(backendHome);
        Path ecatDataDir = detectEcatDataDir(appRoot, backendHome);
        return new EcatInstallPaths(appRoot, backendHome, ecatDataDir);
    }

    /** 安装根目录（如 {@code D:\EcatPlatform}），探测失败为 null。 */
    public Path getAppRoot()
    {
        return appRoot;
    }

    /** 后端程序目录（含 ecat-backend.jar 与 .env），探测失败为 null。 */
    public Path getBackendHome()
    {
        return backendHome;
    }

    /** 应用数据目录 {数据根}\ecat（快照与标记文件所在处），探测失败为 null。 */
    public Path getEcatDataDir()
    {
        return ecatDataDir;
    }

    /** 快照根目录 {数据根}\ecat\backups。 */
    public Path getBackupRoot()
    {
        return ecatDataDir == null ? null : ecatDataDir.resolve("backups");
    }

    /** 数据根目录 {数据根}（即 ecat 的上一级），用于展示。 */
    public Path getDataRoot()
    {
        return ecatDataDir == null ? null : ecatDataDir.getParent();
    }

    /** 守护工具可执行文件，找不到时为 null。 */
    public Path getGuardianExe()
    {
        if (appRoot == null)
        {
            return null;
        }
        Path exe = appRoot.resolve("bin").resolve(GUARDIAN_EXE_NAME);
        return Files.isRegularFile(exe) ? exe : null;
    }

    /** 控制台版备份工具，找不到时为 null。 */
    public Path getConsoleExe()
    {
        if (appRoot == null)
        {
            return null;
        }
        Path exe = appRoot.resolve("bin").resolve(CONSOLE_EXE_NAME);
        return Files.isRegularFile(exe) ? exe : null;
    }

    /** 程序版本（读 system/config/EcatVersion.txt 的 APP_VERSION），读不到为 null。 */
    public String readAppVersion()
    {
        if (appRoot == null)
        {
            return null;
        }
        try
        {
            Path versionFile = appRoot.resolve(VERSION_FILE_RELATIVE);
            if (!Files.isRegularFile(versionFile))
            {
                return null;
            }
            for (String rawLine : Files.readAllLines(versionFile, StandardCharsets.UTF_8))
            {
                String line = rawLine.trim();
                int idx = line.indexOf(':');
                if (idx <= 0)
                {
                    continue;
                }
                String key = line.substring(0, idx).trim();
                if ("APP_VERSION".equalsIgnoreCase(key))
                {
                    return line.substring(idx + 1).trim();
                }
            }
        }
        catch (Exception ignored)
        {
            // 版本仅用于展示，失败不影响功能
        }
        return null;
    }

    /** 标记文件路径；ecatDataDir 未知时为 null。 */
    public Path getOpenBackupTabMarker()
    {
        return ecatDataDir == null ? null : ecatDataDir.resolve(OPEN_BACKUP_TAB_MARKER);
    }

    /** 维护锁路径；ecatDataDir 未知时为 null。 */
    public Path getMaintenanceLock()
    {
        return ecatDataDir == null ? null : ecatDataDir.resolve(MAINTENANCE_LOCK);
    }

    /** 当前是否正在备份/还原（维护锁存在且未过期）。 */
    public boolean isMaintenanceRunning()
    {
        Path lock = getMaintenanceLock();
        if (lock == null || !Files.exists(lock))
        {
            return false;
        }
        try
        {
            long ageMs = System.currentTimeMillis() - Files.getLastModifiedTime(lock).toMillis();
            // 超过 6 小时视为遗留锁，与 EcatGuardian 的判定保持一致
            return ageMs < 6L * 60 * 60 * 1000;
        }
        catch (Exception ignored)
        {
            return false;
        }
    }

    // ------------------------------------------------------------------ 探测

    /**
     * 后端目录：优先取 user.dir（NSSM 的 AppDirectory 正是它），
     * 若不像是后端目录，则自 user.dir 向上找含 ecat-backend.jar 或 .env 的目录。
     */
    private static Path detectBackendHome()
    {
        Path start = toPath(System.getProperty("user.dir"));
        if (start == null)
        {
            return null;
        }
        for (Path candidate : walkUp(start))
        {
            if (Files.isRegularFile(candidate.resolve("ecat-backend.jar"))
                    || Files.isRegularFile(candidate.resolve(".env")))
            {
                return candidate;
            }
        }
        return start;
    }

    /**
     * 安装根目录：ECAT_APP_ROOT 显式指定优先；否则自后端目录向上找带
     * {@code bin/EcatGuardian.exe} 或 {@code system/config/install.config} 的目录，
     * 并以 install.config 里的 APP_ROOT 为准（与守护工具 InstallInfo.Load 保持一致）。
     */
    private static Path detectAppRoot(Path backendHome)
    {
        Path explicit = toPath(firstNonBlank(System.getProperty("ECAT_APP_ROOT"), System.getenv("ECAT_APP_ROOT")));
        if (explicit != null && looksLikeAppRoot(explicit))
        {
            return explicit;
        }

        Path start = backendHome != null ? backendHome : toPath(System.getProperty("user.dir"));
        if (start == null)
        {
            return null;
        }
        for (Path candidate : walkUp(start))
        {
            Path configFile = findInstallConfig(candidate);
            if (configFile != null)
            {
                // install.config 是安装期写入的权威来源，优先信它记录的 APP_ROOT
                Path declared = toPath(readKeyValue(configFile, "APP_ROOT"));
                if (declared != null && looksLikeAppRoot(declared))
                {
                    return declared;
                }
                return candidate;
            }
            if (looksLikeAppRoot(candidate))
            {
                return candidate;
            }
        }
        return null;
    }

    private static Path findInstallConfig(Path appRoot)
    {
        Path primary = appRoot.resolve("system").resolve("config").resolve("install.config");
        if (Files.isRegularFile(primary))
        {
            return primary;
        }
        Path fallback = appRoot.resolve("tools").resolve("install.config");
        return Files.isRegularFile(fallback) ? fallback : null;
    }

    private static boolean looksLikeAppRoot(Path dir)
    {
        return Files.isRegularFile(dir.resolve("bin").resolve(GUARDIAN_EXE_NAME))
                || findInstallConfig(dir) != null;
    }

    /**
     * 应用数据目录 {数据根}\ecat（快照与标记文件所在处）。
     *
     * <p>取值顺序与守护工具一致：install.config 的 DATA_ROOT 优先，其次 .env 的 ECAT_DATA_PATH，
     * 最后退回 {安装根}\data\ecat。守护工具的 EcatAppDataDir 同样是 {@code {DATA_ROOT}\ecat}，
     * 两边必须算出同一路径，否则标记文件与快照会各写一处。</p>
     */
    private static Path detectEcatDataDir(Path appRoot, Path backendHome)
    {
        if (appRoot != null)
        {
            Path configFile = findInstallConfig(appRoot);
            if (configFile != null)
            {
                Path dataRoot = toPath(readKeyValue(configFile, "DATA_ROOT"));
                if (dataRoot != null)
                {
                    return dataRoot.resolve("ecat");
                }
            }
        }

        String fromEnv = firstNonBlank(System.getProperty("ECAT_DATA_PATH"), System.getenv("ECAT_DATA_PATH"));
        if (isBlank(fromEnv) && backendHome != null)
        {
            fromEnv = readKeyValue(backendHome.resolve(".env"), "ECAT_DATA_PATH");
        }
        Path parsed = toPath(fromEnv);
        if (parsed != null)
        {
            return parsed;
        }
        if (appRoot != null)
        {
            return appRoot.resolve("data").resolve("ecat");
        }
        return null;
    }

    /**
     * 读取 {@code KEY=VALUE} 形式的配置文件（.env 与 install.config 都是这个格式），
     * 容忍 {@code KEY = "value"} 这类写法：去空白、去包围引号。
     */
    public static String readKeyValue(Path file, String key)
    {
        if (file == null || !Files.isRegularFile(file))
        {
            return null;
        }
        try
        {
            for (String rawLine : Files.readAllLines(file, StandardCharsets.UTF_8))
            {
                String line = rawLine.trim();
                if (line.isEmpty() || line.startsWith("#"))
                {
                    continue;
                }
                int idx = line.indexOf('=');
                if (idx <= 0)
                {
                    continue;
                }
                if (!line.substring(0, idx).trim().equalsIgnoreCase(key))
                {
                    continue;
                }
                String value = line.substring(idx + 1).trim();
                if (value.length() >= 2
                        && ((value.startsWith("\"") && value.endsWith("\""))
                            || (value.startsWith("'") && value.endsWith("'"))))
                {
                    value = value.substring(1, value.length() - 1);
                }
                return value.trim();
            }
        }
        catch (Exception ignored)
        {
            // .env 读不到时返回 null，由调用方回退
        }
        return null;
    }

    private static List<Path> walkUp(Path start)
    {
        List<Path> result = new ArrayList<Path>();
        Path current = start;
        for (int i = 0; i <= MAX_WALK_UP && current != null; i++)
        {
            result.add(current);
            current = current.getParent();
        }
        return result;
    }

    private static Path toPath(String value)
    {
        if (isBlank(value))
        {
            return null;
        }
        try
        {
            return Paths.get(value.trim()).toAbsolutePath().normalize();
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    private static boolean isBlank(String value)
    {
        return value == null || value.trim().isEmpty();
    }

    private static String firstNonBlank(String... values)
    {
        if (values == null)
        {
            return null;
        }
        for (String value : values)
        {
            if (!isBlank(value))
            {
                return value;
            }
        }
        return null;
    }

    /** 目录是否可写（引导页需要写标记文件，提前判断可给出准确提示）。 */
    public static boolean isWritable(Path dir)
    {
        if (dir == null)
        {
            return false;
        }
        try
        {
            if (!Files.isDirectory(dir))
            {
                return false;
            }
            File probe = dir.resolve(".write-probe-" + System.nanoTime()).toFile();
            if (probe.createNewFile())
            {
                return probe.delete();
            }
        }
        catch (Exception ignored)
        {
            // 交给调用方按 false 处理
        }
        return false;
    }
}
