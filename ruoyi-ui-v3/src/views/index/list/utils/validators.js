/**
 * 验证函数
 */

/**
 * 验证任务步骤合法性
 * @param {Array} taskSteps - 任务步骤数组
 * @param {Function} addLog - 添加日志的函数
 * @returns {boolean} 验证是否通过
 */
export function validateTaskSteps(taskSteps, addLog) {
  if (taskSteps.length === 0) {
    addLog('任务执行失败：没有任何步骤', 'error')
    return false
  }

  for (let i = 0; i < taskSteps.length; i++) {
    const step = taskSteps[i]
    if (step.type === 'device') {
      if (!step.deviceId) {
        addLog(`步骤${i + 1}验证失败：未选择设备`, 'error')
        return false
      }
      if (!step.attributeId) {
        addLog(`步骤${i + 1}验证失败：未选择属性`, 'error')
        return false
      }
    } else if (step.type === 'delay') {
      if (!step.delayTime || step.delayTime <= 0) {
        addLog(`步骤${i + 1}验证失败：延迟时间不合法`, 'error')
        return false
      }
    }
  }
  return true
}
