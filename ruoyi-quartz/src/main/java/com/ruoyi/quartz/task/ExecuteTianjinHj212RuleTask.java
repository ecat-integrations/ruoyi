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
 * 天津 HJ212 推送定时任务入口（前时标）。
 * <p>
 * 定时任务 {@code job_group} 应使用字典「数据推送」对应值 {@code ExecuteSiChuanHj212RuleTask}，
 * 与四川推送共用分组以便列表筛选；实际执行 Bean 仍为本类（由 invokeTarget 指定）。
 * host/port 必须与 {@code ComHj212TianjinIntegration.yml} 中 pushtask 的 host:port 一致。
 * </p>
 *
 * <p>调用方式（invokeTarget）示例（ruoyi-quartz 会自动在第 1 个参数注入 triggerType）：</p>
 * <pre>
 * ExecuteTianjinHj212RuleTask.run('192.168.1.219', '4040', '10001', '', '', false)
 * ExecuteTianjinHj212RuleTask.run('192.168.1.219', '4040', '10003', '2026-07-14 09:00:00', '2026-07-14 10:00:00', true)
 * </pre>
 *
 * <p>规则 ID 与配置对应关系：</p>
 * <ul>
 *   <li>10001 - 1分钟推送组（CN=2052）</li>
 *   <li>10002 - 5分钟推送组（CN=2053）</li>
 *   <li>10003 - 1小时推送组（CN=2061）</li>
 *   <li>10004 - 1天推送组（CN=2071）</li>
 *   <li>10005 - 不固定频率推送组（CN=2099）</li>
 *   <li>10006 - 质控组（CN=2099）</li>
 * </ul>
 */
@Component("ExecuteTianjinHj212RuleTask")
public class ExecuteTianjinHj212RuleTask {
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private EcatCore core;

    private static final Logger log = LoggerFactory.getLogger(ExecuteTianjinHj212RuleTask.class);

    private static final String INTEGRATION_ID = "integration-com-hj212-tianjin";
    private static final String TASK_NAME = "executeTianjinHj212RuleTask";

    /**
     * 执行天津 HJ212 推送
     *
     * @param triggerType 触发类型（ruoyi-quartz 会自动在第 1 个参数注入）
     * @param host 服务器地址（须与 pushtask.host 一致）
     * @param port 服务器端口（须与 pushtask.port 一致）
     * @param ruleId 规则ID（10001~10006）
     * @param start 开始时间字符串（yyyy-MM-dd HH:mm:ss，istime=true 时有效）
     * @param end 结束时间字符串（yyyy-MM-dd HH:mm:ss，istime=true 时有效）
     * @param istime 是否使用传入时间
     */
    public void run(String triggerType, String host, String port, String ruleId, String start, String end, Boolean istime) throws ParseException {
        Object integrationObj = core.getIntegrationRegistry().getIntegration(INTEGRATION_ID);
        if (!(integrationObj instanceof IIntegrationTaskManagement)) {
            log.error("天津HJ212集成未加载或不可用: {}，请确认已安装 integration-com-hj212-tianjin", INTEGRATION_ID);
            throw new IllegalStateException("天津HJ212集成未加载: " + INTEGRATION_ID);
        }
        IIntegrationTaskManagement executeHj212RuleTask = (IIntegrationTaskManagement) integrationObj;
        if (executeHj212RuleTask.getTaskExecutor() == null) {
            log.error("天津HJ212任务执行器为空，集成可能尚未 onStart");
            throw new IllegalStateException("天津HJ212 TaskExecutor 未初始化");
        }
        Task wantedTask = executeHj212RuleTask.getTaskExecutor().getTask(TASK_NAME);
        if (wantedTask == null) {
            log.error("找不到天津HJ212推送任务: {}", TASK_NAME);
            throw new IllegalStateException("找不到任务: " + TASK_NAME);
        }

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
