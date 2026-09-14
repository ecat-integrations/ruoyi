import request from '@/utils/request'

// 备份还原：引导信息（安装路径、快照列表、维护状态）
export function getBackupInfo() {
  return request({
    url: '/system/backup/info',
    method: 'get'
  })
}

// 唤起守护工具的「备份还原」页
export function openGuardianBackup() {
  return request({
    url: '/system/backup/open-guardian',
    method: 'post'
  })
}
