-- ============================================================
-- ecat 增量脚本（PostgreSQL）
--
-- 用途：对"已初始化"的数据库做增量变更，按时间顺序向下追加，保持幂等（可重复执行）。
-- 全量初始化脚本请使用：sql/public_no_shard.sql
-- ============================================================


-- ------------------------------------------------------------
-- 2026-09-11  Web端默认首页路由（sys_config: ecat.web.home）
--
-- 登录后默认打开的页面；留空则回退内置首页 /index。
-- 取值示例：
--   国控/省控 ADM 监测首页   : /ecat-integrations/integration-env-air-device-manager/air-device-manager/index/monitor_home
--
-- 说明：/station 等调试阶段页面不作为默认值，需要时可自行显式配置。
--
-- 配置入口：系统管理 → 参数设置 → ecat.web.home
-- 前端会校验目标路由是否已注册，未部署/无权限时自动降级，不会白屏。
-- ------------------------------------------------------------
INSERT INTO "public"."sys_config" (config_name, config_key, config_value, config_type, create_by, create_time, remark)
SELECT 'Web端-默认首页路由', 'ecat.web.home', '', 'N', 'admin', current_timestamp,
       '登录后默认打开的页面路由；留空回退内置首页 /index'
WHERE NOT EXISTS (SELECT 1 FROM "public"."sys_config" WHERE config_key = 'ecat.web.home');


-- ------------------------------------------------------------
-- 2026-09-14  系统管理 → 备份还原（引导入口）
--
-- 定位：本页只做「引导」，后端不执行备份命令。后端以 Windows 服务运行在会话 0，
--       无法呈现交互界面，也无法让用户确认「停止服务」这类高影响操作。
--       因此真正的备份/还原由安装目录 bin 下的守护工具（备份还原页）执行，
--       本页提供风险提示 + 分步引导 + 快照只读列表；打开按钮需先勾选确认风险。
--
-- 可见范围：默认仅管理员。这里刻意不写入 sys_role_menu，其他角色如需使用，
--           请在「系统管理 → 角色管理」中勾选「备份还原」。
-- 权限标识：system:backup:list（查看引导页与快照列表）
--           system:backup:open（打开守护工具的备份还原页）
-- 页面：    ruoyi-ui-v3/src/views/system/backup/index.vue
-- 接口：    GET  /system/backup/info
--           POST /system/backup/open-guardian
--
-- 幂等与取号：不写死 menu_id。各环境（含现场升级库）的菜单 id 早已各自增长，
--             例如 2211~2215 已被 quality_control 占用，写死 id 会撞主键或被
--             WHERE NOT EXISTS 静默跳过。这里改为按 perms 判存在 + 由序列取号，
--             子菜单通过子查询挂到刚插入的父菜单上，可重复执行。
-- 命名：该功能的对外名称统一为「备份还原」，此处 INSERT 用新名，
--       并通过下方 UPDATE 兼容此前已按「备份与恢复」写入的库。
-- ------------------------------------------------------------
-- 先让序列跟上实际最大 id：全量脚本与历史升级都是显式指定 id 的，序列常年落后
-- （现场实测 max(menu_id)=2215 而 last_value=2187），不校正会导致下方插入失败。
SELECT setval('"public"."sys_menu_menu_id_seq"',
              GREATEST((SELECT COALESCE(MAX(menu_id), 1) FROM "public"."sys_menu"),
                       (SELECT last_value FROM "public"."sys_menu_menu_id_seq")));

INSERT INTO "public"."sys_menu" (
    menu_name, parent_id, order_num, path, component, query, route_name,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_by, create_time, update_by, update_time, remark)
SELECT '备份还原', 1, 10, 'backup', 'system/backup/index', NULL, 'Backup',
       1, 0, 'C', '0', 0, 'system:backup:list', 'zip',
       'admin', current_timestamp, '', NULL, '备份还原引导入口（默认仅管理员）'
WHERE NOT EXISTS (SELECT 1 FROM "public"."sys_menu" WHERE perms = 'system:backup:list');

INSERT INTO "public"."sys_menu" (
    menu_name, parent_id, order_num, path, component, query, route_name,
    is_frame, is_cache, menu_type, visible, status, perms, icon,
    create_by, create_time, update_by, update_time, remark)
SELECT '打开守护工具', parent.menu_id, 1, NULL, NULL, NULL, '',
       1, 0, 'F', '0', 0, 'system:backup:open', '#',
       'admin', current_timestamp, '', NULL, '打开守护工具的备份还原页'
FROM "public"."sys_menu" parent
WHERE parent.perms = 'system:backup:list'
  AND NOT EXISTS (SELECT 1 FROM "public"."sys_menu" WHERE perms = 'system:backup:open');

-- 兼容早期已写入「备份与恢复」命名的库：统一改名为「备份还原」，并同步备注
UPDATE "public"."sys_menu"
   SET menu_name = '备份还原',
       remark = '备份还原引导入口（默认仅管理员）',
       update_time = current_timestamp
 WHERE perms = 'system:backup:list'
   AND (menu_name <> '备份还原' OR remark <> '备份还原引导入口（默认仅管理员）');

UPDATE "public"."sys_menu"
   SET remark = '打开守护工具的备份还原页', update_time = current_timestamp
 WHERE perms = 'system:backup:open'
   AND (menu_name <> '打开守护工具' OR remark <> '打开守护工具的备份还原页');
