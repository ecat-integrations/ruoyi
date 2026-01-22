/**
 * 设备属性状态映射
 * 英文状态名 -> 中文显示文本
 */

export const statusTextMap = {
  'Normal': '正常',
  'Alarm': '报警',
  'Calibration': '校准',
  'Maintenance': '维护',
  'Malfunction': '故障',
  'Waiting': '等待',
  'OverUpperLimit': '超上限',
  'UnderLowerLimit': '超下限',
  'Empty': '未设置',
  'Insufficient': '数据不足',
  'AbnormalChange': '数据突变',
  'NoChange': '数据不变',
  'ZeroCheck': '零点检查',
  'SpanCheck': '跨度检查',
  'AccuracyCheck': '准确度检查',
  'ZeroCalibration': '零点校准',
  'SpanCalibration': '跨度校准',
  'FlowCheck': '流量检查',
  'QualityCheck': '质量检查',
  'ZeroDrift': '检定零点漂移',
  'SpanDrift': '检定跨度漂移',
  'SpanReproducibility': '检定跨度重现性',
  'MultiPointSpan': '检定多点跨度',
  'PrecisionCheck': '精密度检查',
  'Other': '其他'
}

/**
 * 获取状态中文文本
 * @param {string} status - 英文状态名
 * @returns {string} 中文文本
 */
export function getStatusText(status) {
  return statusTextMap[status] || status || '正常'
}
