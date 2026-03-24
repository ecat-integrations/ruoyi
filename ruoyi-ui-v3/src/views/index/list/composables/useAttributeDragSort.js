import { ref, watch } from 'vue'

const STORAGE_KEY = 'device-attribute-order'

/**
 * 设备属性拖拽排序
 * @param {Object} device - 设备对象
 * @returns {Object} 排序相关的方法和状态
 */
export function useAttributeDragSort(device) {
  // 从缓存加载排序顺序
  const loadOrderFromCache = () => {
    try {
      const cached = localStorage.getItem(STORAGE_KEY)
      if (cached) {
        const allOrders = JSON.parse(cached)
        // 返回当前设备的属性排序
        return allOrders[device.value?.deviceId] || []
      }
    } catch (error) {
      console.error('读取缓存失败:', error)
    }
    return []
  }

  // 保存排序顺序到缓存
  const saveOrderToCache = (orderedAttrs) => {
    try {
      const cached = localStorage.getItem(STORAGE_KEY)
      let allOrders = {}
      
      if (cached) {
        allOrders = JSON.parse(cached)
      }
      
      // 更新当前设备的排序
      if (orderedAttrs && orderedAttrs.length > 0) {
        allOrders[device.value?.deviceId] = orderedAttrs.map(attr => attr.attributeID)
      } else {
        // 如果为空数组，删除该设备的缓存
        delete allOrders[device.value?.deviceId]
      }
      
      localStorage.setItem(STORAGE_KEY, JSON.stringify(allOrders))
    } catch (error) {
      console.error('保存缓存失败:', error)
    }
  }

  // 应用缓存的排序顺序
  const applyCachedOrder = (originalAttrs) => {
    if (!originalAttrs || originalAttrs.length === 0) {
      return originalAttrs
    }

    const cachedOrder = loadOrderFromCache()
    
    // 如果没有缓存顺序，返回原始顺序（首次加载）
    if (!cachedOrder || cachedOrder.length === 0) {
      // 首次加载时，保存默认顺序
      saveOrderToCache(originalAttrs)
      return originalAttrs
    }

    // 创建属性 ID 到属性对象的映射
    const attrMap = new Map()
    originalAttrs.forEach(attr => {
      attrMap.set(attr.attributeID, attr)
    })

    // 按照缓存的顺序重新排列属性
    const orderedAttrs = []
    cachedOrder.forEach(attrId => {
      if (attrMap.has(attrId)) {
        orderedAttrs.push(attrMap.get(attrId))
        attrMap.delete(attrId)
      }
    })

    // 添加可能在原始数据中存在但不在缓存中的新属性
    attrMap.forEach(attr => {
      orderedAttrs.push(attr)
    })

    return orderedAttrs
  }

  // 处理拖拽结束，更新顺序
  const handleDragEnd = (attrs, fromIndex, toIndex) => {
    if (!attrs || fromIndex === toIndex) {
      return attrs
    }

    // 创建新的排序数组
    const newAttrs = [...attrs]
    const [removed] = newAttrs.splice(fromIndex, 1)
    newAttrs.splice(toIndex, 0, removed)

    // 保存到缓存
    saveOrderToCache(newAttrs)

    return newAttrs
  }

  // 清除特定设备的缓存
  const clearDeviceCache = (deviceId) => {
    try {
      const cached = localStorage.getItem(STORAGE_KEY)
      if (cached) {
        const allOrders = JSON.parse(cached)
        delete allOrders[deviceId]
        localStorage.setItem(STORAGE_KEY, JSON.stringify(allOrders))
      }
    } catch (error) {
      console.error('清除缓存失败:', error)
    }
  }

  // 清除所有缓存
  const clearAllCache = () => {
    try {
      localStorage.removeItem(STORAGE_KEY)
    } catch (error) {
      console.error('清除所有缓存失败:', error)
    }
  }

  // 将属性移动到第一位
  const moveAttributeToFirst = (attrs, attributeIndex) => {
    if (!attrs || attributeIndex <= 0 || attributeIndex >= attrs.length) {
      return attrs
    }

    // 创建新的排序数组，将指定属性移到第一位
    const newAttrs = [...attrs]
    const [removed] = newAttrs.splice(attributeIndex, 1)
    newAttrs.unshift(removed)

    // 保存到缓存
    saveOrderToCache(newAttrs)

    return newAttrs
  }

  return {
    loadOrderFromCache,
    applyCachedOrder,
    handleDragEnd,
    moveAttributeToFirst,
    clearDeviceCache,
    clearAllCache
  }
}
