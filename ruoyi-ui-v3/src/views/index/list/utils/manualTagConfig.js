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
  // XHN2000BV3 型号配置示例
  'XHN2000BV3': {
    /**
     * 返回下拉选项(支持异步)
     * @param {object} device - 设备对象
     * @returns {Promise<Array<{label: string, value: string}>>}
     */
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, "nox_manual_status")
        console.log('XHN2000BV3 选项数据:', res.data.scheme.options)
        
        let options = res.data.scheme.options || []
        
        // 查找并修改"自动"选项为"正常状态"
        const autoIndex = options.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
        if (autoIndex !== -1) {
          // 修改名称
          options[autoIndex].label = '正常状态'
          
          // 如果不在第一个位置,移到第一个
          if (autoIndex !== 0) {
            const autoOption = options.splice(autoIndex, 1)[0]
            options.unshift(autoOption)
          }
        }
        
        return options
      } catch (error) {
        console.error('获取 XHN2000BV3 选项失败:', error)
        return []
      }
    },
    
    /**
     * 确认后的处理逻辑
     * @param {object} device - 设备对象
     * @param {string} selectedValue - 选中的值
     * @returns {Promise<void>}
     */
    onConfirm: async (device, selectedValue) => {
      console.log('XHN2000BV3 设备手动标识:', {
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        selectedValue
      })
      
      // 调用 deviceDebug API 设置属性值
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId: "nox_manual_status",
        value: selectedValue
      })
      
      // 检查返回结果
      if (result.code === 200 && result.msg === '设备控制成功') {
        console.log('XHN2000BV3 标识设置成功')
      } else {
        // 抛出错误,让对话框显示失败原因
        throw new Error(result.msg || '设备控制失败')
      }
    }
  },
  
  // XHS2000BV3 型号配置示例
  'XHS2000BV3': {
    /**
     * 返回下拉选项
     * @param {object} device - 设备对象
     * @returns {Array<{label: string, value: string}>}
     */
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, "so2_manual_status")
        console.log('XHS2000BV3 选项数据:', res.data.scheme.options)

        let options = res.data.scheme.options || []

        // 查找并修改"自动"选项为"正常状态"
        const autoIndex = options.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
        if (autoIndex !== -1) {
          // 修改名称
          options[autoIndex].label = '正常状态'

          // 如果不在第一个位置,移到第一个
          if (autoIndex !== 0) {
            const autoOption = options.splice(autoIndex, 1)[0]
            options.unshift(autoOption)
          }
        }

        return options
      } catch (error) {
        console.error('获取 XHS2000BV3 选项失败:', error)
        return []
      }
    },
    
    /**
     * 确认后的处理逻辑
     * @param {object} device - 设备对象
     * @param {string} selectedValue - 选中的值
     * @returns {Promise<void>}
     */
    onConfirm: async (device, selectedValue) => {
      console.log('XHS2000BV3 设备手动标识:', {
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        selectedValue
      })

      // 调用 deviceDebug API 设置属性值
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId: "so2_manual_status",
        value: selectedValue
      })

      // 检查返回结果
      if (result.code === 200 && result.msg === '设备控制成功') {
        console.log('XHS2000BV3 标识设置成功')
      } else {
        // 抛出错误,让对话框显示失败原因
        throw new Error(result.msg || '设备控制失败')
      }
    }
  },
  'XHOZ2000BV3': {
    /**
     * 返回下拉选项
     * @param {object} device - 设备对象
     * @returns {Array<{label: string, value: string}>}
     */
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, "o3_manual_status")
        console.log('XHOZ2000BV3 选项数据:', res.data.scheme.options)

        let options = res.data.scheme.options || []

        // 查找并修改"自动"选项为"正常状态"
        const autoIndex = options.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
        if (autoIndex !== -1) {
          // 修改名称
          options[autoIndex].label = '正常状态'

          // 如果不在第一个位置,移到第一个
          if (autoIndex !== 0) {
            const autoOption = options.splice(autoIndex, 1)[0]
            options.unshift(autoOption)
          }
        }

        return options
      } catch (error) {
        console.error('获取 XHOZ2000BV3 选项失败:', error)
        return []
      }
    },

    /**
     * 确认后的处理逻辑
     * @param {object} device - 设备对象
     * @param {string} selectedValue - 选中的值
     * @returns {Promise<void>}
     */
    onConfirm: async (device, selectedValue) => {
      console.log('XHOZ2000BV3 设备手动标识:', {
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        selectedValue
      })

      // 调用 deviceDebug API 设置属性值
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId: "o3_manual_status",
        value: selectedValue
      })

      // 检查返回结果
      if (result.code === 200 && result.msg === '设备控制成功') {
        console.log('XHOZ2000BV3 标识设置成功')
      } else {
        // 抛出错误,让对话框显示失败原因
        throw new Error(result.msg || '设备控制失败')
      }
    }
  },
  'XHCO2000BV3': {
    /**
     * 返回下拉选项
     * @param {object} device - 设备对象
     * @returns {Array<{label: string, value: string}>}
     */
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, "co_manual_status")
        console.log('XHCO2000BV3 选项数据:', res.data.scheme.options)

        let options = res.data.scheme.options || []

        // 查找并修改"自动"选项为"正常状态"
        const autoIndex = options.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
        if (autoIndex !== -1) {
          // 修改名称
          options[autoIndex].label = '正常状态'

          // 如果不在第一个位置,移到第一个
          if (autoIndex !== 0) {
            const autoOption = options.splice(autoIndex, 1)[0]
            options.unshift(autoOption)
          }
        }

        return options
      } catch (error) {
        console.error('获取 XHOZ2000BV3 选项失败:', error)
        return []
      }
    },

    /**
     * 确认后的处理逻辑
     * @param {object} device - 设备对象
     * @param {string} selectedValue - 选中的值
     * @returns {Promise<void>}
     */
    onConfirm: async (device, selectedValue) => {
      console.log('XHCO2000BV3 设备手动标识:', {
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        selectedValue
      })

      // 调用 deviceDebug API 设置属性值
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId: "co_manual_status",
        value: selectedValue
      })

      // 检查返回结果
      if (result.code === 200 && result.msg === '设备控制成功') {
        console.log('XHCO2000BV3 标识设置成功')
      } else {
        // 抛出错误,让对话框显示失败原因
        throw new Error(result.msg || '设备控制失败')
      }
    }
  },
  'XHPM3000EV3': {
    /**
     * 返回下拉选项
     * @param {object} device - 设备对象
     * @returns {Array<{label: string, value: string}>}
     */
    getOptions: async (device) => {
      try {
        const res = await getAttributeScheme(device.deviceId, "manual_status")
        console.log('XHPM3000EV3 选项数据:', res.data.scheme.options)

        let options = res.data.scheme.options || []

        // 查找并修改"自动"选项为"正常状态"
        const autoIndex = options.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
        if (autoIndex !== -1) {
          // 修改名称
          options[autoIndex].label = '正常状态'

          // 如果不在第一个位置,移到第一个
          if (autoIndex !== 0) {
            const autoOption = options.splice(autoIndex, 1)[0]
            options.unshift(autoOption)
          }
        }

        return options
      } catch (error) {
        console.error('获取 XHPM3000EV3 选项失败:', error)
        return []
      }
    },

    /**
     * 确认后的处理逻辑
     * @param {object} device - 设备对象
     * @param {string} selectedValue - 选中的值
     * @returns {Promise<void>}
     */
    onConfirm: async (device, selectedValue) => {
      console.log('XHPM3000EV3 设备手动标识:', {
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        selectedValue
      })

      // 调用 deviceDebug API 设置属性值
      const result = await deviceDebug({
        deviceId: device.deviceId,
        attrId: "manual_status",
        value: selectedValue
      })

      // 检查返回结果
      if (result.code === 200 && result.msg === '设备控制成功') {
        console.log('XHPM3000EV3 标识设置成功')
      } else {
        // 抛出错误,让对话框显示失败原因
        throw new Error(result.msg || '设备控制失败')
      }
    }
  },
  // 可以继续添加其他型号的配置...
}
