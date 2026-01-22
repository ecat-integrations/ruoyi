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
import java.util.*;

/**
 * 定时任务调度测试
 * 
 * @author ruoyi
 */
@Component("CreatePartitionTablesTask")
public class CreatePartitionTablesTask
{
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;
    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private static final Logger log = LoggerFactory.getLogger(CreatePartitionTablesTask.class);

    private static final List<String> tableList = Arrays.asList("realdata", "his_data");

    public void run(String triggerType,String table,Integer startWeek, Integer endWeek) throws ParseException {

        IIntegrationTaskManagement envQualityControlTask = (IIntegrationTaskManagement) core.getIntegrationRegistry()
                .getIntegration("integration-env-data-handle");
        Task wantedTask = envQualityControlTask.getTaskExecutor().getTask("EnvCreatePartitionTablesTask");
        if(tableList.contains(table)){
            // 整合参数
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("table", table);
            parameters.put("startWeek", startWeek);  // 开始周
            parameters.put("endWeek", endWeek);  // 结束周
            // 执行任务
            log.info("========== RUN "  + wantedTask.getTaskName() + " ==========");
            log.info(triggerType.equals("1")? "手动触发" : "定时触发" + "task parameters： " + parameters);
            log.info("taskName [" + wantedTask.getTaskName() + "] " + (table+"创建分表"));
            log.info("task LastParameters ： " + wantedTask.getLastParameters());
            wantedTask.execute(parameters);
            log.info("========== END "  + wantedTask.getTaskName() + " ==========");
        }else{
            log.error("聚合类型错误");
        }
    }

}
