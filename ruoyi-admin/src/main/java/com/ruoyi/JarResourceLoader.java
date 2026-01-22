package com.ruoyi;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.util.Assert;
import org.springframework.util.ResourceUtils;

import java.io.IOException;
import java.net.JarURLConnection;
import java.net.URL;
import java.util.jar.JarFile;

/**
 * 支持从 Spring Boot fat jar 内部加载资源的 ResourceLoader
 * 
 * @author coffee
 */
public class JarResourceLoader extends PathMatchingResourcePatternResolver {

    public JarResourceLoader() {
        super();
    }

    /**
     * 重写核心方法，支持 fat jar 内部资源加载
     */
    @Override
    public Resource getResource(String location) {
        Assert.notNull(location, "Location must not be null");
        // 优先处理 classpath: 和 jar:file: 前缀
        if (location.startsWith(CLASSPATH_URL_PREFIX)) {
            String path = location.substring(CLASSPATH_URL_PREFIX.length());
            path = stripLeadingSlash(path);
            Resource resource = new ClassPathResource(path);
            if (resource.exists()) {
                return resource;
            }
        } else if (location.startsWith(ResourceUtils.JAR_URL_PREFIX)) {
            // 处理 jar:file:/xxx.jar!/BOOT-INF/classes/xxx.yml
            try {
                URL url = new URL(location);
                JarURLConnection jarCon = (JarURLConnection) url.openConnection();
                JarFile jarFile = jarCon.getJarFile();
                String entryName = jarCon.getEntryName();
                if (entryName != null && jarFile.getEntry(entryName) != null) {
                    return super.getResource(location);
                }
            } catch (IOException e) {
                // ignore, fallback
            }
        } else if (location.startsWith("/")) {
            // 绝对路径，尝试 classpath
            String path = stripLeadingSlash(location);
            Resource resource = new ClassPathResource(path);
            if (resource.exists()) {
                return resource;
            }
        } else {
            // 相对路径，尝试 classpath
            Resource resource = new ClassPathResource(location);
            if (resource.exists()) {
                return resource;
            }
        }
        // 找不到则交给父类处理（如文件系统等）
        return super.getResource(location);
    }

    /**
     * 去除路径前导斜杠，防止被误判为绝对路径
     */
    private String stripLeadingSlash(String path) {
        if (path == null) return null;
        return path.startsWith("/") ? path.substring(1) : path;
    }
}
