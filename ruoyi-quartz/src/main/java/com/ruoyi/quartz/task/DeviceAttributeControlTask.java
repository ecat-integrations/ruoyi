package com.ruoyi.quartz.task;

import com.ecat.core.EcatCore;
import com.ruoyi.quartz.service.ISysJobService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 设备控制定时任务
 *
 * <p>参考首页设备控制编排中的"设备操作"：对指定设备属性写入新值。
 * invokeTarget 格式：DeviceAttributeControlTask.run('deviceId','attributeId','value')
 *
 * @author dreamfalls
 */
@Component("DeviceAttributeControlTask")
public class DeviceAttributeControlTask
{
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;

    private static final Logger log = LoggerFactory.getLogger(DeviceAttributeControlTask.class);

    /**
     * 对设备属性写入新值
     *
     * @param deviceId    设备ID
     * @param attributeId 属性ID
     * @param value       目标值
     */
    public void run(String triggerType, String deviceId, String attributeId, String value) {
        try {
            if (deviceId == null || deviceId.isEmpty()) {
                log.error("设备控制任务失败：设备ID为空");
                return;
            }
            if (core.getDeviceRegistry().getDeviceByID(deviceId) == null) {
                log.error("设备控制任务失败：设备不存在 {}", deviceId);
                return;
            }
            if (attributeId == null || attributeId.isEmpty()) {
                log.error("设备控制任务失败：属性ID为空");
                return;
            }
            if (core.getDeviceRegistry().getDeviceByID(deviceId).getAttrs().get(attributeId) == null) {
                log.error("设备控制任务失败：属性不存在 deviceId={}, attributeId={}", deviceId, attributeId);
                return;
            }
            log.info("========== RUN DeviceAttributeControlTask ==========");
            log.info("设备控制任务执行：deviceId={}, attributeId={}, value={}", deviceId, attributeId, value);
            core.getDeviceRegistry().getDeviceByID(deviceId).getAttrs()
                    .get(attributeId).setDisplayValue(value);
            log.info("设备控制任务执行成功");
            log.info("========== END DeviceAttributeControlTask ==========");
        } catch (Exception e) {
            log.error("设备控制任务执行异常：deviceId={}, attributeId={}, value={}", deviceId, attributeId, value, e);
        }
    }
}
