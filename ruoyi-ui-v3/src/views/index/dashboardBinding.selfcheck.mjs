import { bindKey, createDashboardBindings } from './dashboardBinding.js'
import { buildDashboardDataDict } from './dashboardDataUtils.js'

function assert(condition, message) {
  if (!condition) {
    throw new Error(message)
  }
}

const bindings = createDashboardBindings()
assert(bindKey('logicdevice.so2', 'so2') === 'logicdevice.so2-so2', 'bindKey')
assert(bindings.middleTwoDict.calib.id === 'logicdevice_station.calibrator-online_status', 'calibrator online_status')
assert(
  bindings.leftFour.some(i => i.id === 'logicdevice_station.sampling_tube-retention_time'),
  'retention_time'
)
assert(
  bindings.rightTwo.find(i => i.name === '第四路开关状态').id === 'logicdevice_station.voltage_regulator-relay_ch4',
  'relay ch4'
)

const dict = buildDashboardDataDict([{
  deviceId: 'uuid-1',
  uniqueId: 'logicdevice.so2',
  deviceName: 'SO2',
  deviceModel: 'LogicDevice-SO2',
  deviceStatus: 1,
  deviceType: 'logical',
  deviceAttrs: [{
    attributeID: 'so2',
    displayName: 'SO2',
    displayValue: '1.2',
    displayUnit: 'ppb',
    updateTime: new Date().toISOString(),
    bindKey: 'logicdevice.so2-so2'
  }]
}])
assert(dict['logicdevice.so2-so2']?.value === '1.2', 'dashboard dict by uniqueId')

console.log('dashboardBinding self-check passed')
