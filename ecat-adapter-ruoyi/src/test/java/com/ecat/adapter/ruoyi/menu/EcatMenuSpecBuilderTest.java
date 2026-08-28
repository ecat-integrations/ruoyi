package com.ecat.adapter.ruoyi.menu;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

public class EcatMenuSpecBuilderTest {

    @Test
    public void buildsDirectoryMenuChildrenAndButtons() {
        Map<String, Object> child = route("device_control", "device_control", "views/DevicePanel", "设备控制", false);
        child.put("permissions", Arrays.asList("device:device_info:list"));
        child.put("buttons", Arrays.asList(button("修改设置", "device_control_setting:settings:edit")));

        Map<String, Object> dir = route("index", "index", "Layout", "设备管理", false);
        dir.put("children", Arrays.asList(child));

        EcatMenuSpecBuilder builder = EcatMenuSpecBuilder.from("integration-env-device-manager", "device-manager",
                Arrays.asList(dir));

        List<EcatMenuSpec> specs = builder.getSpecs();
        assertEquals(3, specs.size());
        assertEquals("M", specs.get(0).getMenuType());
        assertEquals("C", specs.get(1).getMenuType());
        assertEquals("device:device_info:list", specs.get(1).getPerms());
        assertEquals("F", specs.get(2).getMenuType());
        assertEquals("device_control_setting:settings:edit", specs.get(2).getPerms());
        assertTrue(specs.get(2).getRemarkKey().startsWith(EcatMenuKeys.REMARK_PREFIX));
        assertEquals(Arrays.asList("device:device_info:list"), builder.getAccessPerms());
    }

    @Test
    public void attachesHiddenRootRouteUnderLayoutDirectory() {
        Map<String, Object> visible = route("diagram_manager", "diagram_manager", "views/diagramManager", "全域智控视图", false);
        visible.put("permissions", Arrays.asList("diagram:device:list"));
        Map<String, Object> dir = route("index", "index", "Layout", "全域智控视图", false);
        dir.put("children", Arrays.asList(visible));

        Map<String, Object> hidden = route("diagram_view_full", "diagram_view_full", "views/diagramView", "预览", true);
        hidden.put("permissions", Arrays.asList("diagram:device:list"));

        EcatMenuSpecBuilder builder = EcatMenuSpecBuilder.from("integration-env-diagram", "diagram-manager",
                Arrays.asList(dir, hidden));
        List<EcatMenuSpec> specs = builder.getSpecs();
        assertEquals(3, specs.size());
        assertEquals("M", specs.get(0).getMenuType());
        assertEquals(specs.get(0).getRemarkKey(), specs.get(2).getParentRemarkKey());
        assertEquals("1", specs.get(2).getVisible());
    }

    private static Map<String, Object> route(String name, String path, String component, String title, boolean hidden) {
        Map<String, Object> meta = new HashMap<>();
        meta.put("title", title);
        meta.put("icon", "list");
        Map<String, Object> route = new HashMap<>();
        route.put("name", name);
        route.put("path", path);
        route.put("component", component);
        route.put("hidden", hidden);
        route.put("meta", meta);
        return route;
    }

    private static Map<String, Object> button(String title, String perms) {
        Map<String, Object> btn = new HashMap<>();
        btn.put("title", title);
        btn.put("perms", perms);
        return btn;
    }
}
