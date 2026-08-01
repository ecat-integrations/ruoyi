const DEFAULT_ALERT_KEYWORDS = ['报警', '异常', '关', 'off', 'alarm', 'locked', '离线']

/**
 * @param {string|number|null|undefined} value
 * @param {string[]} [keywords]
 */
export function isAlertValue(value, keywords = DEFAULT_ALERT_KEYWORDS) {
  if (value === null || value === undefined || value === '') return false
  const text = String(value).toLowerCase()
  return keywords.some(k => text.includes(String(k).toLowerCase()))
}

/**
 * @param {Record<string, object>} dataDict
 * @param {string} bindingKey
 */
export function getBindingEntry(dataDict, bindingKey) {
  return dataDict[bindingKey] || null
}

/**
 * @param {Record<string, object>} dataDict
 * @param {object} deviceNode
 * @returns {'normal'|'warning'|'alarm'|'offline'|'unknown'}
 */
export function computeDeviceHealth(dataDict, deviceNode) {
  const keys = deviceNode.bindings?.length ? deviceNode.bindings : [deviceNode.primaryBinding]
  if (!keys?.length) return 'unknown'

  let hasData = false
  let hasStale = false
  let hasAlarm = false

  keys.forEach(key => {
    const entry = getBindingEntry(dataDict, key)
    if (!entry || entry.value === null || entry.value === undefined || entry.value === '') {
      return
    }
    hasData = true
    if (entry.status === 0) hasStale = true
    if (isAlertValue(entry.value)) hasAlarm = true
  })

  if (!hasData) return 'offline'
  if (hasAlarm) return 'alarm'
  if (hasStale) return 'warning'
  return 'normal'
}

/**
 * @param {Record<string, object>} dataDict
 * @param {object} deviceNode
 */
export function resolveDeviceDisplay(dataDict, deviceNode) {
  const primary = getBindingEntry(dataDict, deviceNode.primaryBinding)
  const health = computeDeviceHealth(dataDict, deviceNode)
  const value = primary?.value ?? '--'
  const unit = primary?.unit || ''
  return {
    health,
    value,
    unit,
    displayValue: value === '--' ? '--' : `${value}${unit ? ` ${unit}` : ''}`
  }
}

/**
 * @param {Array<object>} deviceStates
 */
export function summarizeHealth(deviceStates) {
  const summary = { normal: 0, warning: 0, alarm: 0, offline: 0, unknown: 0 }
  deviceStates.forEach(item => {
    summary[item.health] = (summary[item.health] || 0) + 1
  })
  return summary
}

/**
 * @param {object} materialRow
 */
export function materialHealth(materialRow) {
  if (!materialRow?.materialCapacity) return 'unknown'
  const ratio = materialRow.materialRemainCapacity / materialRow.materialCapacity
  if (ratio < 0.2) return 'alarm'
  if (ratio < 0.5) return 'warning'
  return 'normal'
}

export function materialPercent(materialRow) {
  if (!materialRow?.materialCapacity) return 0
  return Math.min(100, Math.round((materialRow.materialRemainCapacity / materialRow.materialCapacity) * 100))
}

/**
 * @param {Record<string, object>} dataDict
 * @param {string} bindingKey
 */
export function resolveKpi(dataDict, bindingKey) {
  const entry = getBindingEntry(dataDict, bindingKey)
  if (!entry) {
    return { value: '--', unit: '', health: 'offline' }
  }
  let health = 'normal'
  if (entry.value === null || entry.value === undefined || entry.value === '') {
    health = 'offline'
  } else if (entry.status === 0) {
    health = 'warning'
  } else if (isAlertValue(entry.value)) {
    health = 'alarm'
  }
  return {
    value: entry.value ?? '--',
    unit: entry.unit || '',
    health
  }
}

/**
 * @param {Record<string, object>} dataDict
 * @param {object} deviceNode
 */
export function buildDetailRows(dataDict, deviceNode) {
  const keys = deviceNode.detailBindings || deviceNode.bindings || []
  return keys.map(key => {
    const entry = getBindingEntry(dataDict, key)
    return {
      key,
      name: entry?.name || key.split('-').pop(),
      value: entry?.value ?? '--',
      unit: entry?.unit || '',
      health: entry ? (entry.status === 1 ? (isAlertValue(entry.value) ? 'alarm' : 'normal') : 'warning') : 'offline'
    }
  })
}

/**
 * 默认展示的主指标（1 个）
 */
export function buildPrimaryRow(dataDict, deviceNode) {
  const key = deviceNode.primaryBinding
  if (!key) return null
  const entry = getBindingEntry(dataDict, key)
  if (!entry) {
    return { key, name: deviceNode.label, value: '--', unit: '', health: 'offline' }
  }
  return {
    key,
    name: entry.name || deviceNode.label,
    value: entry.value ?? '--',
    unit: entry.unit || '',
    health: entry.status === 1 ? (isAlertValue(entry.value) ? 'alarm' : 'normal') : 'warning'
  }
}
