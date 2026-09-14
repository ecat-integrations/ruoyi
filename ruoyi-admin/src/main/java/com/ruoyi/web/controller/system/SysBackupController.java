package com.ruoyi.web.controller.system;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.web.core.ecat.BackupSnapshotReader;
import com.ruoyi.web.core.ecat.EcatInstallPaths;

/**
 * 备份还原（引导入口）。
 *
 * <p>本模块<b>不在后端执行备份命令</b>。后端以 Windows 服务方式运行在会话 0，
 * 直接拉起控制台程序既没有界面、也无法让用户确认「停止服务」这类高影响操作。
 * 因此这里的职责只有三件事：</p>
 * <ol>
 *   <li>把快照现状（数量、时间、内容、是否含数据库）如实展示给管理员；</li>
 *   <li>提供快捷入口，唤起「智慧站房修复更新与守护」的「备份还原」页去真正执行；</li>
 *   <li>给出醒目风险提示与操作方向，避免误操作。</li>
 * </ol>
 *
 * <p>唤起方式：先写标记文件 {@code {数据根}\ecat\.open-backup-tab}（守护程序轮询到即切页，
 * 适用于它已常驻托盘的常见情形），未在运行时再触发登录自启计划任务。</p>
 *
 * @author ecat
 */
@RestController
@RequestMapping("/system/backup")
public class SysBackupController extends BaseController
{
    /** 打开守护工具的「备份还原」页。 */
    @PreAuthorize("@ss.hasPermi('system:backup:open')")
    @Log(title = "备份还原", businessType = BusinessType.OTHER)
    @PostMapping("/open-guardian")
    public AjaxResult openGuardian()
    {
        EcatInstallPaths paths = EcatInstallPaths.resolve();

        Path guardianExe = paths.getGuardianExe();
        Path marker = paths.getOpenBackupTabMarker();
        if (marker == null && guardianExe == null)
        {
            return error("未识别到本机 ECAT 安装目录，无法打开守护工具。请在服务器上直接运行安装目录 bin\\EcatGuardian.exe。");
        }

        boolean markerWritten = writeMarker(marker, getUsername());
        boolean guardianRunning = BackupSnapshotReader.isGuardianRunning();

        String method;
        String message;
        if (guardianRunning && markerWritten)
        {
            // 最常见路径：守护程序常驻托盘，轮询到标记后自行弹出并切页
            method = "marker";
            message = "已请求守护工具打开「备份还原」页，请稍候查看其窗口。若未自动弹出，请双击托盘中的守护图标。";
        }
        else if (!guardianRunning && BackupSnapshotReader.isGuardianTaskRegistered()
                && BackupSnapshotReader.runGuardianTask())
        {
            method = "task";
            message = "已通过计划任务启动守护工具并定位到「备份还原」页，请稍候查看其窗口。";
        }
        else if (markerWritten && BackupSnapshotReader.startGuardianDirect(guardianExe))
        {
            method = "direct";
            message = "已尝试启动守护工具，请在打开的窗口中切到「备份还原」页操作。";
        }
        else
        {
            method = "none";
            message = "无法自动唤起守护工具，请到服务器上打开安装目录下的守护工具，并切到「备份还原」页操作。";
        }

        AjaxResult result = AjaxResult.success(message);
        result.put("method", method);
        result.put("guardianRunning", guardianRunning);
        result.put("markerWritten", markerWritten);
        result.put("backupRoot", paths.getBackupRoot() == null ? "" : paths.getBackupRoot().toString());
        result.put("guardianExe", guardianExe == null ? "" : guardianExe.toString());
        return result;
    }

    /** 引导页展示所需的全部只读信息。 */
    @PreAuthorize("@ss.hasPermi('system:backup:list')")
    @GetMapping("/info")
    public AjaxResult info()
    {
        EcatInstallPaths paths = EcatInstallPaths.resolve();
        Path backupRoot = paths.getBackupRoot();

        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("appRoot", text(paths.getAppRoot()));
        data.put("dataRoot", text(paths.getDataRoot()));
        data.put("ecatDataDir", text(paths.getEcatDataDir()));
        data.put("backupRoot", text(backupRoot));
        data.put("appVersion", paths.readAppVersion());

        Path guardianExe = paths.getGuardianExe();
        Path consoleExe = paths.getConsoleExe();
        data.put("guardianExe", text(guardianExe));
        data.put("guardianInstalled", guardianExe != null);
        data.put("consoleExe", text(consoleExe));
        data.put("consoleExeInstalled", consoleExe != null);
        data.put("taskName", EcatInstallPaths.GUARDIAN_TASK_NAME);

        data.put("guardianRunning", BackupSnapshotReader.isGuardianRunning());
        data.put("taskRegistered", BackupSnapshotReader.isGuardianTaskRegistered());
        data.put("maintenanceRunning", paths.isMaintenanceRunning());
        data.put("maintenanceDetail", BackupSnapshotReader.describeMaintenanceLock(paths.getMaintenanceLock()));
        data.put("backupRootWritable", EcatInstallPaths.isWritable(backupRoot));

        List<Map<String, Object>> snapshots = BackupSnapshotReader.list(backupRoot);
        data.put("snapshots", snapshots);
        data.put("snapshotCount", snapshots.size());
        data.put("latestSnapshotId", snapshots.isEmpty() ? "" : String.valueOf(snapshots.get(0).get("id")));

        // 首次加载时前端直接拿这段文案，便于以后统一调整口径
        // 注意：与页面告警标题互补而非重复——标题只说「会停服」，这里补充后果与前置条件
        data.put("riskNotice",
                "备份期间采集与上报会中断；还原会覆盖当前数据，请务必核对所选快照无误。"
                        + "建议提前通知使用人员，并避开业务高峰时段。");
        data.put("generatedAt", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        return AjaxResult.success(data);
    }

    /** 写标记文件；内容带操作人和时间，便于排查是谁触发的。 */
    private boolean writeMarker(Path marker, String username)
    {
        if (marker == null)
        {
            return false;
        }
        try
        {
            Path parent = marker.getParent();
            if (parent != null && !Files.isDirectory(parent))
            {
                Files.createDirectories(parent);
            }
            String content = "requestedBy=" + (username == null ? "unknown" : username)
                    + "\nrequestedAt=" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
                    + "\nsource=ruoyi:system/backup\n";
            Files.write(marker, content.getBytes(StandardCharsets.UTF_8),
                    StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
            return true;
        }
        catch (IOException ex)
        {
            logger.warn("写入备份页标记文件失败：" + ex.getMessage());
            return false;
        }
    }

    private static String text(Path path)
    {
        return path == null ? "" : path.toString();
    }
}
