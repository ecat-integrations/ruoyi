<template>
  <div class="station-dashboard" ref="root">
    <aside class="station-dashboard__dock">
      <div class="station-dashboard__logo" title="智慧站房监控中心" />
      <div class="station-dashboard__title-v">智慧站房监控中心</div>
      <div class="station-dashboard__subtitle-v">监测·质控·动环</div>
      <StatusSummaryBar :summary="summary" layout="dock" />
      <div class="station-dashboard__dock-spacer" />
      <div class="station-dashboard__meta-v">
        <span class="station-dashboard__version">V2.1</span>
        <span class="station-dashboard__time">{{ nowTimeShort }}</span>
      </div>
    </aside>

    <div class="station-dashboard__body">
      <main class="station-dashboard__main">
        <div v-if="focusHint" class="station-dashboard__overlay">
          <span class="station-dashboard__hint">{{ focusHint }}</span>
        </div>
        <StationUnifiedView
          :device-states="deviceStates"
          :material-cards="materialCards"
          :selected-device-id="selectedDeviceId"
          :selected-material-id="selectedMaterialId"
          @select-device="handleSelectDevice"
          @select-material="handleSelectMaterial"
          @clear-selection="clearSelection"
        />
      </main>
    </div>
  </div>
</template>

<script>
import date from '@/utils/date'
import { recordPageVisit } from '@/utils/pageState'
import StatusSummaryBar from './components/StatusSummaryBar.vue'
import StationUnifiedView from './tabs/StationUnifiedView.vue'
import { fetchStationDashboardData, findDeviceState } from './utils/stationDataService'
import './styles/station-dashboard.scss'

export default {
  name: 'StationDashboard',
  components: {
    StatusSummaryBar,
    StationUnifiedView
  },
  data() {
    return {
      nowTime: '',
      deviceStates: [],
      materialCards: [],
      summary: { normal: 0, warning: 0, alarm: 0, offline: 0 },
      selectedDeviceId: '',
      selectedMaterialId: '',
      pollTimer: null,
      clockTimer: null
    }
  },
  computed: {
    nowTimeShort() {
      if (!this.nowTime) return ''
      const parts = this.nowTime.split(' ')
      return parts.length > 1 ? parts[1] : this.nowTime
    },
    focusHint() {
      if (this.selectedDeviceId) {
        const d = findDeviceState(this.deviceStates, this.selectedDeviceId)
        return d ? `已选中：${d.label}（点击空白处关闭）` : ''
      }
      if (this.selectedMaterialId) {
        return '已选中耗材（点击空白处关闭）'
      }
      return ''
    }
  },
  mounted() {
    recordPageVisit('/station', { action: 'page_load' })
    this.nowTime = date.currDate()
    this.clockTimer = setInterval(() => {
      this.nowTime = date.currDate()
    }, 1000)
    this.refreshData()
    this.pollTimer = setInterval(() => this.refreshData(), 5000)
  },
  beforeUnmount() {
    clearInterval(this.clockTimer)
    clearInterval(this.pollTimer)
  },
  methods: {
    async refreshData() {
      try {
        const payload = await fetchStationDashboardData()
        this.deviceStates = payload.deviceStates
        this.materialCards = payload.materialCards
        this.summary = payload.summary
      } catch (error) {
        console.warn('站房大屏数据刷新失败:', error)
      }
    },
    handleSelectDevice(device) {
      this.selectedMaterialId = ''
      this.selectedDeviceId = this.selectedDeviceId === device.id ? '' : device.id
    },
    handleSelectMaterial(card) {
      this.selectedDeviceId = ''
      this.selectedMaterialId = this.selectedMaterialId === card.id ? '' : card.id
    },
    clearSelection() {
      this.selectedDeviceId = ''
      this.selectedMaterialId = ''
    }
  }
}
</script>
