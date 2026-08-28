/**
 * 大屏空气浓度单位档位（与 /nowdata/list?aqUnit= 对齐）。
 * 空串 = 不传参数，保持原接口出数。
 */

export const DASHBOARD_AQ_UNIT_KEY = 'ecat.dashboard.aqUnit'

export function loadDashboardAqUnit() {
  try {
    const value = localStorage.getItem(DASHBOARD_AQ_UNIT_KEY)
    if (value === 'mass' || value === 'volume') {
      return value
    }
  } catch (e) {
    /* ignore quota / private mode */
  }
  return ''
}

export function saveDashboardAqUnit(mode) {
  try {
    if (mode === 'mass' || mode === 'volume') {
      localStorage.setItem(DASHBOARD_AQ_UNIT_KEY, mode)
    } else {
      localStorage.removeItem(DASHBOARD_AQ_UNIT_KEY)
    }
  } catch (e) {
    /* ignore */
  }
}
