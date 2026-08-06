<script>
export default {
  name: 'KpiStrip',
  props: {
    kpiStates: { type: Array, default: () => [] },
    meteoStates: { type: Array, default: () => [] }
  }
}
</script>

<template>
  <div class="kpi-strip">
    <div class="kpi-strip__section">
      <div class="kpi-strip__title">大气监测</div>
      <div class="kpi-strip__grid">
        <div
          v-for="item in kpiStates"
          :key="item.id"
          class="kpi-card"
          :class="`kpi-card--${item.health}`"
        >
          <div class="kpi-card__label">{{ item.label }}</div>
          <div class="kpi-card__value">
            {{ item.value }}<span v-if="item.unit" class="kpi-card__unit">{{ item.unit }}</span>
          </div>
        </div>
      </div>
    </div>
    <div class="kpi-strip__section kpi-strip__section--meteo">
      <div class="kpi-strip__title">气象</div>
      <div class="kpi-strip__meteo">
        <div
          v-for="item in meteoStates"
          :key="item.id"
          class="meteo-item"
          :class="`meteo-item--${item.health}`"
        >
          <span class="meteo-item__label">{{ item.label }}</span>
          <span class="meteo-item__value">{{ item.value }}{{ item.unit }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.kpi-strip {
  display: grid;
  grid-template-columns: 1.4fr 1fr;
  gap: 14px;
}

.kpi-strip__title {
  margin-bottom: 8px;
  font-size: 13px;
  color: #7dd3fc;
  letter-spacing: 0.08em;
}

.kpi-strip__grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 8px;
}

.kpi-card {
  padding: 10px 12px;
  border-radius: 10px;
  background: rgba(8, 24, 48, 0.8);
  border: 1px solid rgba(56, 189, 248, 0.15);
}

.kpi-card__label {
  font-size: 12px;
  color: #94a3b8;
}

.kpi-card__value {
  margin-top: 4px;
  font-size: 20px;
  font-weight: 700;
  color: #f8fafc;
}

.kpi-card__unit {
  margin-left: 4px;
  font-size: 11px;
  color: #94a3b8;
}

.kpi-card--alarm { border-color: rgba(239, 68, 68, 0.55); }
.kpi-card--warning { border-color: rgba(234, 179, 8, 0.55); }
.kpi-card--offline { opacity: 0.65; }

.kpi-strip__meteo {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 8px;
}

.meteo-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 8px 10px;
  border-radius: 8px;
  background: rgba(8, 24, 48, 0.8);
  border: 1px solid rgba(56, 189, 248, 0.12);
}

.meteo-item__label {
  font-size: 11px;
  color: #94a3b8;
}

.meteo-item__value {
  font-size: 14px;
  font-weight: 600;
  color: #e2e8f0;
}

@media (max-width: 1400px) {
  .kpi-strip {
    grid-template-columns: 1fr;
  }
  .kpi-strip__grid {
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }
}
</style>
