<script>
export default {
  name: 'StatusSummaryBar',
  props: {
    summary: {
      type: Object,
      default: () => ({ normal: 0, warning: 0, alarm: 0, offline: 0 })
    },
    layout: {
      type: String,
      default: 'horizontal',
      validator: v => ['horizontal', 'dock'].includes(v)
    }
  },
  computed: {
    items() {
      return [
        { key: 'normal', label: '正常', count: this.summary.normal || 0 },
        { key: 'warning', label: '预警', count: this.summary.warning || 0 },
        { key: 'alarm', label: '告警', count: this.summary.alarm || 0 },
        { key: 'offline', label: '离线', count: this.summary.offline || 0 }
      ]
    }
  }
}
</script>

<template>
  <div class="status-summary" :class="`status-summary--${layout}`">
    <div
      v-for="item in items"
      :key="item.key"
      class="status-summary__item"
      :class="`status-summary__item--${item.key}`"
    >
      <span class="dot" />
      <template v-if="layout === 'dock'">
        <span class="status-summary__label">{{ item.label }}</span>
        <span class="status-summary__count">{{ item.count }}</span>
      </template>
      <template v-else>{{ item.label }} {{ item.count }}</template>
    </div>
  </div>
</template>

<style scoped lang="scss">
.status-summary {
  display: flex;
  gap: 18px;
  align-items: center;
  font-size: 13px;
}

.status-summary__item {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  color: #cbd5e1;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.status-summary__item--normal .dot { background: #22c55e; }
.status-summary__item--warning .dot { background: #eab308; }
.status-summary__item--alarm .dot { background: #ef4444; }
.status-summary__item--offline .dot { background: #64748b; }

.status-summary--dock {
  flex-direction: column;
  gap: 12px;
  align-items: center;
  margin-top: 14px;
  padding-top: 12px;
  border-top: 1px solid rgba(56, 189, 248, 0.12);
}

.status-summary--dock .status-summary__item {
  flex-direction: column;
  gap: 3px;
  font-size: 10px;
  line-height: 1.2;
  color: #94a3b8;
}

.status-summary--dock .dot {
  width: 7px;
  height: 7px;
}

.status-summary--dock .status-summary__count {
  font-size: 11px;
  font-weight: 700;
  color: #e2e8f0;
}

.status-summary--dock .status-summary__label {
  writing-mode: vertical-rl;
  text-orientation: mixed;
  letter-spacing: 0.06em;
}
</style>
