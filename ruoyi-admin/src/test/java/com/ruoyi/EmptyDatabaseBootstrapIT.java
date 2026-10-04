package com.ruoyi;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assume.assumeTrue;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.springframework.context.ConfigurableApplicationContext;

import com.ecat.core.EcatCore;
import com.ruoyi.quartz.service.impl.SysJobServiceImpl;
import com.ruoyi.system.service.impl.SysConfigServiceImpl;
import com.ruoyi.system.service.impl.SysDictTypeServiceImpl;

/**
 * 空库自举真库 IT（工单门控，默认跳过）：空库（无 ruoyi-sys 表）起点直接起
 * ruoyi-admin 全上下文，锁两层启动守护契约——
 * ① flyway 让位：classpath 有 flyway 类（test 依赖模拟 core 类加载器层汇入形态）
 *    时上下文不得因自带 flyway 激活而崩；
 * ② 急切装载容错：sys_config / sys_dict / sys_job 三处 @PostConstruct 直查表
 *    在表尚不存在（桥迁移未建）时跳过装载不崩启动，且 WARN 日志逐表显形。
 *
 * 日志断言走控制台流捕获而非内存 appender：Spring Boot 日志系统在上下文刷新时
 * 重初始化 logback 会清掉编程式 appender；控制台正是车道/运维观测启动报告的同一通道。
 *
 * 执行方式（与仓内真库 IT 同族，凭据不落仓）：
 * <pre>
 *   mvn test -Dtest=EmptyDatabaseBootstrapIT \
 *     （e2e 门：系统属性 -Decat.e2e=true 或环境变量 ECAT_E2E=true——surefire 分叉
 *       JVM 不透传 CLI -D，独立 JVM 跑法走 env 通道；
 *     环境变量：POSTGRES_HOST/PORT/USER/PASSWORD、REDIS_HOST/PORT/DB/PASSWORD、
 *       RUOYI_ADMIN_PORT、RUOYI_ADMIN_RUOYI_PROFILE、RUOYI_ADMIN_TOKEN_SECRET。
 *       注意 POSTGRES_DB 不得在 OS env 导出：目标库名经 dotenv 注入通道覆盖，
 *       而 dotenv 合并语义为 OS env 优先于 .env 文件）
 * </pre>
 * 隔离：用例自建一次性空库（it_empty_*）作为启动目标，跑完即删；对共享库零写入
 * （管理面连接固定落 postgres 维护库）。redis 隔离由运行方指定独立 REDIS_DB。
 */
public class EmptyDatabaseBootstrapIT {

    @Test
    public void emptyDatabase_contextStartsAndSkipsEagerCachesVisibly() throws Exception {
        assumeGate();
        String tempDb = "it_empty_" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        File envDir = writeEnvOverride(tempDb);

        boolean dbCreated = createDatabase(tempDb);
        // 生产嵌入形态 core 与本上下文同进程（EcatCoreInitializer 注册实例）；
        // IT 无运行中的 core，注册壳单例仅满足 ruoyi-quartz 任务 bean 的装配面，
        // 空库起点无任何任务/调度会触达其行为；测毕清除静态引用。
        EcatCore.setInstance(new EcatCore());
        PrintStream originalOut = System.out;
        ByteArrayOutputStream captured = new ByteArrayOutputStream();
        System.setOut(new PrintStream(captured, true, StandardCharsets.UTF_8.name()));
        try {
            // 空库起点直接起全上下文：两层修复前此处崩（flyway 脚本缺失 / sys_config 表缺失）
            RuoYiApplication.main(new String[] { "-e", envDir.getAbsolutePath() });

            ConfigurableApplicationContext context = RuoYiApplication.getApplicationContext();
            assertNotNull("空库起点 ruoyi 上下文必须存活", context);
            assertTrue(context.containsBean("sysConfigServiceImpl"));
            assertTrue(context.containsBean("sysDictTypeServiceImpl"));
            assertTrue(context.containsBean("sysJobServiceImpl"));

            String console = captured.toString(StandardCharsets.UTF_8.name());
            assertSkippedVisibly(console, "sys_config");
            assertSkippedVisibly(console, "sys_dict");
            assertSkippedVisibly(console, "sys_job");
        } finally {
            System.setOut(originalOut);
            closeContext();
            EcatCore.setInstance(null);
            if (dbCreated) {
                dropDatabase(tempDb);
            }
        }
    }

    private static void assumeGate() {
        assumeTrue("未开启 e2e 门（-Decat.e2e=true 或环境变量 ECAT_E2E=true 才执行真库 IT），默认跳过",
                "true".equals(System.getProperty("ecat.e2e"))
                        || "true".equals(System.getenv("ECAT_E2E")));
        assumeTrue("POSTGRES 连接环境变量未齐（POSTGRES_HOST/PORT/USER），跳过",
                env("POSTGRES_HOST") != null && env("POSTGRES_PORT") != null
                        && env("POSTGRES_USER") != null);
        assumeTrue("ruoyi-admin 运行环境变量未齐（RUOYI_ADMIN_PORT/REDIS_HOST），跳过",
                env("RUOYI_ADMIN_PORT") != null && env("REDIS_HOST") != null);
    }

    private static String env(String name) {
        String value = System.getenv(name);
        return value == null || value.isEmpty() ? null : value;
    }

    /**
     * dotenv 注入通道：-e 指向只含 POSTGRES_DB=一次性空库 的目录。
     * dotenv 合并语义为 OS env 优先，故该键不得出现在 OS env（见类注释执行方式）。
     */
    private static File writeEnvOverride(String tempDb) throws Exception {
        File dir = Files.createTempDirectory("ruoyi-it-env").toFile();
        File envFile = new File(dir, ".env");
        Files.write(envFile.toPath(),
                ("POSTGRES_DB=" + tempDb + "\n").getBytes(StandardCharsets.UTF_8));
        return dir;
    }

    private static void assertSkippedVisibly(String console, String table) {
        boolean visible = console.contains("WARN") && console.contains(table)
                && console.contains("跳过");
        assertTrue("表缺失跳过必须日志显形(WARN 含表名与跳过语义): " + table, visible);
    }

    private static void closeContext() {
        ConfigurableApplicationContext context = RuoYiApplication.getApplicationContext();
        if (context != null) {
            context.close();
        }
    }

    /** 管理面连接：固定落 postgres 维护库（集群必有），与被测目标库解耦 */
    private static String adminUrl() {
        return "jdbc:postgresql://" + env("POSTGRES_HOST") + ":" + env("POSTGRES_PORT") + "/postgres";
    }

    private static boolean createDatabase(String tempDb) throws Exception {
        try (Connection connection = DriverManager.getConnection(adminUrl(),
                env("POSTGRES_USER"), System.getenv("POSTGRES_PASSWORD"));
                Statement statement = connection.createStatement()) {
            statement.execute("CREATE DATABASE " + tempDb);
            return true;
        }
    }

    /** 尽力清理：残留连接未释放时删除失败不掩盖主结论，库名带时戳不与后续用例冲突 */
    private static void dropDatabase(String tempDb) {
        try (Connection connection = DriverManager.getConnection(adminUrl(),
                env("POSTGRES_USER"), System.getenv("POSTGRES_PASSWORD"));
                Statement statement = connection.createStatement()) {
            statement.execute("DROP DATABASE IF EXISTS " + tempDb);
        } catch (Exception cleanupFailure) {
            System.err.println("[EmptyDatabaseBootstrapIT] 一次性空库清理失败（不影响用例结论，库名时戳唯一不冲突）: "
                    + tempDb + " -> " + cleanupFailure.getMessage());
        }
    }
}
