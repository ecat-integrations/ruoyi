<template>
  <div class="task-step-list">
    <div v-if="steps.length === 0" class="steps-empty">
      <i class="EditPen"></i>
      <p>暂无任务步骤，请点击上方按钮添加</p>
    </div>

    <div v-else class="steps-container">
      <TaskStepItem
        v-for="(step, index) in steps"
        :key="step.id"
        :step="step"
        :index="index"
        :device-data="deviceData"
        :current-exec-step="currentExecStep"
        :is-running="isRunning"
        @update:step="handleStepUpdate(index, $event)"
        @delete="handleStepDelete(index)"
        @move-up="handleStepMoveUp(index)"
        @move-down="handleStepMoveDown(index)"
        @device-change="handleDeviceChange($event)"
        @type-change="handleTypeChange($event)"
      />
    </div>
  </div>
</template>

<script setup>
import TaskStepItem from './TaskStepItem.vue'

const props = defineProps({
  steps: {
    type: Array,
    default: () => []
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

const emit = defineEmits([
  'update:steps',
  'step-delete',
  'step-move-up',
  'step-move-down',
  'device-change',
  'type-change'
])

function handleStepUpdate(index, newStep) {
  const updatedSteps = [...props.steps]
  updatedSteps[index] = newStep
  emit('update:steps', updatedSteps)
}

function handleStepDelete(index) {
  emit('step-delete', index)
}

function handleStepMoveUp(index) {
  emit('step-move-up', index)
}

function handleStepMoveDown(index) {
  emit('step-move-down', index)
}

function handleDeviceChange(step) {
  emit('device-change', step)
}

function handleTypeChange(step) {
  emit('type-change', step)
}
</script>

<style scoped>
.task-step-list {
  margin-bottom: 16px;
}

.steps-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
  background-color: var(--el-bg-color-page, #f5f7fa);
  border: 1px dashed var(--el-border-color, #dcdfe6);
  border-radius: 6px;
  color: var(--el-text-color-placeholder, #c0c4cc);
}

.steps-empty i {
  font-size: 48px;
  margin-bottom: 12px;
}

.steps-empty p {
  font-size: 14px;
  margin: 0;
}

.steps-container {
  max-height: 500px;
  overflow-y: auto;
  padding-right: 8px;
}

/* 滚动条样式 */
.steps-container::-webkit-scrollbar {
  width: 6px;
}

.steps-container::-webkit-scrollbar-thumb {
  background-color: var(--el-border-color-darker, #dcdfe6);
  border-radius: 3px;
}

.steps-container::-webkit-scrollbar-track {
  background-color: transparent;
}
</style>
