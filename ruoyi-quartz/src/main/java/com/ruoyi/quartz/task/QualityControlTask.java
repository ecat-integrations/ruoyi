package com.ruoyi.quartz.task;

import com.ecat.core.EcatCore;
import com.ecat.core.Integration.IIntegrationTaskManagement;

import com.ecat.core.Task.Task;
import com.ruoyi.quartz.service.ISysJobService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 定时任务调度测试
 * 
 * @author ruoyi
 */
@Component("qualityControlTask")
public class QualityControlTask
{
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;

    private static final Logger log = LoggerFactory.getLogger(QualityControlTask.class);

    public void run(String triggerType, String parameter, String qualityControlType, String calculatedValue){

        IIntegrationTaskManagement envQualityControlTask = (IIntegrationTaskManagement) core.getIntegrationRegistry()
                .getIntegration("integration-env-quality-control-manager");
        Task wantedTask = envQualityControlTask.getTaskExecutor().getTask("EnvQualityControlTask");

        // 数值转化
        try {
            calculatedValue = calculatedValue.replaceAll("[‘’]", "");
        } catch (NumberFormatException e) {
            log.error("Failed to parse double from string: {}", calculatedValue, e);
            throw new IllegalArgumentException("Invalid integer value: " + calculatedValue);
        }
        // 整合参数
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("triggerType", triggerType);
        parameters.put("taskType", triggerType);
        parameters.put("qualityControlType", qualityControlType);
        parameters.put("parameter", parameter);
        parameters.put("calculatedValue", Double.valueOf(calculatedValue));

        parameters.put("core", core);
        parameters.put("taskName", wantedTask.getTaskName());
        parameters.put("taskDescription", wantedTask.getDescription());
        // parameters.put("taskLastParameters", wantedTask.getLastParameters());
        // 执行任务
        log.info("========== RUN "  + wantedTask.getTaskName() + " ==========");
        log.info(triggerType.equals("1")? "手动触发" : "定时触发" + "task parameters： " + parameters);
        log.info("task LastParameters ： " + wantedTask.getLastParameters());
        wantedTask.execute(parameters);
        log.info("========== END "  + wantedTask.getTaskName() + " ==========");
    }

}
