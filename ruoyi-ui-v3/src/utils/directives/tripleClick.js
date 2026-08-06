export const tripleClick = {
  mounted(el, binding) {
    let clickCount = 0
    let lastClickTime = 0
    let clickTimer = null
    const interval = 300

    const handleClick = (event) => {
      if (binding.modifiers.stop) {
        event.stopPropagation()
      }
      const now = Date.now()
      clickCount++

      if (clickTimer) clearTimeout(clickTimer)
      if (now - lastClickTime > interval) clickCount = 1

      lastClickTime = now
      clickTimer = setTimeout(() => {
        if (clickCount === 3) binding.value()
        clickCount = 0
      }, interval)
    }

    el.addEventListener('click', handleClick)
    el.__tripleClickHandler = handleClick
  },
  unmounted(el) {
    el.removeEventListener('click', el.__tripleClickHandler)
  }
}
