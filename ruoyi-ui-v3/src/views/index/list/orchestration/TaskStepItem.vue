<template>
  <div
    class="task-step-item"
    :class="{
      'step-executing': isExecuting,
      'step-disabled': disabled
    }"
  >
    <div class="step-header">
      <div class="step-number">
        <span
          class="step-indicator"
          :class="{ 'step-active': isExecuting }"
        >
          {{ index + 1 }}
        </span>
        <span class="step-type-label">
          {{ stepTypeLabel }}
        </span>
      </div>

      <div class="step-actions">
        <el-button
          :disabled="disabled"
          size="small"
          text
          @click="emit('move-up')"
        >
          <i class="ArrowUp"></i>
        </el-button>
        <el-button
          :disabled="disabled"
          size="small"
          text
          @click="emit('move-down')"
        >
          <i class="ArrowDown"></i>
        </el-button>
        <el-button
          :disabled="disabled"
          size="small"
          text
          type="danger"
          @click="emit('delete')"
        >
          <i class="Delete"></i>
        </el-button>
      </div>
    </div>

    <div class="step-content">
      <!-- 步骤类型选择 -->
      <div class="form-item">
        <label class="form-label">步骤类型</label>
        <el-select
          :model-value="step.type"
          :disabled="disabled"
          @change="handleTypeChange"
        >
          <el-option label="设备操作" value="device" />
          <el-option label="延迟等待" value="delay" />
        </el-select>
      </div>

      <!-- 设备操作步骤配置 -->
      <template v-if="step.type === 'device'">
        <div class="form-item">
          <label class="form-label">选择设备</label>
          <el-select
            :model-value="step.deviceId"
            :disabled="disabled"
            placeholder="请选择设备"
            @change="handleDeviceIdChange"
          >
            <el-option
              v-for="device in deviceData"
              :key="device.deviceId"
              :label="device.deviceName"
              :value="device.deviceId"
            />
          </el-select>
        </div>

        <div class="form-item">
          <label class="form-label">选择属性</label>
          <el-select
            :model-value="step.attributeId"
            :disabled="disabled || !step.deviceId"
            placeholder="请选择属性"
            @change="handleAttributeIdChange"
          >
            <el-option
              v-for="attr in deviceAttributes"
              :key="attr.attributeID"
              :label="attr.displayName"
              :value="attr.attributeID"
            />
          </el-select>
        </div>

        <div class="form-item">
          <label class="form-label">输入新值</label>
          <el-skeleton v-if="loadingScheme" :rows="1" animated />
          <AttributeInput
            v-else-if="attributeScheme"
            v-model="step.targetValue"
            :scheme="attributeScheme.scheme"
          />
          <el-input
            v-else
            :model-value="step.targetValue"
            :disabled="disabled || !step.attributeId"
            placeholder="请输入目标值"
            @input="handleTargetValueChange"
          />
        </div>

        <div class="form-item current-value-row">
          <label class="form-label">当前值</label>
          <span class="current-value-text">{{ currentValue }}</span>
        </div>
      </template>

      <!-- 延迟等待步骤配置 -->
      <template v-else-if="step.type === 'delay'">
        <div class="form-item">
          <label class="form-label">延迟时间（秒）</label>
          <el-input-number
            :model-value="step.delayTime"
            :disabled="disabled"
            :min="1"
            :max="3600"
            :step="1"
            @change="handleDelayTimeChange"
          />
        </div>
      </template>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue'
import AttributeInput from './components/AttributeInput.vue'
import { getAttributeScheme } from '@/api/deviceAttribute'

const props = defineProps({
  step: {
    type: Object,
    required: true
  },
  index: {
    type: Number,
    required: true
  },
  deviceData: {
    type: Array,
    default: () => []
  },
  currentExecStep: {
    type: Number,
    default: -1
  },
  isRunning: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:step', 'delete', 'move-up', 'move-down', 'device-change', 'type-change'])

// 属性scheme加载状态
const loadingScheme = ref(false)
const attributeScheme = ref(null)

// 计算是否正在执行此步骤
const isExecuting = computed(() => props.currentExecStep === props.index)

// 计算是否禁用编辑
const disabled = computed(() => props.isRunning)

// 计算步骤类型标签
const stepTypeLabel = computed(() => {
  return props.step.type === 'device' ? '设备操作' : '延迟等待'
})

// 获取设备属性列表
const deviceAttributes = computed(() => {
  if (!props.step.deviceId) return []
  const device = props.deviceData.find(d => d.deviceId === props.step.deviceId)
  return device?.deviceAttrs.filter(attr => attr.valueChangeable === true) || []
})

// 获取属性当前值
const currentValue = computed(() => {
  if (!props.step.deviceId || !props.step.attributeId) return '-'
  const device = props.deviceData.find(d => d.deviceId === props.step.deviceId)
  if (!device) return '-'

  const attr = device.deviceAttrs.find(a => a.attributeID === props.step.attributeId)
  if (!attr) return '-'

  const value = attr.displayValue ?? ''
  const unit = attr.displayUnit || ''
  return unit ? `${value} ${unit}` : value
})

// 加载属性scheme
async function loadAttributeScheme() {
  if (!props.step.deviceId || !props.step.attributeId) {
    attributeScheme.value = null
    return
  }

  loadingScheme.value = true
  try {
    const res = await getAttributeScheme(props.step.deviceId, props.step.attributeId)
    if (res.code === 200) {
      attributeScheme.value = res.data
    }
  } catch (error) {
    console.error('Failed to load attribute scheme:', error)
    attributeScheme.value = null
  } finally {
    loadingScheme.value = false
  }
}

// 监听设备和属性变化，重新加载scheme
watch(() => [props.step.deviceId, props.step.attributeId], () => {
  loadAttributeScheme()
}, { immediate: true })

// 事件处理 - 通过 emit 更新父组件
function handleTypeChange(value) {
  const updatedStep = { ...props.step, type: value }
  if (value === 'device') {
    updatedStep.delayTime = 2
  } else {
    updatedStep.deviceId = ''
    updatedStep.attributeId = ''
    updatedStep.targetValue = ''
  }
  emit('update:step', updatedStep)
  emit('type-change', updatedStep)
}

function handleDeviceIdChange(value) {
  const updatedStep = {
    ...props.step,
    deviceId: value,
    attributeId: '',
    targetValue: ''
  }
  emit('update:step', updatedStep)
  emit('device-change', updatedStep)
}

function handleAttributeIdChange(value) {
  // 切换属性时清空目标值，避免类型不匹配
  emit('update:step', { ...props.step, attributeId: value, targetValue: '' })
}

function handleTargetValueChange(value) {
  emit('update:step', { ...props.step, targetValue: value })
}

function handleDelayTimeChange(value) {
  emit('update:step', { ...props.step, delayTime: value })
}
</script>

<style scoped>
.task-step-item {
  border: 1px solid var(--el-border-color-light, #ebeef5);
  border-radius: 6px;
  margin-bottom: 12px;
  transition: all 0.3s ease;
  background-color: var(--el-bg-color, #fff);
}

.task-step-item:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.task-step-item.step-executing {
  border-color: #409eff;
  box-shadow: 0 0 12px rgba(64, 158, 255, 0.3);
}

.task-step-item.step-disabled {
  opacity: 0.7;
}

.step-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  border-bottom: 1px solid var(--el-border-color-lighter, #ebeef5);
  background-color: var(--el-bg-color-page, #f5f7fa);
  border-radius: 6px 6px 0 0;
}

.step-number {
  display: flex;
  align-items: center;
  gap: 10px;
}

.step-indicator {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background-color: var(--el-fill-color-light, #f5f7fa);
  border: 2px solid var(--el-border-color, #dcdfe6);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 13px;
  color: var(--el-text-color-regular, #606266);
  transition: all 0.3s ease;
}

.step-indicator.step-active {
  background-color: #409eff;
  border-color: #409eff;
  color: #fff;
  animation: pulse 1.5s infinite;
}

@keyframes pulse {
  0%, 100% {
    box-shadow: 0 0 0 0 rgba(64, 158, 255, 0.4);
  }
  50% {
    box-shadow: 0 0 0 8px rgba(64, 158, 255, 0);
  }
}

.step-type-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--el-text-color-primary, #303133);
}

.step-actions {
  display: flex;
  gap: 4px;
}

.step-content {
  padding: 16px;
}

.form-item {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
}

.form-item:last-child {
  margin-bottom: 0;
}

.form-label {
  width: 120px;
  font-size: 13px;
  color: var(--el-text-color-regular, #606266);
  flex-shrink: 0;
}

.form-item .el-select,
.form-item .el-input,
.form-item .el-input-number,
.form-item > .attribute-input {
  flex: 1;
}

.current-value-row .current-value-text {
  font-size: 13px;
  color: var(--el-text-color-regular, #606266);
}
</style>
