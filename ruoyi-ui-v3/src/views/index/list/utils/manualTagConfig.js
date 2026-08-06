/**
 * 设备手动标识配置
 *
 * 解析策略：
 * 1. 物理设备：按型号白名单映射到各自的 manual 属性 ID（attrId 不统一）
 * 2. logicdevice-airdevice 逻辑设备：coordinate 门禁 + 具备 manual_status 能力即支持
 *    （统一 attrId = manual_status，无需按厂家/参数类型配置）
 */

import { getAttributeScheme } from '@/api/deviceAttribute.js'
import { deviceDebug } from '@/api/login.js'

/** logicdevice-airdevice 集成坐标（排除 airstation） */
export const AIRDEVICE_COORDINATE = 'com.ecat:integration-logicdevice-airdevice'

/** 逻辑空气设备统一的人工状态属性 ID */
export const LOGICAL_MANUAL_STATUS_ATTR = 'manual_status'

/**
 * 可人工设置的手动标识选项及统一展示文案（按 AttributeStatus.name）
 * 物理/逻辑共用；统计类/系统态（Insufficient、Offline 等）不在此列，下拉中过滤掉
 */
const MANUAL_STATUS_LABELS = {
  Normal: '正常状态',
  Alarm: '报警',
  Maintenance: '维护',
  Malfunction: '故障',
  Calibration: '校准',
  ZeroCheck: '零点检查',
  SpanCheck: '跨度检查',
  AccuracyCheck: '准确度检查',
  ZeroCalibration: '零点校准',
  SpanCalibration: '跨度校准',
  FlowCheck: '流量检查',
  QualityCheck: '质量检查',
  ZeroDrift: '检定零点漂移',
  SpanDrift: '检定跨度漂移',
  SpanReproducibility: '检定跨度重现性',
  MultiPointSpan: '检定多点跨度(线性)',
  PrecisionCheck: '精密度检查',
  TempPressureCalibration: '温度压力校准',
  DeviceReplacement: '维修更换设备',
  ConversionCheck: '转换效率检查'
}

/** value 别名 → 标准 AttributeStatus.name */
const MANUAL_STATUS_VALUE_ALIASES = {
  auto: 'Normal',
  normal: 'Normal'
}

/**
 * 解析选项 value 为标准 AttributeStatus.name（无法识别则返回 null）
 * @param {string} rawValue
 * @returns {string|null}
 */
function resolveCanonicalStatus(rawValue) {
  if (!rawValue) return null
  const aliased =
    MANUAL_STATUS_VALUE_ALIASES[rawValue]
    || MANUAL_STATUS_VALUE_ALIASES[rawValue.toLowerCase()]
  if (aliased) return aliased
  return Object.keys(MANUAL_STATUS_LABELS).find(
    key => key.toLowerCase() === rawValue.toLowerCase()
  ) || null
}

/**
 * 规范化手动状态选项：仅保留可人工设置项，统一中文 label，并将「正常状态」置顶
 * @param {Array<{label: string, value: string}>} options
 * @returns {Array<{label: string, value: string}>}
 */
function normalizeManualStatusOptions(options) {
  const result = (options || [])
    .map(opt => {
      const rawValue = opt?.value != null ? String(opt.value) : ''
      const canonical = resolveCanonicalStatus(rawValue)
      if (!canonical || !MANUAL_STATUS_LABELS[canonical]) return null
      return {
        ...opt,
        value: opt.value,
        label: MANUAL_STATUS_LABELS[canonical]
      }
    })
    .filter(Boolean)

  const normalIndex = result.findIndex(opt => {
    const v = opt?.value != null ? String(opt.value) : ''
    return (
      v === 'Normal'
      || v.toLowerCase() === 'normal'
      || v.toLowerCase() === 'auto'
      || opt.label === '正常状态'
    )
  })

  if (normalIndex > 0) {
    const [normalOption] = result.splice(normalIndex, 1)
    result.unshift(normalOption)
  }

  return result
}

/**
 * 创建设备手动标识配置
 * @param {string} label - 日志标识（型号或 logical）
 * @param {string} attrId - 手动状态属性 ID
 */
function createManualTagConfig(label, attrId) {
  return {
    attrId,
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, attrId)
        return normalizeManualStatusOptions(res.data?.scheme?.options)
      } catch (error) {
        console.error(`获取 ${label} 选项失败:`, error)
        return []
      }
    },
    onConfirm: async (device, selectedValue) => {
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId,
        value: selectedValue
      })
      if (result.code === 200 && result.msg === '设备控制成功') {
        return
      }
      throw new Error(result.msg || '设备控制失败')
    }
  }
}

/**
 * 设备是否具备指定属性
 * @param {object} device
 * @param {string} attrId
 */
function hasAttribute(device, attrId) {
  return Array.isArray(device?.deviceAttrs)
    && device.deviceAttrs.some(attr => attr?.attributeID === attrId)
}

/**
 * 解析设备的手动标识配置
 * @param {object} device
 * @returns {{ attrId: string, getOptions: Function, onConfirm: Function } | null}
 */
export function resolveManualTag(device) {
  if (!device) return null

  // 逻辑空气设备：coordinate 门禁 + manual_status 能力
  if (
    device.deviceType === 'logical'
    && device.coordinate === AIRDEVICE_COORDINATE
    && hasAttribute(device, LOGICAL_MANUAL_STATUS_ATTR)
  ) {
    return createManualTagConfig(
      device.deviceModel || 'airdevice-logical',
      LOGICAL_MANUAL_STATUS_ATTR
    )
  }

  // 物理设备：型号白名单
  const model = device.deviceModel
  if (model && MANUAL_TAG_CONFIG[model]) {
    return MANUAL_TAG_CONFIG[model]
  }

  return null
}

/**
 * 检查设备是否支持手动标识（设备级）
 * @param {object} device
 * @returns {boolean}
 */
export function isDeviceSupported(device) {
  return resolveManualTag(device) != null
}

/**
 * 获取设备的标识选项
 * @param {object} device
 * @returns {Promise<Array<{label: string, value: string}>>}
 */
export async function getDeviceTagOptions(device) {
  const config = resolveManualTag(device)
  if (!config?.getOptions) {
    console.warn('设备未支持手动标识或不存在 getOptions', device?.deviceId)
    return []
  }

  try {
    return (await config.getOptions(device)) || []
  } catch (error) {
    console.error(`获取设备 ${device?.deviceId} 的选项失败:`, error)
    return []
  }
}

/**
 * 执行设备的手动标识确认操作
 * @param {object} device
 * @param {string} selectedValue
 * @returns {Promise<void>}
 */
export async function executeDeviceTagAction(device, selectedValue) {
  const config = resolveManualTag(device)
  if (!config?.onConfirm) {
    console.warn('设备未支持手动标识或不存在 onConfirm', device?.deviceId)
    return
  }

  await config.onConfirm(device, selectedValue)
}

/**
 * 获取支持手动标识的物理设备型号列表
 * @returns {string[]}
 */
export function getSupportedModels() {
  return Object.keys(MANUAL_TAG_CONFIG)
}

/**
 * 检查物理设备型号是否支持手动标识（兼容旧调用）
 * @param {string} model
 * @returns {boolean}
 */
export function isModelSupported(model) {
  if (!model) return false
  return Object.prototype.hasOwnProperty.call(MANUAL_TAG_CONFIG, model)
}

/**
 * 手动标识配置映射（仅物理设备）
 * key: 设备型号
 */
const MANUAL_TAG_CONFIG = {
  // sailhero 先河黑壳 V3
  XHN2000BV3: createManualTagConfig('XHN2000BV3', 'nox_manual_status'),
  XHS2000BV3: createManualTagConfig('XHS2000BV3', 'so2_manual_status'),
  XHOZ2000BV3: createManualTagConfig('XHOZ2000BV3', 'o3_manual_status'),
  XHCO2000BV3: createManualTagConfig('XHCO2000BV3', 'co_manual_status'),
  XHPM3000EV3: createManualTagConfig('XHPM3000EV3', 'manual_status'),

  // sailhero 先河 V2
  XHN2000BV2: createManualTagConfig('XHN2000BV2', 'nox_manual_status'),
  XHS2000BV2: createManualTagConfig('XHS2000BV2', 'so2_manual_status'),
  XHOZ2000BV2: createManualTagConfig('XHOZ2000BV2', 'o3_manual_status'),
  XHCO2000BV2: createManualTagConfig('XHCO2000BV2', 'co_manual_status'),
  XHPM2000EV2: createManualTagConfig('XHPM2000EV2', 'manual_status'),

  // saimosen 赛默森 气态分析仪
  SMS8200: createManualTagConfig('SMS8200', 'so2_manual_status'),
  SMS8500: createManualTagConfig('SMS8500', 'co_manual_status'),
  SMS8300: createManualTagConfig('SMS8300', 'nox_manual_status'),
  SMS8400: createManualTagConfig('SMS8400', 'o3_manual_status')
}
