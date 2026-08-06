<script>
import StationRoomScene from '../components/StationRoomScene.vue'

export default {
  name: 'EnvSecurityTab',
  components: { StationRoomScene },
  props: {
    deviceStates: { type: Array, default: () => [] },
    selectedId: { type: String, default: '' }
  },
  emits: ['select-device']
}
</script>

<template>
  <div class="env-security-tab">
    <StationRoomScene
      tab="env-security"
      :device-states="deviceStates"
      :selected-id="selectedId"
      @select-device="$emit('select-device', $event)"
    />
  </div>
</template>

<style scoped lang="scss">
.env-security-tab {
  height: 100%;
  min-height: 0;
  display: flex;
  flex-direction: column;
}

.env-security-tab :deep(.station-room-scene) {
  flex: 1;
  min-height: 480px;
  max-height: none;
}
</style>
