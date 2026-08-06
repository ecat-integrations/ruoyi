<script>
import KpiStrip from '../components/KpiStrip.vue'
import StationRoomScene from '../components/StationRoomScene.vue'

export default {
  name: 'MonitoringQcTab',
  components: { KpiStrip, StationRoomScene },
  props: {
    kpiStates: { type: Array, default: () => [] },
    meteoStates: { type: Array, default: () => [] },
    deviceStates: { type: Array, default: () => [] },
    materialCards: { type: Array, default: () => [] },
    selectedId: { type: String, default: '' }
  },
  emits: ['select-device', 'select-material']
}
</script>

<template>
  <div class="monitoring-qc-tab">
    <KpiStrip :kpi-states="kpiStates" :meteo-states="meteoStates" />
    <StationRoomScene
      tab="monitoring-qc"
      :device-states="deviceStates"
      :material-cards="materialCards"
      :selected-id="selectedId"
      @select-device="$emit('select-device', $event)"
      @select-material="$emit('select-material', $event)"
    />
  </div>
</template>

<style scoped lang="scss">
.monitoring-qc-tab {
  display: flex;
  flex-direction: column;
  gap: 10px;
  min-height: 0;
  height: 100%;
}

.monitoring-qc-tab :deep(.kpi-strip) {
  flex-shrink: 0;
}

.monitoring-qc-tab :deep(.station-room-scene) {
  flex: 1;
  min-height: 480px;
  max-height: none;
}
</style>
