import { getDashboardList } from '@/api/login'
import { buildDashboardDataDict } from '@/views/index/dashboardDataUtils'
import {
  ensureMaterialAvailable,
  fetchMaterialList,
  markMaterialUnavailable
} from '@/views/index/utils/materialAvailability'
import { DEVICE_REGISTRY } from '../config/deviceRegistry'
import {
  buildDetailRows,
  buildPrimaryRow,
  materialHealth,
  materialPercent,
  resolveDeviceDisplay,
  summarizeHealth
} from './healthUtils'

/**
 * 拉取站房大屏数据。耗材接口失败不影响设备数据。
 * @returns {Promise<{
 *   dataDict: object,
 *   deviceStates: array,
 *   materialCards: array,
 *   materialAvailable: boolean,
 *   summary: object,
 *   updatedAt: number
 * }>}
 */
export async function fetchStationDashboardData() {
  const dashboardRes = await getDashboardList()
  const dataDict = buildDashboardDataDict(dashboardRes.data || [])

  const deviceStates = DEVICE_REGISTRY.map(node => {
    const display = resolveDeviceDisplay(dataDict, node)
    return {
      ...node,
      ...display,
      primaryRow: buildPrimaryRow(dataDict, node),
      detailRows: buildDetailRows(dataDict, node)
    }
  })

  const summary = summarizeHealth(deviceStates)
  let materialCards = []
  let materialAvailable = false

  try {
    materialAvailable = await ensureMaterialAvailable()
    if (materialAvailable) {
      const materialRes = await fetchMaterialList()
      const materials = materialRes.rows || []
      materialCards = materials.map(row => ({
        id: `material_${row.materialId || row.materialName}`,
        deviceType: inferMaterialDeviceType(row.materialName),
        label: row.materialName,
        percent: materialPercent(row),
        health: materialHealth(row),
        remain: row.materialRemainCapacity,
        capacity: row.materialCapacity,
        unit: row.materialCapacityUnit || '',
        raw: row
      }))
      materialCards.forEach(card => {
        if (card.health === 'alarm') summary.alarm += 1
        else if (card.health === 'warning') summary.warning += 1
        else summary.normal += 1
      })
    }
  } catch (error) {
    console.warn('站房大屏耗材数据刷新失败:', error)
    markMaterialUnavailable()
    materialAvailable = false
    materialCards = []
  }

  return {
    dataDict,
    deviceStates,
    materialCards,
    materialAvailable,
    summary,
    updatedAt: Date.now()
  }
}

function inferMaterialDeviceType(name = '') {
  const text = String(name).toUpperCase()
  if (text.includes('滤膜') || text.includes('滤带')) return 'filter_tape'
  return 'gas_cylinder'
}

export function findDeviceState(deviceStates, id) {
  return deviceStates.find(item => item.id === id) || null
}
