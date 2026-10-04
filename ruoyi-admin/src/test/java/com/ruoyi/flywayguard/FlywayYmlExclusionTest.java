package com.ruoyi.flywayguard;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import org.junit.Test;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ConfigurableApplicationContext;

/**
 * flyway 让位守护（迁移单轨语义）：全仓迁移由桥侧 db-migration 统一承载，
 * ruoyi 自带 flyway 必须让位。4.0.0 全形态下 db-migration 把 flyway-core
 * 汇入 core 类加载器层，ruoyi 上下文「见类即激活」FlywayAutoConfiguration，
 * 而本包内无 db/migration 脚本（12 域脚本在域集成 jar 内）→ 启动即崩。
 *
 * 本测以 test classpath 放入 flyway-core 模拟「类可见」形态，加载真实
 * application.yml 起窄上下文：契约=上下文起而不崩，且不产生任何 flyway bean。
 * 失败形态若非 flyway 激活所致则原样上抛，不吞（严格模式）。
 */
public class FlywayYmlExclusionTest {

    @Test
    public void flywayClassVisible_contextMustStartWithoutFlywayActivation() throws Exception {
        // 前置有牙：flyway 类必须真的在测试 classpath，否则本测对「类可见形态」失去证明力
        Class<?> flywayClass;
        try {
            flywayClass = Class.forName("org.flywaydb.core.Flyway");
        } catch (ClassNotFoundException absent) {
            fail("前置失效：flyway-core 不在测试 classpath，本测无法模拟「flyway 类可见」形态");
            return;
        }

        ConfigurableApplicationContext context = null;
        try {
            context = new SpringApplicationBuilder(FlywayGuardTestApp.class)
                    .web(WebApplicationType.NONE)
                    .run(
                            // 窄上下文自足配置（命令行形态=最高优先级，压过 application.yml 的
                            // 环境变量占位符）：redis 自动配置仅建连接工厂（惰性），桩值不外连；
                            // adapter 经其 spring.factories 自动装配进入所有自动配置上下文，
                            // 其依赖的动态注册表 Bean 由主应用组件扫描供给，窄上下文与之无关，排除
                            "--spring.autoconfigure.exclude=com.ecat.adapter.ruoyi.EcatRuoyiAdapter",
                            "--spring.redis.host=127.0.0.1",
                            "--spring.redis.port=1",
                            "--spring.redis.database=0",
                            "--spring.redis.password=guard");

            assertEquals("flyway 让位契约：上下文中不得出现任何 flyway bean",
                    0, context.getBeanNamesForType(flywayClass).length);
        } catch (Throwable failure) {
            if (isFlywayScriptMissing(failure)) {
                fail("flyway 类在 classpath 时 FlywayAutoConfiguration 被激活（ruoyi 自带 flyway 未让位）: "
                        + failure);
            }
            throw failure;
        } finally {
            if (context != null) {
                context.close();
            }
        }
    }

    /** 异常链中是否为 flyway 迁移脚本缺失的激活形态（按类型名/消息锚定，不硬依赖类加载） */
    private static boolean isFlywayScriptMissing(Throwable failure) {
        Throwable cursor = failure;
        while (cursor != null) {
            if (cursor.getClass().getName().equals(
                    "org.springframework.boot.autoconfigure.flyway.FlywayMigrationScriptMissingException")) {
                return true;
            }
            String message = cursor.getMessage();
            if (message != null && message.contains("Cannot find migration scripts")) {
                return true;
            }
            cursor = cursor.getCause();
        }
        return false;
    }
}
