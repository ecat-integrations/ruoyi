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
  name: 'PlacedDevice',
  components: { DeviceIcon },
  props: {
    device: { type: Object, required: true },
    layout: { type: Object, required: true },
    selected: { type: Boolean, default: false },
    dimmed: { type: Boolean, default: false }
  },
  emits: ['select'],
  computed: {
    iconSize() {
      return this.layout.iconSize || 40
    },
    panelSide() {
      return this.layout.panelSide || 'bottom'
    },
    isFlat() {
      return this.layout.layoutMode === 'flat'
    },
    style() {
      const scale = this.layout.scale || 1
      const z = this.selected ? 100 : (this.layout.zIndex || 2)
      return {
        left: `${this.layout.x}%`,
        top: `${this.layout.y}%`,
        zIndex: z,
        transform: `translate(-50%, -50%) scale(${scale})`
      }
    },
    healthLabel() {
      return HEALTH_LABELS[this.device.health] || '未知'
    },
    primaryText() {
      const row = this.device.primaryRow
      if (!row || row.value === '--') return '--'
      const unit = row.unit ? ` ${row.unit}` : ''
      return `${row.value}${unit}`
    }
  },
  methods: {
    onClick(event) {
      event.stopPropagation()
      this.$emit('select', this.device)
    },
    rowText(row) {
      if (row.value === '--') return '--'
      return `${row.value}${row.unit ? ` ${row.unit}` : ''}`
    }
  }
}
</script>

<template>
  <button
    type="button"
    class="placed-device"
    :class="[
      `placed-device--${device.health}`,
      `placed-device--panel-${panelSide}`,
      { 'placed-device--selected': selected, 'placed-device--dimmed': dimmed, 'placed-device--flat': isFlat }
    ]"
    :style="style"
    @click="onClick"
  >
    <div class="placed-device__body" :class="{ 'placed-device__body--flat': isFlat }">
      <div class="placed-device__icon-wrap">
        <DeviceIcon :type="device.deviceType" :size="iconSize" />
        <span class="placed-device__dot" :class="`placed-device__dot--${device.health}`" />
      </div>
      <div v-if="!selected" class="placed-device__hint" :class="{ 'placed-device__hint--flat': isFlat }">
        <span class="placed-device__name">{{ device.label }}</span>
        <span v-if="!isFlat" class="placed-device__primary">{{ primaryText }}</span>
      </div>
    </div>

    <!-- 点击后：设备旁展开全部参数 -->
    <div v-if="selected" class="placed-device__panel" @click.stop>
      <div class="placed-device__panel-head">
        <span class="placed-device__panel-title">{{ device.label }}</span>
        <span class="placed-device__panel-status" :class="`placed-device__panel-status--${device.health}`">
          {{ healthLabel }}
        </span>
      </div>
      <div
        v-for="row in device.detailRows"
        :key="row.key"
        class="placed-device__row"
        :class="`placed-device__row--${row.health}`"
      >
        <span class="placed-device__row-name">{{ row.name }}</span>
        <span class="placed-device__row-value">{{ rowText(row) }}</span>
      </div>
    </div>
  </button>
</template>

<style scoped lang="scss">
.placed-device {
  position: absolute;
  padding: 0;
  border: none;
  background: transparent;
  cursor: pointer;
  transform-origin: center center;
  transition: opacity 0.25s ease, filter 0.25s ease;
}

.placed-device--dimmed {
  opacity: 0.28;
  filter: blur(1px);
  pointer-events: none;
}

.placed-device--selected {
  opacity: 1;
  filter: none;
  pointer-events: auto;
}

.placed-device__body {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
}

.placed-device__body--flat {
  flex-direction: row;
  align-items: center;
  gap: 4px;
}

.placed-device--flat {
  transform-origin: center center;
}

.placed-device__icon-wrap {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.placed-device__dot {
  position: absolute;
  top: 1px;
  right: 1px;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  border: 2px solid rgba(4, 12, 28, 0.9);
  box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.25);
  z-index: 2;
}

.placed-device__dot--normal { background: #22c55e; }
.placed-device__dot--warning { background: #eab308; }
.placed-device__dot--alarm {
  background: #ef4444;
  animation: dot-pulse 1.8s ease-in-out infinite;
}
.placed-device__dot--offline { background: #64748b; }
.placed-device__dot--unknown { background: #475569; }

@keyframes dot-pulse {
  0%, 100% { box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.25), 0 0 0 0 rgba(239, 68, 68, 0.5); }
  50% { box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.25), 0 0 6px 2px rgba(239, 68, 68, 0.55); }
}

.placed-device__hint {
  display: flex;
  flex-direction: column;
  align-items: center;
  max-width: 96px;
  padding: 3px 6px;
  border-radius: 5px;
  background: rgba(4, 12, 28, 0.72);
}

.placed-device__hint--flat {
  max-width: 80px;
  padding: 2px 5px;
  background: rgba(4, 12, 28, 0.72);
}

.placed-device__hint--flat .placed-device__name {
  font-size: 10px;
  max-width: 76px;
  line-height: 1.15;
  white-space: normal;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.placed-device__name {
  font-size: 11px;
  color: #94a3b8;
  line-height: 1.25;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 92px;
}

.placed-device__primary {
  font-size: 12px;
  font-weight: 600;
  color: #e2e8f0;
  white-space: nowrap;
}

.placed-device__panel {
  position: absolute;
  min-width: 140px;
  max-width: 180px;
  padding: 8px 10px;
  border-radius: 10px;
  background: rgba(4, 14, 32, 0.96);
  border: 1px solid rgba(56, 189, 248, 0.45);
  box-shadow: 0 8px 24px rgba(2, 8, 23, 0.65);
  backdrop-filter: blur(8px);
  text-align: left;
}

.placed-device--panel-bottom .placed-device__panel {
  top: calc(100% + 6px);
  left: 50%;
  transform: translateX(-50%);
}

.placed-device--panel-top .placed-device__panel {
  bottom: calc(100% + 6px);
  left: 50%;
  transform: translateX(-50%);
}

.placed-device--panel-right .placed-device__panel {
  left: calc(100% + 8px);
  top: 50%;
  transform: translateY(-50%);
}

.placed-device--panel-left .placed-device__panel {
  right: calc(100% + 8px);
  top: 50%;
  transform: translateY(-50%);
}

.placed-device__panel-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 6px;
  margin-bottom: 6px;
  padding-bottom: 6px;
  border-bottom: 1px solid rgba(148, 163, 184, 0.2);
}

.placed-device__panel-title {
  font-size: 12px;
  font-weight: 700;
  color: #f8fafc;
}

.placed-device__panel-status {
  font-size: 10px;
  padding: 1px 6px;
  border-radius: 999px;
  background: rgba(34, 197, 94, 0.2);
  color: #86efac;
}

.placed-device__panel-status--alarm {
  background: rgba(239, 68, 68, 0.25);
  color: #fca5a5;
}

.placed-device__panel-status--warning {
  background: rgba(234, 179, 8, 0.25);
  color: #fde047;
}

.placed-device__panel-status--offline {
  background: rgba(100, 116, 139, 0.3);
  color: #cbd5e1;
}

.placed-device__row {
  display: flex;
  justify-content: space-between;
  gap: 8px;
  padding: 3px 0;
  font-size: 11px;
}

.placed-device__row-name {
  color: #94a3b8;
  flex-shrink: 0;
}

.placed-device__row-value {
  color: #f1f5f9;
  font-weight: 600;
  text-align: right;
}

.placed-device__row--alarm .placed-device__row-value {
  color: #fca5a5;
}
</style>
