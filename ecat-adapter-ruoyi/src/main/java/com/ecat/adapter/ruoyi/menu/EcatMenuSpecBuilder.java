package com.ecat.adapter.ruoyi.menu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 把 module-config.json 的 module_routes 转成 sys_menu 规格，并收集页面级 accessPerms。
 */
public class EcatMenuSpecBuilder {

    private final String integrationName;
    private final String moduleName;
    private final List<EcatMenuSpec> specs = new ArrayList<>();
    private final LinkedHashSet<String> accessPerms = new LinkedHashSet<>();

    public EcatMenuSpecBuilder(String integrationName, String moduleName) {
        this.integrationName = integrationName;
        this.moduleName = moduleName;
    }

    public static EcatMenuSpecBuilder from(String integrationName, String moduleName,
            List<Map<String, Object>> moduleRoutes) {
        EcatMenuSpecBuilder builder = new EcatMenuSpecBuilder(integrationName, moduleName);
        builder.build(moduleRoutes);
        return builder;
    }

    public List<EcatMenuSpec> getSpecs() {
        return specs;
    }

    public List<String> getAccessPerms() {
        return new ArrayList<>(accessPerms);
    }

    public Set<String> getAccessPermSet() {
        return Collections.unmodifiableSet(accessPerms);
    }

    private void build(List<Map<String, Object>> moduleRoutes) {
        if (moduleRoutes == null || moduleRoutes.isEmpty()) {
            return;
        }
        String groupParentKey = null;
        int order = 0;
        for (Map<String, Object> route : moduleRoutes) {
            if (isLayoutDirectory(route)) {
                groupParentKey = walkRoute(route, null, order++);
            } else {
                walkRoute(route, groupParentKey, order++);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private String walkRoute(Map<String, Object> route, String parentKey, int order) {
        String routeName = stringVal(route.get("name"), "unnamed");
        String remarkKey = EcatMenuKeys.routeKey(integrationName, moduleName, routeName);
        List<Map<String, Object>> children = childrenOf(route);
        boolean layoutDir = isLayoutDirectory(route);
        String type = layoutDir ? "M" : "C";

        Map<String, Object> meta = route.get("meta") instanceof Map
                ? (Map<String, Object>) route.get("meta")
                : Collections.emptyMap();
        String title = stringVal(meta.get("title"), routeName);
        String icon = stringVal(meta.get("icon"), "#");
        boolean noCache = Boolean.TRUE.equals(meta.get("noCache"));
        boolean hidden = Boolean.TRUE.equals(route.get("hidden"));

        List<String> permissions = stringList(route.get("permissions"));
        String perm = permissions.isEmpty() ? "" : permissions.get(0);
        for (String p : permissions) {
            if (p != null && !p.isEmpty()) {
                accessPerms.add(p);
            }
        }

        EcatMenuSpec spec = new EcatMenuSpec();
        spec.setRemarkKey(remarkKey);
        spec.setParentRemarkKey(parentKey);
        spec.setMenuName(title);
        spec.setMenuType(type);
        spec.setPath(layoutDir ? ("ecat-" + moduleName) : stringVal(route.get("path"), routeName));
        spec.setPerms(perm);
        spec.setIcon(icon);
        spec.setVisible(hidden ? "1" : "0");
        spec.setIsCache(noCache ? "1" : "0");
        spec.setOrderNum(order);
        specs.add(spec);

        List<Map<String, Object>> buttons = childrenOfKey(route, "buttons");
        int bi = 0;
        for (Map<String, Object> button : buttons) {
            String btnPerms = stringVal(button.get("perms"), "");
            if (btnPerms.isEmpty()) {
                continue;
            }
            EcatMenuSpec btn = new EcatMenuSpec();
            btn.setRemarkKey(EcatMenuKeys.buttonKey(integrationName, moduleName, routeName, btnPerms));
            btn.setParentRemarkKey(remarkKey);
            btn.setMenuName(stringVal(button.get("title"), btnPerms));
            btn.setMenuType("F");
            btn.setPath("");
            btn.setPerms(btnPerms);
            btn.setIcon("#");
            btn.setVisible("0");
            btn.setIsCache("0");
            btn.setOrderNum(bi++);
            specs.add(btn);
        }

        int ci = 0;
        for (Map<String, Object> child : children) {
            walkRoute(child, remarkKey, ci++);
        }
        return remarkKey;
    }

    @SuppressWarnings("unchecked")
    private static boolean isLayoutDirectory(Map<String, Object> route) {
        List<Map<String, Object>> children = childrenOf(route);
        return "Layout".equals(route.get("component")) && children != null && !children.isEmpty();
    }

    @SuppressWarnings("unchecked")
    private static List<Map<String, Object>> childrenOf(Map<String, Object> route) {
        return childrenOfKey(route, "children");
    }

    @SuppressWarnings("unchecked")
    private static List<Map<String, Object>> childrenOfKey(Map<String, Object> route, String key) {
        Object raw = route.get(key);
        if (!(raw instanceof List)) {
            return Collections.emptyList();
        }
        List<?> list = (List<?>) raw;
        List<Map<String, Object>> out = new ArrayList<>();
        for (Object item : list) {
            if (item instanceof Map) {
                out.add((Map<String, Object>) item);
            }
        }
        return out;
    }

    private static List<String> stringList(Object raw) {
        if (raw == null) {
            return Collections.emptyList();
        }
        if (raw instanceof String) {
            String s = ((String) raw).trim();
            return s.isEmpty() ? Collections.emptyList() : Collections.singletonList(s);
        }
        if (raw instanceof List) {
            List<String> out = new ArrayList<>();
            for (Object item : (List<?>) raw) {
                if (item != null) {
                    String s = String.valueOf(item).trim();
                    if (!s.isEmpty()) {
                        out.add(s);
                    }
                }
            }
            return out;
        }
        return Collections.emptyList();
    }

    private static String stringVal(Object raw, String fallback) {
        if (raw == null) {
            return fallback;
        }
        String s = String.valueOf(raw).trim();
        return s.isEmpty() ? fallback : s;
    }
}
