<template>
  <router-view />
</template>

<script setup>
import useSettingsStore from '@/store/modules/settings'
import { handleThemeStyle } from '@/utils/theme'
import { initStatusMapper } from '@/views/index/list/utils/statusMapper'

onMounted(() => {
  nextTick(() => {
    // 初始化主题样式
    handleThemeStyle(useSettingsStore().theme)
  })
  // 预加载状态字典
  initStatusMapper().catch(err => {
    console.warn('状态字典加载失败:', err)
  })
})
</script>
