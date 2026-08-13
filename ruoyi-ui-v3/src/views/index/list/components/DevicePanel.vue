<template>
  <div class="device-panel" :class="{ 'is-logical': isLogicalView }">
    <div class="panel-header">
      <div class="panel-title">
        <div class="mode-switch-buttons">
          <el-tooltip content="切换到大屏" placement="bottom">
            <button
              type="button"
              class="mode-icon-btn mode-icon-btn--dashboard"
              aria-label="切换大屏"
              @click="$emit('return-to-dashboard')"
            >
              <!-- 大屏 -->
              <svg class="mode-icon" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <rect x="3.5" y="5.5" width="17" height="11" rx="1.8" stroke="currentColor" stroke-width="1.6" />
                <path d="M9 19.5h6" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" />
                <path d="M12 16.5v3" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" />
                <path d="M4.2 8.2V6.8h1.4M19.8 8.2V6.8h-1.4M4.2 13.8v1.4h1.4M19.8 13.8v1.4h-1.4" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round" />
              </svg>
              <span class="mode-icon-btn__text">切换大屏</span>
            </button>
          </el-tooltip>
          <el-tooltip content="切换到全域智控" placement="bottom">
            <button
              type="button"
              class="mode-icon-btn mode-icon-btn--station"
              aria-label="全域智控"
              @click="$emit('switch-to-station-preview')"
            >
              <!-- 全域智控 -->
              <svg class="mode-icon" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                <path d="M3.5 16.2 12 20.4 20.5 16.2 12 12 3.5 16.2Z" stroke="currentColor" stroke-width="1.35" stroke-linejoin="round" />
                <path d="M3.5 16.2V9.4L12 5.2 20.5 9.4v6.8" stroke="currentColor" stroke-width="1.35" stroke-linejoin="round" />
                <path d="M12 5.2V12" stroke="currentColor" stroke-width="1.35" stroke-linecap="round" />
                <path d="M9.2 14.1 12 15.5l2.8-1.4V10.8L12 9.4 9.2 10.8v3.3Z" stroke="currentColor" stroke-width="1.25" stroke-linejoin="round" />
                <path d="M12 15.5v2.2" stroke="currentColor" stroke-width="1.2" stroke-linecap="round" />
                <path d="M5.4 14.6 7.6 15.7V13.2L5.4 12.1v2.5Z" stroke="currentColor" stroke-width="1.15" stroke-linejoin="round" />
                <path d="M5.4 12.1 7.6 13.2 9.2 12.4 7 11.3 5.4 12.1Z" stroke="currentColor" stroke-width="1.1" stroke-linejoin="round" opacity="0.85" />
                <path d="M16.4 14.8 18.2 15.7V11.6L16.4 10.7v4.1Z" stroke="currentColor" stroke-width="1.15" stroke-linejoin="round" />
                <circle cx="17.3" cy="10.2" r="0.85" stroke="currentColor" stroke-width="1.1" />
              </svg>
              <span class="mode-icon-btn__text">全域智控</span>
            </button>
          </el-tooltip>
        </div>
      </div>
      <div class="panel-controls">
        <div class="device-kind-switch" title="切换物理设备 / 逻辑设备">
          <span class="kind-label" :class="{ active: deviceKind === 'physical' }">物理设备</span>
          <el-switch
            v-model="isLogicalView"
            inline-prompt
            active-text="逻辑"
            inactive-text="物理"
          />
          <span class="kind-label" :class="{ active: deviceKind === 'logical' }">逻辑设备</span>
        </div>

        <el-button
          type="primary"
          @click="$emit('open-orchestration')"
          icon="Sort"
        >
          设备控制编排
        </el-button>
      </div>
    </div>

    <div v-if="mainDevices.length > 0" class="device-grid">
      <DeviceCard
        v-for="(device, index) in mainDevices"
        :key="device.deviceId"
        :device="device"
        :data-index="index"
        draggable="true"
        @dragstart="handleDragStart($event, index)"
        @dragover="handleDragOver($event)"
        @dragenter="handleDragEnter($event, index)"
        @dragleave="handleDragLeave($event)"
        @drop="handleDrop($event, index)"
        @dragend="handleDragEnd($event)"
        @dblclick="handleDoubleClick($event, index)"
        @contextmenu="handleContextMenu($event, index)"
        @open-manual-tag="handleOpenManualTag"
      />
    </div>
    <EmptyState v-else />

    <!-- 逻辑模式：右上动环页签切入切出站房设备 -->
    <div
      v-if="isLogicalView"
      class="donghuan-shell"
      :class="{ open: donghuanOpen }"
      :style="donghuanShellStyle"
    >
      <button
        type="button"
        class="donghuan-tab"
        :class="{ open: donghuanOpen }"
        :title="donghuanOpen ? '收起动环站房设备' : '展开动环站房设备'"
        @click="toggleDonghuan"
      >
        <span class="donghuan-tab__text">动环</span>
      </button>

      <aside class="donghuan-drawer" aria-label="动环站房设备">
        <div class="donghuan-drawer__head">
          <span>动环 · 站房设备</span>
          <span class="donghuan-drawer__count">{{ stationDevices.length }}</span>
        </div>
        <div v-if="stationDevices.length > 0" class="donghuan-drawer__grid">
          <DeviceCard
            v-for="(device, index) in stationDevices"
            :key="'station-' + device.deviceId"
            :device="device"
            :data-index="index"
            draggable="true"
            @dragstart="handleStationDragStart($event, index)"
            @dragover="handleDragOver($event)"
            @dragenter="handleStationDragEnter($event, index)"
            @dragleave="handleStationDragLeave($event)"
            @drop="handleStationDrop($event, index)"
            @dragend="handleStationDragEnd($event)"
            @dblclick="handleStationDoubleClick($event, index)"
            @contextmenu="handleStationContextMenu($event, index)"
            @open-manual-tag="handleOpenManualTag"
          />
        </div>
        <div v-else class="donghuan-drawer__empty">暂无站房逻辑设备</div>
      </aside>
    </div>

    <div
      v-if="isLogicalView && donghuanOpen"
      class="donghuan-mask"
      @click="closeDonghuan"
    />

    <ManualTagDialog
      v-model="isManualTagDialogShow"
      :device="currentDeviceForTag"
      @success="handleManualTagSuccess"
    />
  </div>
</template>

<script setup>
import { ref, watch, computed, onMounted, onBeforeUnmount } from 'vue'
import DeviceCard from './DeviceCard.vue'
import EmptyState from './EmptyState.vue'
import ManualTagDialog from './ManualTagDialog.vue'
import { useDeviceCardDragSort } from '../composables/useDeviceCardDragSort'
import {
  loadDeviceListView,
  saveDeviceListView,
  filterMainDevices,
  filterStationDevices
} from '../utils/deviceDomain'
import useAppStore from '@/store/modules/app'
import { ElMessage } from 'element-plus'

const props = defineProps({
  deviceData: {
    type: Array,
    default: () => []
  }
})

defineEmits(['open-orchestration', 'return-to-dashboard', 'switch-to-station-preview'])

const appStore = useAppStore()
const { applyCachedOrder, handleDragEnd: saveDragEnd, moveDeviceToFirst } = useDeviceCardDragSort()

const orderedDevices = ref(applyCachedOrder(props.deviceData || []))

/** @type {import('vue').Ref<'physical'|'logical'>} */
const deviceKind = ref('physical')
const donghuanOpen = ref(false)
const viewportWidth = ref(typeof window !== 'undefined' ? window.innerWidth : 1280)

const SIDEBAR_OPEN_WIDTH = 200
const SIDEBAR_COLLAPSED_WIDTH = 54
const MAIN_PEEK_GAP = 20

const sidebarWidth = computed(() => {
  if (appStore.sidebar?.hide) return 0
  return appStore.sidebar?.opened ? SIDEBAR_OPEN_WIDTH : SIDEBAR_COLLAPSED_WIDTH
})

/**
 * 左栏开合变化
 */
const donghuanShellStyle = computed(() => {
  const left = Math.max(sidebarWidth.value + MAIN_PEEK_GAP, MAIN_PEEK_GAP)
  // 极窄窗口处理
  const maxLeft = Math.max(viewportWidth.value - 320, MAIN_PEEK_GAP)
  return {
    left: `${Math.min(left, maxLeft)}px`,
    right: '0',
    width: 'auto',
    bottom: '4px'
  }
})

const isLogicalView = computed({
  get: () => deviceKind.value === 'logical',
  set: (val) => {
    deviceKind.value = val ? 'logical' : 'physical'
    donghuanOpen.value = false
    persistView()
  }
})

const mainDevices = computed(() =>
  filterMainDevices(orderedDevices.value, deviceKind.value)
)

const stationDevices = computed(() =>
  filterStationDevices(orderedDevices.value)
)

function persistView() {
  saveDeviceListView({
    kind: deviceKind.value,
    donghuanOpen: donghuanOpen.value
  })
}

function toggleDonghuan() {
  donghuanOpen.value = !donghuanOpen.value
  persistView()
}

function closeDonghuan() {
  if (!donghuanOpen.value) return
  donghuanOpen.value = false
  persistView()
}

onMounted(() => {
  const saved = loadDeviceListView()
  deviceKind.value = saved.kind
  donghuanOpen.value = saved.kind === 'logical' ? saved.donghuanOpen : false
  viewportWidth.value = window.innerWidth
  window.addEventListener('resize', handleViewportResize, { passive: true })
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleViewportResize)
})

function handleViewportResize() {
  viewportWidth.value = window.innerWidth
}

watch(
  () => props.deviceData,
  (newDevices) => {
    if (newDevices && newDevices.length > 0) {
      orderedDevices.value = applyCachedOrder(newDevices)
    }
  },
  { deep: true }
)

// —— 主列表拖拽 / 置顶 ——
const draggedIndex = ref(null)
const dragOverIndex = ref(null)

const handleDragStart = (event, index) => {
  draggedIndex.value = index
  event.currentTarget.classList.add('dragging')
  event.dataTransfer.effectAllowed = 'move'
  event.dataTransfer.setData('text/plain', index)
}

const handleDragOver = (event) => {
  event.preventDefault()
  event.dataTransfer.dropEffect = 'move'
}

const handleDragEnter = (event, index) => {
  event.preventDefault()
  if (index !== draggedIndex.value) {
    dragOverIndex.value = index
    event.currentTarget.classList.add('drag-over')
  }
}

const handleDragLeave = (event) => {
  event.currentTarget.classList.remove('drag-over')
  dragOverIndex.value = null
}

const handleDrop = (event, toIndex) => {
  event.preventDefault()
  event.stopPropagation()
  const fromIndex = draggedIndex.value
  if (fromIndex !== null && fromIndex !== toIndex) {
    orderedDevices.value = saveDragEnd(
      orderedDevices.value,
      mainDevices.value,
      fromIndex,
      toIndex
    )
    ElMessage.success('已调整设备顺序')
  }
  event.currentTarget.classList.remove('drag-over')
  dragOverIndex.value = null
  draggedIndex.value = null
}

const handleDragEnd = (event) => {
  event.currentTarget.classList.remove('dragging')
  draggedIndex.value = null
  dragOverIndex.value = null
  document.querySelectorAll('.drag-over').forEach(el => el.classList.remove('drag-over'))
}

/** 双击卡片头部：将该设备置顶 */
const handleDoubleClick = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  if (index <= 0) return
  const deviceName = mainDevices.value[index]?.deviceName
  orderedDevices.value = moveDeviceToFirst(
    orderedDevices.value,
    mainDevices.value,
    index
  )
  ElMessage.success(`已将 "${deviceName}" 置顶`)
}

const handleContextMenu = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  if (index > 0) {
    const deviceName = mainDevices.value[index]?.deviceName
    orderedDevices.value = moveDeviceToFirst(
      orderedDevices.value,
      mainDevices.value,
      index
    )
    ElMessage.success(`已将 "${deviceName}" 置顶`)
  }
}

// —— 动环抽屉内拖拽 / 置顶 ——
const stationDraggedIndex = ref(null)

const handleStationDragStart = (event, index) => {
  stationDraggedIndex.value = index
  event.currentTarget.classList.add('dragging')
  event.dataTransfer.effectAllowed = 'move'
  event.dataTransfer.setData('text/plain', `station:${index}`)
}

const handleStationDragEnter = (event, index) => {
  event.preventDefault()
  if (index !== stationDraggedIndex.value) {
    event.currentTarget.classList.add('drag-over')
  }
}

const handleStationDragLeave = (event) => {
  event.currentTarget.classList.remove('drag-over')
}

const handleStationDrop = (event, toIndex) => {
  event.preventDefault()
  event.stopPropagation()
  const fromIndex = stationDraggedIndex.value
  if (fromIndex !== null && fromIndex !== toIndex) {
    orderedDevices.value = saveDragEnd(
      orderedDevices.value,
      stationDevices.value,
      fromIndex,
      toIndex
    )
    ElMessage.success('已调整站房设备顺序')
  }
  event.currentTarget.classList.remove('drag-over')
  stationDraggedIndex.value = null
}

const handleStationDragEnd = (event) => {
  event.currentTarget.classList.remove('dragging')
  stationDraggedIndex.value = null
  document.querySelectorAll('.donghuan-drawer .drag-over').forEach(el => {
    el.classList.remove('drag-over')
  })
}

/** 双击站房卡片头部：置顶（一次双击即生效） */
/** 双击站房卡片头部：置顶（一次双击即生效） */
const handleStationDoubleClick = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  if (index <= 0) return
  const deviceName = stationDevices.value[index]?.deviceName
  orderedDevices.value = moveDeviceToFirst(
    orderedDevices.value,
    stationDevices.value,
    index
  )
  ElMessage.success(`已将 "${deviceName}" 置顶`)
}

const handleStationContextMenu = (event, index) => {
  event.preventDefault()
  event.stopPropagation()
  if (index > 0) {
    const deviceName = stationDevices.value[index]?.deviceName
    orderedDevices.value = moveDeviceToFirst(
      orderedDevices.value,
      stationDevices.value,
      index
    )
    ElMessage.success(`已将 "${deviceName}" 置顶`)
  }
}

const isManualTagDialogShow = ref(false)
const currentDeviceForTag = ref(null)

function handleOpenManualTag(device) {
  currentDeviceForTag.value = device
  isManualTagDialogShow.value = true
}

function handleManualTagSuccess(data) {
  ElMessage.success(`设备 "${data.device.deviceName}" 标识成功,请稍等片刻生效`)
}
</script>

<style scoped>
.device-panel {
  width: 100%;
  padding: 20px;
  padding-bottom: 60px;
  position: relative;
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  padding: 2px 0;
  border-bottom: 1px solid var(--el-border-color-light, #ebeef5);
}

.mode-switch-buttons {
  display: flex;
  gap: 8px;
  align-items: center;
}

.mode-icon-btn {
  height: 28px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  padding: 0 10px 0 8px;
  border-radius: 8px;
  border: 1px solid rgba(15, 23, 42, 0.08);
  background:
    linear-gradient(180deg, rgba(255, 255, 255, 0.92), rgba(248, 250, 252, 0.88));
  box-shadow:
    0 1px 2px rgba(15, 23, 42, 0.04),
    inset 0 1px 0 rgba(255, 255, 255, 0.75);
  color: #475569;
  cursor: pointer;
  transition:
    color 0.2s ease,
    border-color 0.2s ease,
    background 0.2s ease,
    box-shadow 0.2s ease,
    transform 0.2s ease;
}

.mode-icon-btn:hover {
  color: #0f172a;
  border-color: rgba(15, 23, 42, 0.14);
  background:
    linear-gradient(180deg, #ffffff, #f1f5f9);
  box-shadow:
    0 4px 12px rgba(15, 23, 42, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.9);
  transform: translateY(-1px);
}

.mode-icon-btn:active {
  transform: translateY(0);
  box-shadow: 0 1px 2px rgba(15, 23, 42, 0.06);
}

/* 大屏入口 */
.mode-icon-btn--dashboard {
  color: #dbe7f3;
  border-color: rgba(0, 229, 255, 0.22);
  background:
    linear-gradient(180deg, #1c2430 0%, #0b1220 100%);
  box-shadow:
    0 1px 2px rgba(0, 0, 0, 0.28),
    inset 0 1px 0 rgba(255, 255, 255, 0.06),
    inset 0 0 0 1px rgba(0, 229, 255, 0.04);
}

.mode-icon-btn--dashboard:hover {
  color: #f0f9ff;
  border-color: rgba(0, 229, 255, 0.4);
  background:
    linear-gradient(180deg, #243041 0%, #101826 100%);
  box-shadow:
    0 6px 16px rgba(0, 0, 0, 0.32),
    0 0 0 1px rgba(0, 229, 255, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.08);
}

.mode-icon-btn--dashboard:active {
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.35);
}

.mode-icon {
  width: 16px;
  height: 16px;
  display: block;
  flex-shrink: 0;
}

.mode-icon-btn__text {
  font-size: 12px;
  font-weight: 500;
  line-height: 1;
  letter-spacing: 0.02em;
  white-space: nowrap;
}

.panel-controls {
  display: flex;
  gap: 12px;
  align-items: center;
}

.device-kind-switch {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 4px 10px;
  border-radius: 20px;
  background: var(--el-fill-color-light, #f5f7fa);
  border: 1px solid var(--el-border-color-lighter, #ebeef5);
}

.kind-label {
  font-size: 12px;
  font-weight: 500;
  color: #909399;
  user-select: none;
  transition: color 0.2s ease;
}

.kind-label.active {
  color: #409eff;
}

.kind-label.active:last-child {
  color: #9059ff;
}

/* 动环侧栏与窗口动态设置 */
.donghuan-shell {
  position: fixed;
  top: 84px;
  z-index: 40;
  display: flex;
  align-items: stretch;
  transform: translateX(calc(100% - 26px));
  transition:
    transform 0.38s cubic-bezier(0.22, 0.8, 0.28, 1),
    left 0.28s ease;
  pointer-events: none;
}

.donghuan-shell.open {
  transform: translateX(0);
}

.donghuan-tab,
.donghuan-drawer {
  pointer-events: auto;
}

.donghuan-tab {
  width: 26px;
  flex-shrink: 0;
  margin: 28px 0 0;
  margin-right: -1px;
  align-self: flex-start;
  min-height: 64px;
  padding: 10px 0;
  border: 1px solid rgba(144, 89, 255, 0.48);
  border-right: none;
  border-radius: 8px 0 0 8px;
  background: linear-gradient(
    180deg,
    rgba(144, 89, 255, 0.34) 0%,
    rgba(144, 89, 255, 0.14) 100%
  );
  color: #9059ff;
  cursor: pointer;
  transition: color 0.2s ease, border-color 0.2s ease, background 0.2s ease, opacity 0.2s ease;
  opacity: 1;
  position: relative;
  z-index: 2;
}

.donghuan-tab__text {
  writing-mode: vertical-rl;
  letter-spacing: 0.18em;
  font-size: 12px;
  font-weight: 600;
  line-height: 1;
}

.donghuan-tab:hover {
  color: #7a3fe0;
  border-color: rgba(122, 63, 224, 0.62);
  background: linear-gradient(
    180deg,
    rgba(144, 89, 255, 0.42) 0%,
    rgba(144, 89, 255, 0.18) 100%
  );
}

.donghuan-tab.open {
  color: #7a3fe0;
  border-color: rgba(122, 63, 224, 0.68);
  background: linear-gradient(
    180deg,
    rgba(144, 89, 255, 0.46) 0%,
    rgba(144, 89, 255, 0.2) 100%
  );
}

.donghuan-drawer {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  background: var(--el-bg-color, #fff);
  border: 1px solid var(--el-border-color-light, #e4e7ed);
  border-right: none;
  border-radius: 16px 0 0 16px;
  box-shadow: -6px 0 18px rgba(0, 0, 0, 0.08);
  overflow: hidden;
  position: relative;
  z-index: 1;
}

.donghuan-drawer__head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 2px 10px;
  min-height: 24px;
  height: 24px;
  font-size: 12px;
  font-weight: 600;
  line-height: 1;
  color: var(--el-text-color-primary, #303133);
  border-bottom: 1px solid var(--el-border-color-lighter, #ebeef5);
}

.donghuan-drawer__count {
  min-width: 16px;
  height: 16px;
  padding: 0 4px;
  border-radius: 8px;
  background: var(--el-fill-color, #f0f2f5);
  color: var(--el-text-color-secondary, #909399);
  font-size: 11px;
  font-weight: 500;
  line-height: 16px;
  text-align: center;
}

.donghuan-drawer__grid {
  flex: 1;
  overflow: auto;
  padding: 16px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
  align-content: start;
}

/* 仅让参数名/值同行 */
.donghuan-drawer__grid :deep(.attribute-item) {
  margin-bottom: 6px;
  padding: 6px 8px;
}

.donghuan-drawer__grid :deep(.attribute-info) {
  display: flex;
  align-items: baseline;
  gap: 10px;
  min-width: 0;
}

.donghuan-drawer__grid :deep(.attribute-name) {
  margin-bottom: 0;
  flex: 0 1 auto;
  max-width: 48%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.donghuan-drawer__grid :deep(.attribute-value-container) {
  flex: 1 1 auto;
  min-width: 0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.donghuan-drawer__grid :deep(.device-footer) {
  padding: 6px 12px;
  font-size: 12px;
  line-height: 1.2;
  min-height: 0;
}

.donghuan-drawer__grid :deep(.device-type-indicator) {
  padding: 2px 8px;
  font-size: 11px;
  gap: 2px;
  line-height: 1.2;
}

.donghuan-drawer__grid :deep(.device-type-indicator .el-icon) {
  font-size: 13px;
}

.donghuan-drawer__empty {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--el-text-color-secondary, #909399);
  font-size: 14px;
}

.donghuan-mask {
  position: fixed;
  inset: 0;
  z-index: 35;
  background: rgba(0, 0, 0, 0.14);
}

.device-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 20px;
  padding-bottom: 40px;
  margin-bottom: 20px;
  align-items: stretch;
}

.device-grid :deep(.device-card),
.donghuan-drawer__grid :deep(.device-card) {
  cursor: grab;
  user-select: none;
  position: relative;
}

.device-grid :deep(.device-card:active),
.donghuan-drawer__grid :deep(.device-card:active) {
  cursor: grabbing;
}

.device-grid :deep(.device-card.dragging),
.donghuan-drawer__grid :deep(.device-card.dragging) {
  opacity: 0.5;
  transform: scale(1.02);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  z-index: 1000;
  border: 2px solid #409eff;
}

.device-grid :deep(.device-card.drag-over),
.donghuan-drawer__grid :deep(.device-card.drag-over) {
  border: 2px dashed #409eff;
  transition: all 0.2s ease;
}

@media (min-width: 1400px) {
  .device-grid {
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  }
}

@media (max-width: 1200px) {
  .device-grid {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}

@media (max-width: 768px) {
  .device-grid {
    grid-template-columns: 1fr;
  }

  .device-panel {
    margin-top: 50px;
  }

  .donghuan-shell {
    top: 72px;
    transform: translateX(calc(100% - 26px));
  }

  .device-grid :deep(.device-card),
  .donghuan-drawer__grid :deep(.device-card) {
    cursor: default;
  }
}
</style>
