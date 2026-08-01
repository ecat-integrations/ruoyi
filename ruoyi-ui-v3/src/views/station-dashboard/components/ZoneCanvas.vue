<script>
import DeviceNode from './DeviceNode.vue'
import { ZONE_META } from '../config/deviceRegistry'

export default {
  name: 'ZoneCanvas',
  components: { DeviceNode },
  props: {
    tab: { type: String, required: true },
    deviceStates: { type: Array, default: () => [] },
    selectedId: { type: String, default: '' }
  },
  emits: ['select'],
  computed: {
    zones() {
      const zoneMap = {}
      this.deviceStates
        .filter(item => item.tab === this.tab && !item.kpiOnly)
        .forEach(item => {
          if (!zoneMap[item.zone]) zoneMap[item.zone] = []
          zoneMap[item.zone].push(item)
        })

      return Object.keys(zoneMap)
        .map(zone => ({
          id: zone,
          title: ZONE_META[zone]?.title || zone,
          order: ZONE_META[zone]?.order || 99,
          devices: zoneMap[zone]
        }))
        .sort((a, b) => a.order - b.order)
    }
  }
}
</script>

<template>
  <div class="zone-canvas">
    <section v-for="zone in zones" :key="zone.id" class="zone-canvas__zone">
      <div class="zone-canvas__title">{{ zone.title }}</div>
      <div class="zone-canvas__grid">
        <DeviceNode
          v-for="device in zone.devices"
          :key="device.id"
          :device="device"
          :selected="selectedId === device.id"
          @select="$emit('select', $event)"
        />
      </div>
    </section>
  </div>
</template>

<style scoped lang="scss">
.zone-canvas {
  display: flex;
  flex-direction: column;
  gap: 16px;
  min-height: 0;
  overflow: auto;
}

.zone-canvas__zone {
  padding: 14px;
  border-radius: 14px;
  background: rgba(6, 18, 38, 0.72);
  border: 1px solid rgba(56, 189, 248, 0.12);
}

.zone-canvas__title {
  margin-bottom: 12px;
  font-size: 14px;
  font-weight: 600;
  color: #7dd3fc;
}

.zone-canvas__grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
</style>
