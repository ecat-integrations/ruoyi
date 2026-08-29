package com.ecat.adapter.ruoyi.utils;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import java.io.ByteArrayInputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.junit.Test;

public class Utf8JsonTest {

    @Test
    public void readsChineseTitleAsUtf8NotPlatformGbk() throws Exception {
        byte[] json = "{\"title\":\"物资管理\"}".getBytes(StandardCharsets.UTF_8);
        Map<String, Object> map = Utf8Json.readMap(new ByteArrayInputStream(json));
        assertEquals("物资管理", map.get("title"));
        String asGbk = new String(json, Charset.forName("GBK"));
        assertFalse(asGbk.contains("物资管理"));
    }
}
