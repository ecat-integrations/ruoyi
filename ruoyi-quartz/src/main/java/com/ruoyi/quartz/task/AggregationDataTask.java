package com.ruoyi.quartz.task;

import com.ecat.core.EcatCore;
import com.ecat.core.Integration.IIntegrationTaskManagement;
import com.ecat.core.Task.Task;
import com.ruoyi.quartz.service.ISysJobService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 定时任务调度测试
 * 
 * @author ruoyi
 */
@Component("aggregationDataTask")
public class AggregationDataTask
{
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;
    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private static final Logger log = LoggerFactory.getLogger(AggregationDataTask.class);

    /**
     * 数据聚合任务执行入口
     * 
     * @param triggerType 触发类型
     * @param aggType 聚合类型（保留参数，用于兼容）
     * @param start 开始时间字符串
     * @param end 结束时间字符串
     * @param istime 是否使用传入时间
     * @param minutes 聚合分钟数（可选，默认5分钟）
     * @param deviceId 设备ID过滤（可选，null表示所有设备）
     * @param attributeId 参数ID过滤（可选，null表示所有参数）
     */
    public void run(String triggerType, String aggType, String start, String end, Boolean istime,
                    Integer minutes, String deviceId, String attributeId) throws ParseException {

        if (core == null) {
            log.error("AggregationDataTask: EcatCore 未注入，无法执行聚合任务");
            return;
        }

        IIntegrationTaskManagement envDataHandle = (IIntegrationTaskManagement) core.getIntegrationRegistry()
                .getIntegration("integration-env-data-handle");
        if (envDataHandle == null) {
            log.error("AggregationDataTask: 未找到集成 integration-env-data-handle（是否未在 ecat 配置中启用或未启动成功）");
            return;
        }

        if (envDataHandle.getTaskExecutor() == null) {
            log.error("AggregationDataTask: integration-env-data-handle 的 TaskExecutor 为 null（集成 onStart 可能未执行或异常中断）");
            return;
        }

        Task wantedTask = envDataHandle.getTaskExecutor().getTask("AggregationTask");
        if (wantedTask == null) {
            log.error("AggregationDataTask: TaskExecutor 中未注册名为 AggregationTask 的任务（请确认 EnvDataHandleIntegration 已 addTask 聚合任务）");
            return;
        }

        // 默认分钟数
        int aggregationMinutes = (minutes != null) ? minutes : 5;

        Date startTime;
        Date endTime;
        if (istime != null && istime) {
            // 使用传入的时间
            startTime = SDF.parse(start);
            endTime = SDF.parse(end);
        } else {
            // 获取当前时间
            Calendar calendar = Calendar.getInstance();
            Date now = calendar.getTime();
            if(aggregationMinutes == 1440){
                calendar.set(Calendar.HOUR_OF_DAY, 0);
            }
            // 计算 endTime：当前所属时间段的上一个时间段的结束时间（即当前时间段的开始时间）
            calendar.set(Calendar.MINUTE, (calendar.get(Calendar.MINUTE) / aggregationMinutes) * aggregationMinutes); // 向下取整
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);
            endTime = calendar.getTime();
            // 计算 startTime：前三个时间段的开始时间
            calendar.add(Calendar.MINUTE, -(aggregationMinutes * 3)); // 向前推3个时间段
            startTime = calendar.getTime();
        }

        // 整合参数
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("triggerType", triggerType);
        parameters.put("startTime", startTime);
        parameters.put("endTime", endTime);
        parameters.put("minutes", aggregationMinutes);
        parameters.put("aggType", aggType);

        // 新增：过滤参数
        if (deviceId != null) {
            parameters.put("deviceId", deviceId);
        }
        if (attributeId != null) {
            parameters.put("attributeId", attributeId);
        }

        // 执行任务
        log.info("========== RUN "  + wantedTask.getTaskName() + " ==========");
        log.info(triggerType.equals("1")? "手动触发" : "定时触发" + "task parameters： " + parameters);
        log.info("聚合参数: 分钟数={}, 设备={}, 参数={}",
                aggregationMinutes,
                deviceId != null ? deviceId : "全部",
                attributeId != null ? attributeId : "全部");
        log.info("task LastParameters ： " + wantedTask.getLastParameters());
        wantedTask.execute(parameters);
        log.info("========== END "  + wantedTask.getTaskName() + " ==========");
    }
    
    /**
     * 保持向后兼容的方法（5个参数）
     */
    public void run(String triggerType, String aggType, String start, String end, Boolean istime) throws ParseException {
        run(triggerType, aggType, start, end, istime, null, null, null);
    }
}
