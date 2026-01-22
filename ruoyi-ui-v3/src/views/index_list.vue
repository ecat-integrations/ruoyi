<template>
  <div class="device-list-wrapper">
    <DevicePanel
      :device-data="deviceData"
      @open-orchestration="isOrchestrationModalShow = true"
      @return-to-dashboard="handleReturnToDashboard"
    />

    <OrchestrationModal
      v-model="isOrchestrationModalShow"
      :device-data="deviceData"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, getCurrentInstance } from 'vue'
import { getNowData } from '@/api/login'
import { recordPageVisit } from '@/utils/pageState'
import useSettingsStore from '@/store/modules/settings'
import DevicePanel from './index/list/components/DevicePanel.vue'
import OrchestrationModal from './index/list/orchestration/OrchestrationModal.vue'
import { useDeviceData } from './index/list/composables/useDeviceData'

// 定义props
const props = defineProps({
  deviceData: {
    type: Array,
    default: () => []
  },
  isDeviceListMode: {
    type: Boolean,
    default: false
  }
})

// 定义emits
const emit = defineEmits(['return-to-dashboard', 'update-device-data'])

const { proxy } = getCurrentInstance()

// 主题设置
const settingsStore = useSettingsStore()

// 编排弹窗状态
const isOrchestrationModalShow = ref(false)

// 使用设备数据管理
const { requestData, startPolling, stopPolling } = useDeviceData({ emit })

// 处理返回大屏页面的三次点击
const handleReturnToDashboard = () => {
  // 记录页面访问状态
  recordPageVisit('/index', {
    timestamp: Date.now(),
    action: 'return_to_dashboard_mode',
    userAgent: navigator.userAgent
  })
// 通过emit通知父组件切换回大屏模式
  emit('return-to-dashboard')
}

// 生命周期
onMounted(() => {
  recordPageVisit('/index', {
    timestamp: Date.now(),
    action: 'device_list_mode_loaded',
    userAgent: navigator.userAgent
  })

  requestData()
  // 定时刷新设备数据（10秒一次）
  startPolling(10000)
})

onBeforeUnmount(() => {
  stopPolling()
})
</script>

<style scoped>
.device-list-wrapper {
  width: 100%;
  min-height: calc(100vh + 200px);
  background-color: var(--el-bg-color-page, #f5f7fa);
  transition: background-color 0.3s ease;
  position: relative;
  padding-bottom: 100px;
}

@media (max-width: 768px) {
  .device-list-wrapper {
    padding: 10px;
  }
}
</style>
