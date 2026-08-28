/**
 * 把菜单管理里 ecat-sync 行的 visible / status / orderNum 套到 vue-module 路由上。
 * 与若依 getRouters 一致：visible=1 → route.hidden；status=1 → 不进入侧边栏；
 * order_num 决定同级顺序，并与原 sys_menu 路由合并排序。
 *
 * 前端路由 name 为 `{integration}_{routeName}`，业务键为
 * ecat-sync:{integration}/{module}/{routeName}。
 */

export function applyEcatMenuDisplay(routes, integrationName, flags, moduleName) {
  if (!routes || !routes.length) {
    return []
  }
  const result = []
  for (const route of routes) {
    const module = moduleName || parseModuleName(integrationName, route.path)
    const key = module
      ? `ecat-sync:${integrationName}/${module}/${originalRouteName(route.name, integrationName)}`
      : null
    const flag = key && flags ? flags[key] : null
    if (flag && isDisabled(flag.status)) {
      continue
    }
    const next = { ...route }
    if (flag) {
      next.hidden = isHidden(flag.visible)
      if (hasOrder(flag.orderNum)) {
        next.orderNum = Number(flag.orderNum)
      }
    }
    if (Array.isArray(next.children) && next.children.length) {
      next.children = applyEcatMenuDisplay(next.children, integrationName, flags, module)
    }
    result.push(next)
  }
  return sortRoutesByOrderNum(result)
}

/**
 * 按 sys_menu.order_num 排序同级路由；缺省时保持原数组下标，避免打乱未带序号的项。
 */
export function sortRoutesByOrderNum(routes) {
  if (!Array.isArray(routes) || routes.length === 0) {
    return routes
  }
  const decorated = routes.map((route, index) => ({
    route,
    index,
    order: hasOrder(route && route.orderNum) ? Number(route.orderNum) : index
  }))
  decorated.sort((a, b) => {
    if (a.order !== b.order) {
      return a.order - b.order
    }
    return a.index - b.index
  })
  return decorated.map(({ route }) => {
    if (Array.isArray(route.children) && route.children.length) {
      route.children = sortRoutesByOrderNum(route.children)
    }
    return route
  })
}

export function originalRouteName(routeName, integrationName) {
  if (!routeName) {
    return 'unnamed'
  }
  const prefix = integrationName + '_'
  return routeName.startsWith(prefix) ? routeName.slice(prefix.length) : String(routeName)
}

export function parseModuleName(integrationName, path) {
  if (!path || !integrationName) {
    return null
  }
  const needle = `/ecat-integrations/${integrationName}/`
  const idx = String(path).indexOf(needle)
  if (idx < 0) {
    return null
  }
  const rest = String(path).slice(idx + needle.length)
  const moduleName = rest.split('/').filter(Boolean)[0]
  return moduleName || null
}

function isHidden(visible) {
  return String(visible == null ? '0' : visible).trim() === '1'
}

function isDisabled(status) {
  return String(status == null ? '0' : status).trim() === '1'
}

function hasOrder(value) {
  if (value == null || value === '') {
    return false
  }
  return !Number.isNaN(Number(value))
}
