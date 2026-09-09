/**
 * 登录加密令牌编解码（与历史 login_jiami 算法兼容）
 * 格式：URL-safe Base64( offset + interleave(account,password) + checkBit )
 * 约束：账号、密码各 12 位；offset + checkBit === 10
 */

function urlSafeBase64Encode(str) {
  const utf8 = unescape(encodeURIComponent(str))
  const base64 = btoa(utf8)
  return base64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '')
}

function urlSafeBase64Decode(str) {
  let base64Str = String(str).replace(/-/g, '+').replace(/_/g, '/')
  while (base64Str.length % 4 !== 0) {
    base64Str += '='
  }
  try {
    const decodedBytes = atob(base64Str)
    return decodeURIComponent(escape(decodedBytes))
  } catch (e) {
    throw new Error('Base64解码失败，token格式错误')
  }
}

/**
 * 解析 URL token 得到账号密码
 * @param {string} token
 * @returns {{ account: string, password: string }}
 */
export function parseAccountPwd(token) {
  try {
    const baseStr = urlSafeBase64Decode(token)
    const offset = parseInt(baseStr[0], 10)
    const checkBit = parseInt(baseStr[baseStr.length - 1], 10)

    if (isNaN(offset) || isNaN(checkBit) || offset + checkBit !== 10) {
      throw new Error('验证信息失败，请重新进入！')
    }

    const encryptedPart = baseStr.slice(1, -1)
    if (encryptedPart.length !== 24) {
      throw new Error('验证信息失败，请重新进入！')
    }

    const decryptedChars = []
    for (let i = 0; i < encryptedPart.length; i++) {
      decryptedChars.push(String.fromCharCode(encryptedPart.charCodeAt(i) - offset))
    }

    let account = ''
    let password = ''
    for (let i = 0; i < decryptedChars.length; i++) {
      if (i % 2 === 0) {
        account += decryptedChars[i]
      } else {
        password += decryptedChars[i]
      }
    }

    if (account.length !== 12 || password.length !== 12) {
      throw new Error('解析出的账号/密码长度不符合要求')
    }

    return { account, password }
  } catch (e) {
    throw new Error(`解析失败：${e.message}`)
  }
}

/**
 * 生成加密登录 token（联调/测试用）
 * @param {string} account 12 位账号
 * @param {string} password 12 位密码
 * @param {number} [offset=3] 偏移量 1-9
 */
export function buildLoginToken(account, password, offset = 3) {
  if (!account || account.length !== 12 || !password || password.length !== 12) {
    throw new Error('账号/密码必须各为 12 位')
  }
  if (!Number.isInteger(offset) || offset < 1 || offset > 9) {
    throw new Error('offset 须为 1-9 的整数')
  }

  let interleaved = ''
  for (let i = 0; i < 12; i++) {
    interleaved += account[i] + password[i]
  }

  let encrypted = ''
  for (let i = 0; i < interleaved.length; i++) {
    encrypted += String.fromCharCode(interleaved.charCodeAt(i) + offset)
  }

  const checkBit = 10 - offset
  return urlSafeBase64Encode(String(offset) + encrypted + String(checkBit))
}

/** 读取是否启用 URL token 自动登录 */
export function isLoginTokenEnabled() {
  const mode = import.meta.env.VITE_LOGIN_MODE || 'hybrid'
  const enabled = String(import.meta.env.VITE_LOGIN_TOKEN_ENABLED || 'true') === 'true'
  return enabled && (mode === 'hybrid' || mode === 'auto_token')
}

/** 是否展示登录表单 */
export function isLoginFormEnabled() {
  const mode = import.meta.env.VITE_LOGIN_MODE || 'hybrid'
  return mode === 'hybrid' || mode === 'form'
}

/** 是否预填账号密码 */
export function isLoginPrefillEnabled() {
  return String(import.meta.env.VITE_LOGIN_PREFILL || 'false') === 'true'
}

export function getLoginPrefillCredentials() {
  return {
    username: import.meta.env.VITE_LOGIN_DEFAULT_USERNAME || '',
    password: import.meta.env.VITE_LOGIN_DEFAULT_PASSWORD || ''
  }
}
