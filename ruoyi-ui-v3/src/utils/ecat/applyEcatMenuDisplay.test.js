import assert from 'node:assert/strict'
import test from 'node:test'
import {
  applyEcatMenuDisplay,
  joinRoutePath,
  reparentEcatRoutes
} from './applyEcatMenuDisplay.js'

const integration = 'integration-env-device-manager'
const dirKey = 'ecat-sync:integration-env-device-manager/device-manager/index'
const childKey = 'ecat-sync:integration-env-device-manager/device-manager/device_control'

function deviceRoutes() {
  return [{
    name: `${integration}_index`,
    path: `/ecat-integrations/${integration}/device-manager/index`,
    component: 'Layout',
    alwaysShow: true,
    meta: { title: '设备管理', icon: 'list' },
    children: [{
      name: `${integration}_device_control`,
      path: 'device_control',
      component: () => 'DevicePanel',
      meta: { title: '设备控制' }
    }]
  }]
}

test('joinRoutePath keeps absolute child paths', () => {
  assert.equal(
    joinRoutePath('/ecat-integrations/x/index', 'device_control'),
    '/ecat-integrations/x/index/device_control'
  )
  assert.equal(joinRoutePath('/system', '/ecat/page'), '/ecat/page')
})

test('reparent keeps JSON tree when flags have no parentId', () => {
  const flags = {
    [dirKey]: { visible: '0', status: '0', orderNum: '1' },
    [childKey]: { visible: '0', status: '0', orderNum: '2' }
  }
  const ecat = applyEcatMenuDisplay(deviceRoutes(), integration, flags)
  const merged = reparentEcatRoutes([{ path: '/system', name: 'System', menuId: 1, meta: { title: '系统管理' } }], ecat, flags)
  const device = merged.find(r => r.ecatRemark === dirKey)
  assert.ok(device)
  assert.equal(device.children[0].ecatRemark, childKey)
  assert.equal(device.children[0].path, `/ecat-integrations/${integration}/device-manager/index/device_control`)
})

test('reparent moves ecat directory under native menu by parentId', () => {
  const flags = {
    [dirKey]: { visible: '0', status: '0', orderNum: '9', menuId: '501', parentId: '1' },
    [childKey]: { visible: '0', status: '0', orderNum: '1', menuId: '502', parentId: '501', parentRemark: dirKey }
  }
  const ecat = applyEcatMenuDisplay(deviceRoutes(), integration, flags)
  const system = { path: '/system', name: 'System', menuId: 1, component: 'Layout', meta: { title: '系统管理' }, children: [] }
  const merged = reparentEcatRoutes([system], ecat, flags)
  assert.equal(merged.length, 1)
  assert.equal(merged[0].path, '/system')
  assert.equal(merged[0].children[0].ecatRemark, dirKey)
  assert.equal(merged[0].children[0].component, 'ParentView')
  assert.equal(merged[0].children[0].children[0].meta.title, '设备控制')
})

test('reparent drops ecat node when native parent is missing', () => {
  const flags = {
    [dirKey]: { visible: '0', status: '0', parentId: '999' },
    [childKey]: { visible: '0', status: '0', parentId: '501', parentRemark: dirKey }
  }
  const ecat = applyEcatMenuDisplay(deviceRoutes(), integration, flags)
  const merged = reparentEcatRoutes([{ path: '/system', menuId: 1, meta: { title: '系统管理' } }], ecat, flags)
  assert.equal(merged.length, 1)
  assert.equal(merged[0].path, '/system')
})
