<script>
import { getDeviceShape } from '../assets/deviceIconShapes'

export default {
  name: 'DeviceIcon',
  props: {
    type: { type: String, default: 'default' },
    size: { type: Number, default: 56 }
  },
  computed: {
    shapeMarkup() {
      return getDeviceShape(this.type)
    }
  }
}
</script>

<template>
  <div class="device-icon" :style="{ width: `${size}px`, height: `${size}px` }">
    <svg
      class="device-icon__shape"
      :width="size"
      :height="size"
      viewBox="0 0 64 64"
      v-html="shapeMarkup"
    />
  </div>
</template>

<style scoped>
.device-icon {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  filter: drop-shadow(0 3px 8px rgba(2, 8, 23, 0.4));
}

.device-icon__shape {
  display: block;
}
</style>
