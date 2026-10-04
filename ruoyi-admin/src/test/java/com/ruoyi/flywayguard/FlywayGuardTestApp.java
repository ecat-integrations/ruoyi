package com.ruoyi.flywayguard;

import java.lang.reflect.Proxy;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Bean;

/**
 * flyway 让位守护测试的窄上下文载体：只带自动配置激活面，不扫业务组件。
 * 排除 DataSourceAutoConfiguration 与主应用同款（RuoYiApplication 因自管
 * Druid 数据源而排除），并自供一个"不可取连"的桩 DataSource——flyway 自动
 * 配置的激活条件（单候选 DataSource 存在）由此满足，使「flyway 类可见→
 * 自动配置激活」的缺陷形态可在此复现。
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class FlywayGuardTestApp {

    @Bean
    public DataSource guardDataSource() {
        return (DataSource) Proxy.newProxyInstance(FlywayGuardTestApp.class.getClassLoader(),
                new Class<?>[] { DataSource.class },
                (proxy, method, args) -> {
                    throw new SQLException("guard: 本窄上下文只验证自动配置激活面，不应取连接");
                });
    }
}
