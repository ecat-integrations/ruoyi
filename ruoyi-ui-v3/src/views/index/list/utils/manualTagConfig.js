/**
 * 设备手动标识配置
 *
 * 用于配置哪些设备型号支持手动标识功能
 * 每个型号需要配置:
 * - getOptions: 返回下拉选项的函数
 * - onConfirm: 确认后的处理函数
 */

import {getAttributeScheme} from "@/api/deviceAttribute.js";
import {deviceDebug} from "@/api/login.js";

/**
 * 规范化手动状态选项：将"自动"改为"正常状态"并置顶
 * @param {Array<{label: string, value: string}>} options
 * @returns {Array<{label: string, value: string}>}
 */
function normalizeManualStatusOptions(options) {
  const result = options || []
  const autoIndex = result.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
  if (autoIndex !== -1) {
    result[autoIndex].label = '正常状态'
    if (autoIndex !== 0) {
      const autoOption = result.splice(autoIndex, 1)[0]
      result.unshift(autoOption)
    }
  }
  return result
}

/**
 * 创建型号手动标识配置
 * @param {string} model - 设备型号
 * @param {string} attrId - 手动状态属性 ID
 */
function createManualTagConfig(model, attrId) {
  return {
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, attrId)
        console.log(`${model} 选项数据:`, res.data.scheme.options)
        return normalizeManualStatusOptions(res.data.scheme.options)
      } catch (error) {
        console.error(`获取 ${model} 选项失败:`, error)
        return []
      }
    },
    onConfirm: async (device, selectedValue) => {
      console.log(`${model} 设备手动标识:`, {
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        selectedValue
      })
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId,
        value: selectedValue
      })
      if (result.code === 200 && result.msg === '设备控制成功') {
        console.log(`${model} 标识设置成功`)
      } else {
        throw new Error(result.msg || '设备控制失败')
      }
    }
  }
}

/**
 * 获取支持手动标识的设备型号列表
 * @returns {string[]} 设备型号数组
 */
export function getSupportedModels() {
  return Object.keys(MANUAL_TAG_CONFIG)
}

/**
 * 检查设备型号是否支持手动标识
 * @param {string} model - 设备型号
 * @returns {boolean} 是否支持
 */
export function isModelSupported(model) {
  if (!model) return false
  return MANUAL_TAG_CONFIG.hasOwnProperty(model)
}

/**
 * 获取指定型号的标识选项(支持异步)
 * @param {string} model - 设备型号
 * @param {object} device - 设备对象(可选,用于动态生成选项)
 * @returns {Promise<Array<{label: string, value: string}>>} 选项数组的 Promise
 */
export async function getModelTagOptions(model, device = null) {
  const config = MANUAL_TAG_CONFIG[model]
  if (!config || !config.getOptions) {
    console.warn(`型号 ${model} 未配置 getOptions 函数`)
    return []
  }

  try {
    const options = await config.getOptions(device)
    return options || []
  } catch (error) {
    console.error(`获取型号 ${model} 的选项失败:`, error)
    return []
  }
}

/**
 * 执行指定型号的确认操作
 * @param {string} model - 设备型号
 * @param {object} device - 设备对象
 * @param {string} selectedValue - 选中的标识值
 * @returns {Promise<void>}
 */
export async function executeModelTagAction(model, device, selectedValue) {
  const config = MANUAL_TAG_CONFIG[model]
  if (!config || !config.onConfirm) {
    console.warn(`型号 ${model} 未配置 onConfirm 函数`)
    return
  }

  try {
    await config.onConfirm(device, selectedValue)
  } catch (error) {
    console.error(`型号 ${model} 的手动标识操作失败:`, error)
    throw error
  }
}

/**
 * 手动标识配置映射
 * key: 设备型号
 * value: {
 *   getOptions: (device) => Array<{label, value}>,
 *   onConfirm: (device, selectedValue) => Promise<void>
 * }
 */
const MANUAL_TAG_CONFIG = {
  // sailhero 先河黑壳 V3
  'XHN2000BV3': createManualTagConfig('XHN2000BV3', 'nox_manual_status'),
  'XHS2000BV3': createManualTagConfig('XHS2000BV3', 'so2_manual_status'),
  'XHOZ2000BV3': createManualTagConfig('XHOZ2000BV3', 'o3_manual_status'),
  'XHCO2000BV3': createManualTagConfig('XHCO2000BV3', 'co_manual_status'),
  'XHPM3000EV3': createManualTagConfig('XHPM3000EV3', 'manual_status'),

  // sailhero 先河 V2
  'XHN2000BV2': createManualTagConfig('XHN2000BV2', 'nox_manual_status'),
  'XHS2000BV2': createManualTagConfig('XHS2000BV2', 'so2_manual_status'),
  'XHOZ2000BV2': createManualTagConfig('XHOZ2000BV2', 'o3_manual_status'),
  'XHCO2000BV2': createManualTagConfig('XHCO2000BV2', 'co_manual_status'),
  'XHPM2000EV2': createManualTagConfig('XHPM2000EV2', 'manual_status'),

  // saimosen 赛默森 气态分析仪
  'SMS8200': createManualTagConfig('SMS8200', 'so2_manual_status'),
  'SMS8500': createManualTagConfig('SMS8500', 'co_manual_status'),
  'SMS8300': createManualTagConfig('SMS8300', 'nox_manual_status'),
  'SMS8400': createManualTagConfig('SMS8400', 'o3_manual_status'),
}
