/**
 * 设备造型 SVG（扁平拟物，每种设备有辨识度轮廓）
 */
export const DEVICE_ICON_SHAPES = {
  analyzer_so2: `
    <rect x="14" y="10" width="36" height="44" rx="2" fill="#334155" stroke="#94a3b8" stroke-width="1.2"/>
    <rect x="18" y="14" width="28" height="12" rx="1" fill="#0f172a" stroke="#38bdf8" stroke-width="0.8"/>
    <text x="32" y="23" text-anchor="middle" font-size="8" fill="#38bdf8" font-weight="bold">SO₂</text>
    <rect x="18" y="30" width="28" height="3" fill="#475569"/><rect x="18" y="36" width="20" height="3" fill="#475569"/>
    <circle cx="22" cy="44" r="2" fill="#22c55e"/><rect x="26" y="42" width="16" height="4" rx="1" fill="#1e293b"/>
  `,
  analyzer_o3: `
    <rect x="14" y="10" width="36" height="44" rx="2" fill="#334155" stroke="#94a3b8" stroke-width="1.2"/>
    <rect x="18" y="14" width="28" height="12" rx="1" fill="#0f172a" stroke="#a78bfa" stroke-width="0.8"/>
    <text x="32" y="23" text-anchor="middle" font-size="8" fill="#a78bfa" font-weight="bold">O₃</text>
    <path d="M20 32h24M20 38h18" stroke="#64748b" stroke-width="1.5"/>
    <circle cx="22" cy="44" r="2" fill="#22c55e"/>
  `,
  analyzer_no2: `
    <rect x="14" y="10" width="36" height="44" rx="2" fill="#334155" stroke="#94a3b8" stroke-width="1.2"/>
    <rect x="18" y="14" width="28" height="12" rx="1" fill="#0f172a" stroke="#f472b6" stroke-width="0.8"/>
    <text x="32" y="23" text-anchor="middle" font-size="8" fill="#f472b6" font-weight="bold">NO₂</text>
    <rect x="20" y="30" width="24" height="10" rx="1" fill="none" stroke="#64748b" stroke-width="1"/>
    <circle cx="22" cy="44" r="2" fill="#22c55e"/>
  `,
  analyzer_co: `
    <rect x="14" y="10" width="36" height="44" rx="2" fill="#334155" stroke="#94a3b8" stroke-width="1.2"/>
    <rect x="18" y="14" width="28" height="12" rx="1" fill="#0f172a" stroke="#fb923c" stroke-width="0.8"/>
    <text x="32" y="23" text-anchor="middle" font-size="8" fill="#fb923c" font-weight="bold">CO</text>
    <ellipse cx="32" cy="36" rx="10" ry="6" fill="none" stroke="#64748b" stroke-width="1.2"/>
    <circle cx="22" cy="44" r="2" fill="#22c55e"/>
  `,
  analyzer_pm10: `
    <rect x="12" y="12" width="40" height="40" rx="2" fill="#f1f5f9" stroke="#94a3b8" stroke-width="1.5"/>
    <circle cx="32" cy="28" r="11" fill="#e2e8f0" stroke="#64748b" stroke-width="2"/>
    <circle cx="32" cy="28" r="5" fill="#cbd5e1"/>
    <path d="M26 28h12M32 22v12" stroke="#94a3b8" stroke-width="1"/>
    <text x="32" y="48" text-anchor="middle" font-size="7" fill="#475569">PM10</text>
  `,
  analyzer_pm25: `
    <rect x="12" y="12" width="40" height="40" rx="2" fill="#f1f5f9" stroke="#94a3b8" stroke-width="1.5"/>
    <circle cx="32" cy="28" r="9" fill="#e2e8f0" stroke="#64748b" stroke-width="2"/>
    <circle cx="32" cy="28" r="3" fill="#cbd5e1"/>
    <text x="32" y="48" text-anchor="middle" font-size="6" fill="#475569">PM2.5</text>
  `,
  meteo_station: `
    <line x1="32" y1="6" x2="32" y2="40" stroke="#64748b" stroke-width="2.5"/>
    <path d="M32 10 L44 22 L32 17 L20 22 Z" fill="#38bdf8" stroke="#0ea5e9"/>
    <ellipse cx="32" cy="46" rx="12" ry="3" fill="#334155"/>
    <path d="M18 46 Q32 36 46 46" fill="none" stroke="#64748b" stroke-width="1.5"/>
    <circle cx="32" cy="6" r="2" fill="#94a3b8"/>
  `,
  sampling_inlet_pm25: `
    <ellipse cx="32" cy="10" rx="8" ry="3" fill="#94a3b8"/>
    <rect x="27" y="10" width="10" height="32" rx="2" fill="#cbd5e1" stroke="#64748b" stroke-width="1.5"/>
    <path d="M22 42h20l-3 10H25z" fill="#64748b"/>
    <text x="32" y="28" text-anchor="middle" font-size="6" fill="#475569">2.5</text>
  `,
  sampling_inlet_pm10: `
    <ellipse cx="32" cy="8" rx="10" ry="3.5" fill="#94a3b8"/>
    <rect x="25" y="8" width="14" height="34" rx="2" fill="#cbd5e1" stroke="#64748b" stroke-width="1.5"/>
    <path d="M20 42h24l-3 12H23z" fill="#64748b"/>
    <text x="32" y="28" text-anchor="middle" font-size="6" fill="#475569">10</text>
  `,
  sampling_main_pipe: `
    <path d="M4 36h56" stroke="#64748b" stroke-width="8" stroke-linecap="round"/>
    <path d="M4 36h56" stroke="#cbd5e1" stroke-width="4" stroke-linecap="round"/>
    <path d="M46 36V24M46 36V48" stroke="#64748b" stroke-width="2.5"/>
    <circle cx="46" cy="36" r="3" fill="#38bdf8"/>
  `,
  calibrator: `
    <rect x="6" y="24" width="52" height="20" rx="2" fill="#f8fafc" stroke="#64748b" stroke-width="1.5"/>
    <rect x="12" y="28" width="14" height="10" rx="1" fill="#0f172a"/>
    <circle cx="38" cy="33" r="6" fill="none" stroke="#64748b" stroke-width="1.5"/>
    <path d="M48 26v14" stroke="#64748b" stroke-width="2"/>
    <circle cx="48" cy="26" r="2" fill="#38bdf8"/>
  `,
  zero_gas_generator: `
    <rect x="10" y="18" width="44" height="28" rx="3" fill="#f1f5f9" stroke="#64748b" stroke-width="1.5"/>
    <circle cx="32" cy="32" r="10" fill="none" stroke="#0ea5e9" stroke-width="2"/>
    <path d="M32 22v20M22 32h20" stroke="#0ea5e9" stroke-width="1.5"/>
    <text x="32" y="52" text-anchor="middle" font-size="7" fill="#64748b">零气</text>
  `,
  filter_changer: `
    <circle cx="32" cy="32" r="20" fill="#1e293b" stroke="#38bdf8" stroke-width="2"/>
    <circle cx="32" cy="32" r="7" fill="#334155" stroke="#7dd3fc" stroke-width="1.5"/>
    <path d="M32 12v8M32 44v8M12 32h8M44 32h8" stroke="#38bdf8" stroke-width="2"/>
    <path d="M22 22l6 6M42 22l-6 6M22 42l6-6M42 42l-6-6" stroke="#475569" stroke-width="1.2"/>
  `,
  gas_cylinder: `
    <ellipse cx="32" cy="50" rx="15" ry="4" fill="#1e293b"/>
    <path d="M18 20h28v28c0 5-6 8-14 8s-14-3-14-8V20z" fill="#cbd5e1" stroke="#64748b" stroke-width="2"/>
    <rect x="28" y="10" width="8" height="12" rx="1" fill="#64748b"/>
    <circle cx="32" cy="12" r="2.5" fill="#ef4444"/>
    <ellipse cx="32" cy="20" rx="14" ry="3" fill="#e2e8f0"/>
  `,
  filter_tape: `
    <circle cx="20" cy="34" r="15" fill="#f1f5f9" stroke="#64748b" stroke-width="2"/>
    <circle cx="20" cy="34" r="5" fill="#94a3b8"/>
    <circle cx="46" cy="34" r="11" fill="none" stroke="#64748b" stroke-width="2"/>
    <path d="M35 34h8" stroke="#64748b" stroke-width="2"/>
  `,
  camera: `
    <line x1="24" y1="18" x2="24" y2="26" stroke="#64748b" stroke-width="2"/>
    <rect x="12" y="26" width="24" height="16" rx="2" fill="#1e293b" stroke="#38bdf8" stroke-width="1.5"/>
    <circle cx="22" cy="34" r="5" fill="#0f172a" stroke="#38bdf8" stroke-width="1.2"/>
    <path d="M36 30l12-5v18l-12-5z" fill="#334155" stroke="#7dd3fc" stroke-width="1"/>
  `,
  access_control: `
    <rect x="16" y="10" width="32" height="44" rx="3" fill="#f8fafc" stroke="#64748b" stroke-width="1.5"/>
    <rect x="20" y="14" width="24" height="18" rx="2" fill="#0f172a"/>
    <circle cx="32" cy="24" r="6" fill="none" stroke="#38bdf8" stroke-width="1.5"/>
    <rect x="24" y="38" width="16" height="4" rx="1" fill="#64748b"/>
    <path d="M20 48h24" stroke="#94a3b8" stroke-width="2"/>
  `,
  security_alarm: `
    <path d="M32 6 L56 18 V36 C56 48 44 54 32 58 C20 54 8 48 8 36 V18 Z" fill="#292524" stroke="#f59e0b" stroke-width="2"/>
    <text x="32" y="38" text-anchor="middle" font-size="16" fill="#fbbf24" font-weight="bold">!</text>
  `,
  th_sensor: `
    <rect x="30" y="8" width="4" height="16" fill="#64748b"/>
    <circle cx="32" cy="34" r="13" fill="#fef2f2" stroke="#64748b" stroke-width="2"/>
    <path d="M28 34h8M32 30v8" stroke="#ef4444" stroke-width="2"/>
    <text x="32" y="54" text-anchor="middle" font-size="7" fill="#64748b">温湿度</text>
  `,
  indoor_sensor: `
    <rect x="12" y="18" width="40" height="26" rx="3" fill="#1e293b" stroke="#38bdf8" stroke-width="1.5"/>
    <path d="M16 38 Q32 26 48 38" fill="none" stroke="#38bdf8" stroke-width="1.5"/>
    <circle cx="18" cy="24" r="2.5" fill="#22c55e"/>
    <circle cx="28" cy="24" r="2.5" fill="#eab308"/>
    <circle cx="38" cy="24" r="2.5" fill="#38bdf8"/>
  `,
  ups: `
    <rect x="8" y="14" width="48" height="36" rx="3" fill="#f1f5f9" stroke="#64748b" stroke-width="1.5"/>
    <rect x="14" y="20" width="11" height="20" rx="1" fill="#334155"/>
    <rect x="28" y="20" width="11" height="20" rx="1" fill="#475569"/>
    <rect x="42" y="20" width="8" height="20" rx="1" fill="#64748b"/>
    <text x="32" y="54" text-anchor="middle" font-size="8" fill="#334155" font-weight="bold">UPS</text>
  `,
  power_meter: `
    <rect x="12" y="14" width="40" height="34" rx="2" fill="#f8fafc" stroke="#64748b" stroke-width="1.5"/>
    <circle cx="32" cy="30" r="11" fill="#0f172a" stroke="#38bdf8" stroke-width="1.5"/>
    <path d="M32 22v16M24 30h16" stroke="#38bdf8" stroke-width="1.5"/>
    <text x="32" y="54" text-anchor="middle" font-size="7" fill="#64748b">电表</text>
  `,
  voltage_regulator: `
    <rect x="6" y="12" width="52" height="38" rx="2" fill="#f1f5f9" stroke="#64748b" stroke-width="1.5"/>
    <line x1="14" y1="22" x2="50" y2="22" stroke="#64748b" stroke-width="1"/>
    <line x1="14" y1="30" x2="50" y2="30" stroke="#64748b" stroke-width="1"/>
    <line x1="14" y1="38" x2="50" y2="38" stroke="#64748b" stroke-width="1"/>
    <circle cx="18" cy="22" r="2.5" fill="#22c55e"/>
    <circle cx="18" cy="30" r="2.5" fill="#22c55e"/>
    <circle cx="18" cy="38" r="2.5" fill="#eab308"/>
  `,
  air_conditioner: `
    <rect x="6" y="22" width="52" height="20" rx="2" fill="#f8fafc" stroke="#64748b" stroke-width="1.5"/>
    <path d="M12 28h40M12 33h40M12 38h40" stroke="#94a3b8" stroke-width="1.2"/>
    <path d="M48 22c6 4 6 16 0 20" fill="none" stroke="#38bdf8" stroke-width="2"/>
    <text x="32" y="52" text-anchor="middle" font-size="6" fill="#64748b">空调</text>
  `,
  exhaust_fan: `
    <rect x="10" y="10" width="44" height="44" rx="4" fill="#1e293b" stroke="#64748b" stroke-width="1.5"/>
    <circle cx="32" cy="32" r="16" fill="none" stroke="#38bdf8" stroke-width="1.5"/>
    <path d="M32 16c5 7 5 14 0 16c-5-2-5-9 0-16z M48 32c-7 5-14 5-16 0c2-5 9-5 16 0z M32 48c-5-7-5-14 0-16c5 2 5 9 0 16z M16 32c7-5 14-5 16 0c-2 5-9 5-16 0z" fill="#38bdf8" opacity="0.8"/>
    <circle cx="32" cy="32" r="3" fill="#0f172a"/>
  `,
  lighting: `
    <line x1="32" y1="8" x2="32" y2="16" stroke="#64748b" stroke-width="2"/>
    <path d="M24 16h16v5c0 9-16 9-16 0v-5z" fill="#fef08a" stroke="#eab308" stroke-width="1.5"/>
    <path d="M26 34h12l-2 12h-8z" fill="#94a3b8"/>
  `,
  relay_switch: `
    <rect x="10" y="22" width="44" height="22" rx="2" fill="#f1f5f9" stroke="#64748b" stroke-width="1.5"/>
    <rect x="16" y="28" width="9" height="10" rx="1" fill="#22c55e"/>
    <rect x="28" y="28" width="9" height="10" rx="1" fill="#64748b"/>
    <rect x="40" y="28" width="6" height="10" rx="1" fill="#64748b"/>
    <text x="32" y="52" text-anchor="middle" font-size="6" fill="#64748b">继电器</text>
  `,
  default: `
    <circle cx="32" cy="32" r="18" fill="#1e293b" stroke="#7dd3fc" stroke-width="2"/>
    <text x="32" y="36" text-anchor="middle" font-size="12" fill="#7dd3fc">?</text>
  `
}

export const HEALTH_RING_COLORS = {
  normal: '#22c55e',
  warning: '#eab308',
  alarm: '#ef4444',
  offline: '#64748b',
  unknown: '#475569'
}

export function getDeviceShape(type) {
  return DEVICE_ICON_SHAPES[type] || DEVICE_ICON_SHAPES.default
}
