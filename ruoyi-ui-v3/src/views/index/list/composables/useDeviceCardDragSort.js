import { ref } from 'vue'

const STORAGE_KEY = 'device-card-order'

/**
 * 设备卡片拖拽排序
 * @returns {Object} 排序相关的方法和状态
 */
export function useDeviceCardDragSort() {
  // 从缓存加载排序顺序
  const loadOrderFromCache = () => {
    try {
      const cached = localStorage.getItem(STORAGE_KEY)
      if (cached) {
        return JSON.parse(cached)
      }
    } catch (error) {
      console.error('读取设备卡片缓存失败:', error)
    }
    return []
  }

  // 保存排序顺序到缓存
  const saveOrderToCache = (orderedDevices) => {
    try {
      if (orderedDevices && orderedDevices.length > 0) {
        const deviceIds = orderedDevices.map(device => device.deviceId)
        localStorage.setItem(STORAGE_KEY, JSON.stringify(deviceIds))
      } else {
        localStorage.removeItem(STORAGE_KEY)
      }
    } catch (error) {
      console.error('保存设备卡片缓存失败:', error)
    }
  }

  // 应用缓存的排序顺序
  const applyCachedOrder = (devices) => {
    if (!devices || devices.length === 0) {
      return devices
    }

    const cachedOrder = loadOrderFromCache()
    
    // 如果缓存为空，返回原数组
    if (!cachedOrder || cachedOrder.length === 0) {
      return devices
    }

    // 创建映射以便快速查找
    const deviceMap = new Map()
    devices.forEach(device => {
      deviceMap.set(device.deviceId, device)
    })

    // 按照缓存顺序重新排列
    const orderedDevices = []
    cachedOrder.forEach(deviceId => {
      const device = deviceMap.get(deviceId)
      if (device) {
        orderedDevices.push(device)
        deviceMap.delete(deviceId) // 避免重复
      }
    })

    // 添加缓存中没有的新设备
    deviceMap.forEach(device => {
      orderedDevices.push(device)
    })

    return orderedDevices
  }

  // 处理拖拽结束
  const handleDragEnd = (devices, fromIndex, toIndex) => {
    if (fromIndex === null || fromIndex === toIndex) {
      return devices
    }

    // 创建新的排序数组
    const newDevices = [...devices]
    const [removed] = newDevices.splice(fromIndex, 1)
    newDevices.splice(toIndex, 0, removed)

    // 保存到缓存
    saveOrderToCache(newDevices)

    return newDevices
  }

  // 将设备移动到第一位（置顶）
  const moveDeviceToFirst = (devices, deviceIndex) => {
    if (!devices || deviceIndex <= 0 || deviceIndex >= devices.length) {
      return devices
    }

    // 创建新的排序数组，将指定设备移到第一位
    const newDevices = [...devices]
    const [removed] = newDevices.splice(deviceIndex, 1)
    newDevices.unshift(removed)

    // 保存到缓存
    saveOrderToCache(newDevices)

    return newDevices
  }

  // 清除缓存
  const clearAllCache = () => {
    try {
      localStorage.removeItem(STORAGE_KEY)
    } catch (error) {
      console.error('清除设备卡片缓存失败:', error)
    }
  }

  return {
    loadOrderFromCache,
    saveOrderToCache,
    applyCachedOrder,
    handleDragEnd,
    moveDeviceToFirst,
    clearAllCache
  }
}
