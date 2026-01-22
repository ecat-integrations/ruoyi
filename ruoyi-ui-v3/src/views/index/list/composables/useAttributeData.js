/**
 * 属性数据处理组合式函数
 */

import { computed } from 'vue'
import { useDeviceStatus } from './useDeviceStatus'
import { getStatusText } from '../utils/statusMapper'
import { formatTime } from '../utils/timeFormatter'

// RACC2 设备特殊处理
const RACC2_MAPPERS = {
  AC_SET_TEMP: (val) => val !== null ? parseInt(val) + 16 : '无数据',
  AC_MODE: { '0': '自动', '1': '制冷', '2': '除湿', '3': '送风', '4': '制热' },
  AC_SPEED: { '0': '自动风速', '1': '风速一格', '2': '风速二格', '3': '风速三格' },
  AC_DIRECTION: { '0': '自动风向', '1': '风向一', '2': '风向二', '3': '风向三' },
  AC_POWER: (val) => val === '0' ? '开机' : '关机'
}

export function useAttributeData() {
  const { getAttributeStatus } = useDeviceStatus()

  /**
   * 获取格式化的属性值
   * @param {Object} attr - 属性对象
   * @param {Object} device - 设备对象
   * @returns {string} 格式化的值
   */
  const getDisplayValue = (attr, device) => {
    if (device.deviceModel === 'RACC2') {
      const mapper = RACC2_MAPPERS[attr.attributeID]
      if (typeof mapper === 'function') {
        return mapper(attr.displayValue)
      }
      if (typeof mapper === 'object') {
        return mapper[attr.displayValue] || '未知'
      }
    }
    return attr.displayValue ?? '无数据'
  }

  /**
   * 获取属性单位
   * @param {Object} attr - 属性对象
   * @param {Object} device - 设备对象
   * @returns {string} 单位
   */
  const getDisplayUnit = (attr, device) => {
    if (device.deviceModel === 'RACC2' && attr.attributeID === 'AC_SET_TEMP') {
      return '℃'
    }
    return attr.displayUnit || ''
  }

  /**
   * 获取属性状态文本
   * @param {Object} attr - 属性对象
   * @returns {string} 状态文本
   */
  const getAttributeStatusText = (attr) => {
    const status = getAttributeStatus(attr)
    if (status === 'offline') {
      return '离线'
    }
    return getStatusText(attr.status)
  }

  /**
   * 格式化属性更新时间
   * @param {string} timeStr - 时间字符串
   * @param {Object} attr - 属性对象
   * @returns {string} 格式化的时间文本
   */
  const formatAttributeTime = (timeStr, attr) => {
    if (!timeStr) return '离线'

    const updateTime = new Date(timeStr)
    const now = new Date()
    const diffInSeconds = (now - updateTime) / 1000

    if (diffInSeconds <= 60) {
      return getAttributeStatusText(attr)
    }

    return formatTime(timeStr)
  }

  return {
    getDisplayValue,
    getDisplayUnit,
    getAttributeStatus,
    getAttributeStatusText,
    formatAttributeTime
  }
}
