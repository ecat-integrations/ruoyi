<template>
  <el-dialog
    v-model="dialogVisible"
    :title="`手动标识 - ${device?.deviceName || ''}`"
    width="500px"
    :close-on-click-modal="false"
    @close="handleClose"
  >
    <el-form ref="formRef" :model="formData" :rules="rules" label-width="100px">
      <el-form-item label="设备型号">
        <el-tag type="info">{{ device?.deviceModel }}</el-tag>
      </el-form-item>
      
      <el-form-item label="设备编号">
        <span>{{ device?.deviceId }}</span>
      </el-form-item>
      
      <el-form-item label="选择标识" prop="tagValue">
        <el-select
          v-model="formData.tagValue"
          placeholder="请选择标识"
          style="width: 100%"
          :loading="loadingOptions"
        >
          <el-option
            v-for="option in tagOptions"
            :key="option.value"
            :label="option.label"
            :value="option.value"
          />
        </el-select>
      </el-form-item>
    </el-form>
    
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="handleClose">取消</el-button>
        <el-button type="primary" @click="handleConfirm" :loading="confirming">
          确认
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, watch, computed } from 'vue'
import { ElMessage } from 'element-plus'
import { getModelTagOptions, executeModelTagAction } from '../utils/manualTagConfig'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  device: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['update:modelValue', 'success'])

// 对话框显示状态
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

// 表单引用
const formRef = ref(null)

// 确认加载状态
const confirming = ref(false)

// 表单数据
const formData = ref({
  tagValue: ''
})

// 表单验证规则
const rules = {
  tagValue: [
    { required: true, message: '请选择标识', trigger: 'change' }
  ]
}

// 标识选项
const tagOptions = ref([])

// 加载状态
const loadingOptions = ref(false)

// 监听对话框打开,加载选项
watch(
  () => props.modelValue,
  (visible) => {
    if (visible && props.device) {
      loadTagOptions()
    }
  }
)

/**
 * 加载标识选项(支持异步)
 */
async function loadTagOptions() {
  if (!props.device || !props.device.deviceModel) {
    console.warn('设备或设备型号不存在')
    return
  }
  
  loadingOptions.value = true
  
  try {
    const options = await getModelTagOptions(props.device.deviceModel, props.device)
    tagOptions.value = options
    
    // 重置表单
    formData.value.tagValue = ''
    if (formRef.value) {
      formRef.value.clearValidate()
    }
  } catch (error) {
    console.error('加载标识选项失败:', error)
    ElMessage.error('加载标识选项失败')
  } finally {
    loadingOptions.value = false
  }
}

/**
 * 处理确认
 */
async function handleConfirm() {
  if (!formRef.value) return
  
  try {
    // 验证表单
    await formRef.value.validate()
    
    confirming.value = true
    
    // 执行型号的确认操作
    await executeModelTagAction(
      props.device.deviceModel,
      props.device,
      formData.value.tagValue
    )

    
    // 触发成功事件
    emit('success', {
      device: props.device,
      tagValue: formData.value.tagValue
    })
    
    // 关闭对话框
    handleClose()
  } catch (error) {
    if (error.message) {
      ElMessage.error(error.message || '操作失败')
    }
  } finally {
    confirming.value = false
  }
}

/**
 * 处理关闭
 */
function handleClose() {
  dialogVisible.value = false
  // 重置表单
  formData.value.tagValue = ''
  if (formRef.value) {
    formRef.value.clearValidate()
  }
}
</script>

<style scoped>
.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}
</style>
