<template>
  <div class="execution-log-container">
    <div class="log-header">
      <span class="log-title">执行日志</span>
      <el-button
        size="small"
        text
        @click="clearLogs"
      >
        清空
      </el-button>
    </div>
    <div class="log-content">
      <div
        v-for="(log, index) in logs"
        :key="index"
        class="log-item"
        :class="`log-${log.type}`"
      >
        <span class="log-time">{{ log.time }}</span>
        <span class="log-message">{{ log.content }}</span>
      </div>
      <div v-if="logs.length === 0" class="log-empty">
        暂无日志
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  logs: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['clear'])

function clearLogs() {
  emit('clear')
}
</script>

<style scoped>
.execution-log-container {
  border-top: 1px solid var(--el-border-color-light, #ebeef5);
  padding-top: 16px;
}

.log-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.log-title {
  font-size: 14px;
  font-weight: 500;
  color: var(--el-text-color-primary, #303133);
}

.log-content {
  background-color: var(--el-bg-color-page, #f5f7fa);
  border: 1px solid var(--el-border-color-lighter, #ebeef5);
  border-radius: 4px;
  padding: 12px;
  height: 200px;
  overflow-y: auto;
  font-family: 'Courier New', monospace;
  font-size: 13px;
}

.log-item {
  display: flex;
  margin-bottom: 6px;
  line-height: 1.5;
}

.log-time {
  color: var(--el-text-color-secondary, #909399);
  margin-right: 10px;
  min-width: 70px;
}

.log-message {
  flex: 1;
}

.log-item.log-info .log-message {
  color: var(--el-text-color-primary, #303133);
}

.log-item.log-success .log-message {
  color: #67c23a;
}

.log-item.log-error .log-message {
  color: #f56c6c;
}

.log-item.log-warning .log-message {
  color: #e6a23c;
}

.log-empty {
  text-align: center;
  color: var(--el-text-color-placeholder, #c0c4cc);
  padding: 40px 0;
}

/* 滚动条样式 */
.log-content::-webkit-scrollbar {
  width: 6px;
}

.log-content::-webkit-scrollbar-thumb {
  background-color: var(--el-border-color-darker, #dcdfe6);
  border-radius: 3px;
}

.log-content::-webkit-scrollbar-track {
  background-color: transparent;
}
</style>
