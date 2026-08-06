<script>
import DeviceIcon from './DeviceIcon.vue'

const HEALTH_LABELS = {
  normal: '正常',
  warning: '预警',
  alarm: '告警',
  offline: '离线',
  unknown: '无数据'
}

export default {
  name: 'DeviceNode',
  components: { DeviceIcon },
  props: {
    device: { type: Object, required: true },
    selected: { type: Boolean, default: false }
  },
  emits: ['select'],
  computed: {
    healthLabel() {
      return HEALTH_LABELS[this.device.health] || '未知'
    },
    primaryText() {
      if (this.device.value === null || this.device.value === undefined || this.device.value === '') {
        return '--'
      }
      const unit = this.device.unit ? ` ${this.device.unit}` : ''
      if (this.device.isPercentPrimary && !Number.isNaN(Number(this.device.value))) {
        return `${this.device.value}%`
      }
      return `${this.device.value}${unit}`
    }
  }
}
</script>

<template>
  <button
    type="button"
    class="device-node"
    :class="[`device-node--${device.health}`, { 'device-node--selected': selected }]"
    @click="$emit('select', device)"
  >
    <DeviceIcon :type="device.deviceType" :health="device.health" :size="52" />
    <div class="device-node__label">{{ device.label }}</div>
    <div class="device-node__badge">{{ healthLabel }}</div>
    <div class="device-node__value">{{ primaryText }}</div>
  </button>
</template>

<style scoped lang="scss">
.device-node {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  width: 108px;
  padding: 10px 8px;
  border: 1px solid rgba(56, 189, 248, 0.18);
  border-radius: 12px;
  background: rgba(8, 24, 48, 0.72);
  color: #e2e8f0;
  cursor: pointer;
  transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.device-node:hover,
.device-node--selected {
  transform: translateY(-2px);
  border-color: rgba(56, 189, 248, 0.55);
  box-shadow: 0 0 18px rgba(14, 165, 233, 0.18);
}

.device-node--alarm {
  animation: pulse-alarm 2s ease-in-out infinite;
}

.device-node__label {
  font-size: 12px;
  font-weight: 600;
  text-align: center;
  line-height: 1.2;
}

.device-node__badge {
  font-size: 11px;
  opacity: 0.85;
}

.device-node__value {
  font-size: 13px;
  font-weight: 700;
  color: #7dd3fc;
  text-align: center;
  word-break: break-all;
}

@keyframes pulse-alarm {
  0%, 100% { box-shadow: 0 0 0 rgba(239, 68, 68, 0); }
  50% { box-shadow: 0 0 16px rgba(239, 68, 68, 0.35); }
}
</style>
