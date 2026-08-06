/**
 * 耗材（物资）管理集成可用性探测与会话缓存。
 * 集成标识：integration-env-material-manager
 *
 * 以静默探测 /material/manager/list 为准（webintegration/list 可能受权限限制）。
 */

import { listMaterialManager } from '@/api/login'

export const MATERIAL_INTEGRATION_NAME = 'integration-env-material-manager'

export const MATERIAL_DISABLED_TIP = '耗材管理集成未启用，无法展示物资余量'

/** @type {boolean|null} null=未探测 */
let cachedAvailable = null

let tipShown = false

/**
 * 重置会话缓存（例如需要强制重新探测时）
 */
export function resetMaterialAvailabilityCache() {
  cachedAvailable = null
}

/**
 * 运行中探测到接口不可用时同步缓存，避免后续继续轮询。
 */
export function markMaterialUnavailable() {
  cachedAvailable = false
}

/**
 * 确保已探测耗材集成是否可用。
 * @param {{ force?: boolean }} [options]
 * @returns {Promise<boolean>}
 */
export async function ensureMaterialAvailable({ force = false } = {}) {
  if (!force && cachedAvailable !== null) {
    return cachedAvailable
  }
  try {
    await listMaterialManager(
      { pageNum: 1, pageSize: 1, materialStatus: 1 },
      { silent: true }
    )
    cachedAvailable = true
  } catch (e) {
    cachedAvailable = false
  }
  return cachedAvailable
}

/**
 * 未启用时仅提示一次。
 * @param {{ warning: Function }} messageApi element-plus ElMessage 或兼容对象
 */
export function notifyMaterialDisabledOnce(messageApi) {
  if (tipShown || cachedAvailable !== false) {
    return
  }
  tipShown = true
  if (messageApi && typeof messageApi.warning === 'function') {
    messageApi.warning(MATERIAL_DISABLED_TIP)
  }
}

/**
 * 拉取启用中的物资列表（正常请求，非 silent）。
 * @param {object} [query]
 */
export function fetchMaterialList(query = { pageNum: 1, pageSize: 100, materialStatus: 1 }) {
  return listMaterialManager(query)
}
