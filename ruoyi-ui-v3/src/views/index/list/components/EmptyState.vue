<template>
  <div class="no-device-container">
    <div class="no-device-content">
      <i class="DataLine no-device-icon"></i>
      <p class="no-device-text">暂无设备接入</p>
    </div>
  </div>
</template>

<script setup>
// Empty state component - displayed when no devices are available
</script>

<style scoped>
.no-device-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
  padding: 40px 20px;
}

.no-device-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.no-device-icon {
  font-size: 64px;
  color: var(--el-text-color-placeholder, #c0c4cc);
}

.no-device-text {
  font-size: 16px;
  color: var(--el-text-color-regular, #606266);
  margin: 0;
}
</style>
