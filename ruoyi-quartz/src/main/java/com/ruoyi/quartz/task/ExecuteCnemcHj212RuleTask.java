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
import java.util.HashMap;
import java.util.Map;

/**
 * 执行总站（CNEMC）HJ212 推送任务
 *
 * 调用方式（invokeTarget）示例：
 * ExecuteCnemcHj212RuleTask.run('127.0.0.1', '12345', '10003', '2026-03-01 00:00:00', '2026-03-01 01:00:00', true)
 */
@Component("ExecuteCnemcHj212RuleTask")
public class ExecuteCnemcHj212RuleTask {
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;

    private static final Logger log = LoggerFactory.getLogger(ExecuteCnemcHj212RuleTask.class);

    /**
     * 执行 CNEMC HJ212 推送
     *
     * @param triggerType 触发类型（ruoyi-quartz 会自动在第 1 个参数注入）
     * @param host 服务器地址
     * @param port 服务器端口
     * @param ruleId 规则ID
     * @param start 开始时间字符串
     * @param end 结束时间字符串
     * @param istime 是否使用传入时间
     */
    public void run(String triggerType, String host, String port, String ruleId, String start, String end, Boolean istime) throws ParseException {
        IIntegrationTaskManagement integration = (IIntegrationTaskManagement) core.getIntegrationRegistry()
                .getIntegration("integration-com-hj212-cnemc");
        Task wantedTask = integration.getTaskExecutor().getTask("hj212CnemcTask");

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("triggerType", triggerType);
        parameters.put("host", host);
        parameters.put("port", port);
        parameters.put("startTime", start);
        parameters.put("endTime", end);
        parameters.put("istime", istime);
        parameters.put("ruleId", ruleId);

        log.info("========== RUN {} ==========", wantedTask.getTaskName());
        log.info((triggerType != null && triggerType.equals("1") ? "手动触发" : "定时触发") + " task parameters： " + parameters);
        log.info("执行参数: 触发类型={}, 目标服务器={} 规则ID={}, 开始时间={}, 结束时间={}, 是否使用传入时间={}",
                triggerType, host + ":" + port, ruleId, start, end, istime);
        log.info("task LastParameters ： {}", wantedTask.getLastParameters());
        wantedTask.execute(parameters);
        log.info("========== END {} ==========", wantedTask.getTaskName());
    }
}

