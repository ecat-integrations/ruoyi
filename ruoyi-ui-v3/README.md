# 项目介绍
ecat-ruoyi 的前端项目

# 使用介绍

## 基于项目
https://github.com/yangzongzhuan/RuoYi-Vue3.git 7de94e2ea37803216e5afe9d40e7121c87a5344e 2025-04-24

## 前端运行

```bash
# 进入项目目录
cd ruoyi-ui-v3

# 安装依赖
yarn --registry=https://registry.npmmirror.com

# 启动服务
yarn dev

# 构建测试环境 yarn build:stage
# 构建生产环境 yarn build:prod
# 前端访问地址 http://localhost:8081
```

# 更新说明
## 20251224 优化首页list的状态，增强任务编排
### 依赖
- ecat-core: 20251224
- ecat-integrations/env-device-manager: 20251224



# 更新说明
## 2026-04-09 首页添加手动标识状态
后续扩展位置：
/src/views/index/list/utils/manualTagConfig.js
更改配置 MANUAL_TAG_CONFIG
```js
const MANUAL_TAG_CONFIG = {
    // XHN2000BV3 型号配置示例
    'XHN2000BV3': { //型号
        /**
        * 返回下拉选项(支持异步)
        * @param {object} device - 设备对象
        * @returns {Promise<Array<{label: string, value: string}>>}
        */
        getOptions: async (device) => {
            try {
            const res = await getAttributeScheme(device.deviceId, "nox_manual_status")
            console.log('XHN2000BV3 选项数据:', res.data.scheme.options)
        
                let options = res.data.scheme.options || []
                
                // 查找并修改"自动"选项为"正常状态"
                const autoIndex = options.findIndex(opt => opt.label === '自动' || opt.value === 'auto')
                if (autoIndex !== -1) {
                  // 修改名称
                  options[autoIndex].label = '正常状态'
                  
                  // 如果不在第一个位置,移到第一个
                  if (autoIndex !== 0) {
                    const autoOption = options.splice(autoIndex, 1)[0]
                    options.unshift(autoOption)
                  }
                }
                
                return options
              } catch (error) {
                console.error('获取 XHN2000BV3 选项失败:', error)
                return []
              }
        },
        
        /**
         * 确认后的处理逻辑
         * @param {object} device - 设备对象
         * @param {string} selectedValue - 选中的值
         * @returns {Promise<void>}
         */
        onConfirm: async (device, selectedValue) => {
          console.log('XHN2000BV3 设备手动标识:', {
            deviceId: device.deviceId,
            deviceName: device.deviceName,
            selectedValue
          })
          
          // 调用 deviceDebug API 设置属性值
          const result = await deviceDebug({
            deviceId: device.deviceId,
            attrId: "nox_manual_status",
            value: selectedValue
          })
          
          // 检查返回结果
          if (result.code === 200 && result.msg === '设备控制成功') {
            console.log('XHN2000BV3 标识设置成功')
          } else {
            // 抛出错误,让对话框显示失败原因
            throw new Error(result.msg || '设备控制失败')
          }
        }
    },
}
```
配置首页会生效，手动标识功能，点击后会弹窗
弹窗后操作：
选择标识下拉列表-选择状态-确认
逻辑：
打开弹窗→请求getOptions获取下拉选项→显示下拉列表→选择状态→点击确认→请求onConfirm设置标识
