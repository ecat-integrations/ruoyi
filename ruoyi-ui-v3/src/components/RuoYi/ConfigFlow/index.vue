<template>
  <div>
    <svg-icon icon-class="link" @click="goto" />
  </div>
</template>

<script setup>
const url = ref('http://localhost:9999/core-api/index');

function goto() {
  window.open(url.value)
}
</script>
