import request from '@/utils/request'
import { IntegrationLoader as ecatLoader, IntegrationRegistry } from '@/utils/ecat/integrationLoader'

/**
 * IntegrationLoader is a singleton class that loads integration modules dynamically by using ecatLoader.
 * 
 * @author coffee
 */
class IntegrationLoader {
  static instance;
  static registry = IntegrationRegistry;

  constructor() {
    if (!IntegrationLoader.instance) {
      IntegrationLoader.instance = this;
    }
    return IntegrationLoader.instance;
  }

  async loadIntegration(integrationName, app, router) {
    try {
      // 从后端获取模块地址列表
      // const response = await axios.get(`/api/integrations/${integrationName}/modules`);
      // const moduleList = response.data;

      // ruoyi-ui v2 v3 demo
      const moduleList = [
        {
          "name": "moduleA",
          "mtype": "device_register",
          "url": "http://localhost/dev-api/ecat-integrations/integration-my-springboot/moduleA.js?_t=332" //测试环境的url+/dev-api
        },
        // {
        //   "name":"moduleB",
        //   "url":"/dev-api/ecat-integrations/mock-springboot/moduleB.js"
        // }
      ];

      // ruoyi-codegen demo
      // const moduleList = [
      //   {
      //     "name": "mock",
      //     "mtype": "device_register",
      //     "url": "http://localhost/dev-api/ecat-integrations/ecat-integrations-mock-ruoyi-gencode/mock.js?_t=332" //测试环境的url+/dev-api
      //   },
      //   // {
      //   //   "name":"moduleB",
      //   //   "url":"/dev-api/ecat-integrations/mock-springboot/moduleB.js"
      //   // }
      // ];

      return ecatLoader.loadIntegration(integrationName, moduleList, app, router);

    } catch (error) {
      console.error('Failed to load modules:', error);
      return [];
    }
  }
}

const singletonRegistry = IntegrationRegistry
const singletonLoader = new IntegrationLoader();

export { singletonRegistry as IntegrationRegistry, singletonLoader as IntegrationLoader };
