<script>
import DeviceIcon from './DeviceIcon.vue'

export default {
  name: 'MaterialCard',
  components: { DeviceIcon },
  props: {
    card: { type: Object, required: true },
    selected: { type: Boolean, default: false },
    dimmed: { type: Boolean, default: false },
    compact: { type: Boolean, default: true }
  },
  emits: ['select']
}
</script>

<template>
  <button
    type="button"
    class="material-card"
    :class="[
      `material-card--${card.health}`,
      { 'material-card--selected': selected, 'material-card--dimmed': dimmed, 'material-card--compact': compact }
    ]"
    @click.stop="$emit('select', card)"
  >
    <div class="material-card__row">
      <div class="material-card__icon-wrap">
        <DeviceIcon :type="card.deviceType" :size="compact ? 38 : 44" />
        <span class="material-card__dot" :class="`material-card__dot--${card.health}`" />
      </div>
      <div v-if="!selected && compact" class="material-card__compact">
        <div class="material-card__label">{{ card.label }}</div>
        <div class="material-card__percent">{{ card.percent }}%</div>
      </div>
    </div>
    <div v-if="!selected && !compact" class="material-card__compact">
      <div class="material-card__label">{{ card.label }}</div>
      <div class="material-card__percent">{{ card.percent }}%</div>
    </div>
    <div v-if="selected" class="material-card__panel" @click.stop>
      <div class="material-card__label">{{ card.label }}</div>
      <div class="material-card__bar">
        <div class="material-card__fill" :style="{ width: `${card.percent}%` }" />
      </div>
      <div class="material-card__meta">剩余 {{ card.remain }}{{ card.unit }} / {{ card.capacity }}{{ card.unit }}</div>
    </div>
  </button>
</template>

<style scoped lang="scss">
.material-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  width: 88px;
  padding: 6px;
  border-radius: 10px;
  border: 1px solid rgba(56, 189, 248, 0.16);
  background: rgba(8, 24, 48, 0.72);
  color: #e2e8f0;
  cursor: pointer;
  transition: opacity 0.25s ease, filter 0.25s ease;
}

.material-card--compact {
  width: auto;
  max-width: 108px;
  padding: 2px 4px;
  border-radius: 6px;
  background: rgba(8, 24, 48, 0.55);
  border-color: rgba(56, 189, 248, 0.12);
}

.material-card__row {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 4px;
}

.material-card--dimmed {
  opacity: 0.28;
  filter: blur(1px);
  pointer-events: none;
}

.material-card--selected {
  opacity: 1;
  filter: none;
  z-index: 100;
  border-color: rgba(125, 211, 252, 0.6);
  box-shadow: 0 6px 20px rgba(2, 8, 23, 0.55);
  width: 88px;
  padding: 6px;
}

.material-card__icon-wrap {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.material-card__dot {
  position: absolute;
  top: 0;
  right: 0;
  width: 7px;
  height: 7px;
  border-radius: 50%;
  border: 1.5px solid rgba(4, 12, 28, 0.9);
  z-index: 2;
}

.material-card__dot--normal { background: #22c55e; }
.material-card__dot--warning { background: #eab308; }
.material-card__dot--alarm { background: #ef4444; }
.material-card__dot--offline { background: #64748b; }
.material-card__dot--unknown { background: #475569; }

.material-card__compact {
  text-align: left;
  min-width: 0;
}

.material-card__label {
  font-size: 11px;
  line-height: 1.2;
  max-width: 84px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.material-card--compact .material-card__label {
  font-size: 9px;
  max-width: 62px;
  white-space: normal;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.material-card__percent {
  font-size: 13px;
  font-weight: 700;
  color: #7dd3fc;
}

.material-card--compact .material-card__percent {
  font-size: 11px;
}

.material-card__panel {
  width: 100%;
}

.material-card__bar {
  width: 100%;
  height: 6px;
  margin: 4px 0;
  border-radius: 999px;
  background: rgba(148, 163, 184, 0.2);
  overflow: hidden;
}

.material-card__fill {
  height: 100%;
  border-radius: inherit;
  background: linear-gradient(90deg, #22c55e, #38bdf8);
}

.material-card--warning .material-card__fill {
  background: linear-gradient(90deg, #eab308, #f59e0b);
}

.material-card--alarm .material-card__fill {
  background: linear-gradient(90deg, #ef4444, #f97316);
}

.material-card__meta {
  font-size: 9px;
  color: #94a3b8;
  line-height: 1.2;
}
</style>
