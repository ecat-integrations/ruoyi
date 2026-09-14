import assert from 'node:assert/strict'
import test from 'node:test'
import {
  DEFAULT_HOME_PATH,
  buildHomeTag,
  isRouteRegistered,
  normalizeRoutePath,
  resolveHomePath
} from './homeRoute.js'

const ADM_HOME = '/ecat-integrations/integration-env-air-device-manager/air-device-manager/index/monitor_home'

function fakeRouter(paths) {
  return {
    getRoutes: () => paths.map(path => ({ path }))
  }
}

test('normalizeRoutePath trims slashes and adds leading slash', () => {
  assert.equal(normalizeRoutePath('/index'), '/index')
  assert.equal(normalizeRoutePath('index/'), '/index')
  assert.equal(normalizeRoutePath('/adm///'), '/adm')
  assert.equal(normalizeRoutePath(''), '')
  assert.equal(normalizeRoutePath(null), '')
})

test('isRouteRegistered matches normalized paths', () => {
  const router = fakeRouter(['/index', ADM_HOME])
  assert.equal(isRouteRegistered(router, '/index/'), true)
  assert.equal(isRouteRegistered(router, 'index'), true)
  assert.equal(isRouteRegistered(router, '/not-exist'), false)
  assert.equal(isRouteRegistered(null, '/index'), false)
})

test('configured path wins when registered', () => {
  const router = fakeRouter(['/index', ADM_HOME])
  assert.equal(resolveHomePath(router, ADM_HOME), ADM_HOME)
  assert.equal(resolveHomePath(router, `${ADM_HOME}/`), ADM_HOME)
})

test('falls back to built-in /index when configured is blank', () => {
  const router = fakeRouter(['/index', ADM_HOME])
  assert.equal(resolveHomePath(router, ''), DEFAULT_HOME_PATH)
  assert.equal(resolveHomePath(router, '   '), DEFAULT_HOME_PATH)
  assert.equal(resolveHomePath(router, null), DEFAULT_HOME_PATH)
  assert.equal(resolveHomePath(router), DEFAULT_HOME_PATH)
})

test('falls back to /index when configured route is not deployed or not permitted', () => {
  const router = fakeRouter(['/index', ADM_HOME])
  assert.equal(resolveHomePath(router, '/not-deployed'), DEFAULT_HOME_PATH)
  assert.equal(
    resolveHomePath(router, '/ecat-integrations/not-installed/index/home'),
    DEFAULT_HOME_PATH
  )
})

test('debug-only routes are never chosen without explicit configuration', () => {
  // /station 等调试页面不进默认值；只有显式配置才会生效
  const router = fakeRouter(['/index', '/station'])
  assert.equal(resolveHomePath(router, ''), DEFAULT_HOME_PATH)
  assert.equal(resolveHomePath(router, '/station'), '/station')
})

test('resolveHomePath never returns a localStorage-derived preference', () => {
  // 回归保护：历史实现会把本机偏好（dashboardVersion=station）当作候选首页，
  // 导致“没配任何东西却默认进 /station”。这里确保签名只接受配置值。
  const router = fakeRouter(['/index', '/station'])
  assert.equal(resolveHomePath(router, '', '/station'), DEFAULT_HOME_PATH)
})

test('buildHomeTag pins the resolved home route', () => {
  const registered = [
    { path: '/index', name: 'Index', meta: { title: '首页' } },
    { path: ADM_HOME, name: 'adm_monitor_home', meta: { title: '监控首页' } }
  ]
  assert.deepEqual(buildHomeTag(registered, ADM_HOME), {
    fullPath: ADM_HOME,
    path: ADM_HOME,
    name: 'adm_monitor_home',
    meta: { title: '监控首页', affix: true }
  })
})

test('buildHomeTag falls back to /index when home is empty or unresolved', () => {
  const registered = [
    { path: '/index', name: 'Index', meta: { title: '首页' } },
    { path: ADM_HOME, name: 'adm_monitor_home', meta: { title: '监控首页' } }
  ]
  const expected = {
    fullPath: '/index',
    path: '/index',
    name: 'Index',
    meta: { title: '首页', affix: true }
  }
  assert.deepEqual(buildHomeTag(registered, ''), expected)
  assert.deepEqual(buildHomeTag(registered, '/not-registered'), expected)
  assert.deepEqual(buildHomeTag(registered, null), expected)
})

test('buildHomeTag normalizes trailing slash and rejects nameless routes', () => {
  const registered = [
    { path: '/index', name: 'Index', meta: { title: '首页' } },
    { path: `${ADM_HOME}/`, name: 'adm_monitor_home', meta: { title: '监控首页' } }
  ]
  assert.equal(buildHomeTag(registered, ADM_HOME).name, 'adm_monitor_home')
  // 匹配不到带 name 的路由时返回 null，避免生成无法渲染的固定标签
  assert.equal(buildHomeTag([{ path: '/index' }], '/index'), null)
  assert.equal(buildHomeTag(null, '/index'), null)
})
