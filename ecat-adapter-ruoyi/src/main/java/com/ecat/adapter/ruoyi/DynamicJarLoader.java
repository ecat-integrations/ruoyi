package com.ecat.adapter.ruoyi;

import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.TypeAliasRegistry;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.ecat.core.Integration.IntegrationBase;
import com.ecat.adapter.ruoyi.utils.JarTools;
import com.ruoyi.common.core.domain.BaseEntity;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

/**
 * DynamicJarLoader is a utility class for dynamically loading JAR files and registering
 * 
 * @author coffee
 */

// ecat 原创首次完整实现按需动态加载springboot的component和mybatis的mapper

public class DynamicJarLoader {
    private final ApplicationContext applicationContext;
    private final URLClassLoader classLoader;
    private final RuoyiClassLoaderHelper ecatCLoaderHelper;
    private final DefaultListableBeanFactory beanFactory;
    private final RequestMappingHandlerMapping handlerMapping;
    private final Set<Class<?>> registeredMappers = ConcurrentHashMap.newKeySet(); // 线程安全集合
    private final Set<Class<?>> registeredEntities = ConcurrentHashMap.newKeySet(); // 记录已注册的实体类

    public DynamicJarLoader(ApplicationContext applicationContext, URLClassLoader classLoader, RuoyiClassLoaderHelper ecatCLoaderHelper) {
        this.applicationContext = applicationContext;
        this.classLoader = classLoader;
        this.ecatCLoaderHelper = ecatCLoaderHelper;
        this.beanFactory = (DefaultListableBeanFactory) ((ConfigurableApplicationContext) applicationContext)
                .getBeanFactory();
        // beanFactory.setBeanClassLoader(ecatCLoaderHelper.getClassLoader());
        beanFactory.setBeanClassLoader(classLoader);
        this.handlerMapping = applicationContext.getBean(RequestMappingHandlerMapping.class);
    }

    public void loadJar() throws Exception {
        // 步骤1：加载B包中的所有类（通过B传入的classLoader）
        List<Class<?>> classes = loadClassesFromJar();

        // 步骤2：注册B包的MyBatis Mapper（兼容多XML或无XML）
        registerMappers();

        // MyBatisDynamicScanner myBatisDynamicScanner = new MyBatisDynamicScanner(applicationContext, ecatCLoaderHelper);
        // myBatisDynamicScanner.scanAndRegister(extractJarFilePath(classLoader.getURLs()[0]), "com.ecat.integration.MockRuoyiGenCodeIntegration.mapper");
        // 步骤3：注册B包的@RestController和@Service Bean（自动触发AOP代理）
        registerSpringBeans(classes);

    }

    // 加载 JAR 中的所有 .class 文件（修复 URI 异常）
    private List<Class<?>> loadClassesFromJar() throws Exception {
        List<Class<?>> classes = new ArrayList<>();
        Class<?> baseClass = IntegrationBase.class;
        try {
            // 从 classLoader 中获取所有 URL（可能包含 jar:file: 协议的 URL）
            URL[] urls = classLoader.getURLs();
            if (urls.length == 0) {
                throw new IllegalArgumentException("URLClassLoader 中未找到 JAR 文件");
            }
            // ecatCLoaderHelper.addUrls(urls);

            // 提取实际的 JAR 文件路径（处理 jar:file: 协议）
            // ecat-core的LoadJarUtils.java加载顺序为最后加载主 JAR 文件的 URL，兼容 ecat-adapter-ruoyi 内的 class 加载顺序
            String jarPath = JarTools.extractJarFilePath(urls[urls.length - 1]);
            File jarFile = new File(jarPath);

            try (JarFile jar = new JarFile(jarFile)) {
                Enumeration<JarEntry> entries = jar.entries();
                while (entries.hasMoreElements()) {
                    JarEntry entry = entries.nextElement();
                    // 只加载 .class 文件
                    if (entry.getName().endsWith(".class")) {
                        String className = entry.getName().replace('/', '.').substring(0, entry.getName().length() - 6);
                        if (className.equals("module-info")) {
                            continue;
                        }
                        // Object rpkg = ecatCLoaderHelper.getPackage("com.ecat.integration.EnvAlarmManagerIntegration"); // 测试
                        // if(rpkg != null){
                        //     System.out.println("find package com.ecat.integration.EnvAlarmManagerIntegration");
                        // }
                        Class<?> clazz = classLoader.loadClass(className);
                        // Class<?> clazz = ecatCLoaderHelper.getClassLoader().loadClass(className);
                        // 判断clazz是否继承了 IntegrationBase
                        if (!baseClass.isAssignableFrom(clazz)) {
                            classes.add(clazz);
                        }
                        System.out.println("加载类: " + className + "，类加载器: " + clazz.getClassLoader());
                        // classes.add(classLoader.loadClass(className));
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("加载 JAR 类失败", e);
        }
        return classes;
    }

    // 注册B包的@RestController和@Service Bean
    private void registerSpringBeans(List<Class<?>> classes) {
        for (Class<?> clazz : classes) {
            if (isCandidateForRegistration(clazz) && !clazz.isInterface()) {
                String beanName = clazz.getSimpleName().substring(0, 1).toLowerCase()
                        + clazz.getSimpleName().substring(1);
                BeanDefinitionBuilder builder = BeanDefinitionBuilder.genericBeanDefinition(clazz);
                BeanDefinition beanDefinition = builder.getBeanDefinition();
                beanFactory.registerBeanDefinition(beanName, beanDefinition); // 注册到B包的BeanFactory

                registerController(beanName);
            }
        }
        // 手动触发所有单例 Bean 的实例化和初始化
        beanFactory.preInstantiateSingletons();

    }

    // 判断类是否需要注册（@RestController或@Service）
    private boolean isCandidateForRegistration(Class<?> clazz) {
        return clazz.isAnnotationPresent(RestController.class) || clazz.isAnnotationPresent(Service.class);
    }

    // 注册B包的MyBatis Mapper（兼容多XML或无XML）
    private void registerMappers() throws Exception {
        SqlSessionFactory sqlSessionFactory = applicationContext.getBean(SqlSessionFactory.class); // 获取B包的SqlSessionFactory

        URL[] urls = classLoader.getURLs();
        if (urls.length == 0) {
            throw new IllegalArgumentException("URLClassLoader 中未找到 JAR 文件");
        }
        // 从B包的JAR中加载Mapper XML（路径需与B包的Mapper接口匹配）
        // 提取实际的 JAR 文件路径（处理 jar:file: 协议）
        // ecat-core的LoadJarUtils.java加载顺序为最后加载主 JAR 文件的 URL，兼容 ecat-adapter-ruoyi 内的 class 加载顺序
        String jarPath = JarTools.extractJarFilePath(urls[urls.length - 1]);

        try (JarFile jarFile = new JarFile(jarPath)){
            
            Enumeration<JarEntry> entries = jarFile.entries();
            List<Class<?>> entityClasses = new ArrayList<>(); // 存储实体类（如MockTable）
            List<Class<?>> mapperInterfaces = new ArrayList<>();
            List<Resource> xmlResources = new ArrayList<>();

            while (entries.hasMoreElements()) {
                JarEntry entry = entries.nextElement();
                String entryName = entry.getName();

                // 2.1 加载实体类（要求在com/ecat/integration/MockRuoyiGenCodeIntegration/domain包下）
                if (entryName.contains("domain/") && entryName.endsWith(".class")) {
                    String className = entryName.replace("/", ".").replace(".class", "");
                    // Class<?> clazz = ecatCLoaderHelper.getClassLoader().loadClass(className);
                    Class<?> clazz = classLoader.loadClass(className);
                    // 确保是BaseEntity的子类
                    if (clazz.getSuperclass() != null && BaseEntity.class.isAssignableFrom(clazz)) {
                        entityClasses.add(clazz);
                    }
                }

                // 提取Mapper接口类（假设接口在jar的com/mock/mapper包下，以Mapper结尾）
                if (entryName.contains("mapper/") && entryName.endsWith(".class") && entryName.endsWith("Mapper.class")) {
                    String className = entryName.replace("/", ".").replace(".class", "");
                    // Class<?> clazz = ecatCLoaderHelper.getClassLoader().loadClass(className);
                    Class<?> clazz = classLoader.loadClass(className);
                    if (clazz.isInterface()) { // 确保是接口
                        mapperInterfaces.add(clazz);
                    }
                }

                // 提取XML映射文件（假设XML在jar的mapper目录下）
                if (entryName.startsWith("mapper/") && entryName.endsWith("Mapper.xml")) {
                    try (InputStream is = jarFile.getInputStream(entry);
                            ByteArrayOutputStream os = new ByteArrayOutputStream()) {
                        byte[] buffer = new byte[1024];
                        int len;
                        while ((len = is.read(buffer)) != -1) {
                            os.write(buffer, 0, len);
                        }
                        xmlResources.add(new ByteArrayResource(os.toByteArray(), entryName));
                    }
                }
            }

            // 3. 注册实体类别名到MyBatis（关键步骤）
            TypeAliasRegistry typeAliasRegistry = sqlSessionFactory.getConfiguration().getTypeAliasRegistry();
            for (Class<?> entityClass : entityClasses) {
                if (registeredEntities.contains(entityClass)) {
                    continue;
                }
                typeAliasRegistry.registerAlias(entityClass); // 调用registerAlias(Class<?> type)
                registeredEntities.add(entityClass);
            }

            // 4. 将XML映射文件添加到MyBatis的Configuration中
            for (Resource xmlResource : xmlResources) {
                try (InputStream is = xmlResource.getInputStream()) {
                    XMLMapperBuilder builder = new XMLMapperBuilder(
                        is, 
                        sqlSessionFactory.getConfiguration(), 
                        xmlResource.getDescription(), 
                        sqlSessionFactory.getConfiguration().getSqlFragments()
                    );
                    builder.parse(); // 解析XML并添加到Configuration
                }
            }

            // 5. 将Mapper接口注册为Spring Bean（通过MapperFactoryBean）
            for (Class<?> mapperInterface : mapperInterfaces) {
                if (registeredMappers.contains(mapperInterface)) {
                    continue; // 避免重复注册
                }
                registerMapperBean(mapperInterface);
                registeredMappers.add(mapperInterface);
            }
        }

    }

    // 封装注册Controller的逻辑
    private void registerController(String beanName) {
        try {
            Method method = handlerMapping.getClass().getSuperclass().getSuperclass()
                    .getDeclaredMethod("detectHandlerMethods", Object.class);
            method.setAccessible(true);
            method.invoke(handlerMapping, beanName);
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    /**
     * 注册Mapper接口为Spring Bean（内部方法）
     */
    private void registerMapperBean(Class<?> mapperInterface) {
        // String beanName = lowerFirstCase(mapperInterface.getSimpleName());
        String beanName = mapperInterface.getCanonicalName();
        if (beanFactory.containsBeanDefinition(beanName)) {
            throw new IllegalStateException("Bean已存在: " + beanName);
        }

        BeanDefinitionBuilder builder = BeanDefinitionBuilder.genericBeanDefinition(MapperFactoryBean.class);
        builder.addConstructorArgValue(mapperInterface); // 指定Mapper接口
        builder.addPropertyReference("sqlSessionFactory", "sqlSessionFactory"); // 关联SqlSessionFactory

        beanFactory.registerBeanDefinition(beanName, builder.getBeanDefinition());
    }

    /**
     * 辅助方法：首字母小写（生成Bean名称）
     */
    // private String lowerFirstCase(String str) {
    //     if (str == null || str.isEmpty()) return str;
    //     return str.substring(0, 1).toLowerCase() + str.substring(1);
    // }
}
