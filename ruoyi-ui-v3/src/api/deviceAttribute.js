import request from '@/utils/request'

/**
 * 获取属性输入scheme
 * @param {string} deviceId - 设备ID
 * @param {string} attributeId - 属性ID
 */
export function getAttributeScheme(deviceId, attributeId) {
  return request({
    url: '/nowdata/attribute/scheme',
    method: 'get',
    params: { deviceId, attributeId }
  })
}
