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

  /**
   * 在「可见列表」内重排后，合并回全量列表。
   * 保留未展示设备的槽位，只替换可见设备在这些槽位中的顺序。
   * 解决：按物理/逻辑筛选后，v-for 索引与全量 orderedDevices 索引不一致导致排序无效。
   */
  const mergeFilteredOrder = (allDevices, visibleDevices) => {
    if (!allDevices?.length || !visibleDevices?.length) {
      return allDevices || []
    }
    const visibleIds = new Set(visibleDevices.map(d => d.deviceId))
    let cursor = 0
    return allDevices.map(device => {
      if (visibleIds.has(device.deviceId)) {
        return visibleDevices[cursor++]
      }
      return device
    })
  }

  // 处理拖拽结束（indices 针对当前可见列表）
  const handleDragEnd = (allDevices, visibleDevices, fromIndex, toIndex) => {
    if (!visibleDevices || fromIndex === null || fromIndex === toIndex) {
      return allDevices
    }
    if (
      fromIndex < 0 ||
      toIndex < 0 ||
      fromIndex >= visibleDevices.length ||
      toIndex >= visibleDevices.length
    ) {
      return allDevices
    }

    const nextVisible = [...visibleDevices]
    const [removed] = nextVisible.splice(fromIndex, 1)
    nextVisible.splice(toIndex, 0, removed)

    const newDevices = mergeFilteredOrder(allDevices, nextVisible)
    saveOrderToCache(newDevices)
    return newDevices
  }

  // 将可见列表中的设备置顶到可见列表首位（再合并回全量）
  const moveDeviceToFirst = (allDevices, visibleDevices, visibleIndex) => {
    if (
      !allDevices ||
      !visibleDevices ||
      visibleIndex <= 0 ||
      visibleIndex >= visibleDevices.length
    ) {
      return allDevices
    }

    const nextVisible = [...visibleDevices]
    const [removed] = nextVisible.splice(visibleIndex, 1)
    nextVisible.unshift(removed)

    const newDevices = mergeFilteredOrder(allDevices, nextVisible)
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
    mergeFilteredOrder,
    handleDragEnd,
    moveDeviceToFirst,
    clearAllCache
  }
}
