/**
 * 把菜单管理里 ecat-sync 行的 visible / status / orderNum / parent_id 套到 vue-module 路由上。
 * module-config.json 仍是默认树和组件来源；运行时侧边栏树以 sys_menu 为准。
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
    if (key) {
      next.ecatRemark = key
    }
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
 * 按 sys_menu.parent_id 把 ecat 路由挂到若依节点或其它 ecat 节点下。
 * 不修改传入的 ecatRoutes（组件函数需留给 vue-router 注册）。
 * 父节点停用/无权限时子节点一并丢弃，不提升到主类目。
 */
export function reparentEcatRoutes(nativeRoutes, ecatRoutes, flags) {
  const native = Array.isArray(nativeRoutes) ? nativeRoutes : []
  const ecat = Array.isArray(ecatRoutes) ? ecatRoutes : []
  if (!ecat.length) {
    return native
  }

  const items = []
  flattenEcatNodes(ecat, '', null, items)
  if (!items.length) {
    return native.concat(ecat)
  }

  const byRemark = {}
  for (const item of items) {
    const node = cloneRouteShallow(item.route)
    node.path = item.absPath || item.route.path
    node.children = []
    byRemark[item.remark || makeFallbackKey(item)] = { item, node }
  }

  const ecatTop = []
  for (const item of items) {
    const remark = item.remark || makeFallbackKey(item)
    const entry = byRemark[remark]
    if (!entry) {
      continue
    }
    const node = entry.node
    const flag = flags && remark && flags[remark] ? flags[remark] : {}
    const target = resolveParentTarget(flag, item, byRemark, native)
    if (target === 'drop') {
      continue
    }
    if (target === 'root' || !target) {
      ecatTop.push(node)
      continue
    }
    if (isDescendant(node, target)) {
      ecatTop.push(node)
      continue
    }
    attachChild(target, node)
  }

  return sortRoutesByOrderNum(pruneEmptyDirectories(native.concat(ecatTop)))
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

export function joinRoutePath(base, path) {
  if (path == null || path === '') {
    return base || ''
  }
  const raw = String(path)
  if (raw.startsWith('/') || isExternalPath(raw)) {
    return raw
  }
  if (!base) {
    return '/' + raw.replace(/^\/+/, '')
  }
  const prefix = String(base).replace(/\/+$/, '')
  return prefix + '/' + raw.replace(/^\/+/, '')
}

export function findRouteByMenuId(routes, menuId) {
  if (!routes || menuId == null || menuId === '') {
    return null
  }
  const want = String(menuId)
  for (const route of routes) {
    if (route && route.menuId != null && String(route.menuId) === want) {
      return route
    }
    const found = findRouteByMenuId(route && route.children, menuId)
    if (found) {
      return found
    }
  }
  return null
}

function flattenEcatNodes(routes, parentAbs, parentRemark, out) {
  if (!routes) {
    return
  }
  for (const route of routes) {
    const absPath = joinRoutePath(parentAbs, route.path)
    const remark = route.ecatRemark || null
    out.push({ route, remark, absPath, jsonParentRemark: parentRemark })
    if (Array.isArray(route.children) && route.children.length) {
      flattenEcatNodes(route.children, absPath, remark, out)
    }
  }
}

function cloneRouteShallow(route) {
  return { ...route }
}

function makeFallbackKey(item) {
  return item.absPath || String(item.route && item.route.name) || 'unnamed'
}

/**
 * @returns {'root'|'drop'|object} 挂载目标
 */
function resolveParentTarget(flag, item, byRemark, nativeRoutes) {
  const hasFlagParent = flag && flag.parentId != null && String(flag.parentId) !== ''
  if (!hasFlagParent) {
    if (item.jsonParentRemark && byRemark[item.jsonParentRemark]) {
      return byRemark[item.jsonParentRemark].node
    }
    return 'root'
  }
  const parentId = String(flag.parentId).trim()
  if (parentId === '0') {
    return 'root'
  }
  if (flag.parentRemark && byRemark[flag.parentRemark]) {
    return byRemark[flag.parentRemark].node
  }
  const nativeParent = findRouteByMenuId(nativeRoutes, parentId)
  if (nativeParent) {
    return nativeParent
  }
  return 'drop'
}

function attachChild(parent, child) {
  if (!parent.children) {
    parent.children = []
  }
  if (isLayoutLike(parent) && child.component === 'Layout') {
    child.component = 'ParentView'
  } else if (!isLayoutLike(parent) && child.component === 'Layout') {
    child.component = 'ParentView'
  }
  parent.children.push(child)
  parent.alwaysShow = true
  if (!parent.redirect) {
    parent.redirect = 'noRedirect'
  }
}

function isLayoutLike(route) {
  return route && (route.component === 'Layout' || route.component === 'ParentView')
}

function isDescendant(root, maybeChild) {
  if (!root || !maybeChild || !Array.isArray(root.children)) {
    return false
  }
  for (const child of root.children) {
    if (child === maybeChild || isDescendant(child, maybeChild)) {
      return true
    }
  }
  return false
}

function pruneEmptyDirectories(routes) {
  if (!Array.isArray(routes)) {
    return []
  }
  const kept = []
  for (const route of routes) {
    if (Array.isArray(route.children) && route.children.length) {
      route.children = pruneEmptyDirectories(route.children)
    }
    const hasChildren = Array.isArray(route.children) && route.children.length > 0
    if (isLayoutLike(route) && !hasChildren) {
      continue
    }
    kept.push(route)
  }
  return kept
}

function isExternalPath(path) {
  return typeof path === 'string' && /^(https?:|mailto:|tel:)/.test(path)
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
