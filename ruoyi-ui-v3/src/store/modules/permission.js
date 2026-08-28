import auth from '@/plugins/auth'
import router, { constantRoutes, dynamicRoutes } from '@/router'
import { getRouters } from '@/api/menu'
import Layout from '@/layout/index'
import ParentView from '@/components/ParentView'
import InnerLink from '@/layout/components/InnerLink'
import { app } from '@/main.js'
import { getWebIntegrationModuleRouters, getWebIntegrationMenuFlags } from '@/utils/ecat/api/integration'
import { applyEcatMenuDisplay, sortRoutesByOrderNum } from '@/utils/ecat/applyEcatMenuDisplay'

// 匹配views里面所有的.vue文件
const modules = import.meta.glob('./../../views/**/*.vue')

const usePermissionStore = defineStore(
  'permission',
  {
    state: () => ({
      routes: [],
      addRoutes: [],
      defaultRoutes: [],
      topbarRouters: [],
      sidebarRouters: []
    }),
    actions: {
      setRoutes(routes) {
        this.addRoutes = routes
        this.routes = constantRoutes.concat(routes)
      },
      setDefaultRoutes(routes) {
        this.defaultRoutes = constantRoutes.concat(routes)
      },
      setTopbarRoutes(routes) {
        this.topbarRouters = routes
      },
      setSidebarRouters(routes) {
        this.sidebarRouters = routes
      },
      updateRoutes(routes) {
        this.addRoutes = routes;
        this.routes = routes;
      },
      updateDefaultRoutes(routes) {
        this.defaultRoutes = routes;
      },
      updateTopbarRoutes(routes) {
        this.topbarRouters = routes;
      },
      updateSidebarRoutes([routes, insertIndex]) {
        if (!insertIndex) {
          this.sidebarRouters = this.sidebarRouters.concat(routes);
        } else {
          let arr = [...this.sidebarRouters];
          arr.splice(insertIndex, 0, ...routes);
          this.sidebarRouters = arr;
        }
      },
      removeSidebarRoute(routePath) {
        this.sidebarRouters = this.sidebarRouters.filter(
          (item) => item.path !== routePath
        );
      },
      generateRoutes(roles) {
        return new Promise(async (resolve) => {  // 改为 async 函数以支持 await
          try {
            // 1. 先获取后端基础路由
            const res = await getRouters();  // 原 getRouters 调用改为 await
            // const originalRoutes = JSON.parse(JSON.stringify(res.data));  // 保留原始数据副本

            // 2. 获取所有集成模块的 Web 路由，以及菜单管理中的显示/停用
            const [webIntegrationRoutes, flagsRes] = await Promise.all([
              getWebIntegrationModuleRouters(app, router, []),
              getWebIntegrationMenuFlags().catch(() => ({ data: {} }))
            ]);
            const menuFlags = flagsRes && flagsRes.data ? flagsRes.data : {};

            // 3. 从集成结果中提取所有 web 类型的路由，并套用 sys_menu.visible / status
            const extractedWebRoutes = webIntegrationRoutes.flatMap(integrationItem => {
              const [integrationName, moduleTypes] = Object.entries(integrationItem)[0];
              return moduleTypes
                .filter(typeItem => typeItem.mtype === 'web')  // 只筛选 web 类型模块
                .flatMap(typeItem => applyEcatMenuDisplay(typeItem.route || [], integrationName, menuFlags));
            });
            const permittedWebRoutes = filterIntegrationRoutes(extractedWebRoutes)

            // 4. 合并集成路由与后端原始路由，并按 sys_menu.order_num 排序
            const sdata = sortRoutesByOrderNum([...JSON.parse(JSON.stringify(res.data)), ...permittedWebRoutes])
            const rdata = sortRoutesByOrderNum([...JSON.parse(JSON.stringify(res.data)), ...permittedWebRoutes])
            const defaultData = sortRoutesByOrderNum([...JSON.parse(JSON.stringify(res.data)), ...permittedWebRoutes]);

            const sidebarRoutes = filterAsyncRouter(sdata);
            const rewriteRoutes = filterAsyncRouter(rdata, false, true);
            const defaultRoutes = filterAsyncRouter(defaultData);
            const asyncRoutes = filterDynamicRoutes(dynamicRoutes);

            asyncRoutes.forEach(route => { router.addRoute(route) });

            this.setRoutes(rewriteRoutes);
            this.setSidebarRouters(constantRoutes.concat(sidebarRoutes));
            this.setDefaultRoutes(sidebarRoutes);
            this.setTopbarRoutes(defaultRoutes);

            resolve(rewriteRoutes);

          } catch (error) {
            console.error('生成动态路由失败（含集成模块）:', error);
            // 保留原有逻辑（即使集成路由失败，仍返回后端路由）
            resolve(res.data);  // 或根据业务需求返回空数组
          }
        })
      },
      dynamicAddRoutes({ newRoutes, insertIndex }) {
        for (let route of newRoutes) {
          this.removeSidebarRoute(route.path);
          this.updateRoutes(this.routes.filter(curroute => curroute.path !== route.path));
          this.updateDefaultRoutes(this.defaultRoutes.filter(curroute => curroute.path !== route.path));
          this.updateTopbarRoutes(this.topbarRouters.filter(curroute => curroute.path !== route.path));
          if (!isRouteExists(router, route)) {
            router.addRoute(route);
          }
        }

        this.updateSidebarRoutes([newRoutes, insertIndex]);
        this.updateRoutes(this.routes.concat(newRoutes));
        this.updateDefaultRoutes(this.defaultRoutes.concat(newRoutes));
        this.updateTopbarRoutes(this.topbarRouters.concat(newRoutes));
      }
    }
  })

// 遍历后台传来的路由字符串，转换为组件对象
function filterAsyncRouter(asyncRouterMap, lastRouter = false, type = false) {
  return asyncRouterMap.filter(route => {
    if (type && route.children) {
      route.children = filterChildren(route.children)
    }
    if (route.component) {
      // Layout ParentView 组件特殊处理
      if (route.component === 'Layout') {
        route.component = Layout
      } else if (route.component === 'ParentView') {
        route.component = ParentView
      } else if (route.component === 'InnerLink') {
        route.component = InnerLink
      } else if (typeof route.component === 'string') {
        route.component = loadView(route.component)
      }
    }
    if (route.children != null && route.children && route.children.length) {
      route.children = filterAsyncRouter(route.children, route, type)
    } else {
      delete route['children']
      delete route['redirect']
    }
    return true
  })
}

function filterChildren(childrenMap, lastRouter = false) {
  var children = []
  childrenMap.forEach(el => {
    el.path = lastRouter ? lastRouter.path + '/' + el.path : el.path
    if (el.children && el.children.length && el.component === 'ParentView') {
      children = children.concat(filterChildren(el.children, el))
    } else {
      children.push(el)
    }
  })
  return children
}

// 检查路由是否存在,处理2级路由，再多集不适合
function isRouteExists(router, route) {
  const existingRoutes = router.getRoutes();
  return existingRoutes.some(existingRoute => {
    if (existingRoute.path === route.path) {
      if (route.children) {
        return route.children.every(childRoute => {
          return existingRoute.children && existingRoute.children.some(existingChildRoute => {
            return existingChildRoute.path === childRoute.path;
          });
        });
      }
      return true;
    }
    return false;
  });
}

// 动态路由遍历，验证是否具备权限
export function filterDynamicRoutes(routes) {
  const res = []
  routes.forEach(route => {
    if (route.permissions) {
      if (auth.hasPermiOr(route.permissions)) {
        res.push(route)
      }
    } else if (route.roles) {
      if (auth.hasRoleOr(route.roles)) {
        res.push(route)
      }
    }
  })
  return res
}

/**
 * 按用户权限过滤 ecat 集成路由。目录在仍有可见子路由时保留；未声明 permissions 的路由对已登录用户可见。
 */
export function filterIntegrationRoutes(routes) {
  if (!routes || !routes.length) {
    return []
  }
  const result = []
  for (const route of routes) {
    const hasChildDef = Array.isArray(route.children) && route.children.length > 0
    if (hasChildDef) {
      const children = filterIntegrationRoutes(route.children)
      if (children.length === 0) {
        continue
      }
      result.push({ ...route, children })
      continue
    }
    if (hasRoutePermission(route)) {
      result.push(route)
    }
  }
  return result
}

function hasRoutePermission(route) {
  const raw = route.permissions || (route.meta && route.meta.permissions)
  if (raw == null || (Array.isArray(raw) && raw.length === 0)) {
    return true
  }
  const list = Array.isArray(raw) ? raw : [raw]
  return auth.hasPermiOr(list)
}

export const loadView = (view) => {
  let res;
  for (const path in modules) {
    const dir = path.split('views/')[1].split('.vue')[0];
    if (dir === view) {
      res = () => modules[path]();
    }
  }
  return res
}

export default usePermissionStore
