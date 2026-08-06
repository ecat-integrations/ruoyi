<template>
  <div>
    <svg-icon icon-class="question" @click="goto" />
  </div>
</template>

<script setup>
const url = ref('https://github.com/ecat-project/ecat-core/blob/main/README_zh.md');

function goto() {
  window.open(url.value)
}
</script>
