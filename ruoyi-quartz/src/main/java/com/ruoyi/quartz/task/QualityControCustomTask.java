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
@Component("qualityControlCustomTask")
public class QualityControCustomTask
{
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;

    private static final Logger log = LoggerFactory.getLogger(QualityControCustomTask.class);

    public void run(String triggerType,
                    String gas, String stable_time, String read_data_times, String read_data_time_span,
                    String gas_concentration, String stdGasInPortName){

        IIntegrationTaskManagement envQualityControlCustomTask = (IIntegrationTaskManagement) core.getIntegrationRegistry()
                .getIntegration("integration-env-quality-control-manager");
        Task wantedTask = envQualityControlCustomTask.getTaskExecutor().getTask("EnvQualityControlCustomTask");

        // 整合参数
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("triggerType", triggerType);
        parameters.put("taskType", triggerType);
        parameters.put("qualityControlType", "audit_span_check");
        parameters.put("gas", gas);
        parameters.put("genGasTime", Integer.valueOf(stable_time));
        parameters.put("readDataCount", Integer.valueOf(read_data_times));
        parameters.put("readDataSpan", Integer.valueOf(read_data_time_span));
        float genGasConc = Double.valueOf(gas_concentration).floatValue();
        parameters.put("genGasConc", genGasConc);
        parameters.put("stdGasInPortName", stdGasInPortName);

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
