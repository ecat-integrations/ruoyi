<script>
import PlacedDevice from './PlacedDevice.vue'
import MaterialCard from './MaterialCard.vue'
import {
  getUnifiedLayout,
  buildMaterialPlacements
} from '../config/stationRoomLayout'

export default {
  name: 'StationRoomScene',
  components: { PlacedDevice, MaterialCard },
  props: {
    deviceStates: { type: Array, default: () => [] },
    materialCards: { type: Array, default: () => [] },
    selectedDeviceId: { type: String, default: '' },
    selectedMaterialId: { type: String, default: '' }
  },
  emits: ['select-device', 'select-material', 'clear-selection'],
  computed: {
    layoutMap() {
      return getUnifiedLayout()
    },
    isFocused() {
      return !!(this.selectedDeviceId || this.selectedMaterialId)
    },
    placedDevices() {
      return this.deviceStates
        .filter(d => !d.kpiOnly && this.layoutMap[d.id])
        .map(d => ({ device: d, layout: this.layoutMap[d.id] }))
        .sort((a, b) => (a.layout.zIndex || 0) - (b.layout.zIndex || 0))
    },
    materialPlacements() {
      return buildMaterialPlacements(this.materialCards)
    }
  },
  methods: {
    onBackdropClick() {
      this.$emit('clear-selection')
    },
    isDeviceDimmed(deviceId) {
      return this.isFocused && this.selectedDeviceId !== deviceId
    },
    isMaterialDimmed(cardId) {
      return this.isFocused && this.selectedMaterialId !== cardId
    },
    onSelectDevice(device) {
      this.$emit('select-device', device)
    },
    onSelectMaterial(card) {
      this.$emit('select-material', card)
    }
  }
}
</script>

<template>
  <div
    class="station-room-scene"
    :class="{ 'station-room-scene--focused': isFocused }"
    @click="onBackdropClick"
  >
    <svg
      class="station-room-scene__bg"
      :class="{ 'station-room-scene__bg--dimmed': isFocused }"
      viewBox="0 0 1200 720"
      preserveAspectRatio="none"
    >
      <defs>
        <linearGradient id="skyGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#0c4a6e" />
          <stop offset="100%" stop-color="#0a3049" />
        </linearGradient>
        <linearGradient id="floorGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#3f4f63" />
          <stop offset="100%" stop-color="#1a2433" />
        </linearGradient>
        <linearGradient id="rackGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#526277" />
          <stop offset="100%" stop-color="#2a3544" />
        </linearGradient>
        <linearGradient id="platformGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#4a5568" />
          <stop offset="100%" stop-color="#2d3748" />
        </linearGradient>
      </defs>

      <rect x="0" y="0" width="1200" height="95" fill="url(#skyGrad)" />
      <text x="600" y="28" text-anchor="middle" fill="#7dd3fc" font-size="15" font-weight="600">采样平台</text>
      <line x1="0" y1="95" x2="1200" y2="95" stroke="#64748b" stroke-width="2.5" />
      <!-- 采样平台设备落位 -->
      <rect x="75" y="30" width="50" height="40" rx="3" fill="#1e293b" opacity="0.3" stroke="#334155" />
      <rect x="225" y="30" width="50" height="40" rx="3" fill="#1e293b" opacity="0.3" stroke="#334155" />
      <rect x="395" y="30" width="50" height="40" rx="3" fill="#1e293b" opacity="0.3" stroke="#334155" />
      <rect x="635" y="30" width="50" height="40" rx="3" fill="#1e293b" opacity="0.3" stroke="#334155" />
      <rect x="725" y="30" width="50" height="40" rx="3" fill="#1e293b" opacity="0.3" stroke="#334155" />
      <!-- 气象站（右移，避开摄像头3） -->
      <rect x="870" y="28" width="60" height="58" rx="4" fill="#1e293b" opacity="0.35" stroke="#38bdf8" stroke-width="1" stroke-dasharray="4 3" />
      <text x="900" y="24" text-anchor="middle" fill="#7dd3fc" font-size="10">气象站</text>
      <line x1="900" y1="34" x2="900" y2="78" stroke="#64748b" stroke-width="2" />
      <circle cx="900" cy="34" r="3" fill="#94a3b8" />
      <rect x="1025" y="30" width="50" height="40" rx="3" fill="#1e293b" opacity="0.3" stroke="#334155" />

      <rect x="0" y="95" width="1200" height="625" fill="url(#floorGrad)" />
      <rect x="0" y="95" width="1200" height="8" fill="#5a6a7d" />
      <text x="600" y="118" text-anchor="middle" fill="#94a3b8" font-size="12">智慧站房 · 监测 / 质控 / 动环</text>

      <!-- 站房内顶 · 空调 -->
      <rect x="330" y="125" width="60" height="46" rx="3" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <rect x="470" y="125" width="60" height="46" rx="3" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <text x="430" y="122" text-anchor="middle" fill="#64748b" font-size="9">空调</text>

      <line x1="40" y1="250" x2="1160" y2="250" stroke="#334155" stroke-width="1" opacity="0.6" />

      <rect x="70" y="110" width="18" height="210" rx="4" fill="#94a3b8" opacity="0.4" />
      <ellipse cx="79" cy="110" rx="12" ry="4" fill="#64748b" opacity="0.6" />
      <!-- 左侧贴墙 · 采样总管 -->
      <rect x="58" y="195" width="42" height="42" rx="3" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <text x="48" y="218" text-anchor="middle" fill="#64748b" font-size="8" transform="rotate(-90 48 218)">总管</text>

      <rect x="30" y="400" width="210" height="290" rx="6" fill="url(#platformGrad)" opacity="0.55" stroke="#475569" stroke-width="1.5" />
      <text x="135" y="392" text-anchor="middle" fill="#94a3b8" font-size="11">质控区</text>
      <rect x="55" y="420" width="160" height="54" rx="3" fill="#1e293b" opacity="0.45" stroke="#334155" />
      <rect x="55" y="490" width="160" height="54" rx="3" fill="#1e293b" opacity="0.45" stroke="#334155" />
      <rect x="50" y="565" width="70" height="55" rx="3" fill="#1e293b" opacity="0.5" stroke="#334155" />
      <rect x="140" y="565" width="70" height="55" rx="3" fill="#1e293b" opacity="0.5" stroke="#334155" />
      <rect x="50" y="630" width="70" height="50" rx="3" fill="#1e293b" opacity="0.5" stroke="#334155" />
      <rect x="140" y="630" width="70" height="55" rx="3" fill="#1e293b" opacity="0.5" stroke="#334155" />

      <!-- 标气 / 滤膜 分区货架 -->
      <rect x="250" y="430" width="140" height="270" rx="4" fill="#2a3544" opacity="0.7" stroke="#475569" stroke-width="1.2" />
      <line x1="318" y1="438" x2="318" y2="692" stroke="#334155" stroke-width="1" />
      <text x="282" y="444" text-anchor="middle" fill="#94a3b8" font-size="10">标气</text>
      <text x="357" y="444" text-anchor="middle" fill="#94a3b8" font-size="10">滤膜</text>
      <rect x="255" y="450" width="54" height="36" rx="2" fill="#1a2433" opacity="0.45" stroke="#334155" />
      <rect x="255" y="530" width="54" height="36" rx="2" fill="#1a2433" opacity="0.45" stroke="#334155" />
      <rect x="255" y="610" width="54" height="36" rx="2" fill="#1a2433" opacity="0.45" stroke="#334155" />
      <rect x="330" y="500" width="54" height="36" rx="2" fill="#1a2433" opacity="0.45" stroke="#334155" />
      <rect x="330" y="590" width="54" height="36" rx="2" fill="#1a2433" opacity="0.45" stroke="#334155" />

      <rect x="395" y="355" width="530" height="16" rx="2" fill="#64748b" />
      <rect x="385" y="371" width="550" height="130" rx="6" fill="url(#rackGrad)" stroke="#64748b" stroke-width="1.5" />
      <text x="660" y="348" text-anchor="middle" fill="#cbd5e1" font-size="12">监测机柜</text>
      <rect x="420" y="385" width="70" height="95" rx="3" fill="#1a2433" opacity="0.6" stroke="#334155" />
      <rect x="505" y="385" width="70" height="95" rx="3" fill="#1a2433" opacity="0.6" stroke="#334155" />
      <rect x="590" y="385" width="70" height="95" rx="3" fill="#1a2433" opacity="0.6" stroke="#334155" />
      <rect x="675" y="385" width="70" height="95" rx="3" fill="#1a2433" opacity="0.6" stroke="#334155" />
      <rect x="760" y="385" width="70" height="95" rx="3" fill="#1a2433" opacity="0.6" stroke="#334155" />
      <rect x="845" y="385" width="70" height="95" rx="3" fill="#1a2433" opacity="0.6" stroke="#334155" />

      <rect x="460" y="255" width="280" height="70" rx="4" fill="#1e293b" opacity="0.3" stroke="#334155" stroke-width="1" stroke-dasharray="4 3" />
      <rect x="490" y="265" width="60" height="50" rx="3" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <rect x="610" y="265" width="60" height="50" rx="3" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <text x="600" y="248" text-anchor="middle" fill="#64748b" font-size="10">站房环境</text>

      <!-- 右侧 · 墙面设备（照明 / 排风） -->
      <rect x="1050" y="160" width="130" height="175" rx="4" fill="#1e293b" opacity="0.25" stroke="#334155" stroke-width="1" />
      <text x="1115" y="152" text-anchor="middle" fill="#64748b" font-size="10">墙面设备</text>
      <rect x="1085" y="175" width="60" height="50" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <rect x="1085" y="260" width="60" height="50" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />

      <!-- 右侧 · 安防报警（独立块） -->
      <rect x="1050" y="355" width="130" height="95" rx="4" fill="#1e293b" opacity="0.28" stroke="#475569" stroke-width="1.2" />
      <text x="1115" y="368" text-anchor="middle" fill="#94a3b8" font-size="10">安防报警</text>
      <rect x="1085" y="388" width="60" height="50" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />

      <!-- 右侧 · 智能门禁（独立块，门禁下方留白） -->
      <rect x="1050" y="470" width="130" height="95" rx="4" fill="#1e293b" opacity="0.28" stroke="#475569" stroke-width="1.2" />
      <text x="1115" y="483" text-anchor="middle" fill="#94a3b8" font-size="10">智能门禁</text>
      <rect x="1085" y="503" width="60" height="50" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />

      <!-- 供电 · 监测机柜下方 -->
      <rect x="400" y="532" width="520" height="95" rx="4" fill="#2a3544" opacity="0.45" stroke="#475569" stroke-width="1" />
      <text x="660" y="526" text-anchor="middle" fill="#64748b" font-size="10">供电</text>
      <rect x="435" y="555" width="70" height="58" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <rect x="545" y="555" width="70" height="58" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <rect x="655" y="555" width="70" height="58" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />
      <rect x="765" y="555" width="70" height="58" rx="2" fill="#1e293b" opacity="0.35" stroke="#334155" />
    </svg>

    <div v-if="isFocused" class="station-room-scene__veil" />

    <div class="station-room-scene__layer">
      <PlacedDevice
        v-for="item in placedDevices"
        :key="item.device.id"
        :device="item.device"
        :layout="item.layout"
        :selected="selectedDeviceId === item.device.id"
        :dimmed="isDeviceDimmed(item.device.id)"
        @select="onSelectDevice"
      />
      <div
        v-for="(item, idx) in materialPlacements"
        :key="item.card.id || idx"
        class="material-slot"
        :class="{ 'material-slot--selected': selectedMaterialId === item.card.id }"
        :style="{ left: `${item.layout.x}%`, top: `${item.layout.y}%` }"
      >
        <MaterialCard
          :card="item.card"
          :selected="selectedMaterialId === item.card.id"
          :dimmed="isMaterialDimmed(item.card.id)"
          @select="onSelectMaterial"
        />
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.station-room-scene {
  position: relative;
  width: 100%;
  height: 100%;
  min-height: 0;
  border-radius: 0;
  overflow: hidden;
  border: none;
  background: #04101f;
}

.station-room-scene__bg {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  transition: filter 0.3s ease, opacity 0.3s ease;
}

.station-room-scene__bg--dimmed {
  filter: blur(2px) brightness(0.55);
}

.station-room-scene__veil {
  position: absolute;
  inset: 0;
  z-index: 50;
  background: rgba(2, 8, 23, 0.15);
  pointer-events: none;
}

.station-room-scene__layer {
  position: absolute;
  inset: 0;
  z-index: 60;
}

.material-slot {
  position: absolute;
  transform: translate(-50%, -50%);
  z-index: 7;
}

.material-slot--selected {
  z-index: 100;
}
</style>
