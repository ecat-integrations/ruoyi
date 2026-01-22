/**
 * 设备数据请求组合式函数
 */

import { ref } from 'vue'
import { getNowData } from '@/api/login'

export function useDeviceData({ emit }) {
  const deviceTimer = ref(null)

  /**
   * 请求设备数据 - 通过emit通知父组件更新数据
   */
  const requestData = () => {
    getNowData().then((res) => {
      if (res.code === 200) {
        emit?.('update-device-data', res.data)
      }
    }).catch((error) => {
      console.error('获取设备数据失败:', error)
    })
  }

  /**
   * 启动定时刷新
   * @param {number} interval - 刷新间隔（毫秒）
   */
  const startPolling = (interval = 10000) => {
    deviceTimer.value = setInterval(requestData, interval)
  }

  /**
   * 停止定时刷新
   */
  const stopPolling = () => {
    if (deviceTimer.value) {
      clearInterval(deviceTimer.value)
      deviceTimer.value = null
    }
  }

  return {
    deviceTimer,
    requestData,
    startPolling,
    stopPolling
  }
}
