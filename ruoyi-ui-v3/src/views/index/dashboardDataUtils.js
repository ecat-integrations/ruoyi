/**
 * 固定逻辑设备大屏：数据字典构建与面板项刷新。
 */

const DEFAULT_ALERT_KEYWORDS = ['报警', '异常', '关', 'off', 'alarm', 'locked']

/**
 * 从 /nowdata/dashboard-list 响应构建查找字典。
 * 逻辑设备以 uniqueId 为主键；同时保留 deviceId 索引供设备列表模式使用。
 */
export function buildDashboardDataDict(datas) {
  const dataDict = {}
  if (!Array.isArray(datas)) {
    return dataDict
  }

  datas.forEach(data => {
    const deviceId = data.deviceId
    const uniqueId = data.uniqueId
    const bindPrefix = uniqueId || deviceId

    dataDict[deviceId] = {
      name: data.deviceName,
      value: null,
      unit: data.deviceModel,
      status: data.deviceStatus,
      id: deviceId,
      type: 'value'
    }

    if (uniqueId) {
      dataDict[uniqueId] = {
        name: data.deviceName,
        value: null,
        unit: data.deviceModel,
        status: data.deviceStatus,
        id: uniqueId,
        type: 'value'
      }
    }

    const attrs = data.deviceAttrs || []
    attrs.forEach(attr => {
      const entry = {
        name: attr.displayName,
        value: attr.displayValue,
        unit: attr.displayUnit,
        status: resolveAttrFreshness(attr.updateTime),
        id: attr.attributeID,
        type: 'value',
        deviceId,
        uniqueId: uniqueId || null
      }

      if (attr.bindKey) {
        dataDict[attr.bindKey] = entry
      }
      if (bindPrefix && attr.attributeID) {
        dataDict[`${bindPrefix}-${attr.attributeID}`] = entry
      }
      if (deviceId && attr.attributeID) {
        dataDict[`${deviceId}-${attr.attributeID}`] = entry
      }
    })
  })

  return dataDict
}

function resolveAttrFreshness(updateTime) {
  if (updateTime && new Date(updateTime).getTime() > Date.now() - 5 * 60 * 1000) {
    return 1
  }
  return 0
}

/**
 * 刷新单个面板项（与原 analysisData 兼容，扩展告警关键词）。
 */
export function applyDashboardItem(item, dataDict, options = {}) {
  const alertKeywords = options.alertKeywords || DEFAULT_ALERT_KEYWORDS
  const value = dataDict[item.id]?.value

  if (item.type === 'value') {
    item.value = value
  } else {
    item.value = value
  }

  const dictEntry = dataDict[item.id]
  item.unit = dictEntry ? dictEntry.unit : null
  item.status = dictEntry ? dictEntry.status : 0

  if (item.status === 1) {
    item.datastatus = alertKeywords.includes(item.value) ? 2 : 1
  } else {
    item.datastatus = -1
  }
}

export function refreshDashboardPanels(vm, dataDict, panelKeys, options) {
  panelKeys.forEach(key => {
    const panel = vm[key]
    if (Array.isArray(panel)) {
      panel.forEach(item => applyDashboardItem(item, dataDict, options))
    }
  })

  if (vm.middleTwoDict) {
    Object.values(vm.middleTwoDict).forEach(item => applyDashboardItem(item, dataDict, options))
  }
}
