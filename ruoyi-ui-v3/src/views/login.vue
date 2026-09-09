<template>
  <div class="login">
    <!-- 加密令牌自动登录 -->
    <div v-if="tokenAutoLogging" class="token-loading-container">
      <div class="loading-content">
        <el-icon class="loading-icon"><RefreshRight /></el-icon>
        <p class="token-loading-text">{{ tokenLoadingMessage }}</p>
      </div>
    </div>

    <!-- 页面加载中（验证码） -->
    <div v-else-if="pageLoading && formEnabled" class="page-loading-container">
      <el-icon class="is-loading" :size="50">
        <Loading />
      </el-icon>
      <p class="loading-text">加载中...</p>
    </div>

    <!-- 仅 auto_token 且无 token / 失败时的提示 -->
    <div v-else-if="!formEnabled" class="token-loading-container">
      <div class="loading-content">
        <p class="token-loading-text">{{ tokenLoadingMessage || '请通过加密链接访问' }}</p>
      </div>
    </div>
    
    <!-- 登录表单 -->
    <el-form v-show="formEnabled && !pageLoading && !tokenAutoLogging" ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
      <h3 class="title">{{ title }}</h3>
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          type="text"
          size="large"
          auto-complete="off"
          placeholder="账号"
        >
          <template #prefix><svg-icon icon-class="user" class="el-input__icon input-icon" /></template>
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          type="password"
          size="large"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter="handleLogin"
        >
          <template #prefix><svg-icon icon-class="password" class="el-input__icon input-icon" /></template>
        </el-input>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="loginForm.code"
          size="large"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter="handleLogin"
        >
          <template #prefix><svg-icon icon-class="validCode" class="el-input__icon input-icon" /></template>
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="getCode" class="login-code-img" v-show="!codeLoading"/>
          <el-icon v-if="codeLoading" class="is-loading" :size="38">
            <Loading />
          </el-icon>
        </div>
      </el-form-item>
      <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">记住密码</el-checkbox>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="large"
          type="primary"
          style="width:100%;"
          @click.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        <div style="float: right;" v-if="register">
          <router-link class="link-type" to="/register">立即注册</router-link>
        </div>
      </el-form-item>
    </el-form>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>Copyright © 2018-2026 ecat group All Rights Reserved.</span>
    </div>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from "@/utils/jsencrypt";
import useUserStore from '@/store/modules/user'
import { Loading, RefreshRight } from '@element-plus/icons-vue'
import {
  parseAccountPwd,
  isLoginTokenEnabled,
  isLoginFormEnabled,
  isLoginPrefillEnabled,
  getLoginPrefillCredentials
} from '@/utils/loginToken'

const title = import.meta.env.VITE_APP_TITLE;
const userStore = useUserStore();
const route = useRoute();
const router = useRouter();
const { proxy } = getCurrentInstance();

const formEnabled = isLoginFormEnabled();
const tokenEnabled = isLoginTokenEnabled();
const prefillEnabled = isLoginPrefillEnabled();
const prefill = getLoginPrefillCredentials();

const loginForm = ref({
  username: prefillEnabled ? (prefill.username || '') : '',
  password: prefillEnabled ? (prefill.password || '') : '',
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
const pageLoading = ref(formEnabled);
const codeLoading = ref(false);
const captchaEnabled = ref(true);
const register = ref(false);
const redirect = ref(undefined);

const tokenAutoLogging = ref(false);
const tokenLoadingMessage = ref('正在加载中...');
let tokenLoginStarted = false;

watch(route, (newRoute) => {
  redirect.value = newRoute.query && newRoute.query.redirect;
  maybeStartTokenAutoLogin();
}, { immediate: true });

function buildPostLoginQuery(query) {
  return Object.keys(query || {}).reduce((acc, cur) => {
    if (cur !== 'redirect' && cur !== 'token') {
      acc[cur] = query[cur];
    }
    return acc;
  }, {});
}

function navigateAfterLogin() {
  const query = route.query || {};
  router.replace({ path: redirect.value || "/", query: buildPostLoginQuery(query) });
}

function fallbackAfterTokenFailure(message) {
  tokenAutoLogging.value = false;
  tokenLoadingMessage.value = message || '登录失败，请检查登录信息';
  if (formEnabled) {
    pageLoading.value = true;
    getCode();
  }
}

async function handleTokenAutoLogin(tokenStr) {
  tokenAutoLogging.value = true;
  tokenLoadingMessage.value = '正在解析登录信息...';
  try {
    const { account, password } = parseAccountPwd(tokenStr);
    loginForm.value.username = account;
    loginForm.value.password = password;
    tokenLoadingMessage.value = '正在自动登录...';
    await userStore.loginByToken({ username: account, password });
    navigateAfterLogin();
  } catch (error) {
    console.error('自动登录失败:', error);
    const msg = (error && error.message) || '登录失败，请检查登录信息';
    fallbackAfterTokenFailure(msg);
  }
}

function maybeStartTokenAutoLogin() {
  const tokenStr = (route.query && route.query.token) || '';
  if (!tokenStr) {
    if (!formEnabled) {
      tokenLoadingMessage.value = '请通过加密链接访问';
    }
    return;
  }
  if (!tokenEnabled) {
    if (!formEnabled) {
      tokenLoadingMessage.value = '未启用加密令牌登录';
    }
    return;
  }
  if (tokenLoginStarted) {
    return;
  }
  tokenLoginStarted = true;
  handleTokenAutoLogin(tokenStr);
}

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true;
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 });
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 });
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 });
      } else {
        Cookies.remove("username");
        Cookies.remove("password");
        Cookies.remove("rememberMe");
      }
      userStore.login(loginForm.value).then(() => {
        navigateAfterLogin();
      }).catch(() => {
        loading.value = false;
        if (captchaEnabled.value) {
          getCode();
        }
      });
    }
  });
}

let retryTimer = null;

function getCode() {
  if (!formEnabled) {
    return;
  }
  if (retryTimer) {
    clearInterval(retryTimer);
    retryTimer = null;
  }
  codeLoading.value = true;
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled;
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img;
      loginForm.value.uuid = res.uuid;
    }
    pageLoading.value = false;
    codeLoading.value = false;
    if (retryTimer) {
      clearInterval(retryTimer);
      retryTimer = null;
    }
  }).catch(error => {
    console.error('获取验证码失败:', error);
    captchaEnabled.value = false;
    codeLoading.value = false;
    pageLoading.value = false;
    retryTimer = setInterval(() => {
      console.log('重试获取验证码...');
      getCode();
    }, 5000);
  });
}

function getCookie() {
  const username = Cookies.get("username");
  const password = Cookies.get("password");
  const rememberMe = Cookies.get("rememberMe");
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe),
    code: loginForm.value.code,
    uuid: loginForm.value.uuid
  };
}

onUnmounted(() => {
  if (retryTimer) {
    clearInterval(retryTimer);
    retryTimer = null;
  }
});

if (formEnabled) {
  getCookie();
  // 有 token 自动登录时先不拉验证码，失败回退再拉
  if (!(tokenEnabled && route.query && route.query.token)) {
    getCode();
  } else {
    pageLoading.value = false;
  }
}
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
.page-loading-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  .loading-text {
    margin-top: 20px;
    color: #fff;
    font-size: 16px;
  }
}
.token-loading-container {
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
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
.token-loading-text {
  font-size: 24px;
  color: #606266;
  margin: 0;
  font-weight: 500;
}
</style>
