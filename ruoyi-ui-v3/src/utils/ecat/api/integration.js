import request from '@/utils/request'
import { IntegrationLoader } from '@/utils/ecat/integrationLoader'

/**
 * integration api is a module that provides functions to interact with the backend API for ecat web integration: my-ruoyi.
 * 
 * @author coffee
 */

// 获取路由
export const getWebIntegrations = () => {
  return request({
    url: '/webintegration/list',
    method: 'get'
  })
}

export const getWebIntegrationModules = (query) => {
  // query:{
  //   integrationName: "integration-mock-ruoyi-gencode"
  // }
  return request({
    url: '/webintegration/module/list',
    method: 'get',
    params: query
  })
}

// 获取指定或全部的web集成模块路由
/*[
  {
      "integrationName1": [
          {
              "mtype": "web",
              "route": []
          },
          {
              "mtype": "device_register",
              "route": []
          }
      ]
  },
  {
      "integrationName2": [
          {
              "mtype": "web",
              "route": []
          },
          {
              "mtype": "device_register",
              "route": []
          }
      ]
  }
]
  */
export const getWebIntegrationModuleRouters = async (app, router, integrationNames = []) => {
  try {
    // 1. 获取所有集成配置
    const integrationsResponse = await getWebIntegrations();
    const allIntegrations = integrationsResponse.data || [];

    // 2. 筛选目标集成（空列表则取全部）
    const targetIntegrations = integrationNames.length === 0
      ? allIntegrations
      : allIntegrations.filter(integ => integrationNames.includes(integ.integrationName));

    const result = [];

    // 3. 遍历处理每个目标集成
    for (const integration of targetIntegrations) {
      const integrationResult = { [integration.integrationName]: [] };
      try {
        // 4. 获取当前集成的模块列表
        const modulesResponse = await getWebIntegrationModules({
          integrationName: integration.integrationName
        });
        const modules = modulesResponse.data || [];

        // 5. 按mtype分组模块（重点处理web和device_register）
        const modulesByType = modules.reduce((acc, module) => {
          const type = module.mtype;
          acc[type] = acc[type] || [];
          acc[type].push(module);
          return acc;
        }, {});

        // 6. 处理每种模块类型
        for (const [mtype, modulesOfType] of Object.entries(modulesByType)) {
          // 检测mtype是否在['web', 'device_register']中
          if (!['web', 'device_register'].includes(mtype)) {
            console.warn(`集成 ${integration.integrationName} 的模块类型 ${mtype} 不在处理范围内,跳过...`);
            continue;
          }
          let routes = [];
          const integrationInstance = await IntegrationLoader.loadIntegration(
            integration.integrationName,
            modulesOfType,
            app,
            router
          );
          routes = integrationInstance.moduleTypeDict[mtype]["routes"];

          // 7. 收集类型路由
          integrationResult[integration.integrationName].push({
            mtype,
            route: routes
          });
        }

      } catch (error) {
        console.warn(`集成 ${integration.integrationName} 处理失败:`, error);
        // integrationResult[integration.integrationName] = []; // 保留空数组标记异常
      }
      result.push(integrationResult);
    }

    return result;

  } catch (mainError) {
    console.error('获取集成模块路由整体失败:', mainError);
    return [];
  }
};

