/**
 * 登录加密令牌编解码自检
 * 用法：node scripts/verify-login-token.mjs
 */

function urlSafeBase64Encode(str) {
  const utf8 = unescape(encodeURIComponent(str))
  const base64 = Buffer.from(utf8, 'binary').toString('base64')
  return base64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '')
}

function urlSafeBase64Decode(str) {
  let base64Str = String(str).replace(/-/g, '+').replace(/_/g, '/')
  while (base64Str.length % 4 !== 0) base64Str += '='
  const decodedBytes = Buffer.from(base64Str, 'base64').toString('binary')
  return decodeURIComponent(escape(decodedBytes))
}

function parseAccountPwd(token) {
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
    if (i % 2 === 0) account += decryptedChars[i]
    else password += decryptedChars[i]
  }
  if (account.length !== 12 || password.length !== 12) {
    throw new Error('解析出的账号/密码长度不符合要求')
  }
  return { account, password }
}

function buildLoginToken(account, password, offset = 3) {
  if (!account || account.length !== 12 || !password || password.length !== 12) {
    throw new Error('账号/密码必须各为 12 位')
  }
  if (!Number.isInteger(offset) || offset < 1 || offset > 9) {
    throw new Error('offset 须为 1-9 的整数')
  }
  let interleaved = ''
  for (let i = 0; i < 12; i++) interleaved += account[i] + password[i]
  let encrypted = ''
  for (let i = 0; i < interleaved.length; i++) {
    encrypted += String.fromCharCode(interleaved.charCodeAt(i) + offset)
  }
  const checkBit = 10 - offset
  return urlSafeBase64Encode(String(offset) + encrypted + String(checkBit))
}

function assert(cond, msg) {
  if (!cond) throw new Error(msg)
}

const account = 'Admin7s9k2G5'
const password = '7sK2pG9dR3tQ'

const token = buildLoginToken(account, password, 3)
console.log('built token:', token)

const parsed = parseAccountPwd(token)
assert(parsed.account === account, `account mismatch: ${parsed.account}`)
assert(parsed.password === password, `password mismatch: ${parsed.password}`)

for (const offset of [1, 3, 5, 9]) {
  const t = buildLoginToken(account, password, offset)
  const p = parseAccountPwd(t)
  assert(p.account === account && p.password === password, `roundtrip fail offset=${offset}`)
}

let threw = false
try { parseAccountPwd('not-a-valid-token') } catch { threw = true }
assert(threw, 'invalid token should throw')

threw = false
try { buildLoginToken('short', password) } catch { threw = true }
assert(threw, 'short account should throw')

console.log('OK: loginToken encode/decode verified')
