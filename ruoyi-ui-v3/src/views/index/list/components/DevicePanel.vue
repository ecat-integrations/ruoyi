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

    <div v-if="orderedDevices.length > 0" class="device-grid">
      <DeviceCard
        v-for="(device, index) in orderedDevices"
        :key="device.deviceId"
        :device="device"
        :data-index="index"
        draggable="true"
        @dragstart="handleDragStart($event, index)"
        @dragover="handleDragOver($event)"
        @dragenter="handleDragEnter($event, index)"
        @dragleave="handleDragLeave($event)"
        @drop="handleDrop($event, index)"
        @dragend="handleDragEnd($event)"
        @dblclick="handleDoubleClick($event, index)"
        @contextmenu="handleContextMenu($event, index)"
        @open-manual-tag="handleOpenManualTag"
      />
    </div>

    <EmptyState v-else />
    
    <!-- 手动标识弹窗 - 提升到 Panel 层级 -->
    <ManualTagDialog
      v-model="isManualTagDialogShow"
      :device="currentDeviceForTag"
      @success="handleManualTagSuccess"
    />
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import DeviceCard from './DeviceCard.vue'
import EmptyState from './EmptyState.vue'
import ManualTagDialog from './ManualTagDialog.vue'
import { recordPageVisit} from '@/utils/pageState'
import { useDeviceCardDragSort } from '../composables/useDeviceCardDragSort'
import { ElMessage } from 'element-plus'

const props = defineProps({
  deviceData: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['open-orchestration', 'return-to-dashboard'])

// 使用设备卡片拖拽排序
const { applyCachedOrder, handleDragEnd: saveDragEnd, moveDeviceToFirst } = useDeviceCardDragSort()

// 应用缓存的排序顺序
const orderedDevices = ref(applyCachedOrder(props.deviceData || []))

// 监听设备数据变化，重新应用缓存顺序
watch(
  () => props.deviceData,
  (newDevices) => {
    if (newDevices && newDevices.length > 0) {
      orderedDevices.value = applyCachedOrder(newDevices)
    }
  },
  { deep: true }
)

// 拖拽相关状态
const draggedIndex = ref(null)
const dragOverIndex = ref(null)

// 双击计数器
let clickCount = 0
let lastClickTime = 0
let lastClickedDeviceIndex = -1

// 处理拖拽开始
const handleDragStart = (event, index) => {
  draggedIndex.value = index
  event.currentTarget.classList.add('dragging')
  event.dataTransfer.effectAllowed = 'move'
  event.dataTransfer.setData('text/plain', index)
}

// 处理拖拽经过
const handleDragOver = (event) => {
  event.preventDefault()
  event.dataTransfer.dropEffect = 'move'
}

// 处理拖拽进入
const handleDragEnter = (event, index) => {
  event.preventDefault()
  if (index !== draggedIndex.value) {
    dragOverIndex.value = index
    event.currentTarget.classList.add('drag-over')
  }
}

// 处理拖拽离开
const handleDragLeave = (event) => {
  event.currentTarget.classList.remove('drag-over')
  dragOverIndex.value = null
}

// 处理放下
const handleDrop = (event, toIndex) => {
  event.preventDefault()
  event.stopPropagation()
  
  const fromIndex = draggedIndex.value
  
  if (fromIndex !== null && fromIndex !== toIndex) {
    // 更新顺序并保存到缓存
    orderedDevices.value = saveDragEnd(orderedDevices.value, fromIndex, toIndex)
    ElMessage.success(`已调整设备顺序`)
  }
  
  // 清理样式
  event.currentTarget.classList.remove('drag-over')
  dragOverIndex.value = null
  draggedIndex.value = null
}

// 处理拖拽结束
const handleDragEnd = (event) => {
  event.currentTarget.classList.remove('dragging')
  draggedIndex.value = null
  dragOverIndex.value = null
  
  // 清理所有 drag-over 样式
  document.querySelectorAll('.drag-over').forEach(el => {
    el.classList.remove('drag-over')
  })
}

// 处理双击置顶
const handleDoubleClick = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  
  const now = Date.now()
  
  // 判断是否是同一个设备的连续点击
  if (now - lastClickTime < 400 && index === lastClickedDeviceIndex) {
    clickCount++
    
    if (clickCount >= 2) {
      // 连点两下，置顶设备
      if (index > 0) {
        const deviceName = orderedDevices.value[index].deviceName
        orderedDevices.value = moveDeviceToFirst(orderedDevices.value, index)
        ElMessage.success(`已将 "${deviceName}" 置顶`)
      }
      clickCount = 0
      lastClickedDeviceIndex = -1
    }
  } else {
    clickCount = 1
    lastClickedDeviceIndex = index
  }
  
  lastClickTime = now
  
  // 重置计数器
  setTimeout(() => {
    if (Date.now() - lastClickTime >= 400) {
      clickCount = 0
      lastClickedDeviceIndex = -1
    }
  }, 400)
}

// 处理右击置顶
const handleContextMenu = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  
  if (index > 0) {
    const deviceName = orderedDevices.value[index].deviceName
    orderedDevices.value = moveDeviceToFirst(orderedDevices.value, index)
    ElMessage.success(`已将 "${deviceName}" 置顶`)
  }
}

// 三次点击计数器（用于返回大屏）
let returnClickCount = 0
let returnLastClickTime = 0

// 手动标识相关状态
const isManualTagDialogShow = ref(false)
const currentDeviceForTag = ref(null)

/**
 * 处理打开手动标识对话框
 */
function handleOpenManualTag(device) {
  currentDeviceForTag.value = device
  isManualTagDialogShow.value = true
}

/**
 * 处理手动标识成功
 */
function handleManualTagSuccess(data) {
  console.log('手动标识成功:', data)
  // 可以在这里执行额外的操作,比如刷新设备数据等
  ElMessage.success(`设备 "${data.device.deviceName}" 标识成功,请稍等片刻生效`)
}

/**
 * 处理三次点击返回大屏
 */
function handleTripleClick() {
  const now = Date.now()
  returnClickCount++

  if (now - returnLastClickTime > 300) {
    returnClickCount = 1
  }

  returnLastClickTime = now

  if (returnClickCount === 3) {
    handleReturnToDashboard();
    // 触发返回事件
    emit('return-to-dashboard')
    returnClickCount = 0
  } else {
    // 重置计数器
    setTimeout(() => {
      if (Date.now() - returnLastClickTime >= 300) {
        returnClickCount = 0
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

  // 通过 emit 通知父组件切换回大屏模式
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
  align-items: stretch;
}

/* 拖拽相关样式 */
.device-grid :deep(.device-card) {
  cursor: grab;
  user-select: none;
  position: relative;
}

.device-grid :deep(.device-card:active) {
  cursor: grabbing;
}

.device-grid :deep(.device-card.dragging) {
  opacity: 0.5;
  transform: scale(1.02);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  z-index: 1000;
  border: 2px solid #409eff;
}

.device-grid :deep(.device-card.drag-over) {
  border: 2px dashed #409eff;
  transition: all 0.2s ease;
}

.device-grid :deep(.device-card.drag-over::before) {
  content: '';
  position: absolute;
  top: -2px;
  left: -2px;
  right: -2px;
  bottom: -2px;
  border: 2px dashed #409eff;
  animation: pulse-border 1s infinite;
  pointer-events: none;
  z-index: 1001;
}

@keyframes pulse-border {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
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
  
  /* 移动端禁用拖拽 */
  .device-grid :deep(.device-card) {
    cursor: default;
  }
}
</style>
