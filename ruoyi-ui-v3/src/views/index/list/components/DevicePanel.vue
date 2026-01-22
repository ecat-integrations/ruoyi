<template>
  <div class="device-panel">
    <div class="panel-header">
      <div class="panel-title">
        <h2 class="hidden-title" @click="handleTripleClick"> </h2>
      </div>
      <div class="panel-controls">
        <el-button
          type="primary"
          @click="$emit('open-orchestration')"
          icon="Sort"
        >
          设备控制编排
        </el-button>
      </div>
    </div>

    <div v-if="deviceData.length > 0" class="device-grid">
      <DeviceCard
        v-for="device in deviceData"
        :key="device.deviceId"
        :device="device"
      />
    </div>

    <EmptyState v-else />
  </div>
</template>

<script setup>
import DeviceCard from './DeviceCard.vue'
import EmptyState from './EmptyState.vue'
import { recordPageVisit} from '@/utils/pageState';

defineProps({
  deviceData: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['open-orchestration', 'return-to-dashboard'])

// 三次点击计数器
let clickCount = 0
let lastClickTime = 0

/**
 * 处理三次点击返回大屏
 */
function handleTripleClick() {
  const now = Date.now()
  clickCount++

  if (now - lastClickTime > 300) {
    clickCount = 1
  }

  lastClickTime = now

  if (clickCount === 3) {
    handleReturnToDashboard();
    // 触发返回事件
    emit('return-to-dashboard')
    clickCount = 0
  } else {
    // 重置计数器
    setTimeout(() => {
      if (Date.now() - lastClickTime >= 300) {
        clickCount = 0
      }
    }, 300)
  }
}
// 处理返回大屏页面的三次点击
const handleReturnToDashboard = () => {
  // 记录页面访问状态
  recordPageVisit('/index', {
    timestamp: Date.now(),
    action: 'return_to_dashboard_mode',
    userAgent: navigator.userAgent
  });

  // 通过emit通知父组件切换回大屏模式
  emit('return-to-dashboard');
};
</script>

<style scoped>
.device-panel {
  width: 100%;
  padding: 20px;
  padding-bottom: 60px;
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  padding: 8px 0;
  border-bottom: 1px solid var(--el-border-color-light, #ebeef5);
  transition: border-color 0.3s ease;
}

.panel-title h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  color: var(--el-text-color-primary, #303133);
  transition: color 0.3s ease;
}

.hidden-title {
  width: 20ch;
  height: 2em;
  background: transparent;
  border: none;
  cursor: pointer;
  display: inline-block;
  line-height: 2em;
  text-align: center;
  font-family: monospace;
  margin: 0;
  padding: 0;
}

.hidden-title:hover,
.hidden-title:active,
.hidden-title:focus {
  background: transparent;
  border: none;
  outline: none;
}

.panel-controls {
  display: flex;
  gap: 12px;
  align-items: center;
}

.device-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 20px;
  padding-bottom: 40px;
  margin-bottom: 20px;
}

/* 大屏幕优化 */
@media (min-width: 1400px) {
  .device-grid {
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  }
}

/* 中等屏幕 */
@media (max-width: 1200px) {
  .device-grid {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}

@media (max-width: 768px) {
  .device-grid {
    grid-template-columns: 1fr;
  }

  .device-panel {
    margin-top: 50px;
  }
}
</style>
