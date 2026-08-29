package com.ecat.adapter.ruoyi.menu;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ruoyi.common.core.domain.entity.SysMenu;
import com.ruoyi.system.domain.SysRoleMenu;
import com.ruoyi.system.mapper.SysMenuMapper;
import com.ruoyi.system.mapper.SysRoleMenuMapper;

/**
 * 将 vue-modules/module-config.json 幂等同步到 sys_menu。
 * <p>
 * 业务键为 remark=ecat-sync:{integration}/{module}/{route}；F 按钮可按 perms 复用已有行（ADM 决策 C 种子）。
 * 再次同步不覆盖改过的 visible / order_num / menu_name / icon / status / parent_id。
 */
@Service
public class EcatMenuSyncService {

    private static final Logger log = LoggerFactory.getLogger(EcatMenuSyncService.class);

    @Autowired
    private SysMenuMapper menuMapper;

    @Autowired
    private SysRoleMenuMapper roleMenuMapper;

    /**
     * 同步菜单并返回该子模块页面级权限（供 webintegration 接口按用户过滤）。
     */
    @Transactional
    public List<String> sync(String integrationName, String moduleName, List<Map<String, Object>> moduleRoutes) {
        EcatMenuSpecBuilder builder = EcatMenuSpecBuilder.from(integrationName, moduleName, moduleRoutes);
        upsertAll(builder.getSpecs());
        cleanupLegacyAdmPermDir();
        return builder.getAccessPerms();
    }

    public List<String> collectAccessPerms(String integrationName, String moduleName,
            List<Map<String, Object>> moduleRoutes) {
        return EcatMenuSpecBuilder.from(integrationName, moduleName, moduleRoutes).getAccessPerms();
    }

    private void upsertAll(List<EcatMenuSpec> specs) {
        Map<String, Long> remarkToId = new HashMap<>();
        for (EcatMenuSpec spec : specs) {
            Long parentId = 0L;
            if (spec.getParentRemarkKey() != null) {
                Long resolved = remarkToId.get(spec.getParentRemarkKey());
                parentId = resolved != null ? resolved : 0L;
            }
            SysMenu existing = menuMapper.selectMenuByRemark(spec.getRemarkKey());
            if (existing == null && "F".equals(spec.getMenuType())
                    && spec.getPerms() != null && !spec.getPerms().isEmpty()) {
                existing = menuMapper.selectMenuByPerms(spec.getPerms());
            }
            Long menuId;
            if (existing == null) {
                menuId = insertSpec(spec, parentId);
            } else {
                menuId = existing.getMenuId();
                updateStructural(existing, spec, parentId);
            }
            remarkToId.put(spec.getRemarkKey(), menuId);
            grantAdminRole(menuId);
            retireLegacyButtonIfPromoted(spec);
        }
    }

    /**
     * ADM 决策 C 曾把页面 list 权限建成 F 按钮。现改为 C 菜单后删除同 perms 的旧 F，避免角色树重复。
     */
    private void retireLegacyButtonIfPromoted(EcatMenuSpec spec) {
        if (!"C".equals(spec.getMenuType()) || spec.getPerms() == null || spec.getPerms().isEmpty()) {
            return;
        }
        SysMenu legacyF = menuMapper.selectMenuByPerms(spec.getPerms());
        if (legacyF == null || EcatMenuKeys.isEcatSyncRemark(legacyF.getRemark())) {
            return;
        }
        roleMenuMapper.deleteRoleMenuByMenuId(legacyF.getMenuId());
        menuMapper.deleteMenuById(legacyF.getMenuId());
        log.info("ecat-sync 删除已提升为菜单的旧 F 权限行 perms={} menuId={}", spec.getPerms(), legacyF.getMenuId());
    }

    private Long insertSpec(EcatMenuSpec spec, Long parentId) {
        SysMenu menu = new SysMenu();
        menu.setParentId(parentId);
        menu.setMenuName(spec.getMenuName());
        menu.setOrderNum(spec.getOrderNum());
        menu.setPath(spec.getPath());
        menu.setIsFrame("1");
        menu.setIsCache(spec.getIsCache());
        menu.setMenuType(spec.getMenuType());
        menu.setVisible(spec.getVisible());
        menu.setStatus("0");
        menu.setPerms(spec.getPerms());
        menu.setIcon(spec.getIcon() == null || spec.getIcon().isEmpty() ? "#" : spec.getIcon());
        menu.setRemark(spec.getRemarkKey());
        menu.setCreateBy(EcatMenuKeys.CREATE_BY);
        menuMapper.insertMenu(menu);
        if (menu.getMenuId() == null) {
            SysMenu inserted = menuMapper.selectMenuByRemark(spec.getRemarkKey());
            if (inserted != null) {
                menu.setMenuId(inserted.getMenuId());
            }
        }
        log.info("ecat-sync 新增菜单 {} type={} perms={} id={}", spec.getMenuName(), spec.getMenuType(),
                spec.getPerms(), menu.getMenuId());
        return menu.getMenuId();
    }

    private void updateStructural(SysMenu existing, EcatMenuSpec spec, Long parentId) {
        SysMenu patch = new SysMenu();
        patch.setMenuId(existing.getMenuId());
        if (EcatMenuKeys.shouldRefreshParent(existing.getParentId(), parentId, existing.getUpdateBy())) {
            patch.setParentId(parentId);
        }
        patch.setPath(spec.getPath());
        patch.setPerms(spec.getPerms() == null ? "" : spec.getPerms());
        patch.setMenuType(spec.getMenuType());
        patch.setRemark(spec.getRemarkKey());
        if (EcatMenuKeys.shouldRefreshMenuName(existing.getMenuName(), spec.getMenuName(), existing.getUpdateBy())) {
            patch.setMenuName(spec.getMenuName());
            patch.setUpdateBy(EcatMenuKeys.CREATE_BY);
            log.info("ecat-sync 纠正菜单名称 {} → {} id={}", existing.getMenuName(), spec.getMenuName(),
                    existing.getMenuId());
        }
        menuMapper.updateMenu(patch);
    }

    private void grantAdminRole(Long menuId) {
        if (menuId == null) {
            return;
        }
        int count = roleMenuMapper.countRoleMenu(EcatMenuKeys.ADMIN_ROLE_ID, menuId);
        if (count > 0) {
            return;
        }
        SysRoleMenu rm = new SysRoleMenu();
        rm.setRoleId(EcatMenuKeys.ADMIN_ROLE_ID);
        rm.setMenuId(menuId);
        roleMenuMapper.batchRoleMenu(Collections.singletonList(rm));
    }

    /**
     * 菜单管理里对 ecat 行改过的 visible / status / order_num / parent_id，供前端侧边栏按若依规则套用。
     * visible: 0 显示 1 隐藏；status: 0 正常 1 停用；parentId=0 表示主类目。
     */
    public Map<String, Map<String, String>> listDisplayFlags() {
        List<SysMenu> menus = menuMapper.selectEcatSyncMenus();
        Map<String, Map<String, String>> flags = new HashMap<>();
        if (menus == null) {
            return flags;
        }
        Map<Long, SysMenu> ecatById = new HashMap<>();
        for (SysMenu menu : menus) {
            if (menu.getMenuId() != null) {
                ecatById.put(menu.getMenuId(), menu);
            }
        }
        for (SysMenu menu : menus) {
            if (menu.getRemark() == null || menu.getRemark().isEmpty()) {
                continue;
            }
            Map<String, String> flag = new HashMap<>();
            flag.put("visible", trimFlag(menu.getVisible(), "0"));
            flag.put("status", trimFlag(menu.getStatus(), "0"));
            flag.put("orderNum", menu.getOrderNum() == null ? "0" : String.valueOf(menu.getOrderNum()));
            Long menuId = menu.getMenuId();
            Long parentId = menu.getParentId() == null ? 0L : menu.getParentId();
            flag.put("menuId", menuId == null ? "" : String.valueOf(menuId));
            flag.put("parentId", String.valueOf(parentId));
            SysMenu parent = ecatById.get(parentId);
            if (parent != null && EcatMenuKeys.isEcatSyncRemark(parent.getRemark())) {
                flag.put("parentRemark", parent.getRemark());
            }
            flags.put(menu.getRemark(), flag);
        }
        return flags;
    }

    private static String trimFlag(String raw, String fallback) {
        if (raw == null) {
            return fallback;
        }
        String s = raw.trim();
        return s.isEmpty() ? fallback : s;
    }

    /**
     * ADM 决策 C 隐藏父目录在 F 按钮迁到新 C 菜单后若已空则删除，避免角色树双份「空气设备管理」。
     */
    private void cleanupLegacyAdmPermDir() {
        SysMenu legacy = menuMapper.checkMenuNameUnique("空气设备管理(权限)", 0L, -1L, false);
        if (legacy == null) {
            return;
        }
        if (menuMapper.hasChildByMenuId(legacy.getMenuId()) == 0) {
            roleMenuMapper.deleteRoleMenuByMenuId(legacy.getMenuId());
            menuMapper.deleteMenuById(legacy.getMenuId());
            log.info("ecat-sync 删除空的 ADM 隐藏权限目录 menuId={}", legacy.getMenuId());
        }
    }
}
