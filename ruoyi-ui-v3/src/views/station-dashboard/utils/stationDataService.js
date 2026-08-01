import { getDashboardList, listMaterialManager } from '@/api/login'
import { buildDashboardDataDict } from '@/views/index/dashboardDataUtils'
import { DEVICE_REGISTRY } from '../config/deviceRegistry'
import {
  buildDetailRows,
  buildPrimaryRow,
  computeDeviceHealth,
  materialHealth,
  materialPercent,
  resolveDeviceDisplay,
  summarizeHealth
} from './healthUtils'

export async function fetchStationDashboardData() {
  const [dashboardRes, materialRes] = await Promise.all([
    getDashboardList(),
    listMaterialManager({ pageNum: 1, pageSize: 100, materialStatus: 1 })
  ])

  const dataDict = buildDashboardDataDict(dashboardRes.data || [])
  const materials = materialRes.rows || []

  const deviceStates = DEVICE_REGISTRY.map(node => {
    const display = resolveDeviceDisplay(dataDict, node)
    return {
      ...node,
      ...display,
      primaryRow: buildPrimaryRow(dataDict, node),
      detailRows: buildDetailRows(dataDict, node)
    }
  })

  const materialCards = materials.map(row => ({
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

  const summary = summarizeHealth(deviceStates)
  materialCards.forEach(card => {
    if (card.health === 'alarm') summary.alarm += 1
    else if (card.health === 'warning') summary.warning += 1
    else summary.normal += 1
  })

  return {
    dataDict,
    deviceStates,
    materialCards,
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
