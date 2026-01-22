package com.ruoyi.quartz.task;

import com.ecat.core.EcatCore;
import com.ecat.core.Integration.IIntegrationTaskManagement;
import com.ecat.core.Task.Task;
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
@Component("patrolTask")
public class PatrolTask
{

    @Autowired
    private EcatCore core;

    private static final Logger log = LoggerFactory.getLogger(PatrolTask.class);

    public void run(String triggerType, String patrolType){
        IIntegrationTaskManagement envPatrolTask = (IIntegrationTaskManagement) core.getIntegrationRegistry()
                .getIntegration("integration-env-patrol-manager");
        Task wantedTask = envPatrolTask.getTaskExecutor().getTask("EnvPatrolTask");

        // 整合参数
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("triggerType", triggerType);
        parameters.put("patrolType", patrolType);
        parameters.put("patrolNotes", "");
        parameters.put("patrolContent", "");

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
