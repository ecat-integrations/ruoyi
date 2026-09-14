# ruoyi

RuoYi管理后台（ruoyi-*系列 + ecat-adapter-ruoyi）
当前版本: 1.0.1

## 协议声明
1. 核心依赖：本插件基于 **ECAT Core**（Apache License 2.0）开发，Core 项目地址：https://github.com/ecat-project/ecat-core。
2. 插件自身：本插件的源代码采用 [MIT License] 授权（基于 RuoYi 框架）。
3. 合规说明：使用本插件需遵守 ECAT Core 的 Apache 2.0 协议规则，若复用 ECAT Core 代码片段，需保留原版权声明。

### 许可证获取
- ECAT Core 完整许可证：https://github.com/ecat-project/ecat-core/blob/main/LICENSE
- 本插件许可证：./LICENSE

## 前端加密令牌登录（V1）

用于外链/嵌入场景：通过 URL 携带混淆后的账号密码，打开登录页后自动登录（绕过验证码；后端仍按账号密码鉴权）。

实现位置：`ruoyi-ui-v3/src/utils/loginToken.js`  
配置（Vite）：`ruoyi-ui-v3/.env.development` / `.env.staging` / `.env.production` 中的 `VITE_LOGIN_*`

### V1 长度与协议约定

- **账号、密码必须各为 12 位**（定长协议，与历史 `login_jiami` 一致）
- 不满足 12 位的账号/密码无法生成或解析 V1 token（变长协议暂未实现）

### 如何生成 token

在前端工程中调用：

```js
import { buildLoginToken } from '@/utils/loginToken'

// account / password 须各 12 位；offset 可选，默认 3（取值 1–9）
const token = buildLoginToken('Admin1234567', '012345678912', 3)
// 示例：M0Q6Z3ZwTmw1cXM6SnY8PGduVTU2Snc4VDc
```

或在 `ruoyi-ui-v3` 目录执行自检脚本（会打印示例 token）：

```bash
cd ruoyi-ui-v3
node scripts/verify-login-token.mjs
```

### 如何使用

项目为 Hash 路由，访问：

```text
/#/login?token=<加密令牌>
/#/login?token=<加密令牌>&redirect=/index
```

兼容旧入口：`/#/login_jiami?token=...`（会跳转到 `/login`）。

需满足：`VITE_LOGIN_TOKEN_ENABLED=true`，且 `VITE_LOGIN_MODE` 为 `hybrid` 或 `auto_token`。  
修改生产环境 `.env.production` 后需重新执行 `npm run build:prod`（或等价构建）使配置生效。

