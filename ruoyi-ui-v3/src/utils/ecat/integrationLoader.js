import request from '@/utils/request'

/**
 * IntegrationLoader is a singleton class that loads integration modules dynamically for ecat integrations.
 * 
 * @author coffee
 */

class Integration {
  constructor(name) {
    this.name = name;
    this.moduleTypeDict = {}; // { [key: string]: { entry_route: {}, routes: {} } }
  }

  /**
   *
   * @param {*} moduleTypeDict
   * @description { [key: string]: { entry_route: {}, routes: {} } }
   * @returns {void}
   */
  updateModuleTypeDict(moduleTypeDict) {
    // 追加或者更新模块类型字典
    this.moduleTypeDict = { ...this.moduleTypeDict, ...moduleTypeDict };
  }

  /**
   *
   * @param {*} mtype 类型，枚举值
   * @returns {
                path: "/ecat-integrations/mock-springboot/moduleA/MockUserLogsList",
                name: "MockSpringboot_MockUserLogsList",
                component: () => import("./MockUserLogsList.vue"),
                entry: true
              }
   */
  getModuleTypeEntryRoute(mtype) {
    if(!this.moduleTypeDict[mtype]) {
      return null;
    }
    return this.moduleTypeDict[mtype]["entry_route"];
  }

}

class IntegrationRegistry {
  static instance;

  constructor() {
    if (!IntegrationRegistry.instance) {
      this.integrations = {}; // { [key: string]: Integration }
      IntegrationRegistry.instance = this;
    }
    return IntegrationRegistry.instance;
  }

  registerIntegration(name, integration) {
    this.integrations[name] = integration;
  }

  getIntegration(name) {
    return this.integrations[name];
  }
}

class IntegrationLoader {
  static instance;
  static registry = new IntegrationRegistry();

  constructor() {
    if (!IntegrationLoader.instance) {
      IntegrationLoader.instance = this;
    }
    return IntegrationLoader.instance;
  }

  async loadIntegration(integrationName, moduleList, app, router) {
    let integration = IntegrationLoader.registry.getIntegration(integrationName)

    // 仅加载未加载的模块
    if (!moduleList || moduleList.length === 0) {
      // console.warn(`No modules found for integration ${integrationName}.`);
      return null
    }
    // 检查moduleList中每个mtype是否已经加载过，仅加载未处理过的mtype

    let needModuleList = moduleList.filter(module => {
      let mtype = module.mtype;
      let entryRoute = integration && integration.getModuleTypeEntryRoute(mtype);
      if (entryRoute) {
        // console.warn(`Module ${mtype} already loaded for integration ${integrationName}.`);
        return false;
      }
      return true;
    });
    // 如果没有需要加载的模块，直接返回
    if (needModuleList.length === 0) {
      // console.warn(`No new modules found for integration ${integrationName}.`);
      return integration;
    }

    try {

      // 并行加载所有模块
      const promises = needModuleList.map(module => {
        return new Promise((resolve, reject) => {
          const script = document.createElement('script');
          script.src = import.meta.env.VITE_APP_BASE_API + module.url;
          script.onload = () => {
            // 动态获取模块名称
            const moduleName = module.name;
            // resolve(this[`__dynamicModule_${moduleName}`]);
            // delete this[`__dynamicModule_${moduleName}`];
            const dynamicModule = window[`__dynamicModule_${moduleName}`];
            resolve(dynamicModule);
          };
          script.onerror = (error) => {
            reject(error);
          };
          document.head.appendChild(script);
        });
      });

      // 等待所有模块加载完成
      const modules = await Promise.all(promises);

      let moduleTypeDict = {};
      try {
        moduleTypeDict = this.registerVueModules(modules, app, router);
      }
      catch (error) {
        console.error('Failed to register modules:', error);
        // 释放内容
        modules.forEach(module => {
          const moduleName = module.name;
          delete window[`__dynamicModule_${moduleName}`];
        });

        throw error;
      }

      if (!integration) {
        // 创建integration实例
        integration = new Integration(integrationName);
      }
      // integration绑定所有模块
      integration.updateModuleTypeDict(moduleTypeDict);
      // 注册integration
      IntegrationLoader.registry.registerIntegration(integrationName, integration);

      return integration;
    } catch (error) {
      console.error('Failed to load modules:', error);
      return [];
    }
  }

  registerVueModules(modules, app, router) {
    let moduleTypeDict = {};

    let utils = {
      "request": request,
    }


    let options = {
    }

    modules.forEach(module => {
      if (module && module.install) {
        // 将组件注册到app
        let moduleInfo = module.install(app, router, utils, options);
        // moduleInfo = {
        //   "mtype": "device_register",
        //   "name": "moduleA",
        //   "path": "/ecat-integrations/mock-springboot/moduleA",
        //   "routes": [{
        //     path: "/ecat-integrations/mock-springboot/moduleA/MockUserLogsList",
        //     name: "MockSpringboot_MockUserLogsList",
        //     component: () => import("./MockUserLogsList.vue"),
        //   }]
        // }

        // 默认entryComponentRoute为第一个路由
        let entryComponentRoute;
        if (moduleInfo.routes.length > 0) {
          entryComponentRoute = moduleInfo.routes[0];
          // integration已经确保了mtype不重复
          moduleTypeDict[moduleInfo.mtype] =
          {
            "entry_route": entryComponentRoute,
            "routes": moduleInfo.routes
          }
        }
        else {
          // 抛出异常
          throw new Error(`entry: true component not found in module ${moduleInfo.path}`);
        }
      }
    });

    return moduleTypeDict;
  }
}

const singletonRegistry = new IntegrationRegistry();
const singletonLoader = new IntegrationLoader();

export { singletonRegistry as IntegrationRegistry, singletonLoader as IntegrationLoader };
