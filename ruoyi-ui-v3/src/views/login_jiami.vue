<template>
  <div class="login">
    <div class="loading-container">
      <div class="loading-content">
        <el-icon class="loading-icon"><RefreshRight /></el-icon>
        <p class="loading-text">{{ loadingMessage }}</p>
      </div>
    </div>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>Copyright © 2018-2025 ruoyi.vip All Rights Reserved.</span>
    </div>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from "@/utils/jsencrypt";
import useUserStore from '@/store/modules/user'
import { RefreshRight } from '@element-plus/icons-vue'

const title = import.meta.env.VITE_APP_TITLE;
const userStore = useUserStore();
const route = useRoute();
const router = useRouter();
const { proxy } = getCurrentInstance();

const loginForm = ref({
  username: "",
  password: "",
  rememberMe: false,
  code: "",
  uuid: ""
});

const loginRules = {
  username: [{ required: true, trigger: "blur", message: "请输入您的账号" }],
  password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
};

const codeUrl = ref("");
const loading = ref(false);
// 验证码开关
const captchaEnabled = ref(true);
// 注册开关
const register = ref(false);
const redirect = ref(undefined);

// 新增变量用于处理token自动登录
const loadingMessage = ref('正在加载中...');
const tokenStr = ref('');

// 监听路由变化，获取token并执行自动登录
watch(route, (newRoute) => {
  redirect.value = newRoute.query && newRoute.query.redirect;

  // 获取URL参数中的token
  tokenStr.value = newRoute.query.token || '';

  // 如果存在token，则尝试自动登录
  if (tokenStr.value) {
    handleTokenAutoLogin();
  } else {
    // 如果没有token，显示错误信息
    loadingMessage.value = '加载失败，验证信息错误！';
  }
}, { immediate: true });

// 封装URL安全的Base64解码函数
function urlSafeBase64Decode(str) {
  // 还原URL安全字符为标准Base64字符
  let base64Str = str.replace(/-/g, '+').replace(/_/g, '/');
  // 补充Base64缺失的等号（Base64长度必须是4的倍数）
  while (base64Str.length % 4 !== 0) {
    base64Str += '=';
  }
  // 浏览器内置atob解码，再转成UTF-8字符串
  try {
    const decodedBytes = atob(base64Str);
    const decodedStr = decodeURIComponent(escape(decodedBytes));
    return decodedStr;
  } catch (e) {
    throw new Error("Base64解码失败，token格式错误");
  }
}

// 解析账号密码
function parseAccountPwd(token) {
  try {
    // 第一步：先解码URL安全的Base64，得到原始混淆串
    const baseStr = urlSafeBase64Decode(token);
    // 第二步：解析原始混淆串
    const offset = parseInt(baseStr[0]); // 第一位是偏移量
    const checkBit = parseInt(baseStr[baseStr.length - 1]); // 最后一位是校验位

    // 校验偏移量和校验位是否合法
    if (isNaN(offset) || isNaN(checkBit) || offset + checkBit !== 10) {
      throw new Error("验证信息失败，请重新进入！");
    }

    // 提取加密字符部分（去掉首位的偏移量和末位的校验位）
    const encryptedPart = baseStr.slice(1, -1);
    if (encryptedPart.length !== 24) {
      throw new Error("验证信息失败，请重新进入！");
    }

    // 还原字符（ASCII码减去偏移量）
    let decryptedChars = [];
    for (let i = 0; i < encryptedPart.length; i++) {
      const char = encryptedPart[i];
      const originalChar = String.fromCharCode(char.charCodeAt(0) - offset);
      decryptedChars.push(originalChar);
    }

    // 分离账号和密码（偶数位是账号，奇数位是密码）
    let account = "";
    let password = "";
    for (let i = 0; i < decryptedChars.length; i++) {
      if (i % 2 === 0) {
        account += decryptedChars[i];
      } else {
        password += decryptedChars[i];
      }
    }

    // 验证账号密码长度
    if (account.length !== 12 || password.length !== 12) {
      throw new Error("解析出的账号/密码长度不符合要求");
    }

    return { account, password };
  } catch (e) {
    throw new Error(`解析失败：${e.message}`);
  }
}

// 使用token自动登录
async function handleTokenAutoLogin() {
  loadingMessage.value = '正在解析登录信息...';

  try {
    // 解析token获取账号密码
    const { account, password } = parseAccountPwd(tokenStr.value);

    // 设置表单数据
    loginForm.value.username = account;
    loginForm.value.password = password;

    loadingMessage.value = '正在自动加载验证...';

    // 执行自动登录
    await userStore.login(loginForm.value);

    // 登录成功，跳转到目标页面
    const query = route.query;
    const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
      if (cur !== "redirect") {
        acc[cur] = query[cur];
      }
      return acc;
    }, {});
    router.push({ path: redirect.value || "/", query: otherQueryParams });

  } catch (error) {
    // 解析失败或登录失败
    loadingMessage.value = error.message || '登录失败，请检查登录信息';
    console.error('自动登录失败:', error);
  }
}

// 以下函数保留但不会被调用，因为不再显示登录表单
function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true;
      // 勾选了需要记住密码设置在 cookie 中设置记住用户名和密码
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 });
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 });
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 });
      } else {
        // 否则移除
        Cookies.remove("username");
        Cookies.remove("password");
        Cookies.remove("rememberMe");
      }
      // 调用action的登录方法
      userStore.login(loginForm.value).then(() => {
        const query = route.query;
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") {
            acc[cur] = query[cur];
          }
          return acc;
        }, {});
        router.push({ path: redirect.value || "/", query: otherQueryParams });
      }).catch(() => {
        loading.value = false;
        // 重新获取验证码
        if (captchaEnabled.value) {
          getCode();
        }
      });
    }
  });
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled;
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img;
      loginForm.value.uuid = res.uuid;
    }
  });
}

function getCookie() {
  const username = Cookies.get("username");
  const password = Cookies.get("password");
  const rememberMe = Cookies.get("rememberMe");
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  };
}

// 初始化时获取验证码和cookie，但因为不显示登录表单，这些可能不需要
getCode();
getCookie();
</script>

<style lang='scss' scoped>
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-image: url("../assets/images/login-background.jpg");
  background-size: cover;
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100%;
  position: fixed;
  top: 0;
  left: 0;
  background-color: rgba(255, 255, 255, 0.9);
  z-index: 9999;
}

.loading-content {
  text-align: center;
}

.loading-icon {
  font-size: 36px;
  animation: rotating 2s linear infinite;
  margin-bottom: 20px;
  display: block;
}

@keyframes rotating {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.loading-text {
  font-size: 24px;
  color: #606266;
  margin: 0;
  font-weight: 500;
}

.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #707070;
}

.login-form {
  border-radius: 6px;
  background: #ffffff;
  width: 400px;
  padding: 25px 25px 5px 25px;
  z-index: 1;
  .el-input {
    height: 40px;
    input {
      height: 40px;
    }
  }
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 0px;
  }
}

.login-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}
.login-code {
  width: 33%;
  height: 40px;
  float: right;
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.el-login-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}
.login-code-img {
  height: 40px;
  padding-left: 12px;
}
</style>
