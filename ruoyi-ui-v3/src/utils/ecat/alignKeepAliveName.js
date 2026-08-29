/**
 * 将集成页组件 name 对齐到路由 name，使 RuoYi <keep-alive :include="cachedViews"> 能命中缓存。
 *
 * cachedViews 存的是 route.name；keep-alive 匹配的是 component.name / __name。
 * 集成 UMD 页编译后 __name 来自文件名（如 hisdata），与带前缀的路由名
 * （如 integration-env-data-manager_hisdata）不一致，切页后会重建实例、查询条件丢失。
 */

const SHARED_LAYOUT_NAMES = new Set(['Layout', 'ParentView', 'InnerLink'])

export function alignKeepAliveName(routes) {
  if (!routes) return
  const list = Array.isArray(routes) ? routes : [routes]
  list.forEach(alignRouteKeepAliveName)
}

function alignRouteKeepAliveName(route) {
  if (!route) return
  if (route.children && route.children.length) {
    route.children.forEach(alignRouteKeepAliveName)
  }
  assignKeepAliveName(route)
}

function assignKeepAliveName(route) {
  const routeName = route.name
  const component = route.component
  if (!routeName || !component || typeof component !== 'object') return
  const compiledName = component.name || component.__name
  if (SHARED_LAYOUT_NAMES.has(compiledName)) return
  component.name = routeName
  component.__name = routeName
}
