/**
 * 设备属性状态映射
 * 从后台字典动态获取状态文本
 */

import { getDicts } from '@/api/system/dict/data'

const DICT_TYPE = 'data_sign'
let dictCache = null
let loadPromise = null

/**
 * 加载字典数据
 */
async function loadDict() {
  if (dictCache) return dictCache
  if (loadPromise) return loadPromise

  loadPromise = getDicts(DICT_TYPE).then(resp => {
    if (resp.code === 200) {
      // 转换为 Map: { value: label }
      dictCache = {}
      resp.data.forEach(item => {
        dictCache[item.dictValue] = item.dictLabel
      })
    }
    return dictCache
  }).finally(() => {
    loadPromise = null
  })

  return loadPromise
}

/**
 * 预加载字典（在应用启动时调用）
 */
export async function initStatusMapper() {
  await loadDict()
}

/**
 * 获取状态中文文本
 * @param {string|number} statusId - 数字状态 ID
 * @returns {string} 中文文本
 */
export function getStatusText(statusId) {
  if (statusId == null) return '位置状态(null)'

  const id = String(statusId)

  // 如果字典已加载，从字典获取
  if (dictCache && dictCache[id]) {
    return dictCache[id]
  }

  // 字典未加载时的降级显示（返回 ID）
  return id
}

/**
 * 刷新字典缓存
 */
export function refreshDictCache() {
  dictCache = null
  return loadDict()
}
