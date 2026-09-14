import { defineConfig, loadEnv } from 'vite'
import fs from 'fs'
import path from 'path'
import createVitePlugins from './vite/plugins'

const baseUrl = 'http://localhost:8080' // 后端接口

/**
 * 解析界面头部展示的版本号，优先级：
 *   1. 环境变量 VITE_APP_VERSION（可在 .env.* 或命令行临时覆盖）
 *   2. 核心版本 ecat.core.version（自动读取上级 pom.xml，升级核心后前端无需改动）
 *   3. package.json 的 version（兜底）
 * 常规情况下只需在 pom.xml 中维护 ecat.core.version 即可。
 */
function resolveAppVersion(env) {
  const fromEnv = env.VITE_APP_VERSION && env.VITE_APP_VERSION.trim()
  if (fromEnv) return fromEnv
  try {
    const pom = fs.readFileSync(path.resolve(__dirname, '../pom.xml'), 'utf-8')
    const matched = pom.match(/<ecat\.core\.version>\s*([^<\s]+)\s*<\/ecat\.core\.version>/)
    if (matched && matched[1]) return matched[1]
  } catch (e) {
    // 仅前端目录打包（未包含后端源码）时读不到 pom，忽略即可
  }
  try {
    const pkg = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'package.json'), 'utf-8'))
    if (pkg.version) return pkg.version
  } catch (e) {
    // 忽略解析失败
  }
  return ''
}

// https://vitejs.dev/config/
export default defineConfig(({ mode, command }) => {
  const env = loadEnv(mode, process.cwd())
  const { VITE_APP_ENV } = env
  const appVersion = resolveAppVersion(env)
  return {
    // 注入到前端的版本号（见 src/utils/appVersion.js）
    define: {
      __ECAT_APP_VERSION__: JSON.stringify(appVersion)
    },
    // 部署生产环境和开发环境下的URL。
    // 默认情况下，vite 会假设你的应用是被部署在一个域名的根路径上
    // 例如 https://www.ruoyi.vip/。如果应用被部署在一个子路径上，你就需要用这个选项指定这个子路径。例如，如果你的应用被部署在 https://www.ruoyi.vip/admin/，则设置 baseUrl 为 /admin/。
    base: VITE_APP_ENV === 'production' ? '/' : '/',
    plugins: createVitePlugins(env, command === 'build'),
    resolve: {
      // https://cn.vitejs.dev/config/#resolve-alias
      alias: {
        // 设置路径
        '~': path.resolve(__dirname, './'),
        // 设置别名
        '@': path.resolve(__dirname, './src')
      },
      // https://cn.vitejs.dev/config/#resolve-extensions
      extensions: ['.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue']
    },
    // 打包配置
    build: {
      // https://vite.dev/config/build-options.html
      sourcemap: command === 'build' ? false : 'inline',
      outDir: 'dist',
      assetsDir: 'assets',
      chunkSizeWarningLimit: 2000,
      rollupOptions: {
        output: {
          chunkFileNames: 'static/js/[name]-[hash].js',
          entryFileNames: 'static/js/[name]-[hash].js',
          assetFileNames: 'static/[ext]/[name]-[hash].[ext]'
        }
      }
    },
    // vite 相关配置
    server: {
      port: 80,
      host: true,
      open: true,
      proxy: {
        // https://cn.vitejs.dev/config/#server-proxy
        '/dev-api': {
          target: baseUrl,
          changeOrigin: true,
          rewrite: (p) => p.replace(/^\/dev-api/, '')
        },
         // springdoc proxy
         '^/v3/api-docs/(.*)': {
          target: baseUrl,
          changeOrigin: true,
        }
      }
    },
    //fix:error:stdin>:7356:1: warning: "@charset" must be the first rule in the file
    css: {
      postcss: {
        plugins: [
          {
            postcssPlugin: 'internal:charset-removal',
            AtRule: {
              charset: (atRule) => {
                if (atRule.name === 'charset') {
                  atRule.remove();
                }
              }
            }
          }
        ]
      }
    }
  }
})
