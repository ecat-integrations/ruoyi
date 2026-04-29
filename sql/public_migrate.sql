/*
 文件说明:
   用于将postgresql12 升级postgres18时，旧库表中的设置数据及记录数据迁移到新库表中
 注意事项:
   确保旧PG12数据库服务在localhost中以端口5433端口启动;
   确保新PG18数据库服务在localhost中以端口5432端口启动;
 执行步骤:
   打开 pgAdmin
   连接 PG18
   进入数据库 ecat
   打开 Query Tool
   粘贴 → 执行
 脚本做了什么:
   完整迁移各表所有数据 + 主键 ID
   自动清空目标表
   自动把sequence号设置为当前表最大 ID

 Date: 16/04/2026 14:44:47
*/


-- 开启跨库连接
CREATE EXTENSION IF NOT EXISTS dblink;
SET search_path TO public;

-- =============================================
-- 1. env_alarm_settings (id)
-- =============================================
TRUNCATE TABLE env_alarm_settings;
INSERT INTO env_alarm_settings SELECT * FROM dblink(
                                                     'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                     'SELECT * FROM env_alarm_settings'
                                             ) AS t(id int4, alarm_type varchar(50), setting_content text, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6), sort int4);
SELECT setval(pg_get_serial_sequence('env_alarm_settings','id'), COALESCE(MAX(id),1)) FROM env_alarm_settings;

-- =============================================
-- 2. env_device_settings (id)
-- =============================================
TRUNCATE TABLE env_device_settings;
INSERT INTO env_device_settings SELECT * FROM dblink(
                                                      'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                      'SELECT * FROM env_device_settings'
                                              ) AS t(id int4, device_name varchar(100), device_type varchar(50), sort int4, setting_content text, device_id varchar(50), created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_device_settings','id'), COALESCE(MAX(id),1)) FROM env_device_settings;

-- =============================================
-- 3. env_material_manager (id)
-- =============================================
TRUNCATE TABLE env_material_manager;
INSERT INTO env_material_manager SELECT * FROM dblink(
                                                       'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                       'SELECT * FROM env_material_manager'
                                               ) AS t(id int4, material_code varchar(50), material_name varchar(100), material_type varchar(50), specification varchar(100), manufacturer varchar(100), production_date date, expiry_date date, warehousing_time timestamp(6), material_capacity numeric(10,3), material_capacity_unit varchar(100), material_remain_capacity numeric(10,3), material_status int4, storage_location varchar(100), remarks text, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6), material_content text);
SELECT setval(pg_get_serial_sequence('env_material_manager','id'), COALESCE(MAX(id),1)) FROM env_material_manager;

-- =============================================
-- 4. sys_job (job_id)
-- =============================================
TRUNCATE TABLE sys_job;
INSERT INTO sys_job SELECT * FROM dblink(
                                          'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                          'SELECT * FROM sys_job'
                                  ) AS t(job_id int8, job_name varchar(64), job_group varchar(64), invoke_target varchar(500), cron_expression varchar(255), misfire_policy varchar(20), concurrent char(1), status char(1), create_by varchar(64), create_time timestamp(6), update_by varchar(64), update_time timestamp(6), remark varchar(500));
SELECT setval('sys_job_job_id_seq', COALESCE(MAX(job_id),1)) FROM sys_job;

-- =============================================
-- 5. sys_user (user_id)
-- =============================================
TRUNCATE TABLE sys_user;
INSERT INTO sys_user SELECT * FROM dblink(
                                           'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                           'SELECT * FROM sys_user'
                                   ) AS t(user_id int8, dept_id int8, user_name varchar(30), nick_name varchar(30), user_type varchar(2), email varchar(50), phonenumber varchar(11), sex char(1), avatar varchar(100), password varchar(100), status char(1), del_flag char(1), login_ip varchar(128), login_date timestamp(6), create_by varchar(64), create_time timestamp(6), update_by varchar(64), update_time timestamp(6), remark varchar(500));
SELECT setval('sys_user_user_id_seq', COALESCE(MAX(user_id),1)) FROM sys_user;

-- =============================================
-- 6. sys_job_log (job_log_id)
-- =============================================
TRUNCATE TABLE sys_job_log;
INSERT INTO sys_job_log SELECT * FROM dblink(
                                              'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                              'SELECT * FROM sys_job_log'
                                      ) AS t(job_log_id int8, job_name varchar(64), job_group varchar(64), invoke_target varchar(500), job_message varchar(500), status char(1), exception_info varchar(2000), create_time timestamp(6));
SELECT setval('sys_job_log_job_log_id_seq', COALESCE(MAX(job_log_id),1)) FROM sys_job_log;

-- =============================================
-- 7. sys_oper_log (oper_id)
-- =============================================
TRUNCATE TABLE sys_oper_log;
INSERT INTO sys_oper_log SELECT * FROM dblink(
                                               'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                               'SELECT * FROM sys_oper_log'
                                       ) AS t(oper_id int8, title varchar(50), business_type int4, method varchar(255), request_method varchar(10), operator_type int4, oper_name varchar(50), dept_name varchar(50), oper_url varchar(255), oper_ip varchar(128), oper_location varchar(255), oper_param varchar(2000), json_result varchar(2000), status int4, error_msg varchar(2000), oper_time timestamp(6), cost_time int8);
SELECT setval('sys_oper_log_oper_id_seq', COALESCE(MAX(oper_id),1)) FROM sys_oper_log;

-- =============================================
-- 8. env_access_control_records (id)
-- =============================================
TRUNCATE TABLE env_access_control_records;
INSERT INTO env_access_control_records SELECT * FROM dblink(
                                                             'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                             'SELECT * FROM env_access_control_records'
                                                     ) AS t(id int4, device_name varchar(100), device_ip varchar(50), device_mac varchar(50), employee_id varchar(50), employee_name varchar(50), access_method varchar(50), setting_content text, result_json text, file_json text, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_access_control_records','id'), COALESCE(MAX(id),1)) FROM env_access_control_records;

-- =============================================
-- 9. env_data_manager_alarms (alarm_id)
-- =============================================
TRUNCATE TABLE env_data_manager_alarms;
INSERT INTO env_data_manager_alarms SELECT * FROM dblink(
                                                          'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                          'SELECT * FROM env_data_manager_alarms'
                                                  ) AS t(alarm_id int4, alarm_type int4, start_time timestamp(6), update_time timestamp(6), end_time timestamp(6), description text, severity_level varchar(20), status varchar(20), created_by varchar(50), updated_by varchar(50), sta_code varchar(50), result_content text);
SELECT setval(pg_get_serial_sequence('env_data_manager_alarms','alarm_id'), COALESCE(MAX(alarm_id),1)) FROM env_data_manager_alarms;

-- =============================================
-- 10. env_device_setting_records (id)
-- =============================================
TRUNCATE TABLE env_device_setting_records;
INSERT INTO env_device_setting_records SELECT * FROM dblink(
                                                             'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                             'SELECT * FROM env_device_setting_records'
                                                     ) AS t(id int4, device_setting_id int4, device_id varchar, device_setting_time timestamp(6), device_setting_content text, created_by varchar, updated_by varchar, create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_device_setting_records','id'), COALESCE(MAX(id),1)) FROM env_device_setting_records;

-- =============================================
-- 11. env_maintenance_records (id)
-- =============================================
TRUNCATE TABLE env_maintenance_records;
INSERT INTO env_maintenance_records SELECT * FROM dblink(
                                                          'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                          'SELECT * FROM env_maintenance_records'
                                                  ) AS t(id int4, maintenance_mode varchar(50), maintenance_type varchar(20), maintenance_time timestamp(6), maintenance_content text, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_maintenance_records','id'), COALESCE(MAX(id),1)) FROM env_maintenance_records;

-- =============================================
-- 12. env_material_records (id)
-- =============================================
TRUNCATE TABLE env_material_records;
INSERT INTO env_material_records SELECT * FROM dblink(
                                                       'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                       'SELECT * FROM env_material_records'
                                               ) AS t(id int4, material_code varchar(50), usage_time timestamp(6), usage_capacity numeric(10,3), remarks text, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_material_records','id'), COALESCE(MAX(id),1)) FROM env_material_records;

-- =============================================
-- 13. env_patrol_records (id)
-- =============================================
TRUNCATE TABLE env_patrol_records;
INSERT INTO env_patrol_records SELECT * FROM dblink(
                                                     'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                     'SELECT * FROM env_patrol_records'
                                             ) AS t(id int4, generation_time timestamp(6), patrol_type varchar(100), patrol_notes text, patrol_content text, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_patrol_records','id'), COALESCE(MAX(id),1)) FROM env_patrol_records;

-- =============================================
-- 14. env_quality_control_records (id)
-- =============================================
TRUNCATE TABLE env_quality_control_records;
INSERT INTO env_quality_control_records SELECT * FROM dblink(
                                                              'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                              'SELECT * FROM env_quality_control_records'
                                                      ) AS t(id int4, task_type varchar(50), quality_control_type varchar(50), parameter text, start_time timestamp(6), end_time timestamp(6), standard_value numeric, monitoring_data numeric, calculated_value numeric, execution_status int4, execution_log text, result_evaluation text, quality_control_plan_id int4, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6));
SELECT setval(pg_get_serial_sequence('env_quality_control_records','id'), COALESCE(MAX(id),1)) FROM env_quality_control_records;

-- =============================================
-- 15. env_quality_control_report (id)
-- =============================================
TRUNCATE TABLE env_quality_control_report;
INSERT INTO env_quality_control_report SELECT * FROM dblink(
                                                             'dbname=ecat host=localhost port=5433 user=postgres password=iotbasePWD',
                                                             'SELECT * FROM env_quality_control_report'
                                                     ) AS t(id int4, report_name varchar(100), report_type varchar(20), report_date date, instrument_name varchar(100), instrument_no varchar(50), gas_type varchar(50), filer varchar(50), reviewer varchar(50), maintenance_company varchar(100), report_content text, report_note text, is_discarded bool, created_by varchar(50), updated_by varchar(50), create_time timestamp(6), update_time timestamp(6), gas_source varchar(50), gas_no varchar(50));
SELECT setval('env_quality_control_report_id_seq', COALESCE(MAX(id),1)) FROM env_quality_control_report;

-- 完成
SELECT '✅ 15张表迁移完成 + 自增序列已同步到最大值，后续新增无冲突' AS result;
