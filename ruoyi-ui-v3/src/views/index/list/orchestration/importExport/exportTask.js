/**
 * 导出任务功能
 */

import { ElMessage } from 'element-plus'

// ==================== 版本管理 ====================
/**
 * 当前任务数据格式版本
 * 必须与 useTaskOrchestration.js 中的 TASK_DATA_VERSION 保持一致
 */
export const TASK_DATA_VERSION = '1.0'

/**
 * 导出全部任务到JSON文件
 * @param {Array} savedTasks - 已保存的任务列表
 * @param {string} filename - 文件名（可选）
 */
export function exportTask(savedTasks, filename = null) {
  if (!savedTasks || savedTasks.length === 0) {
    ElMessage.warning('没有可导出的任务')
    return Promise.reject(new Error('No tasks to export'))
  }

  return new Promise((resolve, reject) => {
    try {
      // 导出任务列表，包含完整的任务信息和版本信息
      const taskData = {
        version: TASK_DATA_VERSION,
        exportTime: new Date().toISOString(),
        taskCount: savedTasks.length,
        tasks: savedTasks.map(task => ({
          version: task.version || TASK_DATA_VERSION,  // 包含每个任务的版本
          id: task.id,
          name: task.name,
          createTime: task.createTime,
          updateTime: task.updateTime,
          steps: task.steps
        }))
      }

      const jsonStr = JSON.stringify(taskData, null, 2)
      const blob = new Blob([jsonStr], { type: 'application/json' })
      const url = URL.createObjectURL(blob)

      const link = document.createElement('a')
      link.href = url
      // 生成带时间戳的文件名
      const timestamp = new Date().toISOString().slice(0, 19).replace(/[:-]/g, '')
      link.download = filename || `device_tasks_${timestamp}.json`

      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)

      URL.revokeObjectURL(url)

      ElMessage.success(`成功导出 ${savedTasks.length} 个任务 (版本 ${TASK_DATA_VERSION})`)
      resolve(taskData)
    } catch (error) {
      ElMessage.error('任务导出失败')
      reject(error)
    }
  })
}
