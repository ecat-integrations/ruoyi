<template>
  <div class="station-preview-wrapper">
    <div class="preview-header">
      <div class="header-left">
        <el-button 
          type="primary" 
          @click="handleReturnToList"
          class="back-btn"
        >
          <el-icon><Back /></el-icon>
          返回列表页
        </el-button>
        <h2 class="page-title">全域控制视图</h2>
        <el-button type="success" plain @click="openIdDialog" class="set-id-btn">
          <el-icon style="margin-right: 4px;"><Setting /></el-icon>
          设置视图ID
        </el-button>
        <el-button
          type="primary"
          plain
          :disabled="!diagramId"
          class="fullscreen-btn"
          @click="enterFullscreen"
        >
          <el-icon style="margin-right: 4px;"><FullScreen /></el-icon>
          全屏
        </el-button>
        <el-tag v-if="diagramId" type="primary" effect="plain">{{ diagramId }}</el-tag>
      </div>
    </div>
    <div class="preview-content">
      <!-- 全域控制视图集成未加载提示（v-if / v-else-if / v-else 必须紧邻，中间不能插入其他元素） -->
      <div v-if="integrationUnavailable" class="preview-placeholder integration-error">
        <el-icon class="integration-error-icon" :size="48"><WarningFilled /></el-icon>
        <p class="integration-error-title">全域控制视图集成未加载</p>
        <p class="hint">未检测到全域控制视图集成（integration-env-diagram），请确认后端集成模块已加载后重试</p>
        <el-button type="primary" plain @click="retryLoad" class="integration-error-btn">
          重新加载
        </el-button>
      </div>
      <iframe
        v-else-if="diagramId"
        ref="iframeRef"
        :key="iframeKey"
        :src="iframeSrc"
        :class="['diagram-frame', { 'is-fullscreen': isFullscreen }]"
        frameborder="0"
        @load="onIframeLoad"
      ></iframe>
      <div v-else class="preview-placeholder">
        <p>未设置视图 ID</p>
        <p class="hint">视图加载依赖「全域智控视图」集成功能：请到「全域智控视图管理」中创建对应视图并复制视图 ID，再点击右上角「设置视图ID」填入，本页面即自动加载该视图进行展示；留空则保持当前提示状态。</p>
      </div>
    </div>

    <el-button
      v-if="isFullscreen"
      type="danger"
      class="exit-fullscreen-btn"
      @click="exitFullscreen"
    >
      <el-icon style="margin-right: 4px;"><Close /></el-icon>
      退出全屏
    </el-button>

    <el-dialog v-model="idDialogVisible" title="设置视图ID" width="460px" :close-on-click-modal="false">
      <el-alert type="info" :closable="false" show-icon class="id-dialog-alert">
        视图加载依赖「全域智控视图」集成功能：请到「全域智控视图管理」中创建对应视图，复制视图 ID 后填入，本页面即自动加载该视图进行展示；清空视图 ID 并确定，则关闭本页面的视图加载功能。
      </el-alert>
      <el-form label-width="90px" @submit.prevent>
        <el-form-item label="视图ID">
          <el-select
            v-model="inputId"
            filterable
            allow-create
            default-first-option
            clearable
            placeholder="可下拉选择已有视图，或直接输入视图 ID（如 AK05Y1）"
            style="width: 100%"
          >
            <el-option
              v-for="item in diagramOptions"
              :key="item.id"
              :value="item.id"
              :label="item.description ? `${item.id}（${item.description}）` : item.id"
            >
              <span class="opt-id">{{ item.id }}</span>
              <span class="opt-desc">{{ item.description || '无描述' }}</span>
            </el-option>
          </el-select>
          <div class="form-item-hint">留空并点击确定，即关闭本页面的视图加载功能</div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="idDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmId">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { Back, Setting, FullScreen, Close, WarningFilled } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import router from '@/router'

const emit = defineEmits(['return-to-list'])

/** 视图 ID：设置后通过 iframe 嵌入 diagram_view 全域控制视图页（control 控制模式） */
const STORAGE_KEY = 'station-preview-diagram-id'
/** 全域视图管理记录缓存 key（与 env-diagram diagramStore.js 共用，宿主与 iframe 同源可直接读取） */
const DIAGRAM_RECORDS_KEY = 'ecat-diagram-records'
const diagramId = ref(localStorage.getItem(STORAGE_KEY) || '')
const idDialogVisible = ref(false)
const inputId = ref('')
/** 全域视图管理中的已有视图列表（下拉选项：{ id, description }） */
const diagramOptions = ref([])
/** iframe 刷新用 key：设置 ID 后自增，强制重建 iframe 重新加载 */
const iframeKey = ref(0)
/** 全屏状态：iframe 以 fixed 覆盖整个视口，支持原生 Fullscreen API 增强 */
const isFullscreen = ref(false)
/** 全域控制视图集成未加载（iframe 目标地址不存在或集成路由未注册）提示标志 */
const integrationUnavailable = ref(false)
/** iframe 元素引用：加载完成后用于检查内部是否落到 404 页 */
const iframeRef = ref(null)
/** iframe 内部 404 轮询检测：iframe 内 ruoyi 应用初始化需要时间，404 页出现较晚，故轮询 */
const IFRAME_CHECK_INTERVAL = 500
const IFRAME_CHECK_MAX = 20
let iframeCheckTimer = null
let iframeCheckCount = 0

/** 预览页路由地址（hash 路由；diagram_view_full 为不挂 Layout 的独立路由，iframe 内不显示 ruoyi 套壳） */
const VIEW_PATH = '/ecat-integrations/integration-env-diagram/diagram-manager/diagram_view_full'

const iframeSrc = computed(() => {
  const base = window.location.origin + window.location.pathname
  return `${base}#${VIEW_PATH}?diagramId=${encodeURIComponent(diagramId.value)}`
})

function openIdDialog() {
  loadDiagramOptions()
  inputId.value = diagramId.value
  idDialogVisible.value = true
}

/**
 * 读取全域视图管理中的已有视图列表（与 env-diagram diagramStore.js 共用 localStorage）
 * 每次打开弹窗时重新读取，保证能拿到最新创建的视图
 */
function loadDiagramOptions() {
  try {
    const list = JSON.parse(localStorage.getItem(DIAGRAM_RECORDS_KEY) || '[]')
    diagramOptions.value = Array.isArray(list) ? list : []
  } catch (e) {
    console.warn('[station-preview] 读取视图列表失败:', e)
    diagramOptions.value = []
  }
}

function confirmId() {
  const id = inputId.value.trim()
  // 视图 ID 留空：视为关闭视图加载功能，清空本地缓存并退出视图加载（iframe 随 v-else-if 自动移除）
  if (!id) {
    localStorage.removeItem(STORAGE_KEY)
    diagramId.value = ''
    integrationUnavailable.value = false
    iframeKey.value++
    idDialogVisible.value = false
    return
  }
  // 校验视图 ID 是否存在于全域视图管理中：不存在则提示并阻止提交
  if (!diagramOptions.value.some((item) => item.id === id)) {
    ElMessage.error(`视图 ID「${id}」不存在，请先在「全域智控视图管理」中创建对应视图`)
    return
  }
  diagramId.value = id
  // 保存到前端缓存，下次打开自动带出，重新设置即覆盖
  localStorage.setItem(STORAGE_KEY, id)
  // 重新设置时重置集成未加载提示，并按当前路由注册情况决定是否直接提示
  integrationUnavailable.value = false
  if (diagramId.value && !checkIntegrationReady()) {
    integrationUnavailable.value = true
  }
  // key 自增强制重建 iframe，确保重新设置（含相同 ID）后立即刷新加载新页面
  iframeKey.value++
  idDialogVisible.value = false
}

/** 进入全屏：CSS 覆盖视口 + 原生 Fullscreen API（支持时） */
function enterFullscreen() {
  if (!diagramId.value || integrationUnavailable.value) return
  isFullscreen.value = true
  // 通知 iframe 内部页面：全屏布局变化后延迟重新适配画布
  notifyIframeFitScreen()
  try {
    const el = document.documentElement
    if (el.requestFullscreen) {
      el.requestFullscreen().catch(() => {})
    } else if (el.webkitRequestFullscreen) {
      el.webkitRequestFullscreen()
    }
  } catch (e) {
    // 不支持原生全屏时，CSS 全屏仍然生效
  }
}

/** 退出全屏 */
function exitFullscreen() {
  isFullscreen.value = false
  // 通知 iframe 内部页面：退出全屏后布局变化，延迟重新适配画布
  notifyIframeFitScreen()
  try {
    if (document.fullscreenElement) {
      document.exitFullscreen()
    } else if (document.webkitExitFullscreen) {
      document.webkitExitFullscreen()
    }
  } catch (e) {
    // 忽略
  }
}

/**
 * 通知 iframe 内部页面重新适配画布（diagramView.vue 收到后延迟 2 秒执行 handle.fitScreen）
 * 宿主与 iframe 同源（同一 origin 的 hash 路由），直接 postMessage 即可
 */
function notifyIframeFitScreen() {
  const iframeWin = iframeRef.value && iframeRef.value.contentWindow
  if (!iframeWin) return
  try {
    iframeWin.postMessage(
      { type: 'diagram-view-fit-screen', source: 'station-preview' },
      window.location.origin
    )
  } catch (e) {
    // 跨域等异常时忽略，对方页面自身初始化时也会执行一次 fitScreen
  }
}

/** 监听浏览器原生全屏退出（按 Esc）同步状态 */
function onFullscreenChange() {
  if (!document.fullscreenElement) {
    isFullscreen.value = false
  }
}

/** 监听 Esc 键退出 CSS 全屏 */
function onKeydown(e) {
  if (e.key === 'Escape' && isFullscreen.value) {
    exitFullscreen()
  }
}

onMounted(() => {
  document.addEventListener('fullscreenchange', onFullscreenChange)
  document.addEventListener('keydown', onKeydown)
  // 主动检查：iframe 目标地址对应的全域控制视图集成路由是否已注册，未注册则直接提示
  if (diagramId.value && !checkIntegrationReady()) {
    integrationUnavailable.value = true
  }
})

onBeforeUnmount(() => {
  stopIframe404Check()
  document.removeEventListener('fullscreenchange', onFullscreenChange)
  document.removeEventListener('keydown', onKeydown)
})

/**
 * 主动检查全域控制视图集成路由是否已注册（宿主与 iframe 共用同一份集成列表，检查结果一致）
 */
function checkIntegrationReady() {
  return router.getRoutes().some(
    (route) => route.path === VIEW_PATH || route.name === 'integration-env-diagram_diagram_view_full'
  )
}

/**
 * iframe 加载完成：轮询检测 iframe 内部是否落到 ruoyi 404 页（地址不存在 / 集成未加载）
 */
function onIframeLoad() {
  stopIframe404Check()
  iframeCheckCount = 0
  iframeCheckTimer = setInterval(() => {
    iframeCheckCount++
    let is404 = false
    try {
      const doc = iframeRef.value && iframeRef.value.contentDocument
      const body = doc && doc.body
      is404 = !!(body && (
        body.querySelector('.wscn-http404') ||
        (body.innerText && body.innerText.indexOf('404错误') !== -1)
      ))
    } catch (e) {
      // 访问 iframe 内部异常时跳过本次检查
    }
    if (is404) {
      // 检测到 404：集成未加载或地址不存在，切换为提示状态
      integrationUnavailable.value = true
      stopIframe404Check()
      return
    }
    if (iframeCheckCount >= IFRAME_CHECK_MAX) {
      stopIframe404Check()
    }
  }, IFRAME_CHECK_INTERVAL)
}

/** 停止 iframe 内部 404 轮询检测 */
function stopIframe404Check() {
  if (iframeCheckTimer) {
    clearInterval(iframeCheckTimer)
    iframeCheckTimer = null
  }
}

/** 重新加载：清除提示并重建 iframe 重新尝试 */
function retryLoad() {
  integrationUnavailable.value = false
  if (diagramId.value && !checkIntegrationReady()) {
    integrationUnavailable.value = true
    return
  }
  iframeKey.value++
}

/**
 * 处理返回列表页
 */
const handleReturnToList = () => {
  emit('return-to-list')
}
</script>

<style scoped>
.station-preview-wrapper {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  background-color: var(--el-bg-color-page, #f5f7fa);
  transition: background-color 0.3s ease;
  overflow: hidden;
}
.preview-header {
  padding: 16px 20px;
  flex-shrink: 0;
  background-color: var(--el-bg-color, #fff);
  border-bottom: 1px solid var(--el-border-color-light, #ebeef5);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.back-btn {
  flex-shrink: 0;
}

.set-id-btn {
  flex-shrink: 0;
}

.page-title {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: var(--el-text-color-primary, #303133);
  transition: color 0.3s ease;
}

.preview-content {
  display: flex;
  flex-direction: column;
  align-items: stretch;
  flex: 1;
  width: 100%;
  overflow: hidden;
  box-sizing: border-box;
}

.diagram-frame {
  flex: 1;
  width: 100%;
  min-height: 0;
  border: none;
  background: #fff;
}

.fullscreen-btn {
  flex-shrink: 0;
}

/* 全屏态：fixed 覆盖整个视口，背景用白色保证内容清晰可见 */
.diagram-frame.is-fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 9999;
  background: #fff;
}

.exit-fullscreen-btn {
  position: fixed;
  top: 16px;
  left: 16px;
  z-index: 10000;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.preview-placeholder {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--el-text-color-regular, #606266);
  overflow: hidden;
}

.preview-placeholder p {
  margin: 16px 0 8px;
  font-size: 18px;
}

.preview-placeholder .hint {
  font-size: 14px;
  color: var(--el-text-color-secondary, #909399);
  max-width: 620px;
  text-align: center;
  line-height: 1.8;
  margin: 8px 16px;
}

.id-dialog-alert {
  margin-bottom: 16px;
  line-height: 1.8;
}

.form-item-hint {
  font-size: 12px;
  line-height: 1.6;
  color: var(--el-text-color-secondary, #909399);
  margin-top: 4px;
}

/* 下拉选项：左侧视图 ID 加粗，右侧描述灰色小字 */
.opt-id {
  font-weight: 600;
  margin-right: 10px;
}

.opt-desc {
  color: var(--el-text-color-secondary, #909399);
  font-size: 12px;
}

.integration-error-icon {
  color: var(--el-color-warning, #e6a23c);
  margin-bottom: 8px;
}

.integration-error-title {
  margin: 8px 0;
  font-size: 18px;
  font-weight: 600;
  color: var(--el-text-color-primary, #303133);
}

.integration-error-btn {
  margin-top: 16px;
}

@media (max-width: 768px) {
  .preview-header {
    padding: 12px 16px;
  }
  
  .page-title {
    font-size: 16px;
  }
}
</style>
