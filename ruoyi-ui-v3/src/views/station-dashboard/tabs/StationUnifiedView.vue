<script>
import StationRoomScene from '../components/StationRoomScene.vue'

export default {
  name: 'StationUnifiedView',
  components: { StationRoomScene },
  props: {
    deviceStates: { type: Array, default: () => [] },
    materialCards: { type: Array, default: () => [] },
    selectedDeviceId: { type: String, default: '' },
    selectedMaterialId: { type: String, default: '' }
  },
  emits: ['select-device', 'select-material', 'clear-selection']
}
</script>

<template>
  <div class="station-unified-view">
    <StationRoomScene
      :device-states="deviceStates"
      :material-cards="materialCards"
      :selected-device-id="selectedDeviceId"
      :selected-material-id="selectedMaterialId"
      @select-device="$emit('select-device', $event)"
      @select-material="$emit('select-material', $event)"
      @clear-selection="$emit('clear-selection')"
    />
  </div>
</template>

<style scoped lang="scss">
.station-unified-view {
  display: flex;
  flex: 1;
  min-height: 0;
  width: 100%;
  height: 100%;
}

.station-unified-view :deep(.station-room-scene) {
  flex: 1;
  width: 100%;
  height: 100%;
  min-height: 0;
}
</style>
