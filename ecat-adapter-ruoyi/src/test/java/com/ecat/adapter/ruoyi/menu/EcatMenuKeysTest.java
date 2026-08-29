package com.ecat.adapter.ruoyi.menu;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

import org.junit.Test;

public class EcatMenuKeysTest {

    @Test
    public void utf8MisreadAsGbkMatchesReportedMojibake() {
        Charset gbk = Charset.forName("GBK");
        assertEquals("鐗╄祫绠＄悊", new String("物资管理".getBytes(StandardCharsets.UTF_8), gbk));
        assertEquals("璐ㄦ帶鏌ヨ", new String("质控查询".getBytes(StandardCharsets.UTF_8), gbk));
        assertTrue(EcatMenuKeys.isGbkMojibakeOfUtf8("鐗╄祫绠＄悊", "物资管理"));
        assertTrue(EcatMenuKeys.isGbkMojibakeOfUtf8("璐ㄦ帶鏌ヨ", "质控查询"));
    }

    @Test
    public void refreshGarbledNameEvenIfOpsTouchedUpdateBy() {
        assertTrue(EcatMenuKeys.shouldRefreshMenuName("鐗╄祫绠＄悊", "物资管理", "admin"));
    }

    @Test
    public void keepOpsRenamedTitle() {
        assertFalse(EcatMenuKeys.shouldRefreshMenuName("耗材管理", "物资管理", "admin"));
    }

    @Test
    public void refreshWhenStillOwnedBySync() {
        assertTrue(EcatMenuKeys.shouldRefreshMenuName("鐗╄祫绠＄悊", "物资管理", EcatMenuKeys.CREATE_BY));
        assertFalse(EcatMenuKeys.shouldRefreshMenuName("物资管理", "物资管理", EcatMenuKeys.CREATE_BY));
    }

    @Test
    public void keepOpsMovedParent() {
        assertFalse(EcatMenuKeys.shouldRefreshParent(100L, 0L, "admin"));
        assertTrue(EcatMenuKeys.shouldRefreshParent(100L, 0L, EcatMenuKeys.CREATE_BY));
        assertTrue(EcatMenuKeys.shouldRefreshParent(100L, 0L, null));
        assertFalse(EcatMenuKeys.shouldRefreshParent(0L, 0L, "admin"));
    }

    @Test
    public void frontendPrefixedRouteNameMapsToRemarkKey() {
        String integration = "integration-env-device-manager";
        String frontendName = integration + "_device_control";
        String original = frontendName.substring(integration.length() + 1);
        assertEquals("device_control", original);
        assertEquals("ecat-sync:integration-env-device-manager/device-manager/device_control",
                EcatMenuKeys.routeKey(integration, "device-manager", original));
    }
}
