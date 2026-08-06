<script>
export default {
  name: 'TabBar',
  props: {
    modelValue: { type: String, required: true }
  },
  emits: ['update:modelValue'],
  data() {
    return {
      tabs: [
        { id: 'monitoring-qc', label: '监测质控' },
        { id: 'env-security', label: '动环安防' }
      ]
    }
  }
}
</script>

<template>
  <div class="tab-bar">
    <button
      v-for="tab in tabs"
      :key="tab.id"
      type="button"
      class="tab-bar__item"
      :class="{ 'tab-bar__item--active': modelValue === tab.id }"
      @click="$emit('update:modelValue', tab.id)"
    >
      {{ tab.label }}
    </button>
  </div>
</template>

<style scoped lang="scss">
.tab-bar {
  display: inline-flex;
  gap: 8px;
  padding: 4px;
  border-radius: 999px;
  background: rgba(8, 24, 48, 0.8);
  border: 1px solid rgba(56, 189, 248, 0.18);
}

.tab-bar__item {
  min-width: 108px;
  padding: 8px 18px;
  border: none;
  border-radius: 999px;
  background: transparent;
  color: #94a3b8;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.tab-bar__item--active {
  background: linear-gradient(135deg, rgba(14, 165, 233, 0.35), rgba(56, 189, 248, 0.15));
  color: #f8fafc;
  box-shadow: inset 0 0 0 1px rgba(125, 211, 252, 0.35);
}
</style>
