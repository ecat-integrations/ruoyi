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
  name: 'DeviceDetailDrawer',
  components: { DeviceIcon },
  props: {
    device: { type: Object, default: null }
  },
  emits: ['close'],
  computed: {
    visible() {
      return !!this.device
    },
    rows() {
      return this.device?.detailRows || []
    }
  },
  methods: {
    healthLabel(health) {
      return HEALTH_LABELS[health] || '未知'
    }
  }
}
</script>

<template>
  <transition name="drawer-slide">
    <aside v-if="visible" class="detail-drawer">
      <div class="detail-drawer__header">
        <DeviceIcon :type="device.deviceType" :health="device.health" :size="56" />
        <div>
          <div class="detail-drawer__title">{{ device.label }}</div>
          <div class="detail-drawer__status">{{ healthLabel(device.health) }}</div>
        </div>
        <button type="button" class="detail-drawer__close" @click="$emit('close')">×</button>
      </div>
      <div class="detail-drawer__body">
        <div v-for="row in rows" :key="row.key" class="detail-row" :class="`detail-row--${row.health}`">
          <span class="detail-row__name">{{ row.name }}</span>
          <span class="detail-row__value">{{ row.value }}{{ row.unit }}</span>
        </div>
      </div>
    </aside>
  </transition>
</template>

<style scoped lang="scss">
.detail-drawer {
  position: absolute;
  top: 0;
  right: 0;
  width: 320px;
  height: 100%;
  padding: 16px;
  background: rgba(4, 12, 28, 0.96);
  border-left: 1px solid rgba(56, 189, 248, 0.2);
  box-shadow: -8px 0 24px rgba(2, 8, 23, 0.45);
  z-index: 20;
}

.detail-drawer__header {
  display: grid;
  grid-template-columns: auto 1fr auto;
  gap: 12px;
  align-items: center;
  margin-bottom: 16px;
}

.detail-drawer__title {
  font-size: 18px;
  font-weight: 700;
  color: #f8fafc;
}

.detail-drawer__status {
  margin-top: 4px;
  font-size: 12px;
  color: #7dd3fc;
}

.detail-drawer__close {
  width: 28px;
  height: 28px;
  border: none;
  border-radius: 50%;
  background: rgba(148, 163, 184, 0.15);
  color: #e2e8f0;
  font-size: 18px;
  cursor: pointer;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  padding: 10px 0;
  border-bottom: 1px solid rgba(148, 163, 184, 0.12);
}

.detail-row__name {
  color: #94a3b8;
  font-size: 13px;
}

.detail-row__value {
  color: #f8fafc;
  font-size: 13px;
  font-weight: 600;
}

.drawer-slide-enter-active,
.drawer-slide-leave-active {
  transition: transform 0.25s ease, opacity 0.25s ease;
}

.drawer-slide-enter-from,
.drawer-slide-leave-to {
  transform: translateX(100%);
  opacity: 0;
}
</style>
