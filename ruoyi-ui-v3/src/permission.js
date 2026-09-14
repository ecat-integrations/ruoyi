import router from './router'
import { ElMessage } from 'element-plus'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'
import { isHttp, isPathMatch } from '@/utils/validate'
import { isRelogin } from '@/utils/request'
import useUserStore from '@/store/modules/user'
import useSettingsStore from '@/store/modules/settings'
import usePermissionStore from '@/store/modules/permission'
import { DEFAULT_HOME_PATH } from '@/utils/homeRoute'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login', '/login_jiami', '/register']

const isWhiteList = (path) => {
  return whiteList.some(pattern => isPathMatch(pattern, path))
}

router.beforeEach((to, from, next) => {
  NProgress.start()
  if (getToken()) {
    to.meta.title && useSettingsStore().setTitle(to.meta.title)
    /* has token*/
    if (to.path === '/login') {
      // 已登录再访问登录页：交给根路径统一解析默认首页（需先完成动态路由注册）
      next({ path: '/' })
      NProgress.done()
    } else if (isWhiteList(to.path)) {
      next()
    } else {
      if (useUserStore().roles.length === 0) {
        isRelogin.show = true
        // 判断当前用户是否已拉取完user_info信息
        useUserStore().getInfo().then(() => {
          isRelogin.show = false
          return usePermissionStore().generateRoutes()
        }).then(accessRoutes => {
          // 根据roles权限生成可访问的路由表
          accessRoutes.forEach(route => {
            if (!isHttp(route.path)) {
              router.addRoute(route) // 动态添加可访问路由表
            }
          })
          // 动态路由（含集成模块）注册完成后，才能正确解析到集成首页
          goHomeOrContinue(to, next, true)
        }).catch(err => {
          useUserStore().logOut().then(() => {
            ElMessage.error(err)
            next({ path: '/' })
          })
        })
      } else {
        goHomeOrContinue(to, next, false)
      }
    }
  } else {
    // 没有token
    if (isWhiteList(to.path)) {
      // 在免登录白名单，直接进入
      next()
    } else {
      next(`/login?redirect=${to.fullPath}`) // 否则全部重定向到登录页
      NProgress.done()
    }
  }
})

/**
 * 解析（或复用）首页路径。必须在动态路由注册完成后调用，否则匹配不到集成首页。
 */
function resolveHome() {
  const store = usePermissionStore()
  if (!store.homePath) {
    store.resolveHomePath()
  }
  return store.homePath || DEFAULT_HOME_PATH
}

/**
 * 决定当前导航的落点。
 *
 * 「首页意图」= 访问根路径 `/` 或内置首页 `/index`：
 *   - `/`            是登录后的统一入口；
 *   - `/index`       是历史遗留的首页地址（侧边栏「首页」菜单、固定标签、面包屑、
 *                    以及各处硬编码的 router.push('/index') 都指向它）。
 * 两者在配置了 ecat.web.home 时都改道到该配置页，这样所有「首页」入口
 * 无需逐个改造就会指向真正的默认首页；未配置时 homePath 恒为 /index，
 * 因此不会产生自跳转，行为与改造前完全一致。
 *
 * @param {boolean} routesJustRegistered 是否刚完成动态路由注册（需重新导航以确保 addRoute 生效）
 */
function goHomeOrContinue(to, next, routesJustRegistered) {
  const isHomeIntent = to.path === '/' || to.path === DEFAULT_HOME_PATH
  if (isHomeIntent) {
    const homePath = resolveHome()
    // 仅在与目标不同时跳转，避免 未配置/解析降级 时出现自我重定向
    if (homePath !== to.path) {
      next({ path: homePath, replace: true })
      return
    }
  }
  if (routesJustRegistered) {
    next({ ...to, replace: true })
  } else {
    next()
  }
}

router.afterEach(() => {
  NProgress.done()
})
