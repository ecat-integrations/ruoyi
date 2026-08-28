package com.ecat.adapter.ruoyi.menu;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

/**
 * ecat 动态菜单写入 sys_menu 的业务键。
 * getRouters 用此前缀排除，避免与 vue-module 侧边栏重复。
 */
public final class EcatMenuKeys {

    public static final String REMARK_PREFIX = "ecat-sync:";

    public static final String CREATE_BY = "ecat-sync";

    public static final Long ADMIN_ROLE_ID = 1L;

    private EcatMenuKeys() {
    }

    public static String routeKey(String integrationName, String moduleName, String routeName) {
        return REMARK_PREFIX + integrationName + "/" + moduleName + "/" + routeName;
    }

    public static String buttonKey(String integrationName, String moduleName, String routeName, String perms) {
        return routeKey(integrationName, moduleName, routeName) + ":" + perms;
    }

    public static boolean isEcatSyncRemark(String remark) {
        return remark != null && remark.startsWith(REMARK_PREFIX);
    }

    /**
     * UTF-8 中文被按 GBK 解码后的典型乱码（物资管理 → 鐗╄祫绠＄悊）。
     */
    public static boolean isGbkMojibakeOfUtf8(String stored, String expectedUtf8) {
        if (stored == null || expectedUtf8 == null || stored.equals(expectedUtf8)) {
            return false;
        }
        try {
            String misdecoded = new String(expectedUtf8.getBytes(StandardCharsets.UTF_8), Charset.forName("GBK"));
            return stored.equals(misdecoded);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 同步时是否用 JSON 标题覆盖库中的 menu_name。
     * 乱码一律纠正；运维在菜单管理里改过名称（updateBy 非 ecat-sync）则保留。
     */
    public static boolean shouldRefreshMenuName(String current, String expected, String updateBy) {
        if (expected == null || expected.isEmpty() || expected.equals(current)) {
            return false;
        }
        if (isGbkMojibakeOfUtf8(current, expected)) {
            return true;
        }
        return updateBy == null || updateBy.isEmpty() || CREATE_BY.equals(updateBy);
    }
}
