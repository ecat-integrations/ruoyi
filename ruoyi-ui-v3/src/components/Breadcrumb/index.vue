<template>
  <el-breadcrumb class="app-breadcrumb" separator="/">
    <transition-group name="breadcrumb">
      <el-breadcrumb-item v-for="(item, index) in levelList" :key="item.path">
        <span v-if="item.redirect === 'noRedirect' || index == levelList.length - 1" class="no-redirect">{{ item.meta.title }}</span>
        <a v-else @click.prevent="handleLink(item)">{{ item.meta.title }}</a>
      </el-breadcrumb-item>
    </transition-group>
  </el-breadcrumb>
</template>

<script setup>
import usePermissionStore from '@/store/modules/permission'

const route = useRoute()
const router = useRouter()
const permissionStore = usePermissionStore()
const levelList = ref([])

function getBreadcrumb() {
  // 以 vue-router 实际匹配链为准：ecat 集成路由是
  // /ecat-integrations/xxx-yyy/... 这类含连字符的多段绝对路径，
  // 手工按 URL 文本切分再逐段比对会失配，导致面包屑退化成只剩「首页」。
  let matched = route.matched.filter((item) => item.meta && item.meta.title)
  // 兜底：动态路由尚未注册完成等极端场景，按菜单树整段路径前缀匹配
  if (matched.length === 0) {
    matched = matchRoutesByPath(route.path, permissionStore.defaultRoutes)
  }
  // 判断是否已在默认首页：是则不再前缀「首页」，否则补一个指向默认首页的入口
  if (!isHomeRoute()) {
    matched = [{ path: resolveHomeHref(), meta: { title: "首页" } }].concat(matched)
  }
  levelList.value = matched.filter(item => item.meta && item.meta.title && item.meta.breadcrumb !== false)
}

/** 当前解析出的默认首页路径（未配置时为 /index） */
function resolveHomeHref() {
  return normalizePath(permissionStore.homePath || '/index')
}

/** 当前路由是否就是默认首页 */
function isHomeRoute() {
  return normalizePath(route.path) === resolveHomeHref()
}

function handleLink(item) {
  const { redirect, path } = item
  if (redirect && redirect !== 'noRedirect') {
    router.push(redirect)
    return
  }
  router.push(path)
}

/** 去掉 query/hash 与结尾多余斜杠，便于整段比较 */
function normalizePath(path) {
  let result = String(path == null ? '' : path).split('?')[0].split('#')[0]
  if (result.length > 1) {
    result = result.replace(/\/+$/, '')
  }
  return result
}

/** 拼接父子路径，子路径为绝对路径时直接采用 */
function joinPath(base, path) {
  const raw = String(path == null ? '' : path)
  if (!raw) {
    return normalizePath(base)
  }
  if (raw.startsWith('/') || /^(https?:|mailto:|tel:)/.test(raw)) {
    return normalizePath(raw)
  }
  const prefix = String(base || '').replace(/\/+$/, '')
  return normalizePath((prefix || '') + '/' + raw.replace(/^\/+/, ''))
}

function escapeRegExp(text) {
  return String(text).replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
}

/** 单个路径段转正则，支持 :param(\\d+) 与 * 通配 */
function segmentToPattern(segment) {
  if (segment.startsWith(':')) {
    const open = segment.indexOf('(')
    if (open >= 0 && segment.endsWith(')')) {
      return '(' + segment.slice(open + 1, -1) + ')'
    }
    return '[^/]+'
  }
  if (segment === '*') {
    return '.*'
  }
  return escapeRegExp(segment)
}

/** 判断菜单节点路径是否为当前 URL 的祖先（含自身），支持动态段 */
function isPathPrefix(routeFullPath, targetPath) {
  const full = normalizePath(routeFullPath)
  if (!full) {
    return false
  }
  if (!full.includes(':') && !full.includes('*')) {
    return targetPath === full || targetPath.startsWith(full + '/')
  }
  const source = full.split('/').map((seg) => (seg ? segmentToPattern(seg) : '')).join('/')
  return new RegExp('^' + source + '(?:/|$)').test(targetPath)
}

/** 在菜单树中按整段路径前缀找出最深的一条可展示链路 */
function findChain(target, routes, basePath, ancestors) {
  let best = ancestors
  if (!Array.isArray(routes)) {
    return best
  }
  for (const node of routes) {
    if (!node) {
      continue
    }
    const full = joinPath(basePath, node.path)
    // path 为空字符串的布局容器（如 path: '' 包住 /index）本身不参与前缀判断，直接下钻
    if (full && !isPathPrefix(full, target)) {
      continue
    }
    const titled = node.meta && node.meta.title && node.meta.breadcrumb !== false
    const chain = titled ? ancestors.concat([{ ...node, path: full || basePath }]) : ancestors
    const deeper = findChain(target, node.children, full || basePath, chain)
    if (deeper.length >= best.length) {
      best = deeper
    }
  }
  return best
}

function matchRoutesByPath(path, routes) {
  return findChain(normalizePath(path), routes, '', [])
}

watchEffect(() => {
  // if you go to the redirect page, do not update the breadcrumbs
  if (route.path.startsWith('/redirect/')) {
    return
  }
  getBreadcrumb()
})
getBreadcrumb()
</script>

<style lang='scss' scoped>
.app-breadcrumb.el-breadcrumb {
  display: inline-block;
  font-size: 14px;
  line-height: 50px;
  margin-left: 8px;

  .no-redirect {
    color: #97a8be;
    cursor: text;
  }
}
</style>