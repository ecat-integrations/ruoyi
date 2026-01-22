/**
 * 任务编排组合式函数
 * 提供任务步骤管理、执行控制、任务保存/加载功能
 */

import { ref } from 'vue'
import { deviceDebug } from '@/api/login'
import { ElMessage, ElMessageBox } from 'element-plus'
import { validateTaskSteps as validateSteps } from '../utils/validators'

// ==================== 版本管理 ====================
/**
 * 当前任务数据格式版本
 * 格式：主版本号.次版本号 (如: 1.0, 1.1, 2.0)
 * 主版本号变更：不兼容的格式变更
 * 次版本号变更：向后兼容的格式变更
 */
export const TASK_DATA_VERSION = '1.0'

/**
 * 兼容的最低版本号
 * 低于此版本的数据将无法导入
 */
export const MIN_COMPATIBLE_VERSION = '1.0'

export function useTaskOrchestration(props) {
  // ==================== 状态定义 ====================
  const taskSteps = ref([])           // 当前编辑的任务步骤
  const isTaskRunning = ref(false)    // 任务是否正在执行
  const currentExecStep = ref(-1)     // 当前执行的步骤索引
  const executionLogs = ref([])       // 执行日志列表
  const taskTimer = ref(null)         // 任务定时器

  // 任务管理相关状态
  const savedTasks = ref([])          // 已保存的任务列表
  const currentEditingTaskId = ref(null)  // 当前编辑的任务ID（null=新任务）

  // ==================== 辅助函数 ====================
  /**
   * 生成唯一ID
   */
  const generateUniqueId = () => Date.now() + Math.floor(Math.random() * 1000)

  /**
   * 添加执行日志
   */
  const addExecutionLog = (content, type = 'info') => {
    const time = new Date().toLocaleTimeString('zh-CN', {
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    })
    executionLogs.value.push({ time, content, type })

    // 自动滚动到最新日志
    setTimeout(() => {
      const logContainer = document.querySelector('.log-content')
      if (logContainer) logContainer.scrollTop = logContainer.scrollHeight
    }, 0)
  }

  // ==================== 任务步骤操作 ====================
  /**
   * 添加步骤
   */
  const addStep = (type) => {
    const newStep = {
      id: generateUniqueId(),
      type,
      deviceId: '',
      attributeId: '',
      targetValue: '',
      delayTime: 2
    }
    taskSteps.value.push(newStep)
    addExecutionLog(`添加${type === 'device' ? '设备操作' : '延迟等待'}步骤`, 'info')
  }

  /**
   * 删除步骤
   */
  const deleteStep = (index) => {
    const step = taskSteps.value[index]
    taskSteps.value.splice(index, 1)
    addExecutionLog(`删除第${index + 1}步：${step.type === 'device' ? '设备操作' : '延迟等待'}`, 'info')

    if (isTaskRunning.value && currentExecStep.value === index) {
      stopTaskExecution()
    }
  }

  /**
   * 移动步骤
   */
  const moveStep = (index, direction) => {
    if (direction === 'up' && index > 0) {
      [taskSteps.value[index], taskSteps.value[index - 1]] =
        [taskSteps.value[index - 1], taskSteps.value[index]]
      addExecutionLog(`步骤${index + 1}上移至位置${index}`, 'info')
    } else if (direction === 'down' && index < taskSteps.value.length - 1) {
      [taskSteps.value[index], taskSteps.value[index + 1]] =
        [taskSteps.value[index + 1], taskSteps.value[index]]
      addExecutionLog(`步骤${index + 1}下移至位置${index + 2}`, 'info')
    }
  }

  /**
   * 处理步骤类型变更
   */
  const handleStepTypeChange = (step) => {
    if (step.type === 'device') {
      step.delayTime = 2
    } else {
      step.deviceId = ''
      step.attributeId = ''
      step.targetValue = ''
    }
  }

  /**
   * 处理设备选择变更
   */
  const handleDeviceChange = (step) => {
    step.attributeId = ''
    step.targetValue = ''
  }

  // ==================== 任务管理功能 ====================
  /**
   * 加载已保存任务列表
   */
  const loadSavedTasks = () => {
    const tasks = JSON.parse(localStorage.getItem('deviceTasks') || '[]')
    savedTasks.value = tasks
  }

  // 初始化：加载已保存的任务列表
  loadSavedTasks()

  /**
   * 保存为新任务
   * @param {string} taskName - 任务名称
   * @returns {boolean} 保存是否成功
   */
  const saveAsNewTask = (taskName) => {
    if (!validateTaskSteps()) return false

    // 检查任务名称唯一性
    const nameExists = savedTasks.value.some(t => t.name === taskName)
    if (nameExists) {
      ElMessage.error(`任务名称 "${taskName}" 已存在，请使用其他名称`)
      return false
    }

    const now = new Date().toISOString()
    const taskData = {
      version: TASK_DATA_VERSION,  // 添加数据版本
      id: `${Date.now()}_${Math.floor(Math.random() * 1000)}`,
      name: taskName,
      createTime: now,
      updateTime: now,
      steps: JSON.parse(JSON.stringify(taskSteps.value))
    }

    savedTasks.value.push(taskData)
    persistTasks()
    currentEditingTaskId.value = null

    addExecutionLog(`新任务保存成功：${taskName}`, 'success')
    ElMessage.success('任务已保存')
    return true
  }

  /**
   * 更新当前任务
   * @returns {Promise<boolean>} 更新是否成功
   */
  const updateCurrentTask = async () => {
    if (!validateTaskSteps()) return false

    const task = savedTasks.value.find(t => t.id === currentEditingTaskId.value)
    if (!task) {
      ElMessage.error('当前任务不存在')
      return false
    }

    try {
      // 确认覆盖
      await ElMessageBox.confirm(
        `是否要覆盖任务 "${task.name}"？`,
        '确认更新',
        {
          confirmButtonText: '确认',
          cancelButtonText: '取消',
          type: 'warning'
        }
      )

      // 更新任务
      task.steps = JSON.parse(JSON.stringify(taskSteps.value))
      task.updateTime = new Date().toISOString()
      persistTasks()

      addExecutionLog(`任务更新成功：${task.name}`, 'success')
      ElMessage.success('任务已更新')
      return true
    } catch {
      // 用户取消
      return false
    }
  }

  /**
   * 加载指定任务
   * @param {string} taskId - 任务ID
   */
  const loadTask = (taskId) => {
    const task = savedTasks.value.find(t => t.id === taskId)
    if (!task) {
      ElMessage.error('任务不存在')
      return
    }

    taskSteps.value = JSON.parse(JSON.stringify(task.steps))
    currentEditingTaskId.value = taskId
    addExecutionLog(`加载任务：${task.name}`, 'info')
  }

  /**
   * 删除任务
   * @param {string} taskId - 任务ID
   */
  const deleteTask = async (taskId) => {
    const task = savedTasks.value.find(t => t.id === taskId)
    if (!task) return

    try {
      await ElMessageBox.confirm(
        `确定要删除任务 "${task.name}" 吗？`,
        '确认删除',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }
      )

      savedTasks.value = savedTasks.value.filter(t => t.id !== taskId)
      persistTasks()

      // 如果删除的是当前编辑的任务，重置状态
      if (currentEditingTaskId.value === taskId) {
        currentEditingTaskId.value = null
        taskSteps.value = []
      }

      addExecutionLog(`任务已删除：${task.name}`, 'info')
      ElMessage.success('任务已删除')
    } catch {
      // 用户取消
    }
  }

  /**
   * 持久化任务列表到 localStorage
   */
  const persistTasks = () => {
    localStorage.setItem('deviceTasks', JSON.stringify(savedTasks.value))
  }

  /**
   * 比较版本号
   * @param {string} version1 - 版本1
   * @param {string} version2 - 版本2
   * @returns {number} 1: version1 > version2, -1: version1 < version2, 0: 相等
   */
  const compareVersions = (version1, version2) => {
    const v1Parts = version1.split('.').map(Number)
    const v2Parts = version2.split('.').map(Number)

    for (let i = 0; i < Math.max(v1Parts.length, v2Parts.length); i++) {
      const v1Part = v1Parts[i] || 0
      const v2Part = v2Parts[i] || 0

      if (v1Part > v2Part) return 1
      if (v1Part < v2Part) return -1
    }

    return 0
  }

  /**
   * 校验任务数据版本
   * @param {Object} task - 任务对象
   * @returns {boolean} 版本是否兼容
   */
  const validateTaskVersion = (task) => {
    const taskVersion = task.version || '1.0'  // 默认版本为1.0（兼容无版本字段的老数据）

    // 检查版本是否低于最低兼容版本
    if (compareVersions(taskVersion, MIN_COMPATIBLE_VERSION) < 0) {
      ElMessage.warning(
        `任务 "${task.name}" 的数据版本 (${taskVersion}) 过低，` +
        `当前系统要求最低版本为 ${MIN_COMPATIBLE_VERSION}，已跳过该任务`
      )
      return false
    }

    // 如果版本高于当前版本，给出警告但允许导入（向后兼容假设）
    if (compareVersions(taskVersion, TASK_DATA_VERSION) > 0) {
      addExecutionLog(
        `任务 "${task.name}" 的数据版本 (${taskVersion}) 高于当前版本 (${TASK_DATA_VERSION})，` +
        `可能存在兼容性问题`,
        'warning'
      )
    }

    return true
  }

  /**
   * 导入任务列表
   * @param {Array} importedTasks - 要导入的任务列表
   * @param {string} conflictMode - 冲突处理模式: 'overwrite' | 'skip' | 'cancel'
   * @returns {boolean} 导入是否成功
   */
  const importTasks = (importedTasks, conflictMode = 'skip') => {
    if (!importedTasks || importedTasks.length === 0) {
      ElMessage.warning('没有可导入的任务')
      return false
    }

    // 创建本地任务名称映射，用于快速查找
    const localTaskMap = new Map(savedTasks.value.map(t => [t.name, t]))

    let addedCount = 0
    let updatedCount = 0
    let skippedCount = 0
    let versionIncompatibleCount = 0

    for (const importedTask of importedTasks) {
      // 校验版本
      if (!validateTaskVersion(importedTask)) {
        versionIncompatibleCount++
        continue
      }

      const existingTask = localTaskMap.get(importedTask.name)

      if (existingTask) {
        // 任务名称冲突
        if (conflictMode === 'overwrite') {
          // 覆盖模式：更新现有任务，保留原版本号或使用导入的版本号
          existingTask.steps = importedTask.steps
          existingTask.updateTime = new Date().toISOString()
          // 如果导入的任务有版本号，更新版本
          if (importedTask.version) {
            existingTask.version = importedTask.version
          }
          updatedCount++
        } else if (conflictMode === 'skip') {
          // 跳过模式：不导入重名任务
          skippedCount++
        }
        // cancel 模式在调用前处理，这里不处理
      } else {
        // 没有冲突，添加新任务
        const newTask = {
          version: importedTask.version || TASK_DATA_VERSION,  // 使用导入的版本或当前版本
          id: importedTask.id,
          name: importedTask.name,
          createTime: importedTask.createTime,
          updateTime: importedTask.updateTime,
          steps: importedTask.steps
        }
        savedTasks.value.push(newTask)
        localTaskMap.set(newTask.name, newTask)
        addedCount++
      }
    }

    persistTasks()

    // 生成导入结果日志
    const resultParts = []
    if (addedCount > 0) resultParts.push(`新增 ${addedCount} 个`)
    if (updatedCount > 0) resultParts.push(`更新 ${updatedCount} 个`)
    if (skippedCount > 0) resultParts.push(`跳过 ${skippedCount} 个`)
    if (versionIncompatibleCount > 0) resultParts.push(`${versionIncompatibleCount} 个版本不兼容`)

    if (resultParts.length > 0) {
      addExecutionLog(`导入任务完成：${resultParts.join('、')}`, 'success')
      ElMessage.success(`导入成功：${resultParts.join('、')}任务`)
    }

    return true
  }

  // ==================== 任务验证 ====================
  /**
   * 验证任务步骤合法性
   */
  const validateTaskSteps = () => {
    return validateSteps(taskSteps.value, addExecutionLog)
  }

  // ==================== 任务执行 ====================
  /**
   * 设备控制API
   */
  const controlDeviceApi = async (deviceId, attributeId, targetValue) => {
    const debugData = {
      deviceId: deviceId,
      attrId: attributeId,
      value: targetValue
    }
    const result = await deviceDebug(debugData)
    addExecutionLog(`设备调试结果：${JSON.stringify(result)}`, 'info')
    await new Promise(resolve => setTimeout(resolve, 500))
    return { success: true, message: '控制指令已下发' }
  }

  /**
   * 执行单个步骤
   */
  const executeSingleStep = async (step, index) => {
    currentExecStep.value = index
    addExecutionLog(`开始执行步骤${index + 1}：${step.type === 'device' ? '设备操作' : '延迟等待'}`, 'info')

    try {
      if (step.type === 'device') {
        const device = props.deviceData.find(d => d.deviceId === step.deviceId)
        const attr = device?.deviceAttrs.find(a => a.attributeID === step.attributeId)
        const deviceName = device?.deviceName || '未知设备'
        const attrName = attr?.displayName || '未知属性'

        addExecutionLog(`设备操作：${deviceName} - ${attrName} -> ${step.targetValue}`, 'info')

        const result = await controlDeviceApi(step.deviceId, step.attributeId, step.targetValue)

        if (result.success) {
          addExecutionLog(`步骤${index + 1}执行成功：${result.message}`, 'success')
        } else {
          addExecutionLog(`步骤${index + 1}执行失败：${result.message}`, 'error')
          throw new Error(result.message)
        }
      } else {
        addExecutionLog(`开始延迟${step.delayTime}秒`, 'info')
        await new Promise(resolve => {
          taskTimer.value = setTimeout(resolve, step.delayTime * 1000)
        })
        addExecutionLog(`步骤${index + 1}延迟结束`, 'success')
      }

      if (index < taskSteps.value.length - 1) {
        taskTimer.value = setTimeout(() => {
          executeSingleStep(taskSteps.value[index + 1], index + 1)
        }, 100)
      } else {
        addExecutionLog('所有任务步骤执行完成', 'success')
        stopTaskExecution()
      }
    } catch (error) {
      addExecutionLog(`任务中断：${error.message}`, 'error')
      stopTaskExecution()
    }
  }

  /**
   * 开始任务执行
   */
  const startTaskExecution = () => {
    if (!validateTaskSteps()) return

    isTaskRunning.value = true
    currentExecStep.value = -1
    executionLogs.value = []
    addExecutionLog('任务开始执行', 'info')
    executeSingleStep(taskSteps.value[0], 0)
  }

  /**
   * 停止任务执行
   */
  const stopTaskExecution = () => {
    if (taskTimer.value) {
      clearTimeout(taskTimer.value)
      taskTimer.value = null
    }
    isTaskRunning.value = false
    addExecutionLog(`任务已停止，执行至步骤${currentExecStep.value + 1}`, 'info')
    currentExecStep.value = -1
  }

  /**
   * 切换任务执行状态
   */
  const toggleTaskExecution = () => {
    isTaskRunning.value ? stopTaskExecution() : startTaskExecution()
  }

  // ==================== 清空操作 ====================
  /**
   * 清空任务步骤
   */
  const clearTask = async () => {
    if (taskSteps.value.length === 0) return

    // 如果正在编辑任务，先确认是否放弃修改
    if (currentEditingTaskId.value) {
      try {
        await ElMessageBox.confirm(
          '当前正在编辑已有任务，确定要清空步骤吗？',
          '提示',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
      } catch {
        return
      }
    } else {
      try {
        await ElMessageBox.confirm(
          '确定要清空所有任务步骤吗？',
          '提示',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        )
      } catch {
        return
      }
    }

    taskSteps.value = []
    currentEditingTaskId.value = null
    addExecutionLog('所有任务步骤已清空', 'info')
  }

  // ==================== 返回公共接口 ====================
  return {
    // 状态
    taskSteps,
    isTaskRunning,
    currentExecStep,
    executionLogs,
    savedTasks,
    currentEditingTaskId,

    // 步骤操作
    addStep,
    deleteStep,
    moveStep,
    handleStepTypeChange,
    handleDeviceChange,

    // 任务管理
    loadSavedTasks,
    saveAsNewTask,
    updateCurrentTask,
    loadTask,
    deleteTask,
    importTasks,

    // 任务执行
    validateTaskSteps,
    toggleTaskExecution,

    // 清空操作
    clearTask
  }
}
