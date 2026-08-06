import { bindKey, AIR_PREFIX, STATION_PREFIX } from '@/views/index/dashboardBinding'

/** @typedef {'monitoring-qc'|'env-security'} StationTab */
/** @typedef {'sampling_platform'|'monitoring_rack'|'qc_equipment'|'power_zone'|'env_zone'|'control_zone'|'security_zone'} StationZone */

/**
 * @param {string} id
 * @param {object} config
 */
function node(id, config) {
  return { id, ...config }
}

/** @type {Array<import('./deviceRegistry.types').StationDeviceNode>} */
export const DEVICE_REGISTRY = [
  // —— 监测质控 · 采样平台 ——
  node('camera_1', {
    deviceType: 'camera',
    label: '摄像头1',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [bindKey(STATION_PREFIX + 'camera.1', 'online_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'camera.1', 'online_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'camera.1', 'online_status')]
  }),
  node('camera_2', {
    deviceType: 'camera',
    label: '摄像头2',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [bindKey(STATION_PREFIX + 'camera.2', 'online_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'camera.2', 'online_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'camera.2', 'online_status')]
  }),
  node('camera_3', {
    deviceType: 'camera',
    label: '摄像头3',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [bindKey(STATION_PREFIX + 'camera.3', 'online_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'camera.3', 'online_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'camera.3', 'online_status')]
  }),
  node('camera_4', {
    deviceType: 'camera',
    label: '摄像头4',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [bindKey(STATION_PREFIX + 'camera.4', 'online_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'camera.4', 'online_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'camera.4', 'online_status')]
  }),
  node('sampling_main_pipe', {
    deviceType: 'sampling_main_pipe',
    label: '采样总管',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [
      bindKey(STATION_PREFIX + 'sampling_tube', 'flow_velocity'),
      bindKey(STATION_PREFIX + 'sampling_tube', 'temperature')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'sampling_tube', 'flow_velocity'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'sampling_tube', 'temperature'),
      bindKey(STATION_PREFIX + 'sampling_tube', 'humidity'),
      bindKey(STATION_PREFIX + 'sampling_tube', 'flow_velocity'),
      bindKey(STATION_PREFIX + 'sampling_tube', 'retention_time')
    ]
  }),
  node('pm25_inlet', {
    deviceType: 'sampling_inlet_pm25',
    label: 'PM2.5采样口',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [bindKey(AIR_PREFIX + 'pm25', 'current_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'pm25', 'current_flow'),
    detailBindings: [bindKey(AIR_PREFIX + 'pm25', 'current_flow'), bindKey(AIR_PREFIX + 'pm25', 'pm_concentration')]
  }),
  node('pm10_inlet', {
    deviceType: 'sampling_inlet_pm10',
    label: 'PM10采样口',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [bindKey(AIR_PREFIX + 'pm10', 'current_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'pm10', 'current_flow'),
    detailBindings: [bindKey(AIR_PREFIX + 'pm10', 'current_flow'), bindKey(AIR_PREFIX + 'pm10', 'pm_concentration')]
  }),

  // —— 监测质控 · 机柜分析仪 ——
  node('analyzer_so2', {
    deviceType: 'analyzer_so2',
    label: 'SO₂分析仪',
    tab: 'monitoring-qc',
    zone: 'monitoring_rack',
    bindings: [bindKey(AIR_PREFIX + 'so2', 'so2'), bindKey(AIR_PREFIX + 'so2', 'sample_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'so2', 'so2'),
    detailBindings: [bindKey(AIR_PREFIX + 'so2', 'so2'), bindKey(AIR_PREFIX + 'so2', 'sample_flow')]
  }),
  node('analyzer_o3', {
    deviceType: 'analyzer_o3',
    label: 'O₃分析仪',
    tab: 'monitoring-qc',
    zone: 'monitoring_rack',
    bindings: [bindKey(AIR_PREFIX + 'o3', 'o3'), bindKey(AIR_PREFIX + 'o3', 'sample_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'o3', 'o3'),
    detailBindings: [bindKey(AIR_PREFIX + 'o3', 'o3'), bindKey(AIR_PREFIX + 'o3', 'sample_flow')]
  }),
  node('analyzer_no2', {
    deviceType: 'analyzer_no2',
    label: 'NO₂分析仪',
    tab: 'monitoring-qc',
    zone: 'monitoring_rack',
    bindings: [bindKey(AIR_PREFIX + 'nox', 'no2'), bindKey(AIR_PREFIX + 'nox', 'sample_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'nox', 'no2'),
    detailBindings: [bindKey(AIR_PREFIX + 'nox', 'no2'), bindKey(AIR_PREFIX + 'nox', 'no'), bindKey(AIR_PREFIX + 'nox', 'nox'), bindKey(AIR_PREFIX + 'nox', 'sample_flow')]
  }),
  node('analyzer_co', {
    deviceType: 'analyzer_co',
    label: 'CO分析仪',
    tab: 'monitoring-qc',
    zone: 'monitoring_rack',
    bindings: [bindKey(AIR_PREFIX + 'co', 'co'), bindKey(AIR_PREFIX + 'co', 'sample_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'co', 'co'),
    detailBindings: [bindKey(AIR_PREFIX + 'co', 'co'), bindKey(AIR_PREFIX + 'co', 'sample_flow')]
  }),
  node('analyzer_pm10', {
    deviceType: 'analyzer_pm10',
    label: 'PM10分析仪',
    tab: 'monitoring-qc',
    zone: 'monitoring_rack',
    bindings: [bindKey(AIR_PREFIX + 'pm10', 'pm_concentration'), bindKey(AIR_PREFIX + 'pm10', 'current_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'pm10', 'pm_concentration'),
    detailBindings: [bindKey(AIR_PREFIX + 'pm10', 'pm_concentration'), bindKey(AIR_PREFIX + 'pm10', 'current_flow')]
  }),
  node('analyzer_pm25', {
    deviceType: 'analyzer_pm25',
    label: 'PM2.5分析仪',
    tab: 'monitoring-qc',
    zone: 'monitoring_rack',
    bindings: [bindKey(AIR_PREFIX + 'pm25', 'pm_concentration'), bindKey(AIR_PREFIX + 'pm25', 'current_flow')],
    primaryBinding: bindKey(AIR_PREFIX + 'pm25', 'pm_concentration'),
    detailBindings: [bindKey(AIR_PREFIX + 'pm25', 'pm_concentration'), bindKey(AIR_PREFIX + 'pm25', 'current_flow')]
  }),

  // —— 监测质控 · 质控设备 ——
  node('calibrator', {
    deviceType: 'calibrator',
    label: '动态校准仪',
    tab: 'monitoring-qc',
    zone: 'qc_equipment',
    bindings: [bindKey(STATION_PREFIX + 'calibrator', 'online_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'calibrator', 'online_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'calibrator', 'online_status')]
  }),
  node('zero_gas', {
    deviceType: 'zero_gas_generator',
    label: '零气发生器',
    tab: 'monitoring-qc',
    zone: 'qc_equipment',
    bindings: [bindKey(STATION_PREFIX + 'zero_gas_relay', 'relay_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'zero_gas_relay', 'relay_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'zero_gas_relay', 'relay_status')]
  }),
  node('filter_so2', {
    deviceType: 'filter_changer',
    label: 'SO₂换膜器',
    tab: 'monitoring-qc',
    zone: 'qc_equipment',
    bindings: [
      bindKey(STATION_PREFIX + 'filter_changer.so2', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.so2', 'branch_temp')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'filter_changer.so2', 'filter_remaining'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'filter_changer.so2', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.so2', 'branch_temp')
    ],
    isPercentPrimary: true
  }),
  node('filter_nox', {
    deviceType: 'filter_changer',
    label: 'NOx换膜器',
    tab: 'monitoring-qc',
    zone: 'qc_equipment',
    bindings: [
      bindKey(STATION_PREFIX + 'filter_changer.nox', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.nox', 'branch_temp')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'filter_changer.nox', 'filter_remaining'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'filter_changer.nox', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.nox', 'branch_temp')
    ],
    isPercentPrimary: true
  }),
  node('filter_co', {
    deviceType: 'filter_changer',
    label: 'CO换膜器',
    tab: 'monitoring-qc',
    zone: 'qc_equipment',
    bindings: [
      bindKey(STATION_PREFIX + 'filter_changer.co', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.co', 'branch_temp')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'filter_changer.co', 'filter_remaining'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'filter_changer.co', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.co', 'branch_temp')
    ],
    isPercentPrimary: true
  }),
  node('filter_o3', {
    deviceType: 'filter_changer',
    label: 'O₃换膜器',
    tab: 'monitoring-qc',
    zone: 'qc_equipment',
    bindings: [
      bindKey(STATION_PREFIX + 'filter_changer.o3', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.o3', 'branch_temp')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'filter_changer.o3', 'filter_remaining'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'filter_changer.o3', 'filter_remaining'),
      bindKey(STATION_PREFIX + 'filter_changer.o3', 'branch_temp')
    ],
    isPercentPrimary: true
  }),

  // —— 动环安防 · 供电 ——
  node('power_meter', {
    deviceType: 'power_meter',
    label: '三相电表',
    tab: 'env-security',
    zone: 'power_zone',
    bindings: [
      bindKey(STATION_PREFIX + 'power_meter', 'voltage_a'),
      bindKey(STATION_PREFIX + 'power_meter', 'current_a')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'power_meter', 'voltage_a'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'power_meter', 'voltage_a'),
      bindKey(STATION_PREFIX + 'power_meter', 'voltage_b'),
      bindKey(STATION_PREFIX + 'power_meter', 'voltage_c'),
      bindKey(STATION_PREFIX + 'power_meter', 'current_a'),
      bindKey(STATION_PREFIX + 'power_meter', 'current_b'),
      bindKey(STATION_PREFIX + 'power_meter', 'current_c'),
      bindKey(STATION_PREFIX + 'power_meter', 'power_active_a'),
      bindKey(STATION_PREFIX + 'power_meter', 'power_active_b'),
      bindKey(STATION_PREFIX + 'power_meter', 'power_active_c')
    ]
  }),
  node('ups', {
    deviceType: 'ups',
    label: 'UPS',
    tab: 'env-security',
    zone: 'power_zone',
    bindings: [
      bindKey(STATION_PREFIX + 'ups', 'output_voltage'),
      bindKey(STATION_PREFIX + 'ups', 'load_percent')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'ups', 'load_percent'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'ups', 'input_voltage'),
      bindKey(STATION_PREFIX + 'ups', 'output_voltage'),
      bindKey(STATION_PREFIX + 'ups', 'load_percent'),
      bindKey(STATION_PREFIX + 'ups', 'battery_voltage'),
      bindKey(STATION_PREFIX + 'ups', 'battery_temp'),
      bindKey(STATION_PREFIX + 'ups', 'ups_status')
    ]
  }),
  node('voltage_regulator', {
    deviceType: 'voltage_regulator',
    label: '配电稳压',
    tab: 'env-security',
    zone: 'power_zone',
    bindings: [bindKey(STATION_PREFIX + 'voltage_regulator', 'voltage_ch1')],
    primaryBinding: bindKey(STATION_PREFIX + 'voltage_regulator', 'voltage_ch1'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'voltage_regulator', 'voltage_ch1'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'voltage_ch2'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'current_ch1'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'current_ch2')
    ]
  }),

  // —— 动环安防 · 环境 ——
  node('th_sensor', {
    deviceType: 'th_sensor',
    label: '站房温湿度',
    tab: 'env-security',
    zone: 'env_zone',
    bindings: [
      bindKey(STATION_PREFIX + 'th', 'temperature'),
      bindKey(STATION_PREFIX + 'th', 'humidity')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'th', 'temperature'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'th', 'temperature'),
      bindKey(STATION_PREFIX + 'th', 'humidity')
    ]
  }),
  node('indoor_pollutant', {
    deviceType: 'indoor_sensor',
    label: '室内污染物',
    tab: 'env-security',
    zone: 'env_zone',
    bindings: [bindKey(STATION_PREFIX + 'indoor_pollutant', 'pm25_indoor')],
    primaryBinding: bindKey(STATION_PREFIX + 'indoor_pollutant', 'pm25_indoor'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'indoor_pollutant', 'pm25_indoor'),
      bindKey(STATION_PREFIX + 'indoor_pollutant', 'pm10_indoor'),
      bindKey(STATION_PREFIX + 'indoor_pollutant', 'o3_indoor'),
      bindKey(STATION_PREFIX + 'indoor_pollutant', 'co_indoor'),
      bindKey(STATION_PREFIX + 'indoor_pollutant', 'no2_indoor'),
      bindKey(STATION_PREFIX + 'indoor_pollutant', 'so2_indoor')
    ]
  }),
  node('meteo', {
    deviceType: 'meteo_station',
    label: '气象站',
    tab: 'monitoring-qc',
    zone: 'sampling_platform',
    bindings: [
      bindKey(AIR_PREFIX + 'meteo', 'wind_speed'),
      bindKey(AIR_PREFIX + 'meteo', 'temperature')
    ],
    primaryBinding: bindKey(AIR_PREFIX + 'meteo', 'wind_speed'),
    detailBindings: [
      bindKey(AIR_PREFIX + 'meteo', 'wind_speed'),
      bindKey(AIR_PREFIX + 'meteo', 'wind_direction'),
      bindKey(AIR_PREFIX + 'meteo', 'temperature'),
      bindKey(AIR_PREFIX + 'meteo', 'humidity'),
      bindKey(AIR_PREFIX + 'meteo', 'atmospheric_pressure'),
      bindKey(AIR_PREFIX + 'meteo', 'dew_point')
    ]
  }),

  // —— 动环安防 · 控制 ——
  node('ac1', {
    deviceType: 'air_conditioner',
    label: '空调1',
    tab: 'env-security',
    zone: 'control_zone',
    bindings: [bindKey(STATION_PREFIX + 'air_conditioner.ac1', 'running_mode')],
    primaryBinding: bindKey(STATION_PREFIX + 'air_conditioner.ac1', 'running_mode'),
    detailBindings: [bindKey(STATION_PREFIX + 'air_conditioner.ac1', 'running_mode')]
  }),
  node('ac2', {
    deviceType: 'air_conditioner',
    label: '空调2',
    tab: 'env-security',
    zone: 'control_zone',
    bindings: [bindKey(STATION_PREFIX + 'air_conditioner.ac2', 'running_mode')],
    primaryBinding: bindKey(STATION_PREFIX + 'air_conditioner.ac2', 'running_mode'),
    detailBindings: [bindKey(STATION_PREFIX + 'air_conditioner.ac2', 'running_mode')]
  }),
  node('exhaust_fan', {
    deviceType: 'exhaust_fan',
    label: '排风扇',
    tab: 'env-security',
    zone: 'control_zone',
    bindings: [bindKey(STATION_PREFIX + 'exhaust_fan', 'speed')],
    primaryBinding: bindKey(STATION_PREFIX + 'exhaust_fan', 'speed'),
    detailBindings: [bindKey(STATION_PREFIX + 'exhaust_fan', 'speed')]
  }),
  node('lighting', {
    deviceType: 'lighting',
    label: '照明',
    tab: 'env-security',
    zone: 'control_zone',
    bindings: [bindKey(STATION_PREFIX + 'lighting', 'switch_status')],
    primaryBinding: bindKey(STATION_PREFIX + 'lighting', 'switch_status'),
    detailBindings: [bindKey(STATION_PREFIX + 'lighting', 'switch_status')]
  }),
  node('relay_panel', {
    deviceType: 'relay_switch',
    label: '继电器',
    tab: 'env-security',
    zone: 'control_zone',
    bindings: [
      bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch1'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch2')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch1'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch1'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch2'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch3'),
      bindKey(STATION_PREFIX + 'voltage_regulator', 'relay_ch4')
    ]
  }),

  // —— 动环安防 · 安防 ——
  node('access_control', {
    deviceType: 'access_control',
    label: '智能门禁',
    tab: 'env-security',
    zone: 'security_zone',
    bindings: [
      bindKey(STATION_PREFIX + 'access_control', 'lock_status'),
      bindKey(STATION_PREFIX + 'access_control', 'online_status')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'access_control', 'online_status'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'access_control', 'lock_status'),
      bindKey(STATION_PREFIX + 'access_control', 'online_status')
    ]
  }),
  node('security_alarm', {
    deviceType: 'security_alarm',
    label: '安防报警',
    tab: 'env-security',
    zone: 'security_zone',
    bindings: [
      bindKey(STATION_PREFIX + 'security_alarm', 'ir_alarm'),
      bindKey(STATION_PREFIX + 'security_alarm', 'water_leak')
    ],
    primaryBinding: bindKey(STATION_PREFIX + 'security_alarm', 'ir_alarm'),
    detailBindings: [
      bindKey(STATION_PREFIX + 'security_alarm', 'ir_alarm'),
      bindKey(STATION_PREFIX + 'security_alarm', 'smoke_1'),
      bindKey(STATION_PREFIX + 'security_alarm', 'smoke_2'),
      bindKey(STATION_PREFIX + 'security_alarm', 'temp_alarm_1'),
      bindKey(STATION_PREFIX + 'security_alarm', 'temp_alarm_2'),
      bindKey(STATION_PREFIX + 'security_alarm', 'water_leak')
    ]
  })
]

export const KPI_ITEMS = [
  { id: 'kpi_pm10', label: 'PM₁₀', binding: bindKey(AIR_PREFIX + 'pm10', 'pm_concentration'), unit: 'μg/m³' },
  { id: 'kpi_pm25', label: 'PM₂.₅', binding: bindKey(AIR_PREFIX + 'pm25', 'pm_concentration'), unit: 'μg/m³' },
  { id: 'kpi_co', label: 'CO', binding: bindKey(AIR_PREFIX + 'co', 'co'), unit: 'mg/m³' },
  { id: 'kpi_so2', label: 'SO₂', binding: bindKey(AIR_PREFIX + 'so2', 'so2'), unit: 'μg/m³' },
  { id: 'kpi_o3', label: 'O₃', binding: bindKey(AIR_PREFIX + 'o3', 'o3'), unit: 'μg/m³' },
  { id: 'kpi_no', label: 'NO', binding: bindKey(AIR_PREFIX + 'nox', 'no'), unit: 'μg/m³' },
  { id: 'kpi_no2', label: 'NO₂', binding: bindKey(AIR_PREFIX + 'nox', 'no2'), unit: 'μg/m³' },
  { id: 'kpi_nox', label: 'NOx', binding: bindKey(AIR_PREFIX + 'nox', 'nox'), unit: 'μg/m³' }
]

export const METEO_ITEMS = [
  { id: 'meteo_wind_speed', label: '风速', binding: bindKey(AIR_PREFIX + 'meteo', 'wind_speed') },
  { id: 'meteo_wind_dir', label: '风向', binding: bindKey(AIR_PREFIX + 'meteo', 'wind_direction') },
  { id: 'meteo_temp', label: '温度', binding: bindKey(AIR_PREFIX + 'meteo', 'temperature') },
  { id: 'meteo_humidity', label: '湿度', binding: bindKey(AIR_PREFIX + 'meteo', 'humidity') },
  { id: 'meteo_pressure', label: '气压', binding: bindKey(AIR_PREFIX + 'meteo', 'atmospheric_pressure') },
  { id: 'meteo_dew', label: '露点', binding: bindKey(AIR_PREFIX + 'meteo', 'dew_point') }
]

export const ZONE_META = {
  sampling_platform: { title: '采样平台', order: 1 },
  monitoring_rack: { title: '监测机柜', order: 2 },
  qc_equipment: { title: '质控与维护', order: 3 },
  power_zone: { title: '供电单元', order: 1 },
  env_zone: { title: '站房环境', order: 2 },
  control_zone: { title: '控制单元', order: 3 },
  security_zone: { title: '安防单元', order: 4 }
}

export function getDevicesByTab(tab) {
  return DEVICE_REGISTRY.filter(d => d.tab === tab && !d.kpiOnly)
}

export function getDevicesByZone(tab, zone) {
  return DEVICE_REGISTRY.filter(d => d.tab === tab && d.zone === zone && !d.kpiOnly)
}
