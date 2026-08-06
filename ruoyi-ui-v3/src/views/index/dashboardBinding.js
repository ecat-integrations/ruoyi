/**
 * 大屏固定逻辑设备绑定配置。
 * 键格式：{uniqueId}-{attributeId}，与 GET /nowdata/dashboard-list 的 bindKey 一致。
 */

export const STATION_PREFIX = 'logicdevice_station.'
export const AIR_PREFIX = 'logicdevice.'

/** @param {string} uniqueId @param {string} attrId */
export function bindKey(uniqueId, attrId) {
  return `${uniqueId}-${attrId}`
}

/** @param {string} name @param {string} uniqueId @param {string} attrId @param {object} [extra] */
function item(name, uniqueId, attrId, extra = {}) {
  return {
    name,
    value: null,
    unit: null,
    status: -1,
    id: bindKey(uniqueId, attrId),
    type: 'value',
    valuestatus: -1,
    ...extra
  }
}

function station(device, attr, name, extra) {
  return item(name, STATION_PREFIX + device, attr, extra)
}

function air(device, attr, name, extra) {
  return item(name, AIR_PREFIX + device, attr, extra)
}

export function createDashboardBindings() {
  return {
    leftOne: [
      station('security_alarm', 'ir_alarm', '红外状态'),
      station('security_alarm', 'smoke_1', '烟感1状态'),
      station('security_alarm', 'smoke_2', '烟感2状态'),
      station('security_alarm', 'temp_alarm_1', '温感1状态'),
      station('security_alarm', 'temp_alarm_2', '温感2状态'),
      station('security_alarm', 'water_leak', '水浸状态')
    ],
    leftSecurity: [
      station('access_control', 'lock_status', '门禁锁状态'),
      station('access_control', 'online_status', '门禁在线状态'),
      station('camera.1', 'online_status', '摄像头1在线'),
      station('camera.2', 'online_status', '摄像头2在线'),
      station('camera.3', 'online_status', '摄像头3在线'),
      station('camera.4', 'online_status', '摄像头4在线')
    ],
    leftTwo: [
      air('pm10', 'current_flow', 'PM10流量'),
      air('pm25', 'current_flow', 'PM2.5流量'),
      air('so2', 'sample_flow', 'SO2监测仪流量'),
      air('o3', 'sample_flow', 'O3监测仪流量'),
      air('nox', 'sample_flow', 'NO2监测仪流量'),
      air('co', 'sample_flow', 'CO监测仪流量')
    ],
    leftThree: [
      station('th', 'temperature', '站房温度'),
      station('th', 'humidity', '站房湿度'),
      station('indoor_pollutant', 'pm25_indoor', '室内PM2.5浓度'),
      station('indoor_pollutant', 'pm10_indoor', '室内PM10浓度'),
      station('indoor_pollutant', 'o3_indoor', '室内O3浓度'),
      station('indoor_pollutant', 'co_indoor', '室内CO浓度'),
      station('indoor_pollutant', 'no2_indoor', '室内NO2浓度'),
      station('indoor_pollutant', 'so2_indoor', '室内SO2浓度')
    ],
    leftFour: [
      station('sampling_tube', 'temperature', '采样管温度'),
      station('sampling_tube', 'humidity', '采样管湿度'),
      station('sampling_tube', 'flow_velocity', '采样管流速'),
      station('sampling_tube', 'retention_time', '采样管滞留时间'),
      station('filter_changer.so2', 'branch_temp', 'SO2支管温度'),
      station('filter_changer.co', 'branch_temp', 'CO支管温度'),
      station('filter_changer.o3', 'branch_temp', 'O3支管温度'),
      station('filter_changer.nox', 'branch_temp', 'NO支管温度')
    ],
    rightOne: [
      air('meteo', 'wind_speed', '风速'),
      air('meteo', 'wind_direction', '风向'),
      air('meteo', 'temperature', '温度'),
      air('meteo', 'humidity', '湿度'),
      air('meteo', 'atmospheric_pressure', '大气压力'),
      air('meteo', 'dew_point', '露点温度')
    ],
    rightTwo: [
      station('lighting', 'switch_status', '照明控制'),
      station('exhaust_fan', 'speed', '风机控制'),
      station('air_conditioner.ac1', 'running_mode', '空调1控制'),
      station('air_conditioner.ac2', 'running_mode', '空调2控制'),
      station('zero_gas_relay', 'relay_status', '零气继电器'),
      station('voltage_regulator', 'relay_ch1', '第一路开关状态'),
      station('voltage_regulator', 'relay_ch2', '第二路开关状态'),
      station('voltage_regulator', 'relay_ch3', '第三路开关状态'),
      station('voltage_regulator', 'relay_ch4', '第四路开关状态')
    ],
    rightThree: [
      station('power_meter', 'voltage_a', '站房A相电压'),
      station('power_meter', 'voltage_b', '站房B相电压'),
      station('power_meter', 'voltage_c', '站房C相电压'),
      station('power_meter', 'current_a', '站房A相电流'),
      station('power_meter', 'current_b', '站房B相电流'),
      station('power_meter', 'current_c', '站房C相电流'),
      station('power_meter', 'power_active_a', 'A相有功功率'),
      station('power_meter', 'power_active_b', 'B相有功功率'),
      station('power_meter', 'power_active_c', 'C相有功功率'),
      station('power_meter', 'power_factor_a', 'A相功率因数'),
      station('power_meter', 'power_factor_b', 'B相功率因数'),
      station('power_meter', 'power_factor_c', 'C相功率因数')
    ],
    middleOne: [
      item('PM', AIR_PREFIX + 'pm10', 'pm_concentration', { affix: '10' }),
      item('PM', AIR_PREFIX + 'pm25', 'pm_concentration', { affix: '2.5' }),
      air('co', 'co', 'CO'),
      item('SO', AIR_PREFIX + 'so2', 'so2', { affix: '2' }),
      item('O', AIR_PREFIX + 'o3', 'o3', { affix: '3' }),
      air('nox', 'no', 'NO'),
      item('NO', AIR_PREFIX + 'nox', 'no2', { affix: '2' }),
      item('NO', AIR_PREFIX + 'nox', 'nox', { affix: 'x' })
    ],
    middleTwoDict: {
      CO: item('CO设备', AIR_PREFIX + 'co', 'co'),
      O3: item('O3设备', AIR_PREFIX + 'o3', 'o3'),
      NO2: item('NO2设备', AIR_PREFIX + 'nox', 'no2'),
      SO2: item('SO2设备', AIR_PREFIX + 'so2', 'so2'),
      PM10: item('PM10设备', AIR_PREFIX + 'pm10', 'pm_concentration'),
      PM2_5: item('PM2.5设备', AIR_PREFIX + 'pm25', 'pm_concentration'),
      calib: station('calibrator', 'online_status', '校准仪'),
      air: station('air_conditioner.ac1', 'running_mode', '空调'),
      sample_tube: station('sampling_tube', 'flow_velocity', '采样管'),
      power: station('voltage_regulator', 'current_ch1', '电源设备')
    },
    middleLeftOne: [
      station('ups', 'input_voltage', 'UPS输入电压'),
      station('ups', 'output_voltage', 'UPS输出电压'),
      station('ups', 'load_percent', 'UPS输出负载百分比'),
      station('ups', 'input_freq', 'UPS输入频率'),
      station('ups', 'battery_voltage', 'UPS电池单元电压'),
      station('ups', 'battery_temp', 'UPS电池温度'),
      station('ups', 'ups_status', 'UPS状态'),
      station('voltage_regulator', 'voltage_ch1', '第一路电压'),
      station('voltage_regulator', 'voltage_ch2', '第二路电压'),
      station('voltage_regulator', 'voltage_ch3', '第三路电压'),
      station('voltage_regulator', 'voltage_ch4', '第四路电压'),
      station('voltage_regulator', 'current_ch1', '第一路电流'),
      station('voltage_regulator', 'current_ch2', '第二路电流'),
      station('voltage_regulator', 'current_ch3', '第三路电流'),
      station('voltage_regulator', 'current_ch4', '第四路电流')
    ],
    middleRightOne: [
      station('filter_changer.so2', 'filter_remaining', 'SO2换膜仪剩余量'),
      station('filter_changer.nox', 'filter_remaining', 'NOx换膜仪剩余量'),
      station('filter_changer.co', 'filter_remaining', 'CO换膜仪剩余量'),
      station('filter_changer.o3', 'filter_remaining', 'O3换膜仪剩余量')
    ]
  }
}

/** 返回所有面板数组字段名，用于批量刷新 */
export const DASHBOARD_PANEL_KEYS = [
  'leftOne',
  'leftSecurity',
  'leftTwo',
  'leftThree',
  'leftFour',
  'rightOne',
  'rightTwo',
  'rightThree',
  'middleOne',
  'middleLeftOne',
  'middleRightOne'
]
