package com.ruoyi.quartz.service.impl;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.lang.reflect.Field;
import java.lang.reflect.Proxy;

import org.junit.Test;
import org.postgresql.util.PSQLState;
import org.postgresql.util.PSQLException;
import org.quartz.Scheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.BadSqlGrammarException;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.read.ListAppender;

import com.ruoyi.quartz.mapper.SysJobMapper;

/**
 * 空库自举守护单测：定时任务启动装载（sys_job）对「表尚不存在」容错——
 * 与 sys_config/sys_dict 同型：@PostConstruct 直查表，而表由桥侧迁移在
 * Spring 就绪后才建。契约：42P01 表缺失→跳过装载不崩启动+WARN 日志显形；
 * 其余数据访问异常原样上抛（严格模式）。装载功能本身由既有 job trace
 * 测试族与 e2e 覆盖，此处不重复。
 */
public class EagerJobInitTableMissingTest {

    private static BadSqlGrammarException grammarException(String table, PSQLState state) {
        PSQLException cause = new PSQLException(
                "ERROR: relation \"" + table + "\" does not exist", state);
        return new BadSqlGrammarException("query", "select * from " + table, cause);
    }

    /** 定向桩：指定方法抛给定异常，其余显式失败 */
    private static SysJobMapper jobMapperThrowing(String method, RuntimeException ex) {
        return (SysJobMapper) Proxy.newProxyInstance(EagerJobInitTableMissingTest.class.getClassLoader(),
                new Class<?>[] { SysJobMapper.class },
                (proxy, m, args) -> {
                    if (m.getName().equals(method)) {
                        throw ex;
                    }
                    throw new UnsupportedOperationException("本用例仅触发启动装载路径: " + m.getName());
                });
    }

    /** Scheduler 桩：init() 只会调 clear()（RAM store，无需桩化行为），其余显式失败 */
    private static Scheduler ramSchedulerStub() {
        return (Scheduler) Proxy.newProxyInstance(EagerJobInitTableMissingTest.class.getClassLoader(),
                new Class<?>[] { Scheduler.class },
                (proxy, m, args) -> {
                    if (m.getName().equals("clear")) {
                        return null;
                    }
                    throw new UnsupportedOperationException("本用例仅触发启动装载路径: " + m.getName());
                });
    }

    private static void setField(Object target, String name, Object value) throws Exception {
        Field field = target.getClass().getDeclaredField(name);
        field.setAccessible(true);
        field.set(target, value);
    }

    private static SysJobServiceImpl serviceWith(String mapperMethod, RuntimeException ex) throws Exception {
        SysJobServiceImpl service = new SysJobServiceImpl();
        setField(service, "scheduler", ramSchedulerStub());
        setField(service, "jobMapper", jobMapperThrowing(mapperMethod, ex));
        return service;
    }

    @Test
    public void jobTableMissing_skipInitAndLogVisibly() throws Exception {
        LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
        ListAppender<ILoggingEvent> appender = new ListAppender<>();
        appender.start();
        context.getLogger(SysJobServiceImpl.class).addAppender(appender);
        try {
            serviceWith("selectJobAll", grammarException("sys_job", PSQLState.UNDEFINED_TABLE))
                    .init(); // 不抛即通过：空库起点启动不崩

            boolean visible = appender.list.stream().anyMatch(
                    e -> e.getLevel() == Level.WARN && e.getFormattedMessage().contains("sys_job"));
            assertTrue("表缺失跳过必须日志显形(含表名)", visible);
        } finally {
            context.getLogger(SysJobServiceImpl.class).detachAppender(appender);
        }
    }

    @Test
    public void jobOtherDataError_mustPropagate() throws Exception {
        try {
            serviceWith("selectJobAll", grammarException("sys_job", PSQLState.SYNTAX_ERROR)).init();
            fail("非表缺失异常必须原样上抛，不得吞没（严格模式）");
        } catch (BadSqlGrammarException expected) {
            assertTrue("42601".equals(((PSQLException) expected.getCause()).getSQLState()));
        }
    }
}
