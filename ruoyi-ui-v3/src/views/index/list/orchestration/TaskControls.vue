<template>
  <div class="task-controls">
    <!-- 控制按钮行 -->
    <div class="controls-row">
      <div class="controls-left">
        <el-button
          :type="isTaskRunning ? 'danger' : 'success'"
          :icon="isTaskRunning ? 'VideoPause' : 'VideoPlay'"
          @click="$emit('toggle-execution')"
        >
          {{ isTaskRunning ? '停止执行' : '开始执行' }}
        </el-button>

        <el-button
          icon="Plus"
          @click="$emit('add-new-task')"
        >
          新增任务
        </el-button>

        <el-button
          :disabled="!currentEditingTaskId"
          icon="Edit"
          type="warning"
          @click="$emit('update-task')"
        >
          更新任务
        </el-button>

        <el-button
          :disabled="taskSteps.length === 0"
          icon="Delete"
          @click="$emit('clear')"
        >
          清空步骤
        </el-button>
      </div>

      <div class="controls-right">
        <el-dropdown split-button type="primary" @click="$emit('export')">
          导出
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item @click="$emit('import')">
                <i class="Upload"></i>
                导入任务
              </el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </div>

    <!-- 已保存任务列表 -->
    <div v-if="savedTasks.length > 0" class="saved-tasks-section">
      <div class="section-title">已保存任务:</div>
      <div class="task-list">
        <div
          v-for="task in savedTasks"
          :key="task.id"
          class="task-item"
          :class="{ 'task-item-active': currentEditingTaskId === task.id }"
        >
          <span class="task-name" @click="$emit('load-task', task.id)">
            {{ task.name }}
          </span>
          <el-button
            size="small"
            type="danger"
            text
            icon="Delete"
            @click.stop="$emit('delete-task', task.id)"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
/**
 * TaskControls - 任务控制组件
 * 提供任务执行控制、新增/更新任务、任务列表展示功能
 */

const props = defineProps({
  taskSteps: {
    type: Array,
    default: () => []
  },
  isTaskRunning: {
    type: Boolean,
    default: false
  },
  savedTasks: {
    type: Array,
    default: () => []
  },
  currentEditingTaskId: {
    type: String,
    default: null
  }
})

const emit = defineEmits([
  'toggle-execution',
  'add-new-task',
  'update-task',
  'clear',
  'export',
  'import',
  'load-task',
  'delete-task'
])
</script>

<style scoped>
.task-controls {
  margin-bottom: 20px;
  padding: 16px;
  background-color: var(--el-bg-color-page, #f5f7fa);
  border-radius: 6px;
}

.controls-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.controls-left,
.controls-right {
  display: flex;
  gap: 12px;
  align-items: center;
}

.saved-tasks-section {
  margin-top: 16px;
  padding: 12px;
  background-color: var(--el-bg-color, #fff);
  border-radius: 4px;
}

.section-title {
  font-size: 13px;
  color: var(--el-text-color-regular);
  margin-bottom: 8px;
}

.task-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.task-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 6px 12px;
  background-color: var(--el-fill-color-light, #f5f7fa);
  border-radius: 4px;
  border: 1px solid transparent;
}

.task-item-active {
  border-color: var(--el-color-primary);
  background-color: var(--el-color-primary-light-9);
}

.task-name {
  font-size: 13px;
  color: var(--el-text-color-primary);
  cursor: pointer;
}

.task-name:hover {
  color: var(--el-color-primary);
}
</style>
