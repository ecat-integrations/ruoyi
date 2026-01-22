<template>
  <div
    class="device-card"
    :class="deviceStatusClass"
  >
    <div class="device-header">
      <div class="device-name">{{ device.deviceName }}</div>
      <div class="device-status">
        <span :class="statusTextClass">{{ statusText }}</span>
      </div>
    </div>

    <div class="device-content">
      <AttributeItem
        v-for="attr in device.deviceAttrs"
        :key="attr.attributeID"
        :attr="attr"
        :device="device"
      />
    </div>

    <div class="device-footer">
      <div class="device-model">
        <span class="label">型号:</span> {{ device.deviceModel }}
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import AttributeItem from './AttributeItem.vue'
import { useDeviceStatus } from '../composables/useDeviceStatus'

const props = defineProps({
  device: {
    type: Object,
    required: true
  }
})

const { getDeviceStatusClass, getDeviceStatusTextClass, getDeviceStatusText } = useDeviceStatus()

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
