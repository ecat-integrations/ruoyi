package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.apache.commons.cli.*;

/**
 * 启动程序
 * 
 * @author ruoyi, coffee
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
@ComponentScan(basePackages ={"com.ruoyi","com.ecat.adapter.ruoyi"})
@EnableScheduling
public class RuoYiApplication
{

    // 静态变量存储ApplicationContext
    private static ConfigurableApplicationContext applicationContext;
    
    // 提供静态方法获取上下文
    public static ConfigurableApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public static void main(String[] args)
    {

        // 创建 Options 对象，用于定义命令行选项
        Options options = new Options();
        Option envFileOption = new Option("e", "env-dir", true, "Dir Path to the .env file");
        options.addOption(envFileOption);

        // 创建 CommandLineParser 对象，用于解析命令行参数
        CommandLineParser parser = new DefaultParser();
        try {
            // 解析命令行参数
            CommandLine cmd = parser.parse(options, args);
            String envFileDir = null;
            if (cmd.hasOption("env-dir")) {
                envFileDir = cmd.getOptionValue("env-dir");
            }

            // 检查当前线程和 Spring 使用的 ClassLoader
            // System.out.println("Thread context ClassLoader: " + Thread.currentThread().getContextClassLoader());
            // System.out.println("RuoYiApplication ClassLoader: " + RuoYiApplication.class.getClassLoader());
            // ClassLoader ruoyiClassLoader = RuoYiApplication.class.getClassLoader();

            SpringApplication application = new SpringApplication(RuoYiApplication.class);
            
            JarResourceLoader jarResourceLoader = new JarResourceLoader();
            application.setResourceLoader(jarResourceLoader); // 也可以使用 JarResourceLoader


            // 打印当前 classpath
            // System.out.println("Current classpath:");
            // System.out.println(System.getProperty("java.class.path"));

            // 检查 ScheduleConfig 是否能被加载，结果应不能
            // try {
            //     Class<?> clazz = Class.forName("com.ruoyi.quartz.config.ScheduleConfig");
            //     System.out.println("ScheduleConfig loaded: " + clazz);
            // } catch (ClassNotFoundException e) {
            //     System.out.println("ScheduleConfig NOT found in classpath!");
            // }
            
            // 检查 spring-data-commons 是否存在，结果应能
            // try {
            //     Class<?> clazz = Class.forName("org.springframework.data.repository.config.AnnotationRepositoryConfigurationSource");
            //     System.out.println("spring-data-commons 存在: " + clazz.getProtectionDomain().getCodeSource().getLocation());
            // } catch (ClassNotFoundException e) {
            //     System.out.println("spring-data-commons 缺失，未找到 AnnotationRepositoryConfigurationSource");
            // }


            application.addInitializers(new DotenvConfig(envFileDir));
            application.addInitializers(new EcatCoreInitializer());
            ConfigurableApplicationContext context = application.run(args);

            // 存储上下文到静态变量
            RuoYiApplication.applicationContext = context;

            // 打印所有 Bean 名称
            // for (String beanName : context.getBeanDefinitionNames()) {
            //     System.out.println(beanName);
            // }

        } catch (ParseException e) {
            // 处理参数解析异常
            System.err.println("Error parsing command-line arguments: " + e.getMessage());
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("java -jar your-application.jar", options);
            System.exit(1);
        }

        // // System.setProperty("spring.devtools.restart.enabled", "false");
        // // 创建 SpringApplication 实例
        // SpringApplication application = new SpringApplication(RuoYiApplication.class);
        // // 添加 DotenvConfig 初始化器
        // application.addInitializers(new DotenvConfig());
        // // 运行 Spring 应用
        // application.run(args);
        // SpringApplication.run(RuoYiApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  若依启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " .-------.       ____     __        \n" +
                " |  _ _   \\      \\   \\   /  /    \n" +
                " | ( ' )  |       \\  _. /  '       \n" +
                " |(_ o _) /        _( )_ .'         \n" +
                " | (_,_).' __  ___(_ o _)'          \n" +
                " |  |\\ \\  |  ||   |(_,_)'         \n" +
                " |  | \\ `'   /|   `-'  /           \n" +
                " |  |  \\    /  \\      /           \n" +
                " ''-'   `'-'    `-..-'              ");
    }

    public static <T> T getSpringBean(String name, Class<T> requiredType) {
        return applicationContext.getBean(name, requiredType);
    }

    public static <T> T getSpringBean(Class<T> requiredType) {
        return applicationContext.getBean(requiredType);
    }

    public static Object getSpringBean(String name) {
        return applicationContext.getBean(name);
    }

    public static boolean checkSpringBean(String beanName) {
        return applicationContext.containsBean(beanName);
    }
}
