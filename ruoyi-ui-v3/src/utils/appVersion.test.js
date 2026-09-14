// 版本号展示 + 报警热区守卫（node 原生 test/assert，无 jest）
// 运行：cd ecat-integrations/ruoyi/ruoyi-ui-v3 && node --test src/utils/appVersion.test.js
//
// 背景与结论：
// 1. 版本号由 @/utils/appVersion 提供（vite define 注入 __ECAT_APP_VERSION__，优先级
//    VITE_APP_VERSION > pom 的 ecat.core.version > package.json）。
// 2. 导航栏（Navbar 的 .version-badge）在任何页面都展示版本号，因此大屏首页不再重复展示
//    ——原先大屏右上角各写各的硬编码版本（V1.0.3 / V1.1.4），必然与导航栏不一致。
// 3. 大屏右上角那块区域保留为「报警通知开关」的隐性热区，触发方式由单击改为双击（单击紧邻标题栏易误触）。
//
// 注意：index_cecep.vue / index_legacy.vue 看似无人引用，但 permission.js 用
// import.meta.glob('./../../views/**/*.vue') + loadView() 按后端菜单的 component 字符串激活，
// 它们会被打进产物、也可能随时被菜单启用，所以三个大屏文件必须遵守同一套约定。
import test from 'node:test'
import assert from 'node:assert/strict'
import { readFileSync, readdirSync } from 'node:fs'
import { fileURLToPath } from 'node:url'
import { dirname, join, relative } from 'node:path'

const here = dirname(fileURLToPath(import.meta.url))
const srcRoot = join(here, '..')

/** 统一用 / 分隔，避免 Windows 下反斜杠导致路径断言不稳定。 */
const relPath = (file) => relative(srcRoot, file).split('\\').join('/')

// ==================== 展示文案格式 ====================

// 构建期常量由 vite define 注入，node 下需先装桩再导入
globalThis.__ECAT_APP_VERSION__ = '3.1.0'
const { appVersion, appVersionLabel } = await import('./appVersion.js')

test('原始版本号来自构建期注入', () => {
  assert.equal(appVersion, '3.1.0')
})

test('展示文案统一加 v 前缀', () => {
  assert.equal(appVersionLabel, 'v3.1.0')
})

test('版本号本身已带 v/V 前缀时不重复添加', async () => {
  globalThis.__ECAT_APP_VERSION__ = 'V3.1.0'
  const m = await import('./appVersion.js?v-upper')
  assert.equal(m.appVersionLabel, 'v3.1.0', '大写 V 应被规范化为小写 v 且不重复')
})

test('未注入版本号时展示为空串（由调用方决定如何降级，不得填假版本）', async () => {
  delete globalThis.__ECAT_APP_VERSION__
  const m = await import('./appVersion.js?v-empty')
  assert.equal(m.appVersion, '')
  assert.equal(m.appVersionLabel, '')
})

// ==================== 通用工具 ====================

/** 递归收集 .vue 文件（只扫真正会被编译的扩展名，.vue.bak / .vue.list 这类备份不算）。 */
function collectVueFiles(dir) {
  const out = []
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const full = join(dir, entry.name)
    if (entry.isDirectory()) {
      if (entry.name === 'node_modules' || entry.name === 'dist') continue
      out.push(...collectVueFiles(full))
    } else if (entry.name.endsWith('.vue')) {
      out.push(full)
    }
  }
  return out
}

const vueFiles = collectVueFiles(srcRoot)

/** 大屏首页系列：可被后端菜单 loadView 激活的三个变体。 */
const bigScreenFiles = vueFiles.filter((f) => /[\\/]views[\\/]index(_cecep|_legacy)?\.vue$/.test(f))

/** 取 .nav_item_alarm 热区的起始标签（含全部绑定属性）。 */
function alarmHotspotTag(src) {
  const m = src.match(/<div[^>]*class="nav_item_alarm"[^>]*>/)
  return m ? m[0] : ''
}

test('大屏首页系列齐全（守卫覆盖面自检）', () => {
  assert.deepEqual(
    bigScreenFiles.map(relPath).sort(),
    ['views/index.vue', 'views/index_cecep.vue', 'views/index_legacy.vue'],
    '大屏首页文件集合变了（新增/删除变体）。守卫需同步覆盖，否则漏网文件会重新把版本号写回硬编码',
  )
})

// ==================== 版本号：单一展示点 ====================

// 需求：导航栏在任何页面都展示版本号，大屏右上角不再重复，避免两边不一致。
test('大屏不重复展示版本号（模板与样式都不得再出现 version-number）', () => {
  const offenders = bigScreenFiles.filter((f) => /version-number/.test(readFileSync(f, 'utf8')))
  assert.deepEqual(
    offenders.map(relPath),
    [],
    '以下大屏文件又出现了 version-number（模板或样式），会与导航栏重复展示版本号',
  )
})

test('大屏不得出现硬编码的版本号字面量', () => {
  const offenders = []
  for (const file of bigScreenFiles) {
    const hit = readFileSync(file, 'utf8').match(/V\d+\.\d+(\.\d+)?/)
    if (hit) offenders.push(`${relPath(file)} → "${hit[0]}"`)
  }
  assert.deepEqual(offenders, [], `版本号必须由 @/utils/appVersion 单一来源提供：\n  ${offenders.join('\n  ')}`)
})

test('导航栏是版本号的唯一展示点（兜底防线）', () => {
  const navbar = readFileSync(join(srcRoot, 'layout', 'components', 'Navbar.vue'), 'utf8')
  assert.match(navbar, /from '@\/utils\/appVersion'/, '导航栏应从 @/utils/appVersion 取版本号')
  assert.match(navbar, /appVersionLabel/, '导航栏应展示 appVersionLabel')
  assert.match(navbar, /version-badge/, '导航栏应保留版本号徽标容器')
})

// ==================== 隐性功能保护：报警开关热区 ====================

// 用户关注点：报警开关是"隐性功能"，靠大屏右上角一块区域触发。
// 撤掉版本号后热区没了文字，于是三条约束变得关键：
//   a) 必须绑 @dblclick 而非 @click —— 紧邻标题栏，单击极易误触；
//   b) 热区不能依赖文字撑开，必须自带固定尺寸，否则会塌陷成不可点；
//   c) 模板里引用的方法名必须真实存在 —— Vue 模板写错方法名不会构建报错，只会静默失效。
test('三个大屏的报警热区都绑 @dblclick，且不再绑 @click（防误触）', () => {
  for (const file of bigScreenFiles) {
    const rel = relPath(file)
    const tag = alarmHotspotTag(readFileSync(file, 'utf8'))
    assert.ok(tag, `${rel}: 未找到 .nav_item_alarm 热区；守卫需随模板调整同步更新`)
    assert.match(tag, /@dblclick="handleAlarmToggle"/, `${rel}: 报警开关应绑 @dblclick="handleAlarmToggle"`)
    assert.ok(!/@click=/.test(tag), `${rel}: 热区不得绑 @click —— 单击紧邻标题栏极易误触`)
    assert.ok(!/v-if/.test(tag), `${rel}: 热区不得加 v-if，隐藏会一并切断报警开关入口`)
  }
})

test('报警热区是纯空白热区（版本号已撤走，不得再挂回文字）', () => {
  for (const file of bigScreenFiles) {
    const rel = relPath(file)
    assert.match(
      readFileSync(file, 'utf8'),
      /<div[^>]*class="nav_item_alarm"[^>]*><\/div>/,
      `${rel}: 热区内应无内容；若确实要展示信息，请确认不违反"版本号只在导航栏展示"`,
    )
  }
})

test('handleAlarmToggle 真实存在且切换 alarmOpen（防方法名写错静默失效）', () => {
  for (const file of bigScreenFiles) {
    const rel = relPath(file)
    const src = readFileSync(file, 'utf8')
    const referenced = (alarmHotspotTag(src).match(/@dblclick="(\w+)"/) || [])[1]
    assert.ok(referenced, `${rel}: 未能从模板解析出 @dblclick 处理函数名`)
    assert.match(
      src,
      new RegExp(`${referenced}\\s*\\(\\s*\\)\\s*\\{`),
      `${rel}: 模板引用了 ${referenced}，但该方法未定义（Vue 会静默失效）`,
    )
    assert.match(src, /this\.alarmOpen\s*=\s*!this\.alarmOpen/, `${rel}: ${referenced} 必须切换 alarmOpen`)
    assert.match(src, /alarmOpen\s*:\s*false/, `${rel}: alarmOpen 初始状态应存在`)
  }
})

test('报警热区脱离文字后仍有固定尺寸与手型光标，且位于右上角', () => {
  for (const file of bigScreenFiles) {
    const rel = relPath(file)
    const src = readFileSync(file, 'utf8')

    const css = src.match(/\.nav_item_alarm\s*\{[\s\S]*?\n\}/)
    assert.ok(css, `${rel}: 未找到 .nav_item_alarm 样式；守卫需随样式调整同步更新`)
    assert.match(css[0], /width\s*:\s*\d+px/, `${rel}: 热区应有显式宽度，否则失去文字后塌陷为不可点`)
    assert.match(css[0], /height\s*:\s*\d+px/, `${rel}: 热区应有显式高度，否则失去文字后塌陷为不可点`)
    assert.match(css[0], /cursor\s*:\s*pointer/, `${rel}: 热区应保留手型光标作为唯一可交互提示`)

    const nav = src.match(/\.nav\s*\{[\s\S]*?\n\}/)
    assert.ok(nav, `${rel}: 未找到 .nav 样式`)
    assert.match(nav[0], /position\s*:\s*absolute/, `${rel}: .nav 应绝对定位`)
    assert.match(nav[0], /right\s*:\s*\d+px/, `${rel}: 热区应位于右上角（.nav 需贴右）`)
  }
})
