/**
 * Utility class for handling JAR file paths from URLs.
 * <p>
 * This class provides methods to extract the actual file path of a JAR file
 * from a given URL, supporting both "jar:file:" and "file:" protocols.
 * </p>
 *
 * <h2>Usage</h2>
 * <pre>
 * {@code
 * URL jarUrl = new URL("jar:file:/path/to/jarfile.jar!/some/entry");
 * String jarFilePath = JarTools.extractJarFilePath(jarUrl);
 * System.out.println(jarFilePath); // Outputs: /path/to/jarfile.jar
 * }
 * </pre>
 * 
 * @author coffee
 * 
 */
package com.ecat.adapter.ruoyi.utils;

import java.io.File;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;



public class JarTools {
    /**
     * 从 URL 中提取实际的 JAR 文件路径（处理 jar:file: 协议）
     *
     * @param url jar URL
     * @return jar 文件路径
     * @throws Exception 如果 URL 格式不正确或无法解析
     */
    public static String extractJarFilePath(URL url) throws Exception {
        String urlStr = url.toString();
        if (urlStr.startsWith("jar:file:")) {
            // 提取 ! 之前的部分（格式：jar:file:/path/to/jar.jar!...)
            String pathWithFileProtocol = urlStr.substring("jar:".length(), urlStr.indexOf('!'));
            // 去除 file: 协议头（格式：file:/path/to/jar.jar → /path/to/jar.jar）
            String path = pathWithFileProtocol.startsWith("file:")
                    ? pathWithFileProtocol.substring("file:".length())
                    : pathWithFileProtocol;
            // 解码 URL 编码（如 %20 转换为空格）
            return URLDecoder.decode(path, StandardCharsets.UTF_8.name());
        } else if (urlStr.startsWith("file:")) {
            // 普通 file: 协议直接提取路径（格式：file:/path/to/jar.jar → /path/to/jar.jar）
            return new File(url.toURI()).getPath();
        } else {
            throw new IllegalArgumentException("不支持的 URL 协议: " + urlStr);
        }
    }
}
