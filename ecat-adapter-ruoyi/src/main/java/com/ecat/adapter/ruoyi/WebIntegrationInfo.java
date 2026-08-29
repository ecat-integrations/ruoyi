package com.ecat.adapter.ruoyi;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import com.ruoyi.common.constant.Constants;

/**
 * IntegrationWebInfo is a class that stores information about the web integration module.
 *
 * @author coffee
 */
public class WebIntegrationInfo {
    private String integrationName;  // 集成标识
    private String moduleName;       // 来自config的module_name
    private String publicPath;       // 来自config的public_path
    private String mtype;            // 来自sub_modules的mtype
    /** 该子模块页面级权限，用于按登录用户过滤 webintegration 列表 */
    private List<String> accessPerms = new ArrayList<>();

    public WebIntegrationInfo(String integrationName, String moduleName, String publicPath, String mtype) {
        this.integrationName = integrationName;
        this.moduleName = moduleName;
        this.publicPath = publicPath;
        this.mtype = mtype;
    }

    public String getIntegrationName() { return integrationName; }
    public String getModuleName() { return moduleName; }
    public String getPublicPath() { return publicPath; }
    public String getMtype() { return mtype; }

    public List<String> getAccessPerms() {
        return accessPerms == null ? Collections.emptyList() : accessPerms;
    }

    public void setAccessPerms(List<String> accessPerms) {
        this.accessPerms = accessPerms == null ? new ArrayList<>() : new ArrayList<>(accessPerms);
    }

    /**
     * 用户是否可加载该子模块 JS。未声明页面权限时保持兼容（对已登录用户可见）。
     */
    public boolean allows(Set<String> userPerms) {
        if (userPerms != null && userPerms.contains(Constants.ALL_PERMISSION)) {
            return true;
        }
        List<String> required = getAccessPerms();
        if (required.isEmpty()) {
            return true;
        }
        if (userPerms == null || userPerms.isEmpty()) {
            return false;
        }
        for (String p : required) {
            if (p != null && userPerms.contains(p)) {
                return true;
            }
        }
        return false;
    }
}
