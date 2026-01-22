/**
 * 导入任务功能
 */

import { ElMessage } from 'element-plus'

// ==================== 版本管理 ====================
/**
 * 当前任务数据格式版本
 * 必须与 useTaskOrchestration.js 中的 TASK_DATA_VERSION 保持一致
 */
export const TASK_DATA_VERSION = '1.0'

/**
 * 兼容的最低版本号
 */
export const MIN_COMPATIBLE_VERSION = '1.0'

/**
 * 检测导入任务中与本地任务重名的数量
 * @param {Array} importedTasks - 导入的任务列表
 * @param {Array} localTasks - 本地已保存的任务列表
 * @returns {Object} 包含重名任务信息的对象
 */
export function detectDuplicateNames(importedTasks, localTasks) {
  const localNames = new Set(localTasks.map(t => t.name))
  const duplicates = importedTasks.filter(t => localNames.has(t.name))

  return {
    hasDuplicates: duplicates.length > 0,
    duplicateCount: duplicates.length,
    duplicateNames: duplicates.map(t => t.name)
  }
}

/**
 * 从JSON文件导入任务列表
 * @param {File} file - JSON文件对象
 * @param {Array} localTasks - 本地已保存的任务列表
 * @returns {Promise<Object>} 包含导入结果的对象
 */
export function importTask(file, localTasks = []) {
  return new Promise((resolve, reject) => {
    if (!file) {
      ElMessage.error('请选择要导入的文件')
      reject(new Error('No file selected'))
      return
    }

    const reader = new FileReader()

    reader.onload = (e) => {
      try {
        const jsonStr = e.target.result
        const data = JSON.parse(jsonStr)

        // 支持新旧两种格式
        // 新格式：包含 tasks 数组（完整任务列表）
        // 旧格式：包含 steps 数组（单个任务的步骤）
        let importedTasks = []

        if (data.tasks && Array.isArray(data.tasks)) {
          // 新格式：完整任务列表
          importedTasks = data.tasks
        } else if (data.steps && Array.isArray(data.steps)) {
          // 旧格式：单个任务的步骤，转换为任务列表
          importedTasks = [{
            id: `imported_${Date.now()}`,
            name: '导入的任务',
            createTime: data.exportTime || new Date().toISOString(),
            updateTime: new Date().toISOString(),
            steps: data.steps
          }]
        } else {
          throw new Error('Invalid task format')
        }

        // 验证每个任务的必需字段
        for (const task of importedTasks) {
          if (!task.name || !task.steps || !Array.isArray(task.steps)) {
            throw new Error('Invalid task format')
          }
          // 验证每个步骤的必需字段
          for (const step of task.steps) {
            if (!step.type || !step.id) {
              throw new Error('Invalid step format')
            }
          }
        }

        // 检测重名任务
        const duplicateInfo = detectDuplicateNames(importedTasks, localTasks)

        resolve({
          tasks: importedTasks,
          duplicateInfo
        })
      } catch (error) {
        ElMessage.error('任务导入失败：文件格式不正确')
        reject(error)
      }
    }

    reader.onerror = () => {
      ElMessage.error('文件读取失败')
      reject(new Error('File read error'))
    }

    reader.readAsText(file)
  })
}

/**
 * 从JSON字符串导入任务步骤（保留向后兼容）
 * @param {string} jsonString - JSON字符串
 * @returns {Array} 任务步骤数组
 */
export function importTaskFromJson(jsonString) {
  try {
    const data = JSON.parse(jsonString)

    if (!data.steps || !Array.isArray(data.steps)) {
      throw new Error('Invalid task format')
    }

    return data.steps
  } catch (error) {
    throw new Error('Invalid JSON format')
  }
}
