<template>
  <div class="orchestration-panel">
    <div class="orchestration-panel__body">
      <div class="orchestration-container">
        <!-- 任务控制栏 -->
        <TaskControls
          :task-steps="taskSteps"
          :is-task-running="isTaskRunning"
          :saved-tasks="savedTasks"
          :current-editing-task-id="currentEditingTaskId"
          @toggle-execution="toggleExecution"
          @add-new-task="handleAddNewTask"
          @update-task="handleUpdateTask"
          @clear="handleClear"
          @export="handleExport"
          @import="triggerFileInput"
          @load-task="handleLoadTask"
          @delete-task="handleDeleteTask"
        />

        <!-- 隐藏的文件输入元素 -->
        <input
          ref="fileInputRef"
          type="file"
          accept=".json"
          style="display: none"
          @change="handleFileChange"
        />

        <!-- 步骤操作按钮 -->
        <div class="step-operations">
          <el-button
            :disabled="isTaskRunning"
            icon="Plus"
            @click="addStep('device')"
          >
            添加设备操作
          </el-button>
          <el-button
            :disabled="isTaskRunning"
            icon="Clock"
            @click="addStep('delay')"
          >
            添加延迟等待
          </el-button>
        </div>

        <!-- 任务步骤列表 -->
        <TaskStepList
          v-model:steps="taskSteps"
          :device-data="deviceData"
          :current-exec-step="currentExecStep"
          :is-running="isTaskRunning"
          @step-delete="deleteStep"
          @step-move-up="(index) => moveStep(index, 'up')"
          @step-move-down="(index) => moveStep(index, 'down')"
          @device-change="handleDeviceChange"
          @type-change="handleStepTypeChange"
        />

        <!-- 执行日志 -->
        <ExecutionLog
          :logs="executionLogs"
          @clear="executionLogs = []"
        />
      </div>
    </div>

    <div class="orchestration-panel__footer">
      <el-button @click="handleClose">关闭</el-button>
    </div>

    <!-- 抽屉内浮层：新增任务 / 确认类提示 -->
    <div
      v-if="panelDialog"
      class="panel-dialog-overlay"
      @click.self="closePanelDialog"
    >
      <div
        class="panel-dialog-card"
        role="dialog"
        :aria-label="panelDialog.title"
      >
        <div class="panel-dialog-card__head">
          <span>{{ panelDialog.title }}</span>
          <el-button
            text
            circle
            icon="Close"
            title="关闭"
            @click="closePanelDialog"
          />
        </div>

        <div class="panel-dialog-card__body">
          <template v-if="panelDialog.mode === 'add-task'">
            <el-form
              ref="addTaskFormRef"
              :model="addTaskForm"
              :rules="addTaskRules"
              label-position="top"
              @submit.prevent
            >
              <el-form-item label="任务名称" prop="name">
                <el-input
                  v-model="addTaskForm.name"
                  placeholder="请输入任务名称"
                  maxlength="50"
                  show-word-limit
                  @keyup.enter="confirmAddTask"
                />
              </el-form-item>
            </el-form>
          </template>
          <template v-else>
            <p class="panel-dialog-message">{{ panelDialog.message }}</p>
          </template>
        </div>

        <div class="panel-dialog-card__footer">
          <el-button @click="closePanelDialog">
            {{ panelDialog.cancelText || '取消' }}
          </el-button>
          <el-button
            :type="panelDialog.confirmType || 'primary'"
            @click="confirmPanelDialog"
          >
            {{ panelDialog.confirmText || '确定' }}
          </el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
/**
 * OrchestrationModal - 设备控制任务编排面板
 * 提供任务步骤编辑、执行、保存/加载功能（侧边抽屉内展示）
 */

import { ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import TaskControls from './TaskControls.vue'
import TaskStepList from './TaskStepList.vue'
import ExecutionLog from './ExecutionLog.vue'
import { useTaskOrchestration } from '../composables/useTaskOrchestration'
import { exportTask } from './importExport/exportTask'
import { importTask } from './importExport/importTask'

const props = defineProps({
  deviceData: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['close'])

const {
  taskSteps,
  isTaskRunning,
  currentExecStep,
  executionLogs,
  savedTasks,
  currentEditingTaskId,
  addStep,
  deleteStep,
  moveStep,
  handleStepTypeChange,
  handleDeviceChange,
  saveAsNewTask,
  updateCurrentTask,
  loadTask,
  deleteTask,
  importTasks,
  clearTask,
  toggleTaskExecution,
  validateTaskSteps
} = useTaskOrchestration(props)

/** @type {import('vue').Ref<null | {
 *   mode: 'add-task' | 'confirm',
 *   title: string,
 *   message?: string,
 *   confirmText?: string,
 *   cancelText?: string,
 *   confirmType?: string,
 *   onConfirm?: () => void | Promise<void>
 * }>} */
const panelDialog = ref(null)
const addTaskForm = ref({ name: '' })
const addTaskFormRef = ref(null)
const fileInputRef = ref(null)

const addTaskRules = {
  name: [
    { required: true, message: '请输入任务名称', trigger: 'blur' },
    { min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur' }
  ]
}

function closePanelDialog() {
  panelDialog.value = null
}

async function confirmPanelDialog() {
  const dialog = panelDialog.value
  if (!dialog) return

  if (dialog.mode === 'add-task') {
    await confirmAddTask()
    return
  }

  const onConfirm = dialog.onConfirm
  closePanelDialog()
  if (typeof onConfirm === 'function') {
    await onConfirm()
  }
}

/** 尝试关闭面板；任务运行中时返回 false */
function tryClose() {
  if (isTaskRunning.value) {
    ElMessage.warning('请先停止任务执行再关闭')
    return false
  }
  return true
}

function handleClose() {
  if (!tryClose()) return
  emit('close')
}

function toggleExecution() {
  toggleTaskExecution()
}

function handleAddNewTask() {
  addTaskForm.value.name = ''
  panelDialog.value = {
    mode: 'add-task',
    title: '新增任务',
    confirmText: '确定'
  }
}

async function confirmAddTask() {
  try {
    await addTaskFormRef.value.validate()
    const success = saveAsNewTask(addTaskForm.value.name)
    if (success) {
      closePanelDialog()
    }
  } catch (error) {
    console.log('Validation failed:', error)
  }
}

function handleUpdateTask() {
  if (!currentEditingTaskId.value) return
  if (!validateTaskSteps()) return

  const task = savedTasks.value.find(t => t.id === currentEditingTaskId.value)
  if (!task) {
    ElMessage.error('当前任务不存在')
    return
  }

  panelDialog.value = {
    mode: 'confirm',
    title: '确认更新',
    message: `是否要覆盖任务「${task.name}」？`,
    confirmText: '确认',
    confirmType: 'warning',
    onConfirm: () => {
      updateCurrentTask()
    }
  }
}

function handleLoadTask(taskId) {
  loadTask(taskId)
}

async function handleDeleteTask(taskId) {
  await deleteTask(taskId)
}

function handleClear() {
  if (taskSteps.value.length === 0) return

  const message = currentEditingTaskId.value
    ? '当前正在编辑已有任务，确定要清空步骤吗？'
    : '确定要清空所有任务步骤吗？'

  panelDialog.value = {
    mode: 'confirm',
    title: '提示',
    message,
    confirmText: '确定',
    confirmType: 'warning',
    onConfirm: () => {
      clearTask()
    }
  }
}

async function handleExport() {
  try {
    await exportTask(savedTasks.value)
  } catch (error) {
    console.error('Export failed:', error)
  }
}

function triggerFileInput() {
  fileInputRef.value?.click()
}

async function handleFileChange(event) {
  const file = event.target.files?.[0]
  if (!file) return

  event.target.value = ''

  try {
    const result = await importTask(file, savedTasks.value)

    if (!result || !result.tasks) {
      return
    }

    const { tasks, duplicateInfo } = result

    if (duplicateInfo.hasDuplicates) {
      const duplicateNames = duplicateInfo.duplicateNames.join('、')
      try {
        await ElMessageBox.confirm(
          `导入的任务中有 ${duplicateInfo.duplicateCount} 个与本地任务重名：\n${duplicateNames}\n\n是否覆盖本地已有的任务？`,
          '任务重名提示',
          {
            confirmButtonText: '覆盖',
            cancelButtonText: '不覆盖',
            distinguishCancelAndClose: true,
            type: 'warning'
          }
        )
        importTasks(tasks, 'overwrite')
      } catch (action) {
        if (action === 'cancel') {
          importTasks(tasks, 'skip')
        }
      }
    } else {
      importTasks(tasks, 'skip')
    }
  } catch (error) {
    console.error('Import failed:', error)
  }
}

defineExpose({
  tryClose,
  isTaskRunning
})
</script>

<style scoped>
.orchestration-panel {
  position: relative;
  display: flex;
  flex-direction: column;
  height: 100%;
  min-height: 0;
}

.orchestration-panel__body {
  flex: 1;
  min-height: 0;
  overflow: auto;
  padding: 12px 16px 8px;
}

.orchestration-container {
  padding: 0;
}

.step-operations {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 20px;
  padding: 12px;
  background-color: var(--el-bg-color-page, #f5f7fa);
  border-radius: 6px;
}

.step-operations .el-button {
  flex: 1;
  min-width: 140px;
}

.orchestration-panel__footer {
  flex-shrink: 0;
  display: flex;
  justify-content: flex-end;
  padding: 10px 16px;
  border-top: 1px solid var(--el-border-color-lighter, #ebeef5);
  background: var(--el-bg-color, #fff);
}

.panel-dialog-overlay {
  position: absolute;
  inset: 0;
  z-index: 20;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding: 48px 20px 20px;
  background: rgba(15, 23, 42, 0.28);
}

.panel-dialog-card {
  width: 100%;
  max-width: 360px;
  border-radius: 10px;
  background: var(--el-bg-color, #fff);
  box-shadow: 0 12px 32px rgba(15, 23, 42, 0.18);
  overflow: hidden;
}

.panel-dialog-card__head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 14px 10px 16px;
  font-size: 15px;
  font-weight: 600;
  color: var(--el-text-color-primary, #303133);
  border-bottom: 1px solid var(--el-border-color-lighter, #ebeef5);
}

.panel-dialog-card__body {
  padding: 16px 16px 4px;
}

.panel-dialog-message {
  margin: 0;
  padding: 4px 0 12px;
  font-size: 14px;
  line-height: 1.6;
  color: var(--el-text-color-regular, #606266);
  white-space: pre-wrap;
}

.panel-dialog-card__footer {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding: 10px 16px 14px;
}
</style>
