<template>
  <div class="attribute-input">
    <!-- BINARY: 下拉选择框 -->
    <el-select
      v-if="scheme?.type === 'binary'"
      :model-value="modelValue"
      placeholder="请选择"
      style="width: 100%"
      @change="handleChange"
    >
      <el-option
        v-for="option in scheme?.options"
        :key="option.value"
        :label="option.label"
        :value="option.value"
      />
    </el-select>

    <!-- NUMERIC: 数字输入框 -->
    <template v-else-if="scheme?.type === 'numeric'">
      <el-input-number
        :model-value="modelValue === '' ? undefined : Number(modelValue)"
        :precision="scheme.precision || 0"
        :step="1"
        :controls-position="'right'"
        style="width: 100%"
        @change="handleNumericChange"
      />
      <span v-if="scheme.unit" class="unit-suffix">
        {{ scheme.unit }}
      </span>
    </template>

    <!-- TEXT: 文本输入框 -->
    <el-input
      v-else-if="scheme?.type === 'text'"
      :model-value="modelValue"
      :placeholder="scheme?.placeholder || '请输入值'"
      @input="handleChange"
    />

    <!-- SELECT: 可搜索下拉框 -->
    <el-select
      v-else-if="scheme?.type === 'select'"
      :model-value="modelValue"
      filterable
      placeholder="请选择"
      style="width: 100%"
      @change="handleChange"
    >
      <el-option
        v-for="option in scheme?.options"
        :key="option.value"
        :label="option.label"
        :value="option.value"
      />
    </el-select>

    <!-- COMMAND: 命令按钮组 -->
    <div v-else-if="scheme?.type === 'command'" class="command-buttons">
      <el-button
        v-for="cmd in scheme?.commands"
        :key="cmd.value"
        :type="modelValue === cmd.value ? 'primary' : 'default'"
        @click="handleChange(cmd.value)"
      >
        {{ cmd.label }}
      </el-button>
    </div>

    <!-- UNKNOWN: 默认文本输入 -->
    <el-input
      v-else
      :model-value="modelValue"
      placeholder="请输入值"
      @input="handleChange"
    />
  </div>
</template>

<script setup>
const props = defineProps({
  modelValue: {
    type: [String, Number],
    default: ''
  },
  scheme: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['update:modelValue'])

function handleChange(value) {
  emit('update:modelValue', value)
}

function handleNumericChange(value) {
  emit('update:modelValue', String(value))
}
</script>

<style scoped>
.attribute-input {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 100%;
}

.attribute-input > * {
  flex: 1;
  min-width: 0;
}

.unit-suffix {
  font-size: 13px;
  color: var(--el-text-color-regular);
  flex: 0 0 auto;
}

.command-buttons {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  width: 100%;
}
</style>
