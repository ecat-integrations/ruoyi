package com.ecat.adapter.ruoyi;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.net.URI;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.ecat.adapter.ruoyi.utils.JarTools;
// import com.ecat.core.EcatCore;
import com.ecat.core.Integration.IntegrationBase;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Getter;

/**
 * EcatRuoyiAdapter 是一个适配器，用于在若依框架中动态加载 JAR 文件和 Vue 模块。
 * 它实现了 ApplicationContextAware 接口，以便能够访问 Spring 应用上下文
 * 
 * @author coffee
 */
@Component("ecatRuoyiAdapter")
public class EcatRuoyiAdapter implements ApplicationContextAware {

    private static final Logger log = LoggerFactory.getLogger(EcatRuoyiAdapter.class);

    @Getter
    private Map<String, List<WebIntegrationInfo>> webIntegrationInfoMap = new HashMap<>();

    // @Autowired
    // private EcatCore core;

    @Autowired
    private StaticResourceDynamicRegistry srdRegistry;

    private ApplicationContext context;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) {
        context = applicationContext;
        // 初始化逻辑，可在此处与 ecat/ruoyi-admin 进行动态链接
    }

    public ApplicationContext getContext() {
        return context;
    }

    public void loadJarAndVue(URLClassLoader targetClassLoader, IntegrationBase target) {
        if (context == null || srdRegistry == null) {
            throw new IllegalStateException(
                    "Please ensure EcatRuoyiAdapter is properly initialized.");
        }
        this.loadJar(targetClassLoader);
        this.loadVue(targetClassLoader, target);
    }

    public void loadJar(URLClassLoader targetClassLoader) {

        RuoyiClassLoaderHelper ryAppClassHelper = new RuoyiClassLoaderHelper((URLClassLoader) context.getClassLoader());
        try {
            DynamicJarLoader djl = new DynamicJarLoader(context, targetClassLoader, ryAppClassHelper);
            djl.loadJar();
        } catch (Exception e) {
            log.error("延迟加载 Jar 模块失败: ", e);
        }

    }

    private void loadVue(URLClassLoader targetClassLoader, IntegrationBase target) {
        try {
            URL classUrl = target.getClass().getProtectionDomain().getCodeSource().getLocation();
            // URI classUri = classUrl.toURI();
            // 兼容windows
            URI classUri = URI.create(classUrl.toString().replace("\\", "/").replace(" ", "%20"));

            Map<String, Object> config = getJsonFromJar(classUrl, "vue-modules/module-config.json");
            if (config == null) {
                log.warn("没有找到 vue-modules/module-config.json 文件");
                return;
            }

            // 从config中提取顶层字段
            String publicPath = (String) config.get("public_path");
            String integrationName = (String) config.get("module_name");// 集成标识

            // 解析sub_modules（处理多模块）
            ObjectMapper objectMapper = new ObjectMapper();
            List<Map<String, Object>> subModules = objectMapper.convertValue(
                    config.get("sub_modules"),
                    new com.fasterxml.jackson.core.type.TypeReference<List<Map<String, Object>>>() {
                    });
            if (subModules == null || subModules.isEmpty()) {
                log.warn("module-config.json中未找到sub_modules或sub_modules为空");
                return;
            }

            // 遍历子模块，检查冲突并存储信息
            for (Map<String, Object> subModule : subModules) {
                String mtype = (String) subModule.get("mtype");
                String moduleName = (String) subModule.get("module");
                if (mtype == null) {
                    log.warn("子模块缺少mtype字段，跳过处理");
                    continue;
                }

                // 检查publicPath+moduleName是否已被其他集成占用
                String conflictIntegration = checkDuplicate(publicPath, moduleName);
                if (conflictIntegration != null) {
                    // 冲突时记录具体集成并退出函数
                    log.error("检测到路径冲突：publicPath[{}] + moduleName[{}] 已被集成[{}]占用，当前集成[{}]终止加载",
                            publicPath, moduleName, conflictIntegration, integrationName);
                    return; // 关键修改：冲突时直接退出函数
                }

                // 创建当前模块信息并存储
                WebIntegrationInfo currentInfo = new WebIntegrationInfo(
                        integrationName, moduleName, publicPath, mtype);
                webIntegrationInfoMap.computeIfAbsent(integrationName, k -> new ArrayList<>())
                        .add(currentInfo);
            }

            // 注册静态资源（仅当无冲突时执行）
            String jarUrl = processJarUrl(classUri.toString());
            String vueDistPath = jarUrl + "vue-modules/dist/";
            // srdRegistry = context.getBean(StaticResourceDynamicRegistry.class);
            srdRegistry.registry(publicPath + "**", vueDistPath);
            log.info("集成[{}]的Vue模块加载成功，注册路径：{}", integrationName, publicPath + "**");

        } catch (Exception e) {
            log.error("加载 Vue 模块失败: ", e);
        }
    }

    /**
     * 处理 JAR URL，兼容win下格式正确
     */
    private String processJarUrl(String jarUrl) {

        String urlStr = jarUrl;

        // 检查是否是 Windows 环境
        if (isWindows()) {
            // 检查 URL 是否以 "jar:" 开头
            if (!urlStr.startsWith("jar:")) {
                // 添加 "jar:" 前缀
                urlStr = "jar:" + urlStr;
            }

            // 确保 URL 以 "!/" 结尾
            if (!urlStr.endsWith("!/")) {
                // 如果 URL 以 "/" 结尾，添加 "!"
                if (urlStr.endsWith("/")) {
                    urlStr = urlStr.substring(0, urlStr.length() - 1) + "!/";
                } else if (urlStr.endsWith("!")) {
                    // 如果 URL 以 "!" 结尾，添加 "/"
                    urlStr += "/";
                } else {
                    // 否则，添加 "!/"
                    urlStr += "!/";
                }
            }
        }

        return urlStr;
    }

    private boolean isWindows() {
        String osName = System.getProperty("os.name").toLowerCase();
        return osName.contains("windows");
    }

    private Map<String, Object> getJsonFromJar(URL jarUrl, String jsonEntryPath) throws Exception {
        // 校验入参有效性
        if (jarUrl == null) {
            throw new IllegalArgumentException("JAR URL must not be null");
        }
        if (jsonEntryPath == null || jsonEntryPath.isEmpty()) {
            throw new IllegalArgumentException("JSON entry path must not be empty");
        }

        // 将 URL 转换为本地文件路径（处理 file: 协议）
        String jarPath = JarTools.extractJarFilePath(jarUrl);
        File jarFile = new File(jarPath);

        // 校验 JAR 文件是否存在
        if (!jarFile.exists() || !jarFile.isFile()) {
            throw new IOException("JAR file not found: " + jarFile.getAbsolutePath());
        }

        // 使用 try-with-resources 自动关闭 JarFile
        try (JarFile jar = new JarFile(jarFile)) {
            // 查找目标条目
            JarEntry entry = jar.getJarEntry(jsonEntryPath);
            if (entry == null) {
                throw new IOException("JSON entry not found in JAR: " + jsonEntryPath);
            }

            // 读取条目内容
            try (InputStream inputStream = jar.getInputStream(entry);
                    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {

                StringBuilder jsonContent = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonContent.append(line);
                }
                ObjectMapper objectMapper = new ObjectMapper();
                // 解析 JSON 为 Map
                return objectMapper.readValue(jsonContent.toString(),
                        new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {
                        });
            }
        }
    }

    /**
     * 检查publicPath+moduleName是否已被其他集成占用，返回冲突的集成名称（无冲突返回null）
     */
    private String checkDuplicate(String publicPath, String moduleName) {
        for (Map.Entry<String, List<WebIntegrationInfo>> entry : webIntegrationInfoMap.entrySet()) {
            String existingIntegration = entry.getKey();
            for (WebIntegrationInfo info : entry.getValue()) {
                if (publicPath.equals(info.getPublicPath()) && moduleName.equals(info.getModuleName())) {
                    return existingIntegration; // 返回冲突的集成名称
                }
            }
        }
        return null; // 无冲突
    }
}

class RuoyiClassLoaderHelper {
    private URLClassLoader classLoader;

    RuoyiClassLoaderHelper(URLClassLoader classLoader) {
        this.classLoader = classLoader;
    }

    public URLClassLoader getClassLoader() {
        return classLoader;
    }

    public void addURL(URL url) throws Exception {
        // 判断url 是否已存在
        for (URL u : classLoader.getURLs()) {
            if (u.equals(url)) {
                return;
            }
        }

        Method method = URLClassLoader.class.getDeclaredMethod("addURL", URL.class);
        method.setAccessible(true);
        method.invoke(classLoader, url);
    }

    // 添加多个 URL 路径
    public void addUrls(URL[] urls) {
        for (URL url : urls) {
            try {
                addURL(url);
            } catch (Exception e) {
                throw new RuntimeException("Failed to add URL: " + url, e);
            }
        }
    }

    public Object getPackage(String packageName) {
        try{
            Method method = ClassLoader.class.getDeclaredMethod("getPackage", String.class);
            method.setAccessible(true);
            Package pkg = (Package) method.invoke(classLoader, packageName);
            return pkg;
        }
        catch(Exception e){
            return null;
            // throw new RuntimeException("Failed to get package: " + packageName, e);
        }
    }
}
