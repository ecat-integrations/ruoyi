<template>
  <el-dialog
    v-model="dialogVisible"
    :title="device?.deviceName || '设备属性'"
    width="80vw"
    top="10vh"
    :append-to-body="true"
    :close-on-click-modal="true"
    :close-on-press-escape="true"
    class="device-attribute-modal"
    @closed="handleClosed"
  >
    <template #header>
      <div class="dialog-header">
        <span class="dialog-title">{{ device?.deviceName || '设备属性' }}</span>
        <el-tag type="warning" effect="dark" class="drag-tip">
          <el-icon><Rank /></el-icon>
          拖拽卡片可调整显示顺序
        </el-tag>
      </div>
    </template>
    <div class="attribute-grid">
      <div
        v-for="(attr, index) in orderedAttrs"
        :key="attr.attributeID"
        class="attribute-card"
        draggable="true"
        :class="{
          'attr-online': getAttributeStatus(attr) === 'online',
          'attr-offline': getAttributeStatus(attr) === 'offline',
          'attr-warning': getAttributeStatus(attr) === 'warning',
          'dragging': draggedIndex === index,
          'drag-over': dragOverIndex === index
        }"
        @dragstart="handleDragStart($event, index)"
        @dragover="handleDragOver($event)"
        @dragenter="handleDragEnter($event, index)"
        @dragleave="handleDragLeave($event)"
        @drop="handleDrop($event, index)"
        @dragend="handleDragEnd($event)"
        @dblclick="handleDoubleClick($event, index)"
        @contextmenu="handleContextMenu($event, index)"
      >
        <div class="attribute-header">
          <div class="attr-name">{{ attr.displayName }}</div>
          <el-tag
            :type="getAttributeStatus(attr) === 'online' ? 'success' : 
                    getAttributeStatus(attr) === 'warning' ? 'warning' : 'info'"
            size="small"
          >
            {{ getAttributeStatusText(attr) }}
          </el-tag>
        </div>
        
        <div class="attribute-body">
          <div class="attr-value" :title="getDisplayValue(attr, device)">
            <span class="value">{{ getDisplayValue(attr, device) }}</span>
            <span class="unit">{{ getDisplayUnit(attr, device) }}</span>
          </div>
          <div class="attr-time" v-if="attr.updateTime">
            更新时间：{{ formatUpdateTime(attr.updateTime) }}
          </div>
        </div>
      </div>
    </div>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dialogVisible = false">关闭</el-button>
        <el-button type="primary" @click="handleResetOrder">重置顺序</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useAttributeDragSort } from '../composables/useAttributeDragSort'
import { useAttributeData } from '../composables/useAttributeData'

const props = defineProps({
  device: {
    type: Object,
    default: null
  },
  modelValue: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:modelValue', 'order-change'])

// 使用属性拖拽排序
const { applyCachedOrder, handleDragEnd: saveDragEnd, moveAttributeToFirst, clearDeviceCache } = useAttributeDragSort(ref(props.device))
const { getAttributeStatus, getAttributeStatusText, getDisplayValue, getDisplayUnit } = useAttributeData()

// 弹窗可见性
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
})

// 应用缓存的排序顺序
const orderedAttrs = ref(applyCachedOrder(props.device?.deviceAttrs || []))

// 监听设备属性变化
watch(
  () => props.device?.deviceAttrs,
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
  // 只在第一次进入或切换到新目标时添加样式
  if (dragOverIndex.value !== index && draggedIndex.value !== index) {
    dragOverIndex.value = index
  }
}

// 处理拖拽离开
const handleDragLeave = (event, index) => {
  // 只有当真正离开这个元素（而不是进入子元素）时才清理
  const rect = event.currentTarget.getBoundingClientRect()
  const x = event.clientX
  const y = event.clientY
  
  // 如果鼠标还在元素范围内，不处理
  if (x >= rect.left && x <= rect.right && y >= rect.top && y <= rect.bottom) {
    return
  }
  
  // 只有离开的目标是当前 drag-over 目标时，才清理
  if (dragOverIndex.value === index) {
    dragOverIndex.value = null
  }
}

// 处理放下
const handleDrop = (event, toIndex) => {
  event.preventDefault()
  event.stopPropagation()
  
  const fromIndex = draggedIndex.value
  
  if (fromIndex !== null && fromIndex !== toIndex) {
    // 更新顺序并保存到缓存
    orderedAttrs.value = saveDragEnd(orderedAttrs.value, fromIndex, toIndex)
    ElMessage.success(`已调整属性顺序`)
  }
  
  // 清理样式 - 延迟清理，让用户看到最终效果
  setTimeout(() => {
    dragOverIndex.value = null
    draggedIndex.value = null
  }, 200)
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

// 双击置顶
const handleDoubleClick = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  
  if (index > 0) {
    const attrName = orderedAttrs.value[index].displayName
    orderedAttrs.value = moveAttributeToFirst(orderedAttrs.value, index)
    ElMessage.success(`已将 "${attrName}" 置顶`)
  }
}

// 右键置顶
const handleContextMenu = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  
  if (index > 0) {
    const attrName = orderedAttrs.value[index].displayName
    orderedAttrs.value = moveAttributeToFirst(orderedAttrs.value, index)
    ElMessage.success(`已将 "${attrName}" 置顶`)
  }
}

// 格式化更新时间
const formatUpdateTime = (timeStr) => {
  if (!timeStr) return '无'
  const date = new Date(timeStr)
  return date.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  })
}

// 重置顺序
const handleResetOrder = async () => {
  try {
    await ElMessageBox.confirm(
      '确定要重置该设备的属性顺序吗？将清除缓存的排序设置。',
      '提示',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    clearDeviceCache(props.device.deviceId)
    orderedAttrs.value = applyCachedOrder(props.device.deviceAttrs || [])
    ElMessage.success('已重置属性顺序')
  } catch {
    // 用户取消操作
  }
}

// 弹窗关闭后
const handleClosed = () => {
  // 可以在这里做一些清理工作
}
</script>

<style scoped>
.device-attribute-modal :deep(.el-dialog) {
  position: fixed !important;
  left: 50% !important;
  transform: translateX(-50%) !important;
  margin: 0 !important;
  width: 80vw !important;
  height: 80vh !important;
  max-width: 80vw !important;
  max-height: 80vh !important;
  display: flex;
  flex-direction: column;
}

.device-attribute-modal :deep(.el-overlay) {
  position: fixed !important;
}

.device-attribute-modal :deep(.el-dialog__body) {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  min-height: 0;
}

.attribute-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 10px;
  padding: 8px;
  width: 100%;
}

.attribute-card {
  background: var(--el-bg-color, #fff);
  border-radius: 6px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  transition: all 0.25s ease;
  border: 1px solid var(--el-border-color-light, #ebeef5);
  cursor: grab;
  user-select: none;
  position: relative;
  display: flex;
  flex-direction: column;
}

.attribute-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}

.attribute-card.attr-online {
  border-color: #67c23a;
  box-shadow: 0 2px 8px rgba(103, 194, 58, 0.2);
}

.attribute-card.attr-offline {
  border-color: #e4e7ed;
  background-color: #f5f7fa;
}

.attribute-card.attr-warning {
  border-color: #e6a23c;
  box-shadow: 0 2px 8px rgba(230, 162, 60, 0.2);
}

.attribute-card:active {
  cursor: grabbing;
}

.attribute-card.dragging {
  opacity: 0.4;
  transform: scale(1.05);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  z-index: 1000;
  border: 2px solid #409eff;
  background-color: #ecf5ff;
}

.attribute-card.drag-over {
  border: 3px dashed #409eff;
  transition: all 0.2s ease;
  background-color: #ecf5ff;
  transform: scale(1.02);
}

.attribute-card.drag-over::before {
  content: '';
  position: absolute;
  top: -3px;
  left: -3px;
  right: -3px;
  bottom: -3px;
  border: 3px dashed #409eff;
  animation: pulse-border 1s infinite;
  pointer-events: none;
  z-index: 1001;
  border-radius: 6px;
}

@keyframes pulse-border {
  0%, 100% {
    opacity: 1;
    border-color: #409eff;
  }
  50% {
    opacity: 0.6;
    border-color: #67c23a;
  }
}

.attribute-header {
  padding: 8px 12px;
  border-bottom: 1px solid var(--el-border-color-light, #ebeef5);
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: border-color 0.3s ease;
}

.attr-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--el-text-color-primary, #303133);
  transition: color 0.3s ease;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 70%;
}

.attribute-body {
  padding: 10px 12px;
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.attr-value {
  display: flex;
  align-items: baseline;
  gap: 6px;
  flex-wrap: nowrap;
  max-width: 100%;
  overflow: hidden;
}

.attr-value .value {
  font-size: 18px;
  font-weight: 600;
  color: #409eff;
  flex-shrink: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: calc(100% - 40px);
  cursor: pointer;
}

.attr-value .value:hover {
  text-overflow: clip;
  white-space: normal;
  word-break: break-all;
}

.attr-value .unit {
  font-size: 12px;
  color: var(--el-text-color-regular, #606266);
  flex-shrink: 0;
}

.attr-time {
  font-size: 11px;
  color: var(--el-text-color-secondary, #909399);
  line-height: 1.3;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

/* 弹窗头部样式 */
.device-attribute-modal :deep(.el-dialog__header) {
  padding: 16px 20px;
  border-bottom: 1px solid var(--el-border-color-light, #ebeef5);
  margin-right: 0;
}

.dialog-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  flex-wrap: wrap;
}

.dialog-title {
  font-size: 18px;
  font-weight: 600;
  color: var(--el-text-color-primary, #303133);
}

.drag-tip {
  font-size: 13px;
  padding: 4px 10px;
  display: flex;
  align-items: center;
  gap: 4px;
  animation: pulse-bg 2s infinite;
}

@keyframes pulse-bg {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
  }
}

/* 响应式优化 */
@media (max-width: 768px) {
  .attribute-grid {
    grid-template-columns: 1fr;
  }
  
  .device-attribute-modal :deep(.el-dialog) {
    width: 95vw !important;
    height: 85vh;
  }
}
</style>
