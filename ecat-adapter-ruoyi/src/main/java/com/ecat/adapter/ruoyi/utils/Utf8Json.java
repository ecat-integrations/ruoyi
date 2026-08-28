package com.ecat.adapter.ruoyi.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 按 JSON 规范以 UTF-8 解析，避免 Windows 默认 GBK 把中文菜单标题读成乱码。
 */
public final class Utf8Json {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    private Utf8Json() {
    }

    public static Map<String, Object> readMap(InputStream in) throws IOException {
        return MAPPER.readValue(in, new TypeReference<Map<String, Object>>() {
        });
    }
}
