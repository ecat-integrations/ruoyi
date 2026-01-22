<template>
  <el-dialog
    v-model="dialogVisible"
    title="设备控制任务编排"
    :width="'80%'"
    :before-close="handleBeforeClose"
    :close-on-click-modal="false"
    destroy-on-close
  >
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
        @step-move-up="moveStep"
        @step-move-down="moveStep"
        @device-change="handleDeviceChange"
        @type-change="handleStepTypeChange"
      />

      <!-- 执行日志 -->
      <ExecutionLog
        :logs="executionLogs"
        @clear="executionLogs = []"
      />
    </div>

    <template #footer>
      <span class="dialog-footer">
        <el-button @click="handleClose">关闭</el-button>
      </span>
    </template>
  </el-dialog>

  <!-- 新增任务输入框弹窗 -->
  <el-dialog
    v-model="addTaskDialogVisible"
    title="新增任务"
    width="400px"
    :before-close="handleCloseAddDialog"
  >
    <el-form :model="addTaskForm" :rules="addTaskRules" ref="addTaskFormRef">
      <el-form-item label="任务名称" prop="name">
        <el-input
          v-model="addTaskForm.name"
          placeholder="请输入任务名称"
          maxlength="50"
          show-word-limit
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="addTaskDialogVisible = false">取消</el-button>
      <el-button type="primary" @click="confirmAddTask">确定</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
/**
 * OrchestrationModal - 设备控制任务编排弹窗
 * 提供任务步骤编辑、执行、保存/加载功能
 */

import { ref, computed, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import TaskControls from './TaskControls.vue'
import TaskStepList from './TaskStepList.vue'
import ExecutionLog from './ExecutionLog.vue'
import { useTaskOrchestration } from '../composables/useTaskOrchestration'
import { exportTask } from './importExport/exportTask'
import { importTask } from './importExport/importTask'

// ==================== Props 和 Emits ====================
const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  deviceData: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['update:modelValue'])

// ==================== 弹窗状态 ====================
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
})

// ==================== 使用任务编排逻辑 ====================
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
  toggleTaskExecution
} = useTaskOrchestration(props)

// ==================== 新增任务弹窗状态 ====================
const addTaskDialogVisible = ref(false)
const addTaskForm = ref({ name: '' })
const addTaskFormRef = ref(null)

// 文件输入相关
const fileInputRef = ref(null)

// 表单验证规则
const addTaskRules = {
  name: [
    { required: true, message: '请输入任务名称', trigger: 'blur' },
    { min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur' }
  ]
}

// ==================== 事件处理函数 ====================
/**
 * 弹窗关闭前确认
 */
function handleBeforeClose(done) {
  if (isTaskRunning.value) {
    ElMessage.warning('请先停止任务执行再关闭窗口')
    return
  }
  done()
}

/**
 * 关闭弹窗
 */
function handleClose() {
  if (isTaskRunning.value) {
    ElMessage.warning('请先停止任务执行再关闭窗口')
    return
  }
  dialogVisible.value = false
}

/**
 * 切换任务执行状态
 */
function toggleExecution() {
  toggleTaskExecution()
}

/**
 * 新增任务 - 打开输入框弹窗
 */
function handleAddNewTask() {
  addTaskForm.value.name = ''
  addTaskDialogVisible.value = true
}

/**
 * 确认新增任务
 */
async function confirmAddTask() {
  try {
    await addTaskFormRef.value.validate()
    const success = saveAsNewTask(addTaskForm.value.name)
    if (success) {
      addTaskDialogVisible.value = false
    }
  } catch (error) {
    console.log('Validation failed:', error)
  }
}

/**
 * 关闭新增任务弹窗
 */
function handleCloseAddDialog() {
  addTaskForm.value.name = ''
  addTaskDialogVisible.value = false
}

/**
 * 更新当前任务
 */
async function handleUpdateTask() {
  await updateCurrentTask()
}

/**
 * 加载指定任务
 */
function handleLoadTask(taskId) {
  loadTask(taskId)
}

/**
 * 删除任务
 */
async function handleDeleteTask(taskId) {
  await deleteTask(taskId)
}

/**
 * 清空任务步骤
 */
async function handleClear() {
  await clearTask()
}

/**
 * 导出任务
 */
async function handleExport() {
  try {
    await exportTask(savedTasks.value)
  } catch (error) {
    console.error('Export failed:', error)
  }
}

/**
 * 触发文件输入框
 */
function triggerFileInput() {
  fileInputRef.value?.click()
}

/**
 * 处理文件选择变化
 */
async function handleFileChange(event) {
  const file = event.target.files?.[0]
  if (!file) return

  // 重置文件输入，允许重复选择同一文件
  event.target.value = ''

  try {
    const result = await importTask(file, savedTasks.value)

    if (!result || !result.tasks) {
      return
    }

    const { tasks, duplicateInfo } = result

    if (duplicateInfo.hasDuplicates) {
      // 有重名任务，显示确认对话框
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
        // 用户选择覆盖
        importTasks(tasks, 'overwrite')
      } catch (action) {
        if (action === 'cancel') {
          // 用户选择不覆盖（只导入不重名的）
          importTasks(tasks, 'skip')
        }
        // action === 'close' 表示点击了关闭按钮，不做任何操作
      }
    } else {
      // 没有重名，直接导入
      importTasks(tasks, 'skip')
    }
  } catch (error) {
    console.error('Import failed:', error)
  }
}

// ==================== 监听弹窗状态 ====================
watch(dialogVisible, (newVal) => {
  if (!newVal && !isTaskRunning.value) {
    // 弹窗关闭且任务未运行时，保留状态以便用户下次继续编辑
  }
})
</script>

<style scoped>
.orchestration-container {
  padding: 8px 0;
}

.step-operations {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
  padding: 16px;
  background-color: var(--el-bg-color-page, #f5f7fa);
  border-radius: 6px;
}

.step-operations .el-button {
  flex: 1;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
}
</style>
