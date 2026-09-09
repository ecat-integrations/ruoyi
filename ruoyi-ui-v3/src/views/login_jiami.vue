<template>
  <div class="login">
    <div class="loading-container">
      <div class="loading-content">
        <el-icon class="loading-icon"><RefreshRight /></el-icon>
        <p class="loading-text">正在跳转加密登录...</p>
      </div>
    </div>
  </div>
</template>

<script setup>
/**
 * 兼容旧入口：统一跳转到 /login，保留 query（含 token）
 */
import { RefreshRight } from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()

onMounted(() => {
  router.replace({ path: '/login', query: { ...route.query } })
})
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
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
.loading-text {
  font-size: 24px;
  color: #606266;
  margin: 0;
  font-weight: 500;
}
</style>
