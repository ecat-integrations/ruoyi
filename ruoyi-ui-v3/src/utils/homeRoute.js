/**
 * 首页路由解析。
 *
 * 目标：让「登录后默认打开哪个页面」成为一处可配置的决策，而不是散落在
 * router 静态 redirect / login.vue / permission.js / localStorage 里的多份逻辑。
 *
 * 解析优先级（只有一个来源，避免出现“第二套首页概念”）：
 *   1. 部署级配置 sys_config: ecat.web.home —— 显式配置且路由已注册时生效；
 *   2. 内置首页 /index —— 兜底。
 *
 * 刻意不读取 localStorage 的本机偏好：默认首页属于「这套部署」的决定，
 * 不应由某台浏览器上次的选择改变，否则会变成“同一份配置、不同人看到不同首页”。
 *
 * 候选路由未注册（未部署 / 当前用户无权限 / 路径写错）时自动降级到 /index，
 * 并打印告警，避免“配了没生效”这种无从排查的静默失败。
 *
 * 注意：集成模块路由是在 generateRoutes() 里动态 addRoute 的，因此本函数必须在
 * 动态路由注册完成后调用，否则集成首页永远匹配不到。
 */

export const DEFAULT_HOME_PATH = '/index'

/**
 * 归一化路由 path，便于比较（补前导斜杠、去掉末尾多余斜杠）。
 */
export function normalizeRoutePath(path) {
  if (path == null) {
    return ''
  }
  let normalized = String(path).trim()
  if (!normalized) {
    return ''
  }
  if (!normalized.startsWith('/')) {
    normalized = '/' + normalized
  }
  if (normalized.length > 1) {
    normalized = normalized.replace(/\/+$/, '')
  }
  return normalized
}

/**
 * 判断路由是否已注册到当前 router（含动态注入的集成路由）。
 */
export function isRouteRegistered(router, path) {
  const target = normalizeRoutePath(path)
  if (!target || !router || typeof router.getRoutes !== 'function') {
    return false
  }
  return router.getRoutes().some(route => normalizeRoutePath(route.path) === target)
}

/**
 * 解析首页路径。
 *
 * @param {object} router vue-router 实例
 * @param {string} configuredPath 部署级配置值（ecat.web.home），可为空
 * @returns {string} 已归一化且一定可用的首页路径
 */
export function resolveHomePath(router, configuredPath) {
  const configured = configuredPath == null ? '' : String(configuredPath).trim()
  if (!configured) {
    return DEFAULT_HOME_PATH
  }
  if (isRouteRegistered(router, configured)) {
    return normalizeRoutePath(configured)
  }
  // 配置了但不可用：降级 + 告警，避免静默失败难以排查
  console.warn(
    `[home] ecat.web.home 配置的首页「${configured}」未注册（未部署该模块或当前用户无权限），` +
    `已回退到 ${DEFAULT_HOME_PATH}`
  )
  return DEFAULT_HOME_PATH
}

/**
 * 从已注册路由中挑选「固定标签」对应的路由，即当前首页。
 *
 * 固定标签必须跟随首页，否则默认首页配成集成页面时，会出现
 * “关不掉的『首页』标签仍指向 /index”与真正落地页不一致的问题。
 *
 * 标题刻意取自目标路由自身的 meta.title（而非写死“首页”），
 * 这样标签名与实际展示的页面一致，也不会和路由首次写入标签时的标题打架。
 *
 * @param {Array} registeredRoutes router.getRoutes() 的结果
 * @param {string} homePath 已解析的首页路径，可为空
 * @returns {object|null} 形如 { fullPath, path, name, meta } 的标签；找不到可用路由时返回 null
 */
export function buildHomeTag(registeredRoutes, homePath) {
  const routes = Array.isArray(registeredRoutes) ? registeredRoutes : []
  const target = normalizeRoutePath(homePath) || DEFAULT_HOME_PATH
  const matched = routes.find(route => normalizeRoutePath(route.path) === target)
    || routes.find(route => normalizeRoutePath(route.path) === DEFAULT_HOME_PATH)
  if (!matched || !matched.name) {
    return null
  }
  const path = normalizeRoutePath(matched.path)
  return {
    fullPath: path,
    path,
    name: matched.name,
    // affix 只加在“标签对象”上（运行时语义），不再写死在路由 meta 里，避免出现第二个固定标签
    meta: { ...matched.meta, affix: true }
  }
}
