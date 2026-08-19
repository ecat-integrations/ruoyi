/*
 * Copyright (c) 2026 ECAT Team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.ruoyi.quartz.util;

import com.ecat.core.Utils.Mdc.TraceContext;
import com.ruoyi.common.constant.ScheduleConstants;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.quartz.domain.SysJob;
import com.ruoyi.quartz.service.ISysJobLogService;

import org.junit.Before;
import org.junit.Test;
import org.quartz.JobExecutionContext;
import org.quartz.JobDataMap;

import java.lang.reflect.Proxy;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.Assert.*;

/**
 * quartz 任务作用域 traceId（arch-review 25 号杠杆②）契约：
 * 每次任务执行（execute 漏斗）生成 26 字符 ULID 入 Worker 线程 MDC，
 * 同一次执行内 doExecute/after 全程同 id，执行结束恢复（不残留到线程），
 * 两次执行 id 不同。用 JDK 动态代理桩化 quartz 上下文与 Spring bean 工厂（无 mockito 依赖）。
 *
 * @author coffee
 */
public class AbstractQuartzJobTraceTest {

    private final AtomicInteger logCount = new AtomicInteger();

    @Before
    public void setUp() {
        // after() 写任务日志需 SpringUtils.getBean(ISysJobLogService)：注入桩 bean 工厂
        // 接口含多个查询/维护方法，全量桩化：仅 addJobLog 计数，其余返回 null/默认
        ISysJobLogService stubService = (ISysJobLogService) Proxy.newProxyInstance(
                getClass().getClassLoader(),
                new Class<?>[]{ISysJobLogService.class},
                (proxy, method, args) -> {
                    if ("addJobLog".equals(method.getName())) {
                        logCount.incrementAndGet();
                        return null;
                    }
                    return null;
                });
        Object beanFactory = Proxy.newProxyInstance(
                getClass().getClassLoader(),
                new Class<?>[]{org.springframework.beans.factory.config.ConfigurableListableBeanFactory.class},
                (proxy, method, args) -> {
                    if ("getBean".equals(method.getName()) && args != null && args.length == 1
                            && args[0] instanceof Class) {
                        return stubService;
                    }
                    return null;
                });
        new SpringUtils().postProcessBeanFactory(
                (org.springframework.beans.factory.config.ConfigurableListableBeanFactory) beanFactory);
    }

    private JobExecutionContext stubContext() {
        JobDataMap dataMap = new JobDataMap();
        SysJob props = new SysJob();
        props.setJobName("trace-probe");
        props.setJobGroup("DEFAULT");
        props.setInvokeTarget("traceProbeTask.run()");
        dataMap.put(ScheduleConstants.TASK_PROPERTIES, props);
        return (JobExecutionContext) Proxy.newProxyInstance(
                getClass().getClassLoader(),
                new Class<?>[]{JobExecutionContext.class},
                (proxy, method, args) -> "getMergedJobDataMap".equals(method.getName()) ? dataMap : null);
    }

    /** 每次执行应有 26 字符 ULID（原为 null=红），且执行后恢复线程原 MDC。 */
    @Test
    public void execute_hasUlidTraceIdAndRestoresMdc() throws Exception {
        final String[] seenInExecute = new String[1];
        final String[] seenInAfter = new String[1];
        AbstractQuartzJob job = new AbstractQuartzJob() {
            @Override
            protected void doExecute(JobExecutionContext context, SysJob sysJob) {
                seenInExecute[0] = TraceContext.getTraceId();
            }

            @Override
            protected void after(JobExecutionContext context, SysJob sysJob, Exception e) {
                seenInAfter[0] = TraceContext.getTraceId();
                super.after(context, sysJob, e);
            }
        };

        Map<String, String> previous = TraceContext.capture();
        try {
            job.execute(stubContext());

            assertNotNull("任务执行段应有 traceId", seenInExecute[0]);
            assertEquals(26, seenInExecute[0].length());
            assertEquals("同一次执行内 doExecute/after 应同 id", seenInExecute[0], seenInAfter[0]);
            assertEquals("执行结束应恢复线程原 MDC", previous, TraceContext.capture());
            assertEquals("after 仍正常写任务日志", 1, logCount.get());
        } finally {
            TraceContext.restore(previous);
        }
    }

    /** 两次执行（同一 Job 实例）id 不同——每次任务独立成链。 */
    @Test
    public void twoExecutions_distinctTraceIds() throws Exception {
        final String[] first = new String[1];
        final String[] second = new String[1];
        AbstractQuartzJob job = new AbstractQuartzJob() {
            boolean firstRun = true;
            @Override
            protected void doExecute(JobExecutionContext context, SysJob sysJob) {
                if (firstRun) { first[0] = TraceContext.getTraceId(); firstRun = false; }
                else { second[0] = TraceContext.getTraceId(); }
            }
        };

        job.execute(stubContext());
        job.execute(stubContext());

        assertNotNull(first[0]);
        assertNotNull(second[0]);
        assertNotEquals("两次执行应各自生成 id", first[0], second[0]);
    }
}
