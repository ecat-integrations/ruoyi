package com.ecat.adapter.ruoyi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ecat.adapter.ruoyi.WebIntegrationInfo;
import com.ecat.adapter.ruoyi.EcatRuoyiAdapter;

/**
 * WebIntegrationController is a controller for quary web integrations information.
 * 
 * @author coffee
 */
@RestController
@RequestMapping("webintegration")
public class WebIntegrationController extends BaseController {

    @Autowired
    private EcatRuoyiAdapter ecatAdapter;

    /**
     * 根据Web集成名称查询模块信息
     * 
     * @param integrationName 集成标识（全限定类名）
     * @return 模块信息列表（含name/mtype/url）
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "name": "mock",
      "mtype": "device_register",
      "url": "/ecat-integrations/ecat-integrations-mock-ruoyi-gencode/mock.js"
    },
    {
      "name": "moduleB",
      "mtype": "web",
      "url": "/ecat-integrations/ecat-integrations-mock-ruoyi-gencode/moduleB.js"
    }
  ]
}
     */
    @PreAuthorize("@ss.hasPermi('webintegration:module:list')")
    @GetMapping("/module/list")
    public AjaxResult getIntegrationModules(@RequestParam String integrationName) {
        // EcatRuoyiIntegration ery = (EcatRuoyiIntegration) core.getIntegrationRegistry()
        //         .getIntegration("integration-ecat-ruoyi");
        Map<String, List<WebIntegrationInfo>> infoMap = ecatAdapter.getWebIntegrationInfoMap();
        List<WebIntegrationInfo> webInfoList = infoMap.get(integrationName);

        List<Map<String, Object>> result = new ArrayList<>();
        if (webInfoList != null) {
            for (WebIntegrationInfo info : webInfoList) {
                // 处理publicPath路径格式（确保以/结尾）
                String publicPath = info.getPublicPath().endsWith("/")
                        ? info.getPublicPath()
                        : info.getPublicPath() + "/";

                // 拼接URL：publicPath + module + .js
                String url = publicPath + info.getModuleName() + ".js";

                // 构造返回对象
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
     * 获取所有Web集成的基础信息
     * 
     * @return 集成名称与public_path列表
     * 
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "integrationName": "com.example.MockIntegration",
      "public_path": "/ecat-integrations/ecat-integrations-mock-ruoyi-gencode/"
    },
    {
      "integrationName": "com.example.ModuleBIntegration",
      "public_path": "/ecat-integrations/ecat-integrations-moduleB/"
    }
  ]
}
     */
    @PreAuthorize("@ss.hasPermi('webintegration:list')")
    @GetMapping("/list")
    public AjaxResult getAllIntegrations() {
        // EcatRuoyiIntegration ery = (EcatRuoyiIntegration) core.getIntegrationRegistry()
        //         .getIntegration("integration-ecat-ruoyi");
        Map<String, List<WebIntegrationInfo>> infoMap = ecatAdapter.getWebIntegrationInfoMap();
        List<Map<String, Object>> result = new ArrayList<>();

        // 遍历所有集成名称
        for (Map.Entry<String, List<WebIntegrationInfo>> entry : infoMap.entrySet()) {
            String integrationName = entry.getKey();
            List<WebIntegrationInfo> webInfoList = entry.getValue();

            // 取第一个模块的publicPath（同一集成下所有模块publicPath相同）
            if (!webInfoList.isEmpty()) {
                WebIntegrationInfo firstInfo = webInfoList.get(0);
                Map<String, Object> integrationItem = new HashMap<>();
                integrationItem.put("integrationName", integrationName);
                integrationItem.put("public_path", firstInfo.getPublicPath());
                result.add(integrationItem);
            }
        }

        return success(result);
    }
}
