/**
 * 设备状态管理组合式函数
 */

import { computed } from 'vue'

export function useDeviceStatus() {
  /**
   * 检查设备是否有参数异常
   * @param {Object} device - 设备对象
   * @returns {boolean} 是否有异常
   */
  const hasAbnormalAttribute = (device) => {
    if (!device.deviceAttrs || device.deviceAttrs.length === 0) return false
    return device.deviceAttrs.some(attr => {
      return attr.status && attr.status !== 'Normal' && attr.status !== 'Empty'
    })
  }

  /**
   * 判断属性是否在线（60秒内有更新）
   * @param {Object} attr - 属性对象
   * @returns {boolean} 是否在线
   */
  const isAttributeOnline = (attr) => {
    if (!attr.updateTime) return false
    const updateTime = new Date(attr.updateTime)
    const now = new Date()
    return (now - updateTime) / 1000 <= 60
  }

  /**
   * 获取设备状态
   * @param {Object} device - 设备对象
   * @returns {string} 状态：online、offline、warning
   */
  const getDeviceStatus = (device) => {
    if (!device.deviceAttrs || device.deviceAttrs.length === 0) {
      return 'offline'
    }

    const hasOnlineAttr = device.deviceAttrs.some(attr => isAttributeOnline(attr))
    if (!hasOnlineAttr) {
      return 'offline'
    }

    if (hasAbnormalAttribute(device)) {
      return 'warning'
    }

    return 'online'
  }

  /**
   * 获取属性状态
   * @param {Object} attr - 属性对象
   * @returns {string} 状态：online、offline、warning
   */
  const getAttributeStatus = (attr) => {
    if (!isAttributeOnline(attr)) {
      return 'offline'
    }

    if (attr.status && attr.status !== 'Normal') {
      return 'warning'
    }

    return 'online'
  }

  /**
   * 获取设备状态样式类名
   * @param {Object} device - 设备对象
   * @returns {string} CSS类名
   */
  const getDeviceStatusClass = (device) => {
    const status = getDeviceStatus(device)
    return `device-${status}`
  }

  /**
   * 获取设备状态文本
   * @param {Object} device - 设备对象
   * @returns {string} 状态文本
   */
  const getDeviceStatusText = (device) => {
    const status = getDeviceStatus(device)
    const textMap = {
      online: '在线',
      offline: '离线',
      warning: '注意'
    }
    return textMap[status] || '离线'
  }

  /**
   * 获取设备状态样式类名（用于文本）
   * @param {Object} device - 设备对象
   * @returns {string} CSS类名
   */
  const getDeviceStatusTextClass = (device) => {
    const status = getDeviceStatus(device)
    return `status-${status}`
  }

  return {
    hasAbnormalAttribute,
    isAttributeOnline,
    getDeviceStatus,
    getAttributeStatus,
    getDeviceStatusClass,
    getDeviceStatusText,
    getDeviceStatusTextClass
  }
}
