<template>
  <div
    class="device-card"
    :class="deviceStatusClass"
    @dblclick="$emit('dblclick', $event)"
    @contextmenu="$emit('contextmenu', $event)"
  >
    <div class="device-header">
      <div class="device-name">{{ device.deviceName }}</div>
      <div class="device-status-wrapper">
        <div class="device-status">
          <span :class="statusTextClass">{{ statusText }}</span>
        </div>
        <el-button
          type="default"
          size="small"
          circle
          icon="FullScreen"
          class="more-btn"
          @click.stop="handleMoreClick"
          title="查看所有属性"
        />
      </div>
    </div>

    <div class="device-content">
      <AttributeItem
        v-for="(attr, index) in orderedAttrs"
        :key="attr.attributeID"
        :attr="attr"
        :device="device"
        draggable="true"
        @dragstart="handleDragStart($event, index)"
        @dragover="handleDragOver($event)"
        @dragenter="handleDragEnter($event, index)"
        @dragleave="handleDragLeave($event)"
        @drop="handleDrop($event, index)"
        @dragend="handleDragEnd($event)"
        @click="handleClick($event, index)"
        @contextmenu="handleContextMenu($event, index)"
      />
    </div>

    <div class="device-footer">
      <div class="device-model">
        <span class="label">型号:</span> {{ device.deviceModel }}
      </div>
    </div>

    <!-- 属性详情弹窗 -->
    <DeviceAttributeModal
      v-model="isAttributeModalShow"
      :device="device"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import AttributeItem from './AttributeItem.vue'
import DeviceAttributeModal from './DeviceAttributeModal.vue'
import { useDeviceStatus } from '../composables/useDeviceStatus'
import { useAttributeDragSort } from '../composables/useAttributeDragSort'
import { ElMessage } from 'element-plus'

const emit = defineEmits(['dblclick', 'contextmenu'])

const props = defineProps({
  device: {
    type: Object,
    required: true
  }
})

const { getDeviceStatusClass, getDeviceStatusTextClass, getDeviceStatusText } = useDeviceStatus()
const { applyCachedOrder, handleDragEnd: saveDragEnd, moveAttributeToFirst } = useAttributeDragSort(ref(props.device))

// 应用缓存的排序顺序
const orderedAttrs = ref(applyCachedOrder(props.device.deviceAttrs || []))

// 监听设备属性变化，重新应用缓存顺序
watch(
  () => props.device.deviceAttrs,
  (newAttrs) => {
    if (newAttrs && newAttrs.length > 0) {
      orderedAttrs.value = applyCachedOrder(newAttrs)
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
let lastClickedAttrIndex = -1

// 处理拖拽开始
const handleDragStart = (event, index) => {
  draggedIndex.value = index
  event.target.classList.add('dragging')
  event.dataTransfer.effectAllowed = 'move'
  // 设置拖拽数据（用于兼容）
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
    orderedAttrs.value = saveDragEnd(orderedAttrs.value, fromIndex, toIndex)
  }
  
  // 清理样式
  event.currentTarget.classList.remove('drag-over')
  dragOverIndex.value = null
  draggedIndex.value = null
}

// 处理拖拽结束
const handleDragEnd = (event) => {
  event.target.classList.remove('dragging')
  draggedIndex.value = null
  dragOverIndex.value = null
  
  // 清理所有 drag-over 样式
  document.querySelectorAll('.drag-over').forEach(el => {
    el.classList.remove('drag-over')
  })
}

// 处理点击置顶（连点两下）
const handleClick = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  
  const now = Date.now()
  
  // 判断是否是同一个属性的连续点击
  if (now - lastClickTime < 400 && index === lastClickedAttrIndex) {
    clickCount++
    
    if (clickCount >= 2) {
      // 连点两下，置顶属性
      if (index > 0) {
        orderedAttrs.value = moveAttributeToFirst(orderedAttrs.value, index)
        ElMessage.success(`已将 "${orderedAttrs.value[0].displayName}" 置顶`)
      }
      clickCount = 0
      lastClickedAttrIndex = -1
    }
  } else {
    clickCount = 1
    lastClickedAttrIndex = index
  }
  
  lastClickTime = now
  
  // 重置计数器
  setTimeout(() => {
    if (Date.now() - lastClickTime >= 400) {
      clickCount = 0
      lastClickedAttrIndex = -1
    }
  }, 400)
}

// 处理右击置顶
const handleContextMenu = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  
  if (index > 0) {
    const attrName = orderedAttrs.value[index].displayName
    orderedAttrs.value = moveAttributeToFirst(orderedAttrs.value, index)
    ElMessage.success(`已将 "${attrName}" 置顶`)
  }
}

// 属性详情弹窗
const isAttributeModalShow = ref(false)

// 处理更多按钮点击
const handleMoreClick = () => {
  isAttributeModalShow.value = true
}

const deviceStatusClass = computed(() => getDeviceStatusClass(props.device))
const statusText = computed(() => {
  const status = getDeviceStatusClass(props.device).replace('device-', '')
  const textMap = { online: '在线', offline: '离线', warning: '注意' }
  return textMap[status] || '离线'
})
const statusTextClass = computed(() => getDeviceStatusTextClass(props.device))
</script>

<style scoped>
.device-card {
  background: var(--el-bg-color, #fff);
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  border: 1px solid var(--el-border-color-light, #ebeef5);
  display: flex;
  flex-direction: column;
  height: 100%;
}

.device-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}

.device-card.device-online {
  border-color: #67c23a;
  box-shadow: 0 2px 8px rgba(103, 194, 58, 0.2);
}

.device-card.device-offline {
  border-color: #e4e7ed;
  background-color: #f5f7fa;
}

.device-card.device-warning {
  border-color: #e6a23c;
  box-shadow: 0 2px 8px rgba(230, 162, 60, 0.2);
}

.device-header {
  padding: 16px;
  border-bottom: 1px solid var(--el-border-color-light, #ebeef5);
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: border-color 0.3s ease;
  gap: 12px;
}

.device-status-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
}

.device-status {
  display: flex;
  align-items: center;
}

.more-btn {
  flex-shrink: 0;
  padding: 6px 10px;
  font-size: 14px;
  border-color: var(--el-border-color-light, #e4e7ed);
  background-color: var(--el-bg-color-page, #f5f7fa);
}

.more-btn:hover {
  transform: scale(1.1);
  background-color: var(--el-fill-color-light, #ecf5ff);
  border-color: var(--el-color-primary-light-7, #b3d8ff);
}

.device-name {
  font-size: 18px;
  font-weight: 600;
  color: var(--el-text-color-primary, #303133);
  transition: color 0.3s ease;
}

.status-online {
  color: #67c23a;
  font-weight: 500;
}

.status-offline {
  color: #606266;
  font-weight: 500;
}

.status-warning {
  color: #e6a23c;
  font-weight: 500;
}

.device-content {
  padding: 16px;
  flex: 1;
  overflow-y: auto;
  max-height: 350px;
}

/* 拖拽相关样式 */
.device-content :deep(.attribute-item) {
  cursor: grab;
  user-select: none;
  position: relative;
}

.device-content :deep(.attribute-item:active) {
  cursor: grabbing;
}

.device-content :deep(.attribute-item.dragging) {
  opacity: 0.5;
  transform: scale(1.02);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  z-index: 1000;
}

.device-content :deep(.attribute-item.drag-over) {
  border-top: 2px solid #409eff;
  transition: all 0.2s ease;
}

.device-content :deep(.attribute-item.drag-over::before) {
  content: '';
  position: absolute;
  top: -2px;
  left: 0;
  right: 0;
  height: 2px;
  background-color: #409eff;
  animation: pulse 1s infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

.device-footer {
  padding: 12px 16px;
  background-color: var(--el-bg-color-page, #f5f7fa);
  font-size: 13px;
  color: var(--el-text-color-regular, #606266);
  transition: background-color 0.3s ease, color 0.3s ease;
  border-radius: 0 0 7px 7px;
  margin: -1px;
  border-left: 1px solid transparent;
  border-right: 1px solid transparent;
  border-bottom: 1px solid transparent;
}

.device-card.device-online .device-footer {
  border-left-color: #67c23a;
  border-right-color: #67c23a;
  border-bottom-color: #67c23a;
}

.device-card.device-offline .device-footer {
  border-left-color: #e4e7ed;
  border-right-color: #e4e7ed;
  border-bottom-color: #e4e7ed;
}

.device-card.device-warning .device-footer {
  border-left-color: #e6a23c;
  border-right-color: #e6a23c;
  border-bottom-color: #e6a23c;
}

.label {
  font-weight: 700;
  color: #409eff;
  margin-right: 6px;
}
</style>
