package com.ecat.adapter.ruoyi;

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

    public WebIntegrationInfo(String integrationName, String moduleName, String publicPath, String mtype) {
        this.integrationName = integrationName;
        this.moduleName = moduleName;
        this.publicPath = publicPath;
        this.mtype = mtype;
    }

    // Getter方法
    public String getIntegrationName() { return integrationName; }
    public String getModuleName() { return moduleName; }
    public String getPublicPath() { return publicPath; }
    public String getMtype() { return mtype; }
}
