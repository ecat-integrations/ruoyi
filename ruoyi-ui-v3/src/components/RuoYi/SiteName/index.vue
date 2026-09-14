<template>
  <div class="site-name" :class="{ 'is-editing': editing }">
    <el-input
      v-if="editing"
      ref="inputRef"
      v-model="draft"
      class="site-name-input"
      size="small"
      maxlength="30"
      :placeholder="placeholder"
      @keyup.enter="commit"
      @keyup.esc="cancel"
      @blur="commit"
    />
    <div v-else class="site-name-display" :title="displayTitle" @dblclick="startEdit">
      <span class="site-name-mark" aria-hidden="true">
        <span class="site-name-mark__antenna" />
        <span class="site-name-mark__body" />
        <span class="site-name-mark__pulse" />
      </span>
      <span class="site-name-text" :class="{ 'is-placeholder': !isSiteNameSet }">{{ siteName }}</span>
    </div>
  </div>
</template>

<script setup>
import { useSiteName } from '@/utils/siteName'

const { siteName, isSiteNameSet, setSiteName, placeholder } = useSiteName()

const editing = ref(false)
const draft = ref('')
const inputRef = ref(null)

/** 悬停提示：明确告知双击可编辑（未设置时措辞改为"设置"）。 */
const displayTitle = computed(() => (isSiteNameSet.value ? '双击修改站点名称' : '双击设置站点名称'))

function startEdit() {
  // 未设置时不预填占位提示词，否则用户得先删掉它才能输入
  draft.value = isSiteNameSet.value ? siteName.value : ''
  editing.value = true
  nextTick(() => {
    const input = inputRef.value
    if (input) {
      input.focus()
      input.select && input.select()
    }
  })
}

function commit() {
  if (!editing.value) {
    return
  }
  setSiteName(draft.value)
  editing.value = false
}

function cancel() {
  editing.value = false
}
</script>

<style lang='scss' scoped>
/* 独立定位，不复用 .right-menu-item，避免父级 display/padding 规则影响双击编辑 */
.site-name {
  display: flex;
  align-items: center;
  align-self: stretch;
  height: 100%;
  padding: 0 8px;
  color: var(--navbar-text);
}

.site-name-display {
  position: relative;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  max-width: 220px;
  padding: 4px 2px 6px;
  cursor: default;
  transition: opacity 0.25s ease;

  &::after {
    content: '';
    position: absolute;
    left: 22px;
    right: 2px;
    bottom: 0;
    height: 2px;
    border-radius: 2px;
    background: linear-gradient(
      90deg,
      color-mix(in srgb, var(--navbar-text) 55%, transparent) 0%,
      color-mix(in srgb, var(--navbar-text) 28%, transparent) 55%,
      transparent 100%
    );
    opacity: 0.7;
    transition: opacity 0.25s ease, transform 0.25s ease;
  }

  &:hover {
    .site-name-text {
      opacity: 1;
    }

    .site-name-mark {
      opacity: 0.95;
    }

    &::after {
      opacity: 0.95;
      transform: scaleX(1.02);
      transform-origin: left center;
    }

    .site-name-mark__pulse {
      opacity: 0.9;
    }
  }
}

.site-name-mark {
  position: relative;
  flex-shrink: 0;
  width: 16px;
  height: 16px;
  color: var(--navbar-text);
  opacity: 0.78;

  &__antenna {
    position: absolute;
    left: 50%;
    top: 1px;
    width: 2px;
    height: 6px;
    margin-left: -1px;
    border-radius: 1px;
    background: currentColor;
    opacity: 0.9;

    &::before,
    &::after {
      content: '';
      position: absolute;
      left: 50%;
      width: 6px;
      height: 6px;
      margin-left: -3px;
      border: 1.5px solid #0ea5e9;
      border-bottom-color: transparent;
      border-left-color: transparent;
      border-right-color: transparent;
      border-radius: 50%;
      opacity: 0.75;
    }

    &::before {
      top: -4px;
    }

    &::after {
      top: -7px;
      width: 10px;
      height: 10px;
      margin-left: -5px;
      opacity: 0.5;
    }
  }

  &__body {
    position: absolute;
    left: 2px;
    right: 2px;
    bottom: 0;
    height: 8px;
    border-radius: 2px 2px 1px 1px;
    background: color-mix(in srgb, var(--navbar-text) 18%, transparent);
    border: 1px solid color-mix(in srgb, var(--navbar-text) 55%, transparent);
    box-shadow: none;
  }

  /* 在线状态点恢复绿色呼吸灯 */
  &__pulse {
    position: absolute;
    right: -1px;
    top: 5px;
    width: 5px;
    height: 5px;
    border-radius: 50%;
    background: #22c55e;
    box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.45);
    opacity: 0.8;
    animation: site-name-pulse 2.2s ease-out infinite;
  }
}

.site-name-text {
  display: inline-block;
  max-width: 180px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 14px;
  font-weight: 600;
  letter-spacing: 0.5px;
  line-height: 1.2;
  opacity: 0.82;
  transition: opacity 0.25s ease;
}

/* 未设置态：把占位提示词渲染为"提示"而非"站点名"——降对比、减字重、斜体。
   选择器需带上 .site-name-display:hover 前缀：上面 &:hover 里 .site-name-text{opacity:1}
   特异度为 (0,3,0)，若只写 .site-name-text.is-placeholder (0,2,0) 会被盖过，
   导致一悬停提示态就消失、看起来像真已配置的名字。 */
.site-name-text.is-placeholder {
  font-weight: 500;
  font-style: italic;
  letter-spacing: 0.2px;
  opacity: 0.55;
}

.site-name-display:hover .site-name-text.is-placeholder {
  opacity: 0.8;
}

.site-name-input {
  width: 168px;

  :deep(.el-input__wrapper) {
    padding: 0 8px;
  }

  :deep(.el-input__inner) {
    font-size: 13px;
  }
}

@keyframes site-name-pulse {
  0% {
    box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.45);
  }
  70% {
    box-shadow: 0 0 0 6px rgba(34, 197, 94, 0);
  }
  100% {
    box-shadow: 0 0 0 0 rgba(34, 197, 94, 0);
  }
}

html.dark {
  .site-name-mark__antenna {
    &::before,
    &::after {
      border-top-color: #7dd3fc;
    }
  }
}
</style>
