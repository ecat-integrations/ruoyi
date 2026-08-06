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
        <p class="hint">点击右上角「设置视图ID」输入视图 ID，将嵌入全域控制视图页面（control 控制模式）进行展示</p>
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

    <el-dialog v-model="idDialogVisible" title="设置视图ID" width="420px" :close-on-click-modal="false">
      <el-form label-width="90px" @submit.prevent>
        <el-form-item label="视图ID" required>
          <el-input
            v-model="inputId"
            placeholder="请输入视图 ID（如 AK05Y1）"
            maxlength="10"
            clearable
            @keyup.enter="confirmId"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="idDialogVisible = false">取 消</el-button>
        <el-button type="primary" :disabled="!inputId.trim()" @click="confirmId">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { Back, Setting, FullScreen, Close, WarningFilled } from '@element-plus/icons-vue'
import router from '@/router'

const emit = defineEmits(['return-to-list'])

/** 视图 ID：设置后通过 iframe 嵌入 diagram_view 全域控制视图页（control 控制模式） */
const STORAGE_KEY = 'station-preview-diagram-id'
const diagramId = ref(localStorage.getItem(STORAGE_KEY) || '')
const idDialogVisible = ref(false)
const inputId = ref('')
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
  inputId.value = diagramId.value
  idDialogVisible.value = true
}

function confirmId() {
  const id = inputId.value.trim()
  if (!id) return
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
