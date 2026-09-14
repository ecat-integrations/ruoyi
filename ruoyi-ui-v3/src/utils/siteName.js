import { computed, ref } from 'vue'

/**
 * 头部站点名称。
 *
 * 设置入口：导航栏双击该名称就地编辑，写入 localStorage，刷新/重启后仍生效；
 * 清空即视为回到未设置（展示占位提示词），而不是把占位词当成真名存下来。
 */

const STORAGE_KEY = 'ecat-site-name'

/** 未设置时展示的占位提示词。注意它只是提示，不是站点名，不应写入 localStorage。 */
export const SITE_NAME_PLACEHOLDER = '请设置站点名称'

function readStored() {
  try {
    return String(localStorage.getItem(STORAGE_KEY) || '').trim()
  } catch (e) {
    return ''
  }
}

function writeStored(name) {
  try {
    if (name) {
      localStorage.setItem(STORAGE_KEY, name)
    } else {
      // 空值删除键，保持"从未设置"与"清空后未设置"两种状态一致
      localStorage.removeItem(STORAGE_KEY)
    }
  } catch (e) {
    // localStorage 不可用（隐私模式/被禁用）时仅当前会话生效
  }
}

/**
 * 用户实际设置的名称，未设置时为 ''。
 * 与 siteName（展示值）分开：组件需要据此判断"当前显示的是真名还是占位提示"，
 * 以决定是否套用提示态样式、以及进入编辑时是否预填内容。
 */
const storedSiteName = ref(readStored())

/** 界面展示值：已设置用真名，未设置回落到占位提示词。 */
const siteName = computed(() => storedSiteName.value || SITE_NAME_PLACEHOLDER)

/** 是否已由用户设置过（false 表示当前展示的是占位提示词）。 */
const isSiteNameSet = computed(() => !!storedSiteName.value)

export function useSiteName() {
  /** 设置名称；传空（或纯空白）表示清空，回到未设置态。返回规范化后的名称。 */
  function setSiteName(name) {
    const next = String(name == null ? '' : name).trim()
    storedSiteName.value = next
    writeStored(next)
    return next
  }

  /** 恢复为未设置（展示占位提示词）。 */
  function resetSiteName() {
    return setSiteName('')
  }

  return {
    siteName,
    isSiteNameSet,
    setSiteName,
    resetSiteName,
    placeholder: SITE_NAME_PLACEHOLDER,
  }
}
