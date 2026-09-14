// 站点名称展示规则（node 原生 test/assert，无 jest）
// 运行：cd ecat-integrations/ruoyi/ruoyi-ui-v3 && node --test src/utils/siteName.test.js
//
// 重点守护"未设置"这条语义链：占位提示词只用于展示，绝不能被当成真名写进 localStorage，
// 否则用户清空后会被存成"请设置站点名称"这个看起来像配置过的名字。
import test from 'node:test'
import assert from 'node:assert/strict'

// siteName.js 在模块加载时即读 localStorage，故须先装好桩再动态导入
function installLocalStorageStub(initial = {}) {
  const store = new Map(Object.entries(initial))
  globalThis.localStorage = {
    getItem: (k) => (store.has(k) ? store.get(k) : null),
    setItem: (k, v) => store.set(k, String(v)),
    removeItem: (k) => store.delete(k),
    clear: () => store.clear(),
  }
  return store
}

const KEY = 'ecat-site-name'
const PLACEHOLDER = '请设置站点名称'

installLocalStorageStub()
// 用查询串打破 ESM 模块缓存，拿到干净实例
const mod = await import('./siteName.js')
const { useSiteName, SITE_NAME_PLACEHOLDER } = mod
const { siteName, isSiteNameSet, setSiteName, resetSiteName } = useSiteName()

test('占位提示词常量与预期一致', () => {
  assert.equal(SITE_NAME_PLACEHOLDER, PLACEHOLDER)
})

test('未设置时展示提示「请设置站点名称」，而非任何站点名', () => {
  resetSiteName()
  assert.equal(siteName.value, PLACEHOLDER)
  assert.equal(isSiteNameSet.value, false)
})

test('设置后展示真名并写入 localStorage', () => {
  setSiteName('富阳空气站')
  assert.equal(siteName.value, '富阳空气站')
  assert.equal(isSiteNameSet.value, true)
  assert.equal(globalThis.localStorage.getItem(KEY), '富阳空气站')
})

test('清空即回到未设置：展示提示词，且不得把提示词存成真名', () => {
  setSiteName('富阳空气站')
  setSiteName('')
  assert.equal(siteName.value, PLACEHOLDER, '清空后应回落占位提示')
  assert.equal(isSiteNameSet.value, false)
  assert.equal(globalThis.localStorage.getItem(KEY), null, '清空后应删除存储键，而不是写入占位词')
})

test('纯空白按未设置处理（两侧空白也要裁掉）', () => {
  setSiteName('   ')
  assert.equal(isSiteNameSet.value, false)
  assert.equal(siteName.value, PLACEHOLDER)

  setSiteName('  城北污水厂  ')
  assert.equal(siteName.value, '城北污水厂')
  assert.equal(globalThis.localStorage.getItem(KEY), '城北污水厂')
})

test('setSiteName 返回规范化后的值（空则返回空串，便于调用方判断）', () => {
  assert.equal(setSiteName('  A站  '), 'A站')
  assert.equal(setSiteName(null), '')
  assert.equal(setSiteName(undefined), '')
})

test('不再读取 VITE_APP_SITE_NAME / VITE_APP_TITLE（源码中不得出现）', async () => {
  const { readFileSync } = await import('node:fs')
  const { fileURLToPath } = await import('node:url')
  const { dirname, join } = await import('node:path')
  const raw = readFileSync(join(dirname(fileURLToPath(import.meta.url)), 'siteName.js'), 'utf8')
  // 先剥注释：本文件注释里正解释着"这两个变量已弃用"，不剥会自己命中自己
  const code = raw.replace(/\/\*[\s\S]*?\*\//g, '').replace(/^\s*\/\/.*$/gm, '')
  assert.ok(!/import\.meta\.env/.test(code), '站点名称不应再从 VITE 环境变量取默认值')
  assert.ok(!/VITE_APP_SITE_NAME|VITE_APP_TITLE/.test(code), '不应再引用已弃用的 VITE 变量')
})

test('已存在的 localStorage 值在下次加载时直接生效', async () => {
  installLocalStorageStub({ [KEY]: '  开发区站点  ' })
  const fresh = await import('./siteName.js?fresh=1')
  const freshApi = fresh.useSiteName()
  assert.equal(freshApi.siteName.value, '开发区站点', '首屏应读取已存名称并裁掉空白')
  assert.equal(freshApi.isSiteNameSet.value, true)
})

test('localStorage 不可用时降级为内存态，不抛错', async () => {
  delete globalThis.localStorage
  const fresh = await import('./siteName.js?fresh=2')
  const api = fresh.useSiteName()
  assert.equal(api.siteName.value, PLACEHOLDER, '无 localStorage 时应显示未设置提示')
  assert.doesNotThrow(() => api.setSiteName('临时站'), '写入失败不应抛错')
  assert.equal(api.siteName.value, '临时站', '当前会话内仍应生效')
})
