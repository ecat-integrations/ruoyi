/**
 * 界面头部展示的版本号。
 *
 * 该值由 vite.config.js 通过 define 注入（全局常量 __ECAT_APP_VERSION__），
 * 优先级：环境变量 VITE_APP_VERSION > 核心版本 ecat.core.version（pom.xml） > package.json。
 * 因此升级核心版本后前端会自动跟随，无需在此硬编码。
 */
/* global __ECAT_APP_VERSION__ */
const version =
  typeof __ECAT_APP_VERSION__ !== 'undefined' && __ECAT_APP_VERSION__
    ? String(__ECAT_APP_VERSION__).trim()
    : ''

/** 原始版本号，例如 3.1.0 */
export const appVersion = version

/** 带 v 前缀的展示文案，例如 v3.1.0；版本号本身以 v/V 开头时不会重复添加 */
export const appVersionLabel = version ? `v${version.replace(/^v/i, '')}` : ''
