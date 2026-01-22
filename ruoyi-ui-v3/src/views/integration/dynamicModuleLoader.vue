<template>
  <div class="app-container">
    <h1>动态模块加载器</h1>
    <div>
      <input v-model="moduleName" placeholder="输入模块名称" />
      <button @click="loadModules">加载模块</button>
      <button @click="createVueComponent">测试组件</button>
      <button @click="createVueRoute">测试路由</button>
    </div>
    <div v-if="loading">正在加载模块...</div>
    <div v-if="error">{{ error }}</div>
    <el-dialog v-model="dialogVisible" :title="dynamicComponentName">
      <component :is="dynamicComponent" v-if="dynamicComponent" />
      <template #footer>
        <el-button @click="dialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>
    <component :is="dynamicComponent" v-if="dynamicComponent" />
  </div>
</template>

<!-- 
 * page for manually dynamic module loader testing
 * 
 * !!! load my-springboot integtration module first to test

 * @author coffee
 * -->

<script setup>
import Layout from '@/layout';
import { loadDynamicIntegration, getComponentByName } from '@/router';
import usePermissionStore from '@/store/modules/permission';
import ll from '@/views/integration/dynamicModuleLoader.vue';

// 定义响应式数据
const moduleName = ref('integration-my-springboot');
const loading = ref(false);
const dialogVisible = ref(false);
const error = ref('');
const dynamicComponent = shallowRef(null);
const dynamicComponentName = ref('');

// 加载模块的方法
const loadModules = async () => {
  if (!moduleName.value) {
    error.value = '请输入模块名称';
    return;
  }

  loading.value = true;
  error.value = '';
  dynamicComponent.value = null;

  try {
    const integration = await loadDynamicIntegration(moduleName.value);
    const entryRoute = integration.getModuleTypeEntryRoute('device_register');
    loading.value = false;
    error.value = '';

    if (entryRoute) {
      dynamicComponent.value = entryRoute.component;
      dynamicComponentName.value = entryRoute.name;
      dialogVisible.value = true;
    } else {
      error.value = '模块加载成功，但未找到device_register组件';
    }
  } catch (err) {
    loading.value = false;
    error.value = '加载模块失败: ' + (err.message || err.toString());
  }

};

// 创建 Vue 组件的方法
const createVueComponent = () => {
  dynamicComponent.value = 'AuthRole';
  dialogVisible.value = true;
};

// 创建 Vue 路由的方法, 当前在新路由刷新页面后会导致页面404，是因为路由没有提前准备好，具体办法参考router/index.js
// https://zhuanlan.zhihu.com/p/627915735
const createVueRoute = () => {
  let newroute = [
    {
      path: '/test',
      component: Layout,
      hidden: false,
      redirect: 'noredirect',
      children: [
        {
          path: 'integration',
          component: ll,
          name: 'testdynamicModuleLoader',
          meta: { title: '组件加载测试', icon: 'dashboard' }
        }
      ]
    }
  ];
  const permissionStore = usePermissionStore();
  permissionStore.dynamicAddRoutes({ newRoutes: newroute, insertIndex: null });
};
</script>

<style scoped>
/* 添加一些简单的样式 */
input {
  padding: 8px;
  margin-right: 8px;
}
button {
  padding: 8px 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
button:hover {
  background-color: #45a049;
}
</style>    