package com.ecat.adapter.ruoyi.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ecat.adapter.ruoyi.WebIntegrationInfo;
import com.ecat.adapter.ruoyi.EcatRuoyiAdapter;
import com.ecat.adapter.ruoyi.menu.EcatMenuSyncService;

/**
 * WebIntegrationController is a controller for quary web integrations information.
 *
 * 列表接口只要求登录（SecurityConfig anyRequest authenticated），再按用户 menu perms 过滤模块，
 * 避免 webintegration:list 成为「全有/全无」门槛。
 *
 * @author coffee
 */
@RestController
@RequestMapping("webintegration")
public class WebIntegrationController extends BaseController {

    @Autowired
    private EcatRuoyiAdapter ecatAdapter;

    @Autowired(required = false)
    private EcatMenuSyncService menuSyncService;

    /**
     * 根据Web集成名称查询模块信息
     *
     * @param integrationName 集成标识（全限定类名）
     * @return 模块信息列表（含name/mtype/url）
     */
    @GetMapping("/module/list")
    public AjaxResult getIntegrationModules(@RequestParam String integrationName) {
        Map<String, List<WebIntegrationInfo>> infoMap = ecatAdapter.getWebIntegrationInfoMap();
        List<WebIntegrationInfo> webInfoList = infoMap.get(integrationName);
        Set<String> userPerms = currentPerms();

        List<Map<String, Object>> result = new ArrayList<>();
        if (webInfoList != null) {
            for (WebIntegrationInfo info : webInfoList) {
                if (!info.allows(userPerms)) {
                    continue;
                }
                String publicPath = info.getPublicPath().endsWith("/")
                        ? info.getPublicPath()
                        : info.getPublicPath() + "/";
                String url = publicPath + info.getModuleName() + ".js";

                Map<String, Object> moduleInfo = new HashMap<>();
                moduleInfo.put("name", info.getModuleName());
                moduleInfo.put("mtype", info.getMtype());
                moduleInfo.put("url", url);
                result.add(moduleInfo);
            }
        }
        return success(result);
    }

    /**
     * 获取当前用户有权加载的 Web 集成基础信息
     */
    @GetMapping("/list")
    public AjaxResult getAllIntegrations() {
        Map<String, List<WebIntegrationInfo>> infoMap = ecatAdapter.getWebIntegrationInfoMap();
        Set<String> userPerms = currentPerms();
        List<Map<String, Object>> result = new ArrayList<>();

        for (Map.Entry<String, List<WebIntegrationInfo>> entry : infoMap.entrySet()) {
            String integrationName = entry.getKey();
            List<WebIntegrationInfo> webInfoList = entry.getValue();
            if (webInfoList == null || webInfoList.isEmpty()) {
                continue;
            }
            boolean allowed = false;
            for (WebIntegrationInfo info : webInfoList) {
                if (info.allows(userPerms)) {
                    allowed = true;
                    break;
                }
            }
            if (!allowed) {
                continue;
            }
            WebIntegrationInfo firstInfo = webInfoList.get(0);
            Map<String, Object> integrationItem = new HashMap<>();
            integrationItem.put("integrationName", integrationName);
            integrationItem.put("public_path", firstInfo.getPublicPath());
            result.add(integrationItem);
        }

        return success(result);
    }

    /**
     * ecat 菜单运行时标志（remark → visible/status/orderNum/parentId），供侧边栏覆盖 module-config 默认树。
     */
    @GetMapping("/menu-flags")
    public AjaxResult getMenuFlags() {
        if (menuSyncService == null) {
            return success(Collections.emptyMap());
        }
        return success(menuSyncService.listDisplayFlags());
    }

    private Set<String> currentPerms() {
        try {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser == null || loginUser.getPermissions() == null) {
                return Collections.emptySet();
            }
            return loginUser.getPermissions();
        } catch (Exception e) {
            return Collections.emptySet();
        }
    }
}
