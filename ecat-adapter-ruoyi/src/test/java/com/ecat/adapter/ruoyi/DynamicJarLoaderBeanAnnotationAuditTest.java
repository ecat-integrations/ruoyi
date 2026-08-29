package com.ecat.adapter.ruoyi;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.classic.turbo.TurboFilter;
import ch.qos.logback.core.read.ListAppender;

import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

/**
 * DynamicJarLoader 白名单外 bean 注解点名回归（E4-3）。
 *
 * <p>背景：装载器只注册 @RestController/@Service，@Component 等其它 stereotype 被静默跳过
 * ——运行期 NoSuchBeanDefinition、单测手动 new 完全遮蔽（历史实证坑）。装载期 log.error
 * 点名类名并指路是唯一的可见性出口。
 *
 * <p>同步方式：logback ListAppender 同步捕获，调 audit 后立即可断言——零 sleep、确定性。
 *
 * <p><b>测试环境交互（logback turbo filter）</b>：依赖树里 ecat-core（provided，测试可见）
 * 随 jar 携带 logback.xml，给共享 LoggerContext 装了 ErrorRateLimitFilter 等 TurboFilter
 * ——3 秒窗口内同签名 ERROR 首条过后全部被合并吞掉，与「逐条断言 ERROR 已落」的确定性
 * 测试互斥（首个用例绿、后续同签名用例全红）。测试窗口内摘下 turbo filter、tearDown
 * 原样装回：不动 core 的生产日志治理，测试自己管自己的日志可见性。
 *
 * @author coffee
 */
public class DynamicJarLoaderBeanAnnotationAuditTest {

    private Logger loaderLogger;
    private ListAppender<ILoggingEvent> appender;
    private List<TurboFilter> savedTurboFilters;

    @Before
    public void setUp() {
        LoggerContext ctx = (LoggerContext) LoggerFactory.getILoggerFactory();
        savedTurboFilters = new ArrayList<>(ctx.getTurboFilterList());
        ctx.getTurboFilterList().clear();

        loaderLogger = (Logger) LoggerFactory.getLogger(DynamicJarLoader.class);
        appender = new ListAppender<>();
        appender.start();
        loaderLogger.addAppender(appender);
    }

    @After
    public void tearDown() {
        loaderLogger.detachAppender(appender);
        ((LoggerContext) LoggerFactory.getILoggerFactory()).getTurboFilterList().addAll(savedTurboFilters);
    }

    // ==================== 夹具：各 stereotype 直接标注 ====================

    @Component
    static class ComponentFixture {
    }

    @Controller
    static class ControllerFixture {
    }

    @Repository
    static class RepositoryFixture {
    }

    @Configuration
    static class ConfigurationFixture {
    }

    /** 白名单内（meta-annotation 不穿透：@Service 本身是 @Component 的 meta 标注，不得误伤）。 */
    @Service
    static class ServiceFixture {
    }

    /** 白名单内（@RestController meta 标注 @Controller，同样不得误伤）。 */
    @RestController
    static class RestControllerFixture {
    }

    /** 无任何 bean 注解。 */
    static class PlainFixture {
    }

    // ==================== 断言 ====================

    /** 红路径：@Component 类被 log.error 点名（类名 + 注解名 + 指路文案齐全）。 */
    @Test
    public void componentAnnotatedClass_isNamedInErrorLog() {
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(ComponentFixture.class);

        List<String> errors = errorMessages();
        assertTrue("标 @Component 的类必须有 ERROR 点名, 实际: " + appender.list,
                errors.stream().anyMatch(m -> m.contains(ComponentFixture.class.getName())
                        && m.contains("org.springframework.stereotype.Component")
                        && m.contains("@Service")));
    }

    /** 其余白名单外 stereotype（@Controller/@Repository/@Configuration）同样点名。 */
    @Test
    public void otherNonWhitelistedStereotypes_areAlsoNamed() {
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(ControllerFixture.class);
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(RepositoryFixture.class);
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(ConfigurationFixture.class);

        List<String> errors = errorMessages();
        assertTrue("标 @Controller 的类必须被点名", errors.stream()
                .anyMatch(m -> m.contains(ControllerFixture.class.getName())));
        assertTrue("标 @Repository 的类必须被点名", errors.stream()
                .anyMatch(m -> m.contains(RepositoryFixture.class.getName())));
        assertTrue("标 @Configuration 的类必须被点名", errors.stream()
                .anyMatch(m -> m.contains(ConfigurationFixture.class.getName())));
    }

    /** 绿路径：白名单内（@Service/@RestController）与无注解类零 ERROR——点名不误伤。 */
    @Test
    public void whitelistedAndPlainClasses_emitNoError() {
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(ServiceFixture.class);
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(RestControllerFixture.class);
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(PlainFixture.class);

        assertTrue("白名单内/无注解类不得产生 ERROR, 实际: " + appender.list, errorMessages().isEmpty());
    }

    /** 静默兜底断言（防测试自身失真）：appender 已挂载且日志可达（摘 turbo filter 后事件必落）。 */
    @Test
    public void appenderWiringSanity() {
        DynamicJarLoader.auditNonWhitelistedBeanAnnotation(ComponentFixture.class);
        assertFalse("appender 应捕获到日志事件（挂载/过滤器失效=测试假绿）", appender.list.isEmpty());
    }

    private List<String> errorMessages() {
        return appender.list.stream()
                .filter(e -> e.getLevel() == Level.ERROR)
                .map(ILoggingEvent::getFormattedMessage)
                .collect(Collectors.toList());
    }
}
