<template>
  <div
    class="attribute-item"
    :class="statusClass"
  >
    <div class="attribute-status">
      <div
        class="status-indicator"
        :class="indicatorClass"
      ></div>
    </div>
    <div class="attribute-info">
      <div class="attribute-name">{{ attr.displayName }}</div>
      <div class="attribute-value-container">
        <span
          v-if="attr.displayValue !== null"
          class="attribute-value"
        >
          {{ displayValue }}
        </span>
        <span v-else class="no-data">无数据</span>
        <span class="attribute-unit">{{ displayUnit }}</span>
      </div>
    </div>
    <div class="attribute-time">
      {{ formattedTime }}
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useAttributeData } from '../composables/useAttributeData'

const props = defineProps({
  attr: {
    type: Object,
    required: true
  },
  device: {
    type: Object,
    required: true
  }
})

const {
  getAttributeStatus,
  getDisplayValue,
  getDisplayUnit,
  formatAttributeTime
} = useAttributeData()

const status = computed(() => getAttributeStatus(props.attr))
const statusClass = computed(() => `attr-${status.value}`)
const indicatorClass = computed(() => status.value)
const displayValue = computed(() => getDisplayValue(props.attr, props.device))
const displayUnit = computed(() => getDisplayUnit(props.attr, props.device))
const formattedTime = computed(() => formatAttributeTime(props.attr.updateTime, props.attr))
</script>

<style scoped>
.attribute-item {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
  padding: 10px;
  border-radius: 4px;
  transition: all 0.2s;
  cursor: grab;
  user-select: none;
  position: relative;
}

.attribute-item.attr-online {
  background-color: #f0f9eb;
}

.attribute-item.attr-offline {
  background-color: #f5f7fa;
}

.attribute-item.attr-warning {
  background-color: #fdf6ec;
}

.attribute-item:hover {
  background-color: #f5f7fa;
}

.attribute-item:active {
  cursor: grabbing;
}

/* 右键菜单提示样式 */
.attribute-item.context-menu-active {
  background-color: #e6f7ff;
  border: 1px solid #409eff;
}

.attribute-item.dragging {
  opacity: 0.5;
  transform: scale(1.02);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  z-index: 1000;
}

.attribute-item.drag-over {
  border-top: 2px solid #409eff;
  transition: all 0.2s ease;
}

.attribute-item.drag-over::before {
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

.attribute-status {
  margin-right: 10px;
}

.status-indicator {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.status-indicator.online {
  background-color: #67c23a;
  box-shadow: 0 0 6px rgba(103, 194, 58, 0.5);
}

.status-indicator.offline {
  background-color: #dcdfe6;
}

.status-indicator.warning {
  background-color: #e6a23c;
  box-shadow: 0 0 6px rgba(230, 162, 60, 0.5);
}

.attribute-info {
  flex: 1;
  min-width: 0;
}

.attribute-name {
  font-size: 14px;
  color: var(--el-text-color-regular, #606266);
  margin-bottom: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: color 0.3s ease;
}

.attribute-value-container {
  display: flex;
  align-items: baseline;
}

.attribute-value {
  font-size: 15px;
  font-weight: 500;
  color: var(--el-text-color-primary, #303133);
  margin-right: 4px;
  transition: color 0.3s ease;
}

.attribute-unit {
  font-size: 12px;
  color: #909399;
}

.no-data {
  color: #909399;
  font-style: italic;
  font-size: 13px;
}

.attribute-time {
  font-size: 12px;
  color: #909399;
  white-space: nowrap;
  margin-left: 10px;
}
</style>
