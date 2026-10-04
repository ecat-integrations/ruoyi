package com.ruoyi.system.service.impl;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.lang.reflect.Field;
import java.lang.reflect.Proxy;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.postgresql.util.PSQLState;
import org.postgresql.util.PSQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.BadSqlGrammarException;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.read.ListAppender;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.system.domain.SysConfig;
import com.ruoyi.system.mapper.SysConfigMapper;
import com.ruoyi.system.mapper.SysDictDataMapper;

/**
 * 空库自举守护单测：急切缓存启动装载（sys_config / sys_dict）对「表尚不存在」容错。
 *
 * 背景：ruoyi-sys 表由桥侧迁移在建，而迁移要先拿到 Spring 就绪后的 DataSource，
 * 急切缓存 @PostConstruct 又在 Spring 就绪前直查表——递归依赖使空机起点结构性不可达。
 * 守护契约（三态锁死）：
 * ① 表缺失（PostgreSQL SQLState 42P01，桥迁移完成前的确定形态）→ 跳过装载不崩启动，
 *    且 WARN 日志显形（表建好后经键访问回填或下次重启全量装载）；
 * ② 其余数据访问异常（语法错、连不上等）原样上抛，不吞（严格模式）；
 * ③ 表在且有数据 → 缓存照常装载（修复不伤既有装载功能）。
 */
public class EagerCacheStartupTableMissingTest {

    /** 异常链构造：Spring 翻译后的真实形态（BadSqlGrammarException 包 PSQLException） */
    private static BadSqlGrammarException grammarException(String table, PSQLState state) {
        PSQLException cause = new PSQLException(
                "ERROR: relation \"" + table + "\" does not exist", state);
        String sql = "select * from " + table;
        return new BadSqlGrammarException("query", sql, cause);
    }

    /** 单方法定向桩：指定方法抛给定异常，其余方法显式失败（不静默） */
    private static Object oneShotMapper(Class<?> mapperInterface, String method, RuntimeException ex) {
        return Proxy.newProxyInstance(EagerCacheStartupTableMissingTest.class.getClassLoader(),
                new Class<?>[] { mapperInterface },
                (proxy, m, args) -> {
                    if (m.getName().equals(method)) {
                        throw ex;
                    }
                    throw new UnsupportedOperationException("本用例仅触发启动装载路径: " + m.getName());
                });
    }

    private static void setField(Object target, String name, Object value) throws Exception {
        Field field = target.getClass().getDeclaredField(name);
        field.setAccessible(true);
        field.set(target, value);
    }

    /** 直挂 ListAppender 捕获目标类 logger 输出（内存 appender，不经 logback.xml 过滤链） */
    private static ListAppender<ILoggingEvent> attachAppender(Class<?> loggerOwner) {
        LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
        ListAppender<ILoggingEvent> appender = new ListAppender<>();
        appender.start();
        context.getLogger(loggerOwner).addAppender(appender);
        return appender;
    }

    /** 只摘本测试挂的 appender，不动 logback.xml 配置的全局 appender */
    private static void detachAppender(Class<?> loggerOwner, ListAppender<ILoggingEvent> appender) {
        LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
        context.getLogger(loggerOwner).detachAppender(appender);
    }

    private static boolean hasWarnContaining(List<ILoggingEvent> events, String fragment) {
        return events.stream().anyMatch(
                e -> e.getLevel() == Level.WARN && e.getFormattedMessage().contains(fragment));
    }

    @Test
    public void configTableMissing_skipLoadingAndLogVisibly() throws Exception {
        ListAppender<ILoggingEvent> appender = attachAppender(SysConfigServiceImpl.class);
        try {
            SysConfigServiceImpl service = new SysConfigServiceImpl();
            setField(service, "configMapper", oneShotMapper(SysConfigMapper.class, "selectConfigList",
                    grammarException("sys_config", PSQLState.UNDEFINED_TABLE)));
            setField(service, "redisCache", new RecordingRedisCache());

            service.init(); // 不抛即通过：空库起点启动不崩

            assertTrue("表缺失跳过必须日志显形(含表名)",
                    hasWarnContaining(appender.list, "sys_config"));
        } finally {
            detachAppender(SysConfigServiceImpl.class, appender);
        }
    }

    @Test
    public void configOtherDataError_mustPropagate() throws Exception {
        SysConfigServiceImpl service = new SysConfigServiceImpl();
        setField(service, "configMapper", oneShotMapper(SysConfigMapper.class, "selectConfigList",
                grammarException("sys_config", PSQLState.SYNTAX_ERROR)));
        setField(service, "redisCache", new RecordingRedisCache());

        try {
            service.init();
            fail("非表缺失异常必须原样上抛，不得吞没（严格模式）");
        } catch (BadSqlGrammarException expected) {
            assertTrue(((SQLException) expected.getCause()).getSQLState().equals("42601"));
        }
    }

    @Test
    public void configTablePresent_cacheLoadsAsBefore() throws Exception {
        RecordingRedisCache redis = new RecordingRedisCache();
        SysConfigServiceImpl service = new SysConfigServiceImpl();
        Object mapper = Proxy.newProxyInstance(getClass().getClassLoader(),
                new Class<?>[] { SysConfigMapper.class },
                (proxy, m, args) -> {
                    if (m.getName().equals("selectConfigList")) {
                        SysConfig row = new SysConfig();
                        row.setConfigKey("sys.account.captchaEnabled");
                        row.setConfigValue("true");
                        List<SysConfig> rows = new ArrayList<>();
                        rows.add(row);
                        return rows;
                    }
                    throw new UnsupportedOperationException("本用例仅触发启动装载路径: " + m.getName());
                });
        setField(service, "configMapper", mapper);
        setField(service, "redisCache", redis);

        service.init();

        assertFalse("表在且有数据时缓存必须照常装载（修复不伤既有功能）", redis.keys.isEmpty());
        assertTrue("装载键必须落在参数缓存前缀下",
                redis.keys.get(0).startsWith(CacheConstants.SYS_CONFIG_KEY));
    }

    @Test
    public void dictTableMissing_skipLoadingAndLogVisibly() throws Exception {
        ListAppender<ILoggingEvent> appender = attachAppender(SysDictTypeServiceImpl.class);
        try {
            SysDictTypeServiceImpl service = new SysDictTypeServiceImpl();
            setField(service, "dictDataMapper", oneShotMapper(SysDictDataMapper.class, "selectDictDataList",
                    grammarException("sys_dict_data", PSQLState.UNDEFINED_TABLE)));

            service.init(); // 不抛即通过

            assertTrue("表缺失跳过必须日志显形(含表名)",
                    hasWarnContaining(appender.list, "sys_dict"));
        } finally {
            detachAppender(SysDictTypeServiceImpl.class, appender);
        }
    }

    @Test
    public void dictOtherDataError_mustPropagate() throws Exception {
        SysDictTypeServiceImpl service = new SysDictTypeServiceImpl();
        setField(service, "dictDataMapper", oneShotMapper(SysDictDataMapper.class, "selectDictDataList",
                grammarException("sys_dict_data", PSQLState.SYNTAX_ERROR)));

        try {
            service.init();
            fail("非表缺失异常必须原样上抛，不得吞没（严格模式）");
        } catch (BadSqlGrammarException expected) {
            assertTrue(((SQLException) expected.getCause()).getSQLState().equals("42601"));
        }
    }

    /** 记录型 RedisCache 桩：只捕获写入键，不触真实 redis */
    private static class RecordingRedisCache extends RedisCache {
        final List<String> keys = new ArrayList<>();

        @Override
        public <T> void setCacheObject(final String key, final T value) {
            keys.add(key);
        }
    }
}
