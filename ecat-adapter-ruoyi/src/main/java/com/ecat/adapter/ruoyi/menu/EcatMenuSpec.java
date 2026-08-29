package com.ecat.adapter.ruoyi.menu;

/**
 * 一条待同步到 sys_menu 的菜单/按钮描述。
 */
public class EcatMenuSpec {

    private String remarkKey;
    private String parentRemarkKey;
    private String menuName;
    private String menuType;
    private String path;
    private String perms;
    private String icon;
    private String visible;
    private String isCache;
    private int orderNum;

    public String getRemarkKey() {
        return remarkKey;
    }

    public void setRemarkKey(String remarkKey) {
        this.remarkKey = remarkKey;
    }

    public String getParentRemarkKey() {
        return parentRemarkKey;
    }

    public void setParentRemarkKey(String parentRemarkKey) {
        this.parentRemarkKey = parentRemarkKey;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getPerms() {
        return perms;
    }

    public void setPerms(String perms) {
        this.perms = perms;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getVisible() {
        return visible;
    }

    public void setVisible(String visible) {
        this.visible = visible;
    }

    public String getIsCache() {
        return isCache;
    }

    public void setIsCache(String isCache) {
        this.isCache = isCache;
    }

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }
}
