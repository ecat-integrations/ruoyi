import request from '@/utils/request'

// 登录方法
export function login(username, password, code, uuid) {
  const data = {
    username,
    password,
    code,
    uuid
  }
  return request({
    url: '/login',
    headers: {
      isToken: false,
      repeatSubmit: false
    },
    method: 'post',
    data: data
  })
}
// 查询history列表
// export function getNowData(query) {
//   return request({
//     url: '/station/data/nowdata',
//     method: 'get',
//     params: query
//   })
// }
// 注册方法
export function register(data) {
  return request({
    url: '/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 获取用户详细信息
export function getInfo() {
  return request({
    url: '/getInfo',
    method: 'get'
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post'
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/captchaImage',
    headers: {
      isToken: false
    },
    method: 'get',
    timeout: 20000
  })
}

// 获取实时数据
export function getNowData() {
  return request({
    url: '/nowdata/list',
    method: 'get'
  })
}
// devicedebug
export function deviceDebug(data){
  return request({
    url: '/device_control_setting/settings/control/debug',
    method: 'put',
    data: data
  })
}

// 查询报警管理列表
export function listindexAlarms(query) {
  return request({
    url: '/alarm/alarms/list',
    method: 'get',
    params: query
  })
}
// 查询物资管理列表
export function listMaterialManager(query) {
  return request({
    url: '/material/manager/list',
    method: 'get',
    params: query
  })
}
