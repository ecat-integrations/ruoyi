/**
 * 时间格式化工具函数
 */

/**
 * 格式化时间显示
 * @param {string} timeStr - 时间字符串
 * @returns {string} 格式化后的时间文本
 */
export function formatTime(timeStr) {
  if (!timeStr) return '离线'

  const updateTime = new Date(timeStr)
  const now = new Date()

  if (updateTime.toDateString() === now.toDateString()) {
    return updateTime.toLocaleTimeString('zh-CN', {
      hour: '2-digit',
      minute: '2-digit'
    })
  }

  return updateTime.toLocaleDateString('zh-CN', {
    month: '2-digit',
    day: '2-digit'
  })
}

/**
 * 格式化时间为完整日期时间
 * @param {string} timeStr - 时间字符串
 * @returns {string} 格式化后的日期时间
 */
export function formatDateTime(timeStr) {
  if (!timeStr) return '-'

  const date = new Date(timeStr)
  return date.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  })
}

/**
 * 计算时间差（秒）
 * @param {string} timeStr - 时间字符串
 * @returns {number} 时间差（秒）
 */
export function getTimeDiffInSeconds(timeStr) {
  if (!timeStr) return Infinity
  return (new Date() - new Date(timeStr)) / 1000
}
