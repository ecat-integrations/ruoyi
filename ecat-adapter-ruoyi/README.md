# 组件作用
作为ecat与ruoyi框架的通讯桥梁，处理两者之间相互调用

# 依赖
依赖 springboot 框架

# 使用介绍
被ruoyi-admin引用即可
```
<dependency>
    <groupId>com.ecat.adapter</groupId>
    <artifactId>ecat-adapter-ruoyi</artifactId>
    <version>1.0.0</version>
</dependency>
```

# 对外提供能力
+ 查询适用于ruoyi-ui的Web集成信息接口，见 WebIntegrationController

# TODO:
+ 每个集成还需要在加载时初始化数据库的表结构和权限信息，比如使用sql或语句执行，考虑避免误删除已有数据
+ 目前vue前端模块没有与菜单权限绑定，后期增加时可以在菜单管理中增加路由地址为ecat-integrations/integration-mock-ruoyi-gencode/mock/index的菜单，然后在ruoter加载路由时与各集成的模块进行匹配加载，实现权限与动态集成绑定。
