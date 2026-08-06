/**
 * 统一站房布局（监测 + 质控 / 动环合一）
 * 坐标与 StationRoomScene.vue 背景槽位一一对应（viewBox 1200×720）
 */
export const SCENE_VIEWBOX = { w: 1200, h: 720 }

/** 全局设备 UI 放大系数 */
export const DEVICE_UI_SCALE = 1.32

export function toPercent(x, y) {
  return { x: (x / SCENE_VIEWBOX.w) * 100, y: (y / SCENE_VIEWBOX.h) * 100 }
}

function slot(cx, cy, extra = {}) {
  const { x, y } = toPercent(cx, cy)
  const baseScale = extra.scale ?? 0.9
  const baseIcon = extra.iconSize ?? 48
  const uiScale = extra.uiScale ?? DEVICE_UI_SCALE
  return {
    x,
    y,
    ...extra,
    scale: +(baseScale * uiScale).toFixed(2),
    iconSize: Math.round(baseIcon * uiScale)
  }
}

function flatSlot(cx, cy, extra = {}) {
  return slot(cx, cy, {
    layoutMode: 'flat',
    panelSide: extra.panelSide || 'right',
    uiScale: extra.uiScale ?? 1.1,
    scale: extra.scale ?? 0.8,
    iconSize: extra.iconSize ?? 40,
    ...extra
  })
}

/** 槽位内纵向图标 + 短标签（充盈扁平槽位） */
function tightSlot(cx, cy, extra = {}) {
  return slot(cx, cy, {
    layoutMode: 'stacked',
    uiScale: extra.uiScale ?? 1.12,
    scale: extra.scale ?? 0.84,
    iconSize: extra.iconSize ?? 42,
    ...extra
  })
}

const RACK = { x0: 420, y: 385, w: 70, h: 95, gap: 85 }
const rackCx = i => RACK.x0 + RACK.w / 2 + i * RACK.gap
const rackCy = RACK.y + RACK.h / 2

const FILTER_SLOTS = [
  { x: 85, y: 592.5 },
  { x: 175, y: 592.5 },
  { x: 85, y: 655 },
  { x: 175, y: 657.5 }
]

/** 标气 · 右侧独立区（机柜与右侧墙面之间，避免与滤膜重叠） */
export const MATERIAL_GAS_SLOTS = [
  toPercent(990, 468),
  toPercent(990, 548),
  toPercent(990, 628)
]

/** 滤膜 · 左侧靠近颗粒物监测机柜 */
export const MATERIAL_FILTER_SLOTS = [
  toPercent(290, 518),
  toPercent(290, 608)
]

export const UNIFIED_ROOM_LAYOUT = {
  // 采样平台屋顶
  meteo: slot(900, 50, { scale: 0.85, iconSize: 44, panelSide: 'bottom', zIndex: 5 }),
  camera_1: slot(100, 50, { scale: 0.76, iconSize: 40, panelSide: 'bottom', zIndex: 2 }),
  camera_2: slot(250, 50, { scale: 0.76, iconSize: 40, panelSide: 'bottom', zIndex: 2 }),
  pm25_inlet: slot(420, 50, { scale: 0.82, iconSize: 42, panelSide: 'bottom', zIndex: 3 }),
  pm10_inlet: slot(660, 50, { scale: 0.82, iconSize: 42, panelSide: 'bottom', zIndex: 3 }),
  camera_3: slot(750, 50, { scale: 0.76, iconSize: 40, panelSide: 'bottom', zIndex: 2 }),
  camera_4: slot(1050, 50, { scale: 0.76, iconSize: 40, panelSide: 'bottom', zIndex: 2 }),

  // 左侧贴墙 · 采样总管
  sampling_main_pipe: flatSlot(79, 215, { scale: 0.86, iconSize: 42, panelSide: 'right', zIndex: 4 }),

  // 站房内顶 · 空调
  ac1: tightSlot(360, 148, { scale: 0.86, iconSize: 42, panelSide: 'bottom', zIndex: 4 }),
  ac2: tightSlot(500, 148, { scale: 0.86, iconSize: 42, panelSide: 'bottom', zIndex: 4 }),

  // 质控区
  calibrator: flatSlot(135, 447, { scale: 0.82, iconSize: 40, panelSide: 'right', zIndex: 5 }),
  zero_gas: flatSlot(135, 517, { scale: 0.82, iconSize: 40, panelSide: 'right', zIndex: 5 }),
  filter_so2: tightSlot(FILTER_SLOTS[0].x, FILTER_SLOTS[0].y, { scale: 0.78, iconSize: 38, panelSide: 'right', zIndex: 5 }),
  filter_nox: tightSlot(FILTER_SLOTS[1].x, FILTER_SLOTS[1].y, { scale: 0.78, iconSize: 38, panelSide: 'right', zIndex: 5 }),
  filter_co: tightSlot(FILTER_SLOTS[2].x, FILTER_SLOTS[2].y, { scale: 0.78, iconSize: 38, panelSide: 'right', zIndex: 5 }),
  filter_o3: tightSlot(FILTER_SLOTS[3].x, FILTER_SLOTS[3].y, { scale: 0.78, iconSize: 38, panelSide: 'right', zIndex: 5 }),

  // 监测机柜
  analyzer_pm25: tightSlot(rackCx(0), rackCy, { scale: 0.86, iconSize: 44, panelSide: 'top', zIndex: 6 }),
  analyzer_pm10: tightSlot(rackCx(1), rackCy, { scale: 0.86, iconSize: 44, panelSide: 'top', zIndex: 6 }),
  analyzer_co: tightSlot(rackCx(2), rackCy, { scale: 0.86, iconSize: 44, panelSide: 'top', zIndex: 6 }),
  analyzer_o3: tightSlot(rackCx(3), rackCy, { scale: 0.86, iconSize: 44, panelSide: 'top', zIndex: 6 }),
  analyzer_so2: tightSlot(rackCx(4), rackCy, { scale: 0.86, iconSize: 44, panelSide: 'top', zIndex: 6 }),
  analyzer_no2: tightSlot(rackCx(5), rackCy, { scale: 0.86, iconSize: 44, panelSide: 'top', zIndex: 6 }),

  // 站房环境
  th_sensor: tightSlot(520, 290, { scale: 0.8, iconSize: 38, panelSide: 'bottom', zIndex: 4 }),
  indoor_pollutant: tightSlot(640, 290, { scale: 0.8, iconSize: 38, panelSide: 'bottom', zIndex: 4 }),

  // 右侧墙面 · 照明 / 排风（墙面设备区）
  lighting: tightSlot(1115, 200, { scale: 0.82, iconSize: 40, panelSide: 'left', zIndex: 3 }),
  exhaust_fan: tightSlot(1115, 285, { scale: 0.84, iconSize: 42, panelSide: 'left', zIndex: 4 }),

  // 右侧 · 安防报警（独立块，门禁上方）
  security_alarm: tightSlot(1115, 415, { scale: 0.82, iconSize: 40, panelSide: 'left', zIndex: 5 }),

  // 右侧 · 智能门禁（独立块，略下移）
  access_control: tightSlot(1115, 530, { scale: 0.82, iconSize: 40, panelSide: 'left', zIndex: 5 }),

  // 供电 · 监测机柜下方（略下移，与机柜留间距）
  ups: tightSlot(470, 582, { scale: 0.82, iconSize: 40, panelSide: 'top', zIndex: 5 }),
  power_meter: tightSlot(580, 582, { scale: 0.82, iconSize: 40, panelSide: 'top', zIndex: 5 }),
  relay_panel: tightSlot(690, 582, { scale: 0.82, iconSize: 40, panelSide: 'top', zIndex: 5 }),
  voltage_regulator: tightSlot(800, 582, { scale: 0.82, iconSize: 40, panelSide: 'top', zIndex: 5 })
}

export function getUnifiedLayout() {
  return UNIFIED_ROOM_LAYOUT
}

export function getDeviceLayout(deviceId) {
  return UNIFIED_ROOM_LAYOUT[deviceId] || null
}

export function classifyMaterial(name = '') {
  const text = String(name).toUpperCase()
  if (text.includes('滤膜') || text.includes('滤带') || text.includes('PM')) return 'filter'
  return 'gas'
}

export function sortGasMaterials(cards) {
  const order = ['SO2', 'NOX', 'NO₂', 'NO2', 'CO']
  return [...cards].sort((a, b) => {
    const ai = order.findIndex(k => String(a.label).toUpperCase().includes(k))
    const bi = order.findIndex(k => String(b.label).toUpperCase().includes(k))
    return (ai < 0 ? 99 : ai) - (bi < 0 ? 99 : bi)
  })
}

export function buildMaterialPlacements(materialCards) {
  const gasCards = sortGasMaterials(materialCards.filter(c => classifyMaterial(c.label) === 'gas'))
  const filterCards = materialCards.filter(c => classifyMaterial(c.label) === 'filter')

  const placements = []
  gasCards.slice(0, 3).forEach((card, i) => {
    placements.push({ card, layout: MATERIAL_GAS_SLOTS[i] || MATERIAL_GAS_SLOTS[0] })
  })
  filterCards.slice(0, 2).forEach((card, i) => {
    placements.push({ card, layout: MATERIAL_FILTER_SLOTS[i] || MATERIAL_FILTER_SLOTS[0] })
  })
  return placements
}
