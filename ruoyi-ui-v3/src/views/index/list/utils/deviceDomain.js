/**
 * 设备列表视图：物理 / 逻辑空气设备；动环承载站房逻辑设备。
 */

export const AIRSTATION_COORDINATE = 'com.ecat:integration-logicdevice-airstation'
export const AIRDEVICE_COORDINATE = 'com.ecat:integration-logicdevice-airdevice'

export const DEVICE_VIEW_STORAGE_KEY = 'device_list_view_v3'
export const LEGACY_VIEW_STORAGE_KEY = 'device_list_view_v2'
export const LEGACY_TYPE_FILTER_KEY = 'device_type_filter'

/** @typedef {'physical' | 'logical'} DeviceKind */

/**
 * @returns {{ kind: DeviceKind, donghuanOpen: boolean }}
 */
export function loadDeviceListView() {
  try {
    const raw = localStorage.getItem(DEVICE_VIEW_STORAGE_KEY)
    if (raw) {
      const parsed = JSON.parse(raw)
      if (parsed && (parsed.kind === 'physical' || parsed.kind === 'logical')) {
        return {
          kind: parsed.kind,
          donghuanOpen: parsed.kind === 'logical' && !!parsed.donghuanOpen
        }
      }
    }
  } catch (e) {
    console.warn('加载设备列表视图配置失败:', e)
  }

  // 兼容 v2
  try {
    const raw = localStorage.getItem(LEGACY_VIEW_STORAGE_KEY)
    if (raw) {
      const parsed = JSON.parse(raw)
      if (parsed && (parsed.kind === 'physical' || parsed.kind === 'logical')) {
        return { kind: parsed.kind, donghuanOpen: false }
      }
    }
  } catch (e) {
    /* ignore */
  }

  // 兼容旧 chip
  try {
    const legacy = localStorage.getItem(LEGACY_TYPE_FILTER_KEY)
    if (legacy) {
      const types = JSON.parse(legacy)
      if (Array.isArray(types) && types.length === 1 && types[0] === 'logical') {
        return { kind: 'logical', donghuanOpen: false }
      }
      if (Array.isArray(types) && types.length === 1 && types[0] === 'physical') {
        return { kind: 'physical', donghuanOpen: false }
      }
    }
  } catch (e) {
    /* ignore */
  }

  return { kind: 'physical', donghuanOpen: false }
}

/**
 * @param {{ kind: DeviceKind, donghuanOpen: boolean }} view
 */
export function saveDeviceListView(view) {
  try {
    localStorage.setItem(
      DEVICE_VIEW_STORAGE_KEY,
      JSON.stringify({
        kind: view.kind === 'logical' ? 'logical' : 'physical',
        donghuanOpen: view.kind === 'logical' && !!view.donghuanOpen
      })
    )
  } catch (e) {
    console.warn('保存设备列表视图配置失败:', e)
  }
}

/**
 * @param {object} device
 * @returns {'airstation'|'airdevice'|null}
 */
export function resolveLogicalDomain(device) {
  if (!device || device.deviceType !== 'logical') {
    return null
  }
  if (device.coordinate === AIRSTATION_COORDINATE) {
    return 'airstation'
  }
  if (device.coordinate === AIRDEVICE_COORDINATE) {
    return 'airdevice'
  }
  return null
}

/**
 * 主列表：物理全部，或逻辑模式下仅空气设备。
 * @param {object[]} devices
 * @param {DeviceKind} kind
 */
export function filterMainDevices(devices, kind) {
  if (!devices?.length) {
    return []
  }
  if (kind === 'logical') {
    return devices.filter(
      d => (d.deviceType || 'physical') === 'logical' && resolveLogicalDomain(d) === 'airdevice'
    )
  }
  return devices.filter(d => (d.deviceType || 'physical') === 'physical')
}

/**
 * 动环抽屉：站房逻辑设备。
 * @param {object[]} devices
 */
export function filterStationDevices(devices) {
  if (!devices?.length) {
    return []
  }
  return devices.filter(
    d => (d.deviceType || 'physical') === 'logical' && resolveLogicalDomain(d) === 'airstation'
  )
}
