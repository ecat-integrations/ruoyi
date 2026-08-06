import { ElMessage } from 'element-plus'
import { saveDashboardVersion, getDashboardVersion } from '@/utils/pageState'

export function switchToStationDashboard(router) {
  saveDashboardVersion('station')
  ElMessage({
    message: '正在切换到新版站房大屏...',
    type: 'info',
    duration: 1200
  })
  router.push('/station')
}

export function switchToLegacyDashboard(router) {
  saveDashboardVersion('legacy')
  ElMessage({
    message: '正在切换到经典大屏...',
    type: 'info',
    duration: 1200
  })
  router.push('/index')
}

export function resolveHomePath() {
  return getDashboardVersion() === 'legacy' ? '/index' : '/station'
}
