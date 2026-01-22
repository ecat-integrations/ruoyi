/*
 Navicat Premium Data Transfer

 Source Server         : postgresql
 Source Server Type    : PostgreSQL
 Source Server Version : 120009
 Source Host           : 127.0.0.1:5432
 Source Catalog        : ecat
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120009
 File Encoding         : 65001

 Date: 22/12/2025 14:44:47
*/
-- ----------------------------
-- Sequence structure for env_quality_control_report_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."env_quality_control_report_id_seq";
CREATE SEQUENCE "public"."env_quality_control_report_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for gen_table_column_column_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."gen_table_column_column_id_seq";
CREATE SEQUENCE "public"."gen_table_column_column_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for gen_table_table_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."gen_table_table_id_seq";
CREATE SEQUENCE "public"."gen_table_table_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for his_data_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."his_data_id_seq";
CREATE SEQUENCE "public"."his_data_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for moketableindex
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."moketableindex";
CREATE SEQUENCE "public"."moketableindex" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9999999
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for paid
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."paid";
CREATE SEQUENCE "public"."paid" 
INCREMENT 1
MINVALUE  1
MAXVALUE 999999999999999
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for stid
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."stid";
CREATE SEQUENCE "public"."stid" 
INCREMENT 1
MINVALUE  1
MAXVALUE 99999999999999
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_config_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_config_config_id_seq";
CREATE SEQUENCE "public"."sys_config_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_dept_dept_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_dept_dept_id_seq";
CREATE SEQUENCE "public"."sys_dept_dept_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_dict_data_dict_code_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_dict_data_dict_code_seq";
CREATE SEQUENCE "public"."sys_dict_data_dict_code_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_dict_type_dict_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_dict_type_dict_id_seq";
CREATE SEQUENCE "public"."sys_dict_type_dict_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_job_job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_job_job_id_seq";
CREATE SEQUENCE "public"."sys_job_job_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_job_log_job_log_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_job_log_job_log_id_seq";
CREATE SEQUENCE "public"."sys_job_log_job_log_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_logininfor_info_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_logininfor_info_id_seq";
CREATE SEQUENCE "public"."sys_logininfor_info_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_menu_menu_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_menu_menu_id_seq";
CREATE SEQUENCE "public"."sys_menu_menu_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_notice_notice_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_notice_notice_id_seq";
CREATE SEQUENCE "public"."sys_notice_notice_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_oper_log_oper_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_oper_log_oper_id_seq";
CREATE SEQUENCE "public"."sys_oper_log_oper_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_post_post_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_post_post_id_seq";
CREATE SEQUENCE "public"."sys_post_post_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_role_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_role_role_id_seq";
CREATE SEQUENCE "public"."sys_role_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_user_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_user_user_id_seq";
CREATE SEQUENCE "public"."sys_user_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


-- ----------------------------
-- Sequence structure for tasks_task_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tasks_task_id_seq";
CREATE SEQUENCE "public"."tasks_task_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_id_seq";
CREATE SEQUENCE "public"."user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for env_access_control_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_access_control_records";
CREATE TABLE "public"."env_access_control_records" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "device_name" varchar(100) COLLATE "pg_catalog"."default",
  "device_ip" varchar(50) COLLATE "pg_catalog"."default",
  "device_mac" varchar(50) COLLATE "pg_catalog"."default",
  "employee_id" varchar(50) COLLATE "pg_catalog"."default",
  "employee_name" varchar(50) COLLATE "pg_catalog"."default",
  "access_method" varchar(50) COLLATE "pg_catalog"."default",
  "setting_content" text COLLATE "pg_catalog"."default",
  "result_json" text COLLATE "pg_catalog"."default",
  "file_json" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_access_control_records"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_access_control_records"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."env_access_control_records"."device_ip" IS '设备IP地址';
COMMENT ON COLUMN "public"."env_access_control_records"."device_mac" IS '设备mac地址';
COMMENT ON COLUMN "public"."env_access_control_records"."employee_id" IS '工号';
COMMENT ON COLUMN "public"."env_access_control_records"."employee_name" IS '姓名';
COMMENT ON COLUMN "public"."env_access_control_records"."access_method" IS '打卡方式';
COMMENT ON COLUMN "public"."env_access_control_records"."setting_content" IS '门禁详情';
COMMENT ON COLUMN "public"."env_access_control_records"."result_json" IS '门禁结果';
COMMENT ON COLUMN "public"."env_access_control_records"."file_json" IS '文件内容';
COMMENT ON COLUMN "public"."env_access_control_records"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_access_control_records"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_access_control_records"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_access_control_records"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_access_control_records" IS '门禁记录表';

-- ----------------------------
-- Table structure for env_alarm_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_alarm_settings";
CREATE TABLE "public"."env_alarm_settings" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 20
CACHE 65
),
  "alarm_type" varchar(50) COLLATE "pg_catalog"."default",
  "setting_content" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "sort" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."env_alarm_settings"."id" IS '设置ID';
COMMENT ON COLUMN "public"."env_alarm_settings"."alarm_type" IS '报警类型';
COMMENT ON COLUMN "public"."env_alarm_settings"."setting_content" IS '报警内容';
COMMENT ON COLUMN "public"."env_alarm_settings"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_alarm_settings"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_alarm_settings"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_alarm_settings"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."env_alarm_settings"."sort" IS '排序字段';
COMMENT ON TABLE "public"."env_alarm_settings" IS '报警设置表';

-- ----------------------------
-- Records of env_alarm_settings
-- ----------------------------
INSERT INTO "public"."env_alarm_settings"  VALUES (2, '10', '{"id":134,"device_info":{"xianhe-pm10":["spotsremaining"],"xianhe-pm2.5":["spotsremaining"]},"name":"颗粒物纸带更换","description":"当纸带剩余量低于阈值，给出更换预警提示","icon":"HardDrive","category":"equipment","enabled":true,"configurable":true,"configs":[{"label":"剩余量阈值 (%)","type":"number","value":25,"min":0,"max":100,"step":1},{"label":"","type":"setting","xianhe-pm10":"total_spots","xianhe-pm2.5":"total_spots"}]}', 'admin', 'admin', '2025-05-26 13:47:40', '2025-06-12 16:01:32.73', 140);
INSERT INTO "public"."env_alarm_settings"  VALUES (3, '14', '{"id":72,"device_info":{"sms-qc":["generalalarm"],"sms-calib":["generalalarm"],"xianhe-pm10":["generalalarm"],"xianhe-pm2.5":["generalalarm"],"flying-wis-01":["generalalarm"],"esa-so2":["generalalarm"],"esa-no2":["generalalarm"],"esa-o3":["generalalarm"],"esa-co":["generalalarm"],"sms-power":["generalalarm"],"qdrgdz-01":["generalalarm"]},"name":"监测设备报警","description":"当各个监测设备出现报警时触发","icon":"Settings","category":"equipment","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:20', '2025-06-12 16:37:20.758', 80);
INSERT INTO "public"."env_alarm_settings"  VALUES (4, '8', '{"id":132,"device_info":{"sms-qc":["co_concentration","no2_concentration","so2_concentration","o3_concentration"]},"name":"标准气体泄漏","description":"当检测到标气泄露，超出阈值范围，启动报警并自动开启排风扇","icon":"Wind","category":"gas","enabled":true,"configurable":true,"configs":[{"label":"站房 CO 浓度阈值","type":"number","value":12,"min":0,"max":1000,"step":1,"class":"co_concentration"},{"label":"站房 NO2 浓度阈值","type":"number","value":12,"min":0,"max":1000,"step":1,"class":"no2_concentration"},{"label":"站房 SO2 浓度阈值","type":"number","value":12,"min":0,"max":1000,"step":1,"class":"so2_concentration"},{"label":"","type":"setting","device_id":"sms-qc","param_id":"fan_control"}]}', 'admin', 'admin', '2025-05-26 13:47:19', '2025-07-08 11:34:33.951', 120);
INSERT INTO "public"."env_alarm_settings"  VALUES (5, '9', '{"id":133,"device_info":{"sms-qc":["gas_cylinder1_pressure","gas_cylinder2_pressure","gas_cylinder3_pressure"]},"name":"标准气体更换","description":"当标准气体剩余量低于阈值范围，给出更换预警提示","icon":"Battery","category":"gas","enabled":true,"configurable":true,"configs":[{"label":"SO2 钢瓶气压力阈值（kPa）","type":"number","value":20,"min":0,"max":1000,"step":1,"class":"gas_cylinder1_pressure"},{"label":"NOX 钢瓶气压力阈值（kPa）","type":"number","value":20,"min":0,"max":1000,"step":1,"class":"gas_cylinder2_pressure"},{"label":"CO 钢瓶气压力阈值（kPa）","type":"number","value":20,"min":0,"max":1000,"step":1,"class":"gas_cylinder3_pressure"}]}', 'admin', 'admin', '2025-05-26 13:47:29', '2025-07-05 18:57:37.666', 130);
INSERT INTO "public"."env_alarm_settings"  VALUES (6, '17', '{"id":138,"device_info":{"sms-qc":["infrared_status"]},"name":"异常进入报警","description":"当有人进入站房区域，给出报警提示","icon":"User","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:44', '2025-06-04 12:01:08.268', 180);
INSERT INTO "public"."env_alarm_settings"  VALUES (7, '4', '{"id":68,"device_info":{"sms-qc":["station_ua","station_ub","station_uc"]},"name":"供电电源异常波动","description":"当供电电源的电压超过设定范围，且持续时间超过设定时间，触发报警","icon":"Bolt","category":"power","enabled":true,"configurable":true,"configs":[{"label":"电压范围 (V)","type":"range","value":[200,242],"min":150,"max":300,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:46:23', '2025-07-05 20:05:03.094', 40);
INSERT INTO "public"."env_alarm_settings"  VALUES (8, '3', '{"id":67,"device_info":{"sms-qc":["water_leak_detector"]},"name":"设备间漏水","description":"当设备间任一采样口位置发生漏水，水浸传感器触发报警","icon":"Droplet","category":"environment","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:46:10', '2025-09-10 09:35:04.747', 30);
INSERT INTO "public"."env_alarm_settings"  VALUES (9, '12', '{"id":71,"device_info":{"sms-qc":["sample_tube_temp"]},"name":"采样总管温度异常","description":"当采样总管内样气温度超出阈值范围，且持续时间超过设定时间，触发报警","icon":"Thermometer","category":"sampling","enabled":true,"configurable":true,"configs":[{"label":"温度范围 (℃)","type":"range","value":[10,30],"min":-20,"max":60,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:48:03', '2025-07-08 11:34:24.001', 70);
INSERT INTO "public"."env_alarm_settings"  VALUES (10, '2', '{"id":66,"device_info":{"sms-qc":["bench_humidity"]},"name":"设备间湿度异常","description":"当设备间的湿度传感器测量值超出阈值范围，且持续时间超过设定时间，触发报警","icon":{"name":"Warning","__name":"warning"},"category":"environment","enabled":true,"configurable":true,"configs":[{"label":"湿度范围 (%)","type":"range","value":[30,71],"min":0,"max":100,"step":1},{"label":"持续时间","type":"duration","value":3,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:45:50', '2025-07-08 11:34:16.874', 20);
INSERT INTO "public"."env_alarm_settings"  VALUES (11, '5', '{"id":131,"device_info":{"sms-qc":["ups_input_voltage"]},"name":"稳压电源异常波动","description":"当稳压电源的电压超过设定范围，且持续时间超过设定时间，触发报警","icon":"Gauge","category":"power","enabled":true,"configurable":true,"configs":[{"label":"电压范围 (V)","type":"range","value":[198,242],"min":150,"max":300,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:46:35', '2025-06-04 11:58:19.757', 41);
INSERT INTO "public"."env_alarm_settings"  VALUES (12, '16', '{"id":73,"device_info":{"sms-qc":["smoke_detector1","smoke_detector2"]},"name":"消防报警","description":"当站房发生火情时，烟感报警装置启动报警并主动切断供电电源","icon":"Flame","category":"security","enabled":true,"configurable":true,"configs":[{"label":"","type":"setting","device_id":"sms-power","param_id":"relay_l2"}]}', 'admin', 'admin', '2025-05-26 13:48:37', '2025-07-08 11:34:26.558', 90);
INSERT INTO "public"."env_alarm_settings"  VALUES (13, '11', '{"id":135,"device_info":{"sms-qc":["sampling_tube_residence_time"]},"name":"采样总管流速异常","description":"当采样总管内样气的滞留时间大于设定值，且持续时间超过设定时间，触发报警","icon":"Fan","category":"sampling","enabled":true,"configurable":true,"configs":[{"label":"滞留时间 (s)","type":"number","value":20,"min":5,"max":60,"step":1,"class":"retention"},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:47:53', '2025-06-05 11:37:58.338', 71);
INSERT INTO "public"."env_alarm_settings"  VALUES (14, '15', '{"id":137,"device_info":{"sms-qc":["ups_input_voltage"]},"name":"断电和恢复报警","description":"当监测场地发生断电特殊情况，给出断电报警提示；电源恢复后，给出来电恢复报警提示","icon":"Power","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:29', '2025-06-04 12:01:00.519', 170);
INSERT INTO "public"."env_alarm_settings"  VALUES (16, '18', '{"id":74,"name":"干扰报警","description":"自动识别雾炮喷淋等站房周边人为干扰行为，并给出报警提示","icon":"EyeOff","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:51', '2025-05-26 17:03:57.441', 100);
INSERT INTO "public"."env_alarm_settings"  VALUES (1, '13', '{"id":136,"device_info":{"sms-qc":["so2_gas_temp","nox_gas_temp","co_gas_temp","o3_gas_temp"]},"name":"支管冷凝水预警","description":"当露点温度高于设备间温度时，给出预示并建议空调设定值","icon":"Cloud","category":"sampling","enabled":true,"configurable":true,"configs":[{"label":"温度差值 (℃)","type":"number","value":2,"min":0,"max":10,"step":0.5,"class":"diff"},{"label":"室外温度校准量","type":"number","value":1,"min":0,"max":10,"step":0.1,"class":"coefficient"},{"label":"","type":"setting","rh_device_id":"flying-wis-01","rh_param_id":"humidity","temp_device_id":"flying-wis-01","temp_param_id":"temp","diff_temp_device_id":"sms-qc","diff_temp_param_id":"bench_temp"}]}', 'admin', 'admin', '2025-05-26 13:48:12', '2025-07-08 14:26:54.975', 73);
INSERT INTO "public"."env_alarm_settings"  VALUES (15, '1', '{"id":1,"device_info":{"th901p-001":["temp"]},"name":"设备间温度异常","description":"当设备间的温度传感器测量值超出阈值范围，且持续时间超过设定时间，触发报警","icon":"Thermometer","category":"environment","enabled":true,"configurable":true,"configs":[{"label":"温度范围 (℃)","type":"range","value":[5,35],"min":-20,"max":60,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:39:44', '2025-09-10 09:05:46.27', 10);
INSERT INTO "public"."env_alarm_settings"  VALUES (17, '6', '{"id":69,"device_info":{"sms-qc":["station_ia","station_ib","station_ic"]},"name":"电流异常波动","description":"当供电电流突然升高或降低，超出阈值范围，且持续时间超过设定时间，触发报警","icon":"Zap","category":"power","enabled":true,"configurable":true,"configs":[{"label":"电流范围 (A)","type":"range","value":[5,15],"min":0,"max":30,"step":0.1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:46:51', '2025-07-08 11:34:21.949', 50);
INSERT INTO "public"."env_alarm_settings"  VALUES (18, '19', '{"id":139,"device_info":{"sms-qc":["infrared_status"]},"name":"门禁报警","description":"当非法人员使用门禁时触发报警！","icon":"User","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-07-09 18:36:39', '2025-07-09 18:36:41', 190);
INSERT INTO "public"."env_alarm_settings" VALUES (19, '1000', '{"id":133,"device_info":{"sms-qc":["pm2_5_concentration","pm10_concentration"]},"name":"站房洁净度报警","description":"站房洁净度报警，根据站房颗粒物来判断","icon":"Battery","category":"gas","enabled":true,"configurable":true,"configs":[{"label":"PM10报警阈值","type":"number","value":2000,"min":0,"max":100000,"step":0.01,"class":"sms-qc-pm10_concentration"},{"label":"PM2.5报警阈值","type":"number","value":2000,"min":0,"max":100000,"step":0.01,"class":"sms-qc-pm2_5_concentration"}]}', 'admin', 'admin', '2025-11-11 16:07:59', '2025-11-11 16:08:01', 200);

-- ----------------------------
-- Table structure for env_data_manager_alarms
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_data_manager_alarms";
CREATE TABLE "public"."env_data_manager_alarms" (
  "alarm_id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 10
),
  "alarm_type" int4 NOT NULL,
  "start_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6),
  "end_time" timestamp(6),
  "description" text COLLATE "pg_catalog"."default",
  "severity_level" varchar(20) COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "sta_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'Unknown'::character varying,
  "result_content" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."env_data_manager_alarms"."alarm_id" IS '报警ID';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."alarm_type" IS '报警类型';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."start_time" IS '报警开始时间';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."description" IS '报警描述';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."severity_level" IS '报警等级';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."status" IS '报警状态';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."sta_code" IS '设备编码';
COMMENT ON COLUMN "public"."env_data_manager_alarms"."result_content" IS '解决内容';
COMMENT ON TABLE "public"."env_data_manager_alarms" IS '报警管理';

-- ----------------------------
-- Records of env_data_manager_alarms
-- ----------------------------

-- ----------------------------
-- Table structure for env_data_manager_events
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_data_manager_events";
CREATE TABLE "public"."env_data_manager_events" (
  "event_id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "event_type" int4 NOT NULL,
  "start_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6),
  "end_time" timestamp(6),
  "description" text COLLATE "pg_catalog"."default",
  "severity_level" varchar(20) COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "sta_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'Unknown'::character varying
)
;
COMMENT ON COLUMN "public"."env_data_manager_events"."event_id" IS '事件ID';
COMMENT ON COLUMN "public"."env_data_manager_events"."event_type" IS '事件类型';
COMMENT ON COLUMN "public"."env_data_manager_events"."start_time" IS '事件开始时间';
COMMENT ON COLUMN "public"."env_data_manager_events"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."env_data_manager_events"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."env_data_manager_events"."description" IS '事件描述';
COMMENT ON COLUMN "public"."env_data_manager_events"."severity_level" IS '事件等级';
COMMENT ON COLUMN "public"."env_data_manager_events"."status" IS '事件状态';
COMMENT ON COLUMN "public"."env_data_manager_events"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_data_manager_events"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_data_manager_events"."sta_code" IS '设备编码';
COMMENT ON TABLE "public"."env_data_manager_events" IS '事件管理';

-- ----------------------------
-- Table structure for env_device_setting_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_device_setting_records";
CREATE TABLE "public"."env_device_setting_records" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "device_setting_id" int4 NOT NULL,
  "device_id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "device_setting_time" timestamp(6) NOT NULL,
  "device_setting_content" text COLLATE "pg_catalog"."default",
  "created_by" varchar COLLATE "pg_catalog"."default",
  "updated_by" varchar COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."env_device_setting_records"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_device_setting_records"."device_setting_id" IS '设置ID';
COMMENT ON COLUMN "public"."env_device_setting_records"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."env_device_setting_records"."device_setting_time" IS '设置时间';
COMMENT ON COLUMN "public"."env_device_setting_records"."device_setting_content" IS '内容描述';
COMMENT ON COLUMN "public"."env_device_setting_records"."created_by" IS '创建者';
COMMENT ON COLUMN "public"."env_device_setting_records"."updated_by" IS '更新者';
COMMENT ON COLUMN "public"."env_device_setting_records"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_device_setting_records"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_device_setting_records" IS '设备控制记录';

-- ----------------------------
-- Records of env_device_setting_records
-- ----------------------------

-- ----------------------------
-- Table structure for env_device_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_device_settings";
CREATE TABLE "public"."env_device_settings" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "device_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "sort" int4 DEFAULT 0,
  "setting_content" text COLLATE "pg_catalog"."default",
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_device_settings"."id" IS '设置ID';
COMMENT ON COLUMN "public"."env_device_settings"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."env_device_settings"."device_type" IS '设备类型';
COMMENT ON COLUMN "public"."env_device_settings"."setting_content" IS '设置内容';
COMMENT ON COLUMN "public"."env_device_settings"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."env_device_settings"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_device_settings"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_device_settings"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_device_settings"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_device_settings" IS '设备控制设置表';

-- ----------------------------
-- Records of env_device_settings
-- ----------------------------
INSERT INTO "public"."env_device_settings"  VALUES (1, '采样管加热温度', '4', 60, '{"value":22,"param_ids":{"value":"heating_temp"},"device_id":"sms-qc","online":false}', 'sms-qc', 'admin', 'admin', '2025-06-23 09:14:38', '2025-11-03 16:47:54.951');
INSERT INTO "public"."env_device_settings"  VALUES (2, '门禁', '2', 50, '{"power":true,"param_ids":{"power":"fan_control"},"device_id":"sms-qc","door_ip":"192.168.0.114","door_port":"80","door_username":"admin","door_password":"Sms123456"}', 'sms-qc', 'admin', 'admin', '2025-05-27 09:16:08', '2025-06-09 11:27:05.737');
INSERT INTO "public"."env_device_settings"  VALUES (3, '室内灯光', '1', 30, '{"type":"light","power":true,"param_ids":{"power":"light_control"},"device_id":"sms-qc"}', 'sms-qc', 'admin', 'admin', '2025-05-27 09:09:21', '2025-11-03 16:45:52.869');
INSERT INTO "public"."env_device_settings"  VALUES (4, '排风扇', '1', 40, '{"power":true,"param_ids":{"power":"fan_control"},"device_id":"sms-qc"}', 'sms-qc', 'admin', 'admin', '2025-05-27 09:13:31', '2025-11-03 16:46:19.95');
INSERT INTO "public"."env_device_settings"  VALUES (5, 'PM10零点检查器', '6', 80, '{"power":false,"param_ids":{"mode":"pm10_zero_check_command"},"device_id":"sms-particulate-zero-checker","online":false}', 'sms-particulate-zero-checker', 'admin', 'admin', '2025-06-30 11:35:23', '2025-11-03 16:48:54.722');
INSERT INTO "public"."env_device_settings"  VALUES (6, 'PM2.5零点检查器', '6', 81, '{"power":false,"param_ids":{"mode":"pm2_5_zero_check_command"},"device_id":"sms-particulate-zero-checker","online":false}', 'sms-particulate-zero-checker', 'admin', 'admin', '2025-06-30 11:56:14', '2025-11-03 16:49:06.791');
INSERT INTO "public"."env_device_settings"  VALUES (7, '第一路继电器状态', '1', 70, '{"power":null,"param_ids":{"power":"relay_l1"},"device_id":"sms-power","online":false}', 'sms-qc', 'admin', 'admin', '2025-06-23 09:23:21', '2025-11-03 16:48:11.781');
INSERT INTO "public"."env_device_settings"  VALUES (8, '第二路继电器状态', '1', 71, '{"power":null,"param_ids":{"power":"relay_l2"},"device_id":"sms-power","online":false}', 'sms-qc', 'admin', 'admin', '2025-06-23 09:24:19', '2025-11-03 16:48:22.361');
INSERT INTO "public"."env_device_settings"  VALUES (9, '第三路继电器状态', '1', 72, '{"power":null,"param_ids":{"power":"relay_l3"},"device_id":"sms-power","online":false}', 'sms-qc', 'admin', 'admin', '2025-06-23 09:24:47', '2025-11-03 16:48:29.442');
INSERT INTO "public"."env_device_settings"  VALUES (10, '第四路继电器状态', '1', 73, '{"power":null,"param_ids":{"power":"relay_l4"},"device_id":"sms-power","online":false}', 'sms-qc', 'admin', 'admin', '2025-06-23 09:36:27', '2025-11-03 16:48:38.031');
INSERT INTO "public"."env_device_settings"  VALUES (11, '空调01', '0', 10, '{"type":"AirConditioning","power":true,"value":26.1,"mode":"1.0","speed":"2.0","current":26.1,"param_ids":{"power":"ac1_power","value":"ac1_set_temp","mode":"ac1_mode","speed":"ac1_speed","current":"ac1_cur_temp"},"device_id":"sms-qc","online":false}', 'sms-qc', 'admin', 'admin', '2025-05-27 09:06:05', '2025-11-03 16:45:20.435');
INSERT INTO "public"."env_device_settings"  VALUES (12, '空调02', '0', 20, '{"type":"AirConditioning","power":false,"value":25.5,"mode":"2.0","speed":"3.0","setting":25.5,"param_ids":{"power":"ac2_power","value":"ac2_set_temp","mode":"ac2_mode","speed":"ac2_speed","current":"ac2_cur_temp"},"device_id":"sms-qc","current":null}', 'sms-qc', 'admin', 'admin', '2025-05-27 09:08:06', '2025-11-03 16:45:38.93');

-- ----------------------------
-- Auto increment value for env_device_settings
-- ----------------------------
SELECT setval('"public"."env_device_settings_id_seq"', 13, false);
-- ----------------------------
-- Table structure for env_maintenance_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_maintenance_records";
CREATE TABLE "public"."env_maintenance_records" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "maintenance_mode" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "maintenance_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "maintenance_time" timestamp(6) NOT NULL,
  "maintenance_content" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_maintenance_records"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_maintenance_records"."maintenance_mode" IS '维护模式';
COMMENT ON COLUMN "public"."env_maintenance_records"."maintenance_type" IS '维护类型';
COMMENT ON COLUMN "public"."env_maintenance_records"."maintenance_time" IS '维护时间';
COMMENT ON COLUMN "public"."env_maintenance_records"."maintenance_content" IS '维护内容';
COMMENT ON COLUMN "public"."env_maintenance_records"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_maintenance_records"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_maintenance_records"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_maintenance_records"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_maintenance_records" IS '维护记录表';

-- ----------------------------
-- Records of env_maintenance_records
-- ----------------------------

-- ----------------------------
-- Table structure for env_maintenance_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_maintenance_settings";
CREATE TABLE "public"."env_maintenance_settings" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "maintenance_mode" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "current_status" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "expiry_time" timestamp(6),
  "replacement_interval" text COLLATE "pg_catalog"."default",
  "setting_content" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_maintenance_settings"."id" IS '设置ID';
COMMENT ON COLUMN "public"."env_maintenance_settings"."maintenance_mode" IS '维护模式';
COMMENT ON COLUMN "public"."env_maintenance_settings"."current_status" IS '当前状态';
COMMENT ON COLUMN "public"."env_maintenance_settings"."expiry_time" IS '使用截至时间';
COMMENT ON COLUMN "public"."env_maintenance_settings"."replacement_interval" IS '更换间隔时间';
COMMENT ON COLUMN "public"."env_maintenance_settings"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_maintenance_settings"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_maintenance_settings"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_maintenance_settings"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_maintenance_settings" IS '维护设置表';

-- ----------------------------
-- Records of env_maintenance_settings
-- ----------------------------

-- ----------------------------
-- Table structure for env_material_manager
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_material_manager";
CREATE TABLE "public"."env_material_manager" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "material_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "material_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "material_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "specification" varchar(100) COLLATE "pg_catalog"."default",
  "manufacturer" varchar(100) COLLATE "pg_catalog"."default",
  "production_date" date,
  "expiry_date" date,
  "warehousing_time" timestamp(6) NOT NULL,
  "material_capacity" numeric(10,3),
  "material_capacity_unit" varchar(100) COLLATE "pg_catalog"."default",
  "material_remain_capacity" numeric(10,3),
  "material_status" int4,
  "storage_location" varchar(100) COLLATE "pg_catalog"."default",
  "remarks" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "material_content" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."env_material_manager"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_material_manager"."material_code" IS '物资编号';
COMMENT ON COLUMN "public"."env_material_manager"."material_name" IS '物资名称';
COMMENT ON COLUMN "public"."env_material_manager"."material_type" IS '物资类型';
COMMENT ON COLUMN "public"."env_material_manager"."specification" IS '规格型号';
COMMENT ON COLUMN "public"."env_material_manager"."manufacturer" IS '生产厂家';
COMMENT ON COLUMN "public"."env_material_manager"."production_date" IS '生产日期';
COMMENT ON COLUMN "public"."env_material_manager"."expiry_date" IS '有效期';
COMMENT ON COLUMN "public"."env_material_manager"."warehousing_time" IS '入库时间';
COMMENT ON COLUMN "public"."env_material_manager"."material_capacity" IS '物资容量';
COMMENT ON COLUMN "public"."env_material_manager"."material_capacity_unit" IS '物资容量单位';
COMMENT ON COLUMN "public"."env_material_manager"."material_remain_capacity" IS '剩余物资容量';
COMMENT ON COLUMN "public"."env_material_manager"."material_status" IS '物资状态';
COMMENT ON COLUMN "public"."env_material_manager"."storage_location" IS '存放位置';
COMMENT ON COLUMN "public"."env_material_manager"."remarks" IS '备注';
COMMENT ON COLUMN "public"."env_material_manager"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_material_manager"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_material_manager"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_material_manager"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."env_material_manager"."material_content" IS '物资自定义配置';
COMMENT ON TABLE "public"."env_material_manager" IS '物资管理表';

-- ----------------------------
-- Records of env_material_manager
-- ----------------------------
INSERT INTO "public"."env_material_manager" VALUES (1, 'CO-102NSDIU2', 'CO气罐', '1', 'ASDN50MPA', 'XX公司', '2025-06-01', '2025-07-01', '2025-06-09 17:51:16', 50.000, 'MPa', 50.000, 1, '设备旁边', NULL, 'admin', 'admin', '2025-06-09 17:52:27', '2025-06-09 17:55:07', '{"concentration":20}');
INSERT INTO "public"."env_material_manager" VALUES (2, 'SO2-SUI2SIX', 'SO2气罐', '2', 'ASDASD50MP', 'XX公司', '2025-06-01', '2025-07-01', '2025-06-09 17:52:31', 50.000, 'MPa', 50.000, 1, '设备旁边', NULL, 'admin', 'admin', '2025-06-09 17:53:07', '2025-08-06 15:42:38', '{"concentration":20}');
INSERT INTO "public"."env_material_manager" VALUES (3, 'NO--SD92NX', 'NOx气罐', '3', '1313SADA', 'XX公司', '2025-06-01', '2025-07-01', '2025-06-09 17:53:10', 50.000, 'MPa', 8.000, 1, '设备旁边', NULL, 'admin', 'admin', '2025-06-09 17:53:46', '2025-08-06 15:42:40', '{"concentration":20}');
INSERT INTO "public"."env_material_manager" VALUES (4, 'PM25-23SDASDM', 'PM2.5纸袋', '5', 'ER23', '塞默森', '2025-06-01', '2025-07-01', '2025-06-09 17:54:25', 100.000, '个', 44.000, 1, 'PM2.5设备', NULL, 'admin', 'admin', '2025-06-09 17:54:58', '2025-08-06 15:42:42', '');
INSERT INTO "public"."env_material_manager" VALUES (5, '测试PM10', 'PM10纸袋', '4', '撒旦撒', '塞默森', '2025-06-01', '2025-07-01', '2025-06-09 17:55:14', 50.000, '个', 8.000, 2, 'PM10设备', NULL, 'admin', 'admin', '2025-06-09 17:55:40', '2025-09-10 09:06:27', '{}');
INSERT INTO "public"."env_material_manager" VALUES (6, 'PM10-ZD-2193SNDN', 'PM10纸袋', '4', 'SDWQE', '塞默森', '2025-06-01', '2025-07-01', '2025-06-09 17:53:48', 100.000, '个', 100.000, 1, 'PM10设备', NULL, 'admin', 'admin', '2025-06-09 17:54:24', '2025-09-10 09:06:29', '');
-- ----------------------------
-- Auto increment value for env_material_manager
-- ----------------------------
SELECT setval('"public"."env_material_manager_id_seq"', 7, false);

-- ----------------------------
-- Table structure for env_material_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_material_records";
CREATE TABLE "public"."env_material_records" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "material_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "usage_time" timestamp(6) NOT NULL,
  "usage_capacity" numeric(10,3),
  "remarks" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_material_records"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_material_records"."material_code" IS '物资编号';
COMMENT ON COLUMN "public"."env_material_records"."usage_time" IS '使用时间';
COMMENT ON COLUMN "public"."env_material_records"."usage_capacity" IS '使用量';
COMMENT ON COLUMN "public"."env_material_records"."remarks" IS '使用备注';
COMMENT ON COLUMN "public"."env_material_records"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_material_records"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_material_records"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_material_records"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_material_records" IS '物资使用记录表';


-- ----------------------------
-- Table structure for env_patrol_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_patrol_records";
CREATE TABLE "public"."env_patrol_records" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "generation_time" timestamp(6) NOT NULL,
  "patrol_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "patrol_notes" text COLLATE "pg_catalog"."default",
  "patrol_content" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_patrol_records"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_patrol_records"."generation_time" IS '生成时间';
COMMENT ON COLUMN "public"."env_patrol_records"."patrol_type" IS '巡检类型';
COMMENT ON COLUMN "public"."env_patrol_records"."patrol_notes" IS '巡检备注';
COMMENT ON COLUMN "public"."env_patrol_records"."patrol_content" IS '巡检内容';
COMMENT ON COLUMN "public"."env_patrol_records"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_patrol_records"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_patrol_records"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_patrol_records"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_patrol_records" IS '巡检记录表';

-- ----------------------------
-- Records of env_patrol_records
-- ----------------------------

-- ----------------------------
-- Table structure for env_patrol_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_patrol_settings";
CREATE TABLE "public"."env_patrol_settings" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "setting_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "setting_content" text COLLATE "pg_catalog"."default",
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_patrol_settings"."id" IS '设置ID';
COMMENT ON COLUMN "public"."env_patrol_settings"."setting_type" IS '设置类型';
COMMENT ON COLUMN "public"."env_patrol_settings"."setting_content" IS '设置内容';
COMMENT ON COLUMN "public"."env_patrol_settings"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_patrol_settings"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_patrol_settings"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_patrol_settings"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_patrol_settings" IS '巡检设置表';

-- ----------------------------
-- Records of env_patrol_settings
-- ----------------------------

-- ----------------------------
-- Table structure for env_patrol_statistics
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_patrol_statistics";
CREATE TABLE "public"."env_patrol_statistics" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "period_start_time" timestamp(6) NOT NULL,
  "period_end_time" timestamp(6) NOT NULL,
  "statistics_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "statistics_content" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_patrol_statistics"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_patrol_statistics"."period_start_time" IS '周期开始时间';
COMMENT ON COLUMN "public"."env_patrol_statistics"."period_end_time" IS '周期结束时间';
COMMENT ON COLUMN "public"."env_patrol_statistics"."statistics_type" IS '统计类型';
COMMENT ON COLUMN "public"."env_patrol_statistics"."statistics_content" IS '统计内容';
COMMENT ON COLUMN "public"."env_patrol_statistics"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_patrol_statistics"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_patrol_statistics"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_patrol_statistics"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_patrol_statistics" IS '巡检周期统计表';

-- ----------------------------
-- Records of env_patrol_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for env_quality_control_plan
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_quality_control_plan";
CREATE TABLE "public"."env_quality_control_plan" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "quality_control_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "parameter" text COLLATE "pg_catalog"."default" NOT NULL,
  "quality_control_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "set_concentration_value" numeric,
  "plan_start_time" timestamp(6) NOT NULL,
  "plan_end_time" timestamp(6) NOT NULL,
  "execution_frequency" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_quality_control_plan"."id" IS '质控计划ID';
COMMENT ON COLUMN "public"."env_quality_control_plan"."parameter" IS '参数';
COMMENT ON COLUMN "public"."env_quality_control_plan"."quality_control_type" IS '质控类型';
COMMENT ON COLUMN "public"."env_quality_control_plan"."set_concentration_value" IS '设置浓度值';
COMMENT ON COLUMN "public"."env_quality_control_plan"."plan_start_time" IS '计划开始时间';
COMMENT ON COLUMN "public"."env_quality_control_plan"."plan_end_time" IS '计划结束时间';
COMMENT ON COLUMN "public"."env_quality_control_plan"."execution_frequency" IS '执行频率';
COMMENT ON COLUMN "public"."env_quality_control_plan"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_quality_control_plan"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_quality_control_plan"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_quality_control_plan"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_quality_control_plan" IS '质控计划表';

-- ----------------------------
-- Records of env_quality_control_plan
-- ----------------------------

-- ----------------------------
-- Table structure for env_quality_control_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_quality_control_records";
CREATE TABLE "public"."env_quality_control_records" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 65
),
  "task_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "quality_control_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "parameter" text COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamp(6) NOT NULL,
  "end_time" timestamp(6),
  "standard_value" numeric,
  "monitoring_data" numeric,
  "calculated_value" numeric,
  "execution_status" int4 NOT NULL,
  "execution_log" text COLLATE "pg_catalog"."default",
  "result_evaluation" text COLLATE "pg_catalog"."default",
  "quality_control_plan_id" int4,
  "created_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."env_quality_control_records"."id" IS '记录ID';
COMMENT ON COLUMN "public"."env_quality_control_records"."task_type" IS '任务类型';
COMMENT ON COLUMN "public"."env_quality_control_records"."quality_control_type" IS '质控类型';
COMMENT ON COLUMN "public"."env_quality_control_records"."parameter" IS '质控参数';
COMMENT ON COLUMN "public"."env_quality_control_records"."start_time" IS '开始时间';
COMMENT ON COLUMN "public"."env_quality_control_records"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."env_quality_control_records"."standard_value" IS '标准值';
COMMENT ON COLUMN "public"."env_quality_control_records"."monitoring_data" IS '监测数据';
COMMENT ON COLUMN "public"."env_quality_control_records"."calculated_value" IS '计算值';
COMMENT ON COLUMN "public"."env_quality_control_records"."execution_status" IS '执行状态';
COMMENT ON COLUMN "public"."env_quality_control_records"."execution_log" IS '执行日志';
COMMENT ON COLUMN "public"."env_quality_control_records"."result_evaluation" IS '结果评价';
COMMENT ON COLUMN "public"."env_quality_control_records"."quality_control_plan_id" IS '计划ID';
COMMENT ON COLUMN "public"."env_quality_control_records"."created_by" IS '创建人';
COMMENT ON COLUMN "public"."env_quality_control_records"."updated_by" IS '更新人';
COMMENT ON COLUMN "public"."env_quality_control_records"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."env_quality_control_records"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."env_quality_control_records" IS '质控记录表';

-- ----------------------------
-- Records of env_quality_control_records
-- ----------------------------

-- ----------------------------
-- Table structure for env_quality_control_report
-- ----------------------------
DROP TABLE IF EXISTS "public"."env_quality_control_report";
CREATE TABLE "public"."env_quality_control_report" (
  "id" int4 NOT NULL DEFAULT nextval('env_quality_control_report_id_seq'::regclass),
  "report_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "report_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "report_date" date NOT NULL,
  "instrument_name" varchar(100) COLLATE "pg_catalog"."default",
  "instrument_no" varchar(50) COLLATE "pg_catalog"."default",
  "gas_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "filer" varchar(50) COLLATE "pg_catalog"."default",
  "reviewer" varchar(50) COLLATE "pg_catalog"."default",
  "maintenance_company" varchar(100) COLLATE "pg_catalog"."default",
  "report_content" text COLLATE "pg_catalog"."default",
  "report_note" text COLLATE "pg_catalog"."default",
  "is_discarded" bool NOT NULL DEFAULT false,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "gas_source" varchar(50) COLLATE "pg_catalog"."default",
  "gas_no" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."env_quality_control_report"."report_name" IS '报表名称，如"xxx仪器运行状况检查记录表", "xxx仪器多点校准记录表","xxx仪器精密度审核记录表","xxx仪器准确度审核记录表"等';
COMMENT ON COLUMN "public"."env_quality_control_report"."report_type" IS '报表类型，如"zero_span", "multi_check", "precision_check", "accuracy_check"等';
COMMENT ON COLUMN "public"."env_quality_control_report"."report_date" IS '报表生成日期';
COMMENT ON COLUMN "public"."env_quality_control_report"."instrument_name" IS '仪器名称，如"赛默飞世尔"';
COMMENT ON COLUMN "public"."env_quality_control_report"."instrument_no" IS '仪器编号，如"CMNO001"';
COMMENT ON COLUMN "public"."env_quality_control_report"."gas_type" IS '标气类型，如"SO2", "NOx", "O3", "CO"等';
COMMENT ON COLUMN "public"."env_quality_control_report"."filer" IS '填表人姓名';
COMMENT ON COLUMN "public"."env_quality_control_report"."reviewer" IS '审核人姓名';
COMMENT ON COLUMN "public"."env_quality_control_report"."maintenance_company" IS '运维公司，负责仪器维护的公司名称';
COMMENT ON COLUMN "public"."env_quality_control_report"."report_content" IS '报表详细内容，包含校准、审核、测试等所有数据（TEXT类型）';
COMMENT ON COLUMN "public"."env_quality_control_report"."report_note" IS '报表备注信息，用于记录额外说明';
COMMENT ON COLUMN "public"."env_quality_control_report"."is_discarded" IS '是否废弃，true表示报表已废弃，false表示正常';
COMMENT ON COLUMN "public"."env_quality_control_report"."created_by" IS '创建人ID或姓名';
COMMENT ON COLUMN "public"."env_quality_control_report"."updated_by" IS '更新人ID或姓名';
COMMENT ON COLUMN "public"."env_quality_control_report"."create_time" IS '记录创建时间';
COMMENT ON COLUMN "public"."env_quality_control_report"."update_time" IS '记录更新时间';
COMMENT ON TABLE "public"."env_quality_control_report" IS '质控报表表';

-- ----------------------------
-- Records of env_quality_control_report
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS "public"."gen_table";
CREATE TABLE "public"."gen_table" (
  "table_id" int8 NOT NULL DEFAULT nextval('gen_table_table_id_seq'::regclass),
  "table_name" varchar(200) COLLATE "pg_catalog"."default",
  "table_comment" varchar(500) COLLATE "pg_catalog"."default",
  "sub_table_name" varchar(64) COLLATE "pg_catalog"."default",
  "sub_table_fk_name" varchar(64) COLLATE "pg_catalog"."default",
  "class_name" varchar(100) COLLATE "pg_catalog"."default",
  "tpl_category" varchar(200) COLLATE "pg_catalog"."default",
  "tpl_web_type" varchar(30) COLLATE "pg_catalog"."default",
  "package_name" varchar(100) COLLATE "pg_catalog"."default",
  "module_name" varchar(30) COLLATE "pg_catalog"."default",
  "business_name" varchar(30) COLLATE "pg_catalog"."default",
  "function_name" varchar(50) COLLATE "pg_catalog"."default",
  "function_author" varchar(50) COLLATE "pg_catalog"."default",
  "gen_type" char(1) COLLATE "pg_catalog"."default",
  "gen_path" varchar(200) COLLATE "pg_catalog"."default",
  "options" varchar(1000) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."gen_table"."table_id" IS '编号';
COMMENT ON COLUMN "public"."gen_table"."table_name" IS '表名称';
COMMENT ON COLUMN "public"."gen_table"."table_comment" IS '表描述';
COMMENT ON COLUMN "public"."gen_table"."sub_table_name" IS '关联子表的表名';
COMMENT ON COLUMN "public"."gen_table"."sub_table_fk_name" IS '子表关联的外键名';
COMMENT ON COLUMN "public"."gen_table"."class_name" IS '实体类名称';
COMMENT ON COLUMN "public"."gen_table"."tpl_category" IS '使用的模板（crud单表操作 tree树表操作）';
COMMENT ON COLUMN "public"."gen_table"."tpl_web_type" IS '前端模板类型（element-ui模版 element-plus模版）';
COMMENT ON COLUMN "public"."gen_table"."package_name" IS '生成包路径';
COMMENT ON COLUMN "public"."gen_table"."module_name" IS '生成模块名';
COMMENT ON COLUMN "public"."gen_table"."business_name" IS '生成业务名';
COMMENT ON COLUMN "public"."gen_table"."function_name" IS '生成功能名';
COMMENT ON COLUMN "public"."gen_table"."function_author" IS '生成功能作者';
COMMENT ON COLUMN "public"."gen_table"."gen_type" IS '生成代码方式（0zip压缩包 1自定义路径）';
COMMENT ON COLUMN "public"."gen_table"."gen_path" IS '生成路径（不填默认项目路径）';
COMMENT ON COLUMN "public"."gen_table"."options" IS '其它生成选项';
COMMENT ON COLUMN "public"."gen_table"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."gen_table"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."gen_table"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."gen_table"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."gen_table"."remark" IS '备注';
COMMENT ON TABLE "public"."gen_table" IS '代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO "public"."gen_table" VALUES (6, 'sta_info', '设备管理', '', '', 'StaInfo', 'crud', 'element-ui', 'com.ruoyi.station', 'station', 'staInfo', '站点管理', 'dreamfalls', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418', NULL);
INSERT INTO "public"."gen_table" VALUES (7, 'para_info', '参数管理', '', '', 'ParaInfo', 'crud', 'element-ui', 'com.ruoyi.station', 'station', 'paraInfo', '设备参数管理', 'dreamfalls', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918', NULL);
INSERT INTO "public"."gen_table" VALUES (16, 'env_quality_control_records', '质控记录表', '', '', 'EnvQualityControlRecords', 'crud', 'element-plus', 'com.ecat.integration.EnvQualityControlManagerIntegration', 'quality_control', 'records', '质控记录', 'caohongbo', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211', NULL);
INSERT INTO "public"."gen_table" VALUES (19, 'env_maintenance_records', '维护记录表', '', '', 'EnvMaintenanceRecords', 'crud', 'element-plus', 'com.ecat.integration.EnvMaintenanceManagerIntegration', 'maintenance', 'records', '维护记录', 'caohongbo', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938', NULL);
INSERT INTO "public"."gen_table" VALUES (9, 'his_data', '历史数据', '', '', 'HisData', 'crud', 'element-ui', 'com.ruoyi.station', 'station', 'data', 'history', 'sms', NULL, NULL, '{"parentMenuId":2000}', 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419', NULL);
INSERT INTO "public"."gen_table" VALUES (15, 'env_device_setting_records', '设备控制记录', '', '', 'EnvDeviceSettingRecords', 'crud', 'element-plus', 'com.ecat.integration.EnvDeviceManagerIntegration', 'device_setting', 'records', '设备控制记录', 'caohongbo', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068', NULL);
INSERT INTO "public"."gen_table" VALUES (18, 'env_device_settings', '设备控制设置', '', '', 'EnvDeviceSettings', 'crud', 'element-plus', 'com.ecat.integration.EnvDeviceManagerIntegration', 'device_control_setting', 'settings', '设备控制设置', 'dreamfalls', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301', '设备控制设置');
INSERT INTO "public"."gen_table" VALUES (20, 'env_patrol_records', '巡检记录表', '', '', 'EnvPatrolRecords', 'crud', 'element-plus', 'com.ecat.integration.EnvPatrolManagerIntegration', 'patrol', 'records', '巡检记录', 'caohongbo', '0', NULL, '{"parentMenuId":0}', 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736', NULL);
INSERT INTO "public"."gen_table" VALUES (13, 'env_alarm_settings', '报警设置', '', '', 'EnvAlarmSettings', 'crud', 'element-plus', 'com.ecat.integration.EnvAlarmManagerIntegration', 'alarm_setting', 'settings', '报警设置', 'dreamfalls', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283', NULL);
INSERT INTO "public"."gen_table" VALUES (10, 'tasks', '任务表', '', '', 'Tasks', 'crud', 'element-ui', 'com.ruoyi.station', 'task', 'tasks', '任务，用于存储任务相关信息', 'sms', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855', NULL);
INSERT INTO "public"."gen_table" VALUES (8, 'env_data_manager_events', '事件表', '', '', 'Events', 'crud', 'element-ui', 'com.ecat.integration', 'event', 'events', '事件管理', 'dreamfalls', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681', NULL);
INSERT INTO "public"."gen_table" VALUES (11, 'env_data_manager_alarms', '报警管理', '', '', 'Alarms', 'crud', 'element-plus', 'com.ecat.integration', 'alarm', 'alarms', '报警管理', 'dreamfalls', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476', NULL);
INSERT INTO "public"."gen_table" VALUES (24, 'env_access_control_records', '门禁记录表', '', '', 'EnvAccessControlRecords', 'crud', 'element-plus', 'com.ecat.integration.EnvAccessControlIntegration', 'access_control', 'records', '门禁记录', 'caohongbo', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887', NULL);
INSERT INTO "public"."gen_table" VALUES (23, 'env_material_records', '物资使用记录表', '', '', 'EnvMaterialRecords', 'crud', 'element-plus', 'com.ecat.integration.EnvMaterialRecordsIntegration', 'material', 'records', '物资使用记录', 'caohongbo', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883', NULL);
INSERT INTO "public"."gen_table" VALUES (22, 'env_material_manager', '物资管理表', '', '', 'EnvMaterialManager', 'crud', 'element-plus', 'com.ecat.integration.EnvMaterialManagerIntegration', 'material', 'manager', '物资管理', 'caohongbo', '0', NULL, '{"parentMenuId":2001}', 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258', NULL);
INSERT INTO "public"."gen_table" VALUES (25, 'realdata', '原始数据', '', '', 'Realdata', 'crud', 'element-plus', 'com.ecat.integration.EnvDataManagerIntegration', 'realdata', 'realdata', '原始数据', 'dreamfalls', '0', NULL, '{"parentMenuId":2000}', 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS "public"."gen_table_column";
CREATE TABLE "public"."gen_table_column" (
  "column_id" int8 NOT NULL DEFAULT nextval('gen_table_column_column_id_seq'::regclass),
  "table_id" varchar(64) COLLATE "pg_catalog"."default",
  "column_name" varchar(200) COLLATE "pg_catalog"."default",
  "column_comment" varchar(500) COLLATE "pg_catalog"."default",
  "column_type" varchar(100) COLLATE "pg_catalog"."default",
  "java_type" varchar(500) COLLATE "pg_catalog"."default",
  "java_field" varchar(200) COLLATE "pg_catalog"."default",
  "is_pk" char(1) COLLATE "pg_catalog"."default",
  "is_increment" char(1) COLLATE "pg_catalog"."default",
  "is_required" char(1) COLLATE "pg_catalog"."default",
  "is_insert" char(1) COLLATE "pg_catalog"."default",
  "is_edit" char(1) COLLATE "pg_catalog"."default",
  "is_list" char(1) COLLATE "pg_catalog"."default",
  "is_query" char(1) COLLATE "pg_catalog"."default",
  "query_type" varchar(200) COLLATE "pg_catalog"."default",
  "html_type" varchar(200) COLLATE "pg_catalog"."default",
  "dict_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sort" int4,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."gen_table_column"."column_id" IS '编号';
COMMENT ON COLUMN "public"."gen_table_column"."table_id" IS '归属表编号';
COMMENT ON COLUMN "public"."gen_table_column"."column_name" IS '列名称';
COMMENT ON COLUMN "public"."gen_table_column"."column_comment" IS '列描述';
COMMENT ON COLUMN "public"."gen_table_column"."column_type" IS '列类型';
COMMENT ON COLUMN "public"."gen_table_column"."java_type" IS 'JAVA类型';
COMMENT ON COLUMN "public"."gen_table_column"."java_field" IS 'JAVA字段名';
COMMENT ON COLUMN "public"."gen_table_column"."is_pk" IS '是否主键（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_increment" IS '是否自增（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_required" IS '是否必填（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_insert" IS '是否为插入字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_edit" IS '是否编辑字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_list" IS '是否列表字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_query" IS '是否查询字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."query_type" IS '查询方式（等于、不等于、大于、小于、范围）';
COMMENT ON COLUMN "public"."gen_table_column"."html_type" IS '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
COMMENT ON COLUMN "public"."gen_table_column"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."gen_table_column"."sort" IS '排序';
COMMENT ON COLUMN "public"."gen_table_column"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."gen_table_column"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."gen_table_column"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."gen_table_column"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."gen_table_column" IS '代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO "public"."gen_table_column" VALUES (69, '6', 'last_data_time', '最后数据时间', 'timestamp without time zone', 'String', 'lastDataTime', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'datetime', '', 9, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (72, '7', 'para_id', 'ID', 'integer', 'Long', 'paraId', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (73, '7', 'pa_name', '参数名称', 'character varying', 'String', 'paName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (74, '7', 'pa_unit', '参数单位', 'character varying', 'String', 'paUnit', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (75, '7', 'cmd', '参数指令', 'character varying', 'String', 'cmd', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (76, '7', 'cmd_name', '指令名称', 'character varying', 'String', 'cmdName', '0', '0', '0', '1', '1', '1', '0', 'LIKE', 'input', '', 5, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (77, '7', 'value_type', '数据类型', 'character varying', 'String', 'valueType', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'select', 'sys_data_type', 6, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (78, '7', 'pid', '参数英文标识', 'character varying', 'String', 'pid', '1', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (79, '7', 'pname', '参数中文标识', 'character varying', 'String', 'pname', '0', '0', '1', '1', '1', '1', '0', 'LIKE', 'input', '', 8, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (80, '7', 'st_code', '设备编码', 'character varying', 'String', 'stCode', '1', '0', '1', '1', '1', '1', '0', 'EQ', 'select', '', 9, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (81, '7', 'cmd_type', '指令类型', 'character varying', 'String', 'cmdType', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'select', '', 10, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (82, '7', 'orderby', '排序', 'integer', 'Long', 'orderby', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 11, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (83, '7', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', NULL, '', 15, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (70, '6', 'device_type', '设备类型', 'character varying', 'String', 'deviceType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_device_type', 10, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (71, '6', 'orderby', '设备排序', 'integer', 'Long', 'orderby', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 11, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (84, '7', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', NULL, '', 17, 'admin', '2025-02-14 15:06:30.342815', NULL, '2025-02-14 16:06:38.269918');
INSERT INTO "public"."gen_table_column" VALUES (61, '6', 'sta_id', 'ID自增', 'integer', 'Long', 'staId', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (62, '6', 'sta_name', '设备名称', 'character varying', 'String', 'staName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (63, '6', 'st_code', '设备编码', 'character varying', 'String', 'stCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (64, '6', 'com', '设备COM口', 'character varying', 'String', 'com', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_device_com', 4, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (65, '6', 'protocol_type', '协议类型', 'character varying', 'String', 'protocolType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_device_pro', 5, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (66, '6', 'st_number', '物理设备ID', 'character varying', 'String', 'stNumber', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (67, '6', 'create_time', '创建时间', 'timestamp without time zone', 'String', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (68, '6', 'update_time', '更新时间', 'timestamp without time zone', 'String', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-02-14 14:15:58.271971', NULL, '2025-02-14 14:35:00.401418');
INSERT INTO "public"."gen_table_column" VALUES (88, '8', 'update_time', '更新时间', 'timestamp without time zone', 'String', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', NULL, '', 4, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (89, '8', 'end_time', '结束时间', 'timestamp without time zone', 'String', 'endTime', '0', '0', '0', '0', '0', '1', '0', 'LTE', NULL, '', 5, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (90, '8', 'description', '事件描述', 'text', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (91, '8', 'severity_level', '事件等级', 'character varying', 'String', 'severityLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'event_security', 7, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (92, '8', 'status', '事件状态', 'character varying', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'event_type', 8, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (93, '8', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '0', '0', '0', '1', '0', 'EQ', NULL, '', 9, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (94, '8', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '0', '0', '1', '1', '0', 'EQ', NULL, '', 10, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (85, '8', 'event_id', '事件ID', 'integer', 'Long', 'eventId', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (86, '8', 'event_type', '事件类型', 'integer', 'Long', 'eventType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'event_type', 2, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (87, '8', 'start_time', '事件开始时间', 'timestamp without time zone', 'String', 'startTime', '0', '0', '0', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 3, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (214, '19', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (215, '19', 'maintenance_mode', '维护模式', 'character varying', 'String', 'maintenanceMode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'maintenance_mode', 2, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (264, '23', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (265, '23', 'material_code', '物资编号', 'character varying', 'String', 'materialCode', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (266, '23', 'usage_time', '使用时间', 'timestamp without time zone', 'Date', 'usageTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 3, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (267, '23', 'usage_capacity', '使用量', 'numeric', 'String', 'usageCapacity', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 4, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (268, '23', 'remarks', '使用备注', 'text', 'String', 'remarks', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 5, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (269, '23', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '1', '0', '0', '1', '0', 'EQ', NULL, '', 6, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (270, '23', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '1', '0', '0', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (283, '24', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '1', '0', '0', '1', '0', 'EQ', NULL, '', 11, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (95, '8', 'sta_code', '设备编码', 'character varying', 'String', 'staCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 11, 'admin', '2025-02-18 09:56:57.214503', NULL, '2025-05-16 15:07:13.56681');
INSERT INTO "public"."gen_table_column" VALUES (284, '24', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '1', '0', '0', '1', '0', 'EQ', NULL, '', 12, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (222, '19', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '1', '0', '0', NULL, NULL, 'EQ', NULL, '', 9, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (96, '9', 'id', 'id', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (97, '9', 'station_id', '设备编码', 'character varying', 'String', 'stationId', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'select', '', 2, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (98, '9', 'thing_id', '采集类型', 'character varying', 'String', 'thingId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'thing_type', 3, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (99, '9', 'model_id', '参数', 'character varying', 'String', 'modelId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (100, '9', 'classify', '数据类型', 'character varying', 'String', 'classify', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'data_type', 5, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (101, '9', 'status', '数据状态', 'bigint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'data_sign', 6, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (285, '24', 'create_time', '创建时间', 'timestamp without time zone', 'String', 'createTime', '0', '0', '1', '0', NULL, NULL, NULL, 'EQ', NULL, '', 13, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (110, '10', 'task_id', '任务ID', 'integer', 'Long', 'taskId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (111, '10', 'task_name', '任务名称', 'character varying', 'String', 'taskName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (112, '10', 'task_type', '任务类型', 'integer', 'Long', 'taskType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'task_type', 3, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (113, '10', 'start_time', '任务开始时间', 'timestamp without time zone', 'Date', 'startTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (114, '10', 'end_time', '任务结束时间', 'timestamp without time zone', 'Date', 'endTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (115, '10', 'request_content', '任务内容', 'text', 'String', 'requestContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'fileUpload', '', 6, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (116, '10', 'task_status', '任务状态', 'character varying', 'String', 'taskStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'task_status', 7, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (117, '10', 'response_content', '返回内容', 'text', 'String', 'responseContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 8, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (118, '10', 'create_time', '任务创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', NULL, '', 9, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (119, '10', 'update_time', '任务更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', NULL, '', 10, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (286, '24', 'update_time', '更新时间', 'timestamp without time zone', 'String', 'updateTime', '0', '0', '1', '0', '0', NULL, NULL, 'EQ', NULL, '', 14, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (271, '23', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '1', '0', NULL, NULL, NULL, 'EQ', NULL, '', 8, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (272, '23', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '1', '0', '0', NULL, NULL, 'EQ', NULL, '', 9, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-30 09:21:41.811883');
INSERT INTO "public"."gen_table_column" VALUES (102, '9', 'field', '参数', 'character varying', 'String', 'field', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (103, '9', 'value', '值', 'numeric', 'Integer', 'value', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 8, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (104, '9', 'values', '多值', 'text', 'String', 'values', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 9, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (105, '9', 'total', '统计条数', 'bigint', 'Long', 'total', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 10, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (106, '9', 'unit', '单位', 'character varying', 'String', 'unit', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 11, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (107, '9', 'pick_time', '数据时间', 'timestamp with time zone', 'Date', 'pickTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 12, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (108, '9', 'created_at', '创建时间', 'timestamp with time zone', 'Date', 'createdAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', NULL, '', 13, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (109, '9', 'updated_at', '更新时间', 'timestamp with time zone', 'Date', 'updatedAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', NULL, '', 14, 'admin', '2025-02-18 11:18:07.560103', NULL, '2025-02-18 16:05:51.201419');
INSERT INTO "public"."gen_table_column" VALUES (297, '25', 'tname', '监测点名称', 'text', 'String', 'tname', '0', '0', '0', '1', '1', '0', '0', 'LIKE', 'input', '', 11, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (298, '25', 'pn', '参数名称', 'text', 'String', 'pn', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 12, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (299, '25', 'sname', '设备名称', 'text', 'String', 'sname', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 13, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (230, '20', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', NULL, '', 8, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (231, '20', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', NULL, '', 9, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (123, '11', 'alarm_id', '报警ID', 'integer', 'Long', 'alarmId', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 1, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (124, '11', 'alarm_type', '报警类型', 'integer', 'Long', 'alarmType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'alarm_type', 2, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (125, '11', 'start_time', '报警开始时间', 'timestamp without time zone', 'String', 'startTime', '0', '0', '0', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 3, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (126, '11', 'update_time', '更新时间', 'timestamp without time zone', 'String', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', NULL, '', 4, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (127, '11', 'end_time', '结束时间', 'timestamp without time zone', 'String', 'endTime', '0', '0', '0', '0', '0', '1', '0', 'EQ', NULL, '', 5, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (128, '11', 'description', '报警描述', 'text', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (129, '11', 'severity_level', '报警等级', 'character varying', 'String', 'severityLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'alarm_security', 7, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (130, '11', 'status', '报警状态', 'character varying', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'alarm_status', 8, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (131, '11', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '0', '0', '0', '1', '0', 'EQ', NULL, '', 9, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (132, '11', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '0', '0', '1', '1', '0', 'EQ', NULL, '', 10, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (120, '10', 'create_by', '任务创建人', 'character varying', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', NULL, '', 11, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (121, '10', 'update_by', '任务修改人', 'character varying', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', NULL, '', 12, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (122, '10', 'notes', '任务备注信息', 'text', 'String', 'notes', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 13, 'admin', '2025-02-24 13:11:03.07814', NULL, '2025-02-24 16:52:07.940855');
INSERT INTO "public"."gen_table_column" VALUES (133, '11', 'sta_code', '设备编码', 'character varying', 'String', 'staCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 11, 'admin', '2025-05-16 11:29:44.54617', NULL, '2025-05-16 15:07:26.69476');
INSERT INTO "public"."gen_table_column" VALUES (262, '22', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '1', '0', NULL, NULL, NULL, 'EQ', NULL, '', 18, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (263, '22', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '1', '0', '0', NULL, NULL, 'EQ', NULL, '', 19, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (223, '20', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (224, '20', 'generation_time', '生成时间', 'timestamp without time zone', 'Date', 'generationTime', '0', '0', '1', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 2, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (225, '20', 'patrol_type', '巡检类型', 'character varying', 'String', 'patrolType', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'select', 'patrol_type', 3, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (226, '20', 'patrol_notes', '巡检备注', 'text', 'String', 'patrolNotes', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (227, '20', 'patrol_content', '巡检内容', 'text', 'String', 'patrolContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (228, '20', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (151, '13', 'id', '设置ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (152, '13', 'alarm_type', '报警类型', 'character varying', 'String', 'alarmType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'env_alarm_type', 2, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (229, '20', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '0', '0', '0', '1', '1', 'EQ', NULL, '', 7, 'admin', '2025-05-27 00:33:04.833457', NULL, '2025-05-27 14:12:44.11736');
INSERT INTO "public"."gen_table_column" VALUES (153, '13', 'setting_content', '报警内容', 'text', 'String', 'settingContent', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (154, '13', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '1', '0', '0', '1', '0', 'EQ', NULL, '', 4, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (155, '13', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '1', '0', '0', '1', '0', 'EQ', NULL, '', 5, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (156, '13', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '1', '0', NULL, '1', NULL, 'EQ', NULL, '', 6, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (157, '13', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '1', '0', '0', '1', NULL, 'EQ', NULL, '', 7, 'admin', '2025-05-26 11:07:24.593338', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (287, '25', 'pick_time', '数据时间', 'timestamp with time zone', 'Date', 'pickTime', '0', '0', '0', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 1, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (288, '25', 'tid', '监测点ID', 'text', 'String', 'tid', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 2, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (289, '25', 'pid', '参数ID ', 'text', 'String', 'pid', '0', '0', '1', '1', '1', '1', '0', 'LIKE', 'input', '', 3, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (290, '25', 'sid', '设备ID', 'text', 'String', 'sid', '0', '0', '1', '1', '1', '1', '0', 'LIKE', 'input', '', 4, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (291, '25', 'mindex', '索引', 'bigint', 'Long', 'mindex', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 5, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (292, '25', 'type', '数据类型', 'text', 'String', 'type', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'select', 'env_realdata_data_type', 6, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (293, '25', 'fv', '数字值', 'numeric', 'Double', 'fv', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 7, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (294, '25', 'sv', '字符串值', 'text', 'String', 'sv', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 8, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (295, '25', 'iv', '整型值', 'bigint', 'Long', 'iv', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 9, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (296, '25', 'value', '数据值', 'text', 'String', 'value', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 10, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (204, '18', 'id', '设置ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (205, '18', 'device_name', '设备名称', 'character varying', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (206, '18', 'device_type', '设备类型', 'character varying', 'String', 'deviceType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'env_device_manager_device_type', 3, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (301, '25', 'unit_name', '显示单位', 'text', 'String', 'unitName', '0', '0', '0', '1', '1', '1', '0', 'LIKE', 'input', '', 15, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (193, '13', 'sort', '排序', 'integer', 'Long', 'sort', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, NULL, '2025-05-26 15:43:16.924342', NULL, '2025-05-26 15:44:31.85283');
INSERT INTO "public"."gen_table_column" VALUES (176, '16', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, '0', NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (177, '16', 'task_type', '任务类型', 'character varying', 'String', 'taskType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'quality_control_task_type', 2, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (178, '16', 'quality_control_type', '质控类型', 'character varying', 'String', 'qualityControlType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'quality_control_type', 3, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (179, '16', 'parameter', '质控参数', 'text', 'String', 'parameter', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'select', 'quality_control_param', 4, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (180, '16', 'start_time', '开始时间', 'timestamp without time zone', 'Date', 'startTime', '0', '0', '0', '1', '0', '1', '0', 'BETWEEN', NULL, '', 5, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (181, '16', 'end_time', '结束时间', 'timestamp without time zone', 'Date', 'endTime', '0', '0', '0', '0', '0', '1', '0', 'BETWEEN', NULL, '', 6, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (182, '16', 'standard_value', '标准值', 'numeric', 'Double', 'standardValue', '0', '0', '0', '1', '0', '1', '0', 'EQ', NULL, '', 7, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (183, '16', 'monitoring_data', '监测数据', 'numeric', 'Double', 'monitoringData', '0', '0', '0', '1', '0', '1', '0', 'EQ', NULL, '', 8, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (184, '16', 'calculated_value', '计算值', 'numeric', 'Double', 'calculatedValue', '0', '0', '0', '1', '0', '1', '0', 'EQ', NULL, '', 9, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (185, '16', 'execution_status', '执行状态', 'integer', 'Long', 'executionStatus', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'radio', 'quality_control_execution_status', 10, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (186, '16', 'execution_log', '执行日志', 'text', 'String', 'executionLog', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'textarea', '', 11, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (187, '16', 'result_evaluation', '结果评价', 'text', 'String', 'resultEvaluation', '0', '0', '0', '0', '1', '1', '0', 'EQ', 'textarea', '', 12, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (188, '16', 'quality_control_plan_id', '计划ID', 'integer', 'Long', 'qualityControlPlanId', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 13, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (189, '16', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '1', '0', '0', '0', '0', 'EQ', NULL, '', 14, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (190, '16', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '1', '0', '0', '0', '0', 'EQ', NULL, '', 15, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (191, '16', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '1', '0', NULL, '0', NULL, 'EQ', NULL, '', 16, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (300, '25', 'display', '显示值', 'text', 'String', 'display', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 14, 'admin', '2025-06-13 14:14:21.10248', NULL, '2025-06-16 10:04:37.185004');
INSERT INTO "public"."gen_table_column" VALUES (192, '16', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '1', '0', '0', '0', NULL, 'EQ', NULL, '', 17, 'admin', '2025-05-26 15:00:13.048164', NULL, '2025-05-28 14:55:52.300211');
INSERT INTO "public"."gen_table_column" VALUES (216, '19', 'maintenance_type', '维护类型', 'character varying', 'String', 'maintenanceType', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'select', 'maintenance_type', 3, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (217, '19', 'maintenance_time', '维护时间', 'timestamp without time zone', 'Date', 'maintenanceTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 4, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (218, '19', 'maintenance_content', '维护内容', 'text', 'String', 'maintenanceContent', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 5, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (219, '19', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '1', '0', '0', '1', '0', 'EQ', NULL, '', 6, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (220, '19', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '1', '0', '0', '0', '0', 'EQ', NULL, '', 7, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (221, '19', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '1', '0', NULL, '0', NULL, 'EQ', NULL, '', 8, 'admin', '2025-05-26 18:11:26.072269', NULL, '2025-05-28 16:34:42.364938');
INSERT INTO "public"."gen_table_column" VALUES (167, '15', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', '0', '0', NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (168, '15', 'device_setting_id', '设置ID', 'integer', 'Long', 'deviceSettingId', '0', '0', '1', '0', '0', '0', '1', 'EQ', 'input', '', 2, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (169, '15', 'device_id', '设备ID', 'character varying', 'String', 'deviceId', '0', '0', '1', '0', '0', '1', '1', 'EQ', NULL, '', 3, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (170, '15', 'device_setting_time', '设置时间', 'timestamp without time zone', 'Date', 'deviceSettingTime', '0', '0', '1', '0', '0', '1', '1', 'BETWEEN', 'datetime', '', 4, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (171, '15', 'device_setting_content', '内容描述', 'text', 'String', 'deviceSettingContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (172, '15', 'created_by', '创建者', 'character varying', 'String', 'createdBy', '0', '0', '0', '0', '0', '1', '1', 'EQ', NULL, '', 6, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (173, '15', 'updated_by', '更新者', 'character varying', 'String', 'updatedBy', '0', '0', '0', '0', '0', '1', '1', 'EQ', NULL, '', 7, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (174, '15', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', NULL, '', 8, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (175, '15', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', NULL, '', 9, 'admin', '2025-05-26 13:52:37.572308', NULL, '2025-05-28 17:16:25.946068');
INSERT INTO "public"."gen_table_column" VALUES (250, '22', 'manufacturer', '生产厂家', 'character varying', 'String', 'manufacturer', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 6, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (251, '22', 'production_date', '生产日期', 'date', 'Date', 'productionDate', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'datetime', '', 7, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (252, '22', 'expiry_date', '有效期', 'date', 'Date', 'expiryDate', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'datetime', '', 8, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (253, '22', 'warehousing_time', '入库时间', 'date', 'Date', 'warehousingTime', '0', '0', '1', '0', '1', '1', '1', 'BETWEEN', 'datetime', '', 9, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (254, '22', 'material_capacity', '物资容量', 'numeric', 'Double', 'materialCapacity', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 10, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (255, '22', 'material_capacity_unit', '物资容量单位', 'character varying', 'String', 'materialCapacityUnit', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 11, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (256, '22', 'material_remain_capacity', '剩余物资容量', 'numeric', 'Double', 'materialRemainCapacity', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 12, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (257, '22', 'material_status', '物资状态', 'integer', 'Long', 'materialStatus', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'radio', '', 13, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (258, '22', 'storage_location', '存放位置', 'character varying', 'String', 'storageLocation', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 14, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (259, '22', 'remarks', '备注', 'text', 'String', 'remarks', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 15, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (260, '22', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '1', '0', '0', '0', '0', 'EQ', NULL, '', 16, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (261, '22', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '1', '0', '0', '0', '0', 'EQ', NULL, '', 17, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (273, '24', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (207, '18', 'sort', '排序', 'integer', 'Long', 'sort', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (208, '18', 'setting_content', '设置内容', 'text', 'String', 'settingContent', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 5, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (209, '18', 'device_id', '设备编码', 'character varying', 'String', 'deviceId', '1', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (210, '18', 'created_by', '创建人', 'character varying', 'String', 'createdBy', '0', '0', '0', '0', '0', '1', '0', 'EQ', NULL, '', 7, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (211, '18', 'updated_by', '更新人', 'character varying', 'String', 'updatedBy', '0', '0', '0', '0', '0', '1', '0', 'EQ', NULL, '', 8, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (212, '18', 'create_time', '创建时间', 'timestamp without time zone', 'Date', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', NULL, '', 9, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (213, '18', 'update_time', '更新时间', 'timestamp without time zone', 'Date', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', NULL, '', 10, 'admin', '2025-05-26 17:44:06.741238', NULL, '2025-05-27 08:49:24.000301');
INSERT INTO "public"."gen_table_column" VALUES (274, '24', 'device_name', '设备名称', 'character varying', 'String', 'deviceName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (275, '24', 'device_ip', '设备IP地址', 'character varying', 'String', 'deviceIp', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (276, '24', 'device_mac', '设备mac地址', 'character varying', 'String', 'deviceMac', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (245, '22', 'id', '记录ID', 'integer', 'Long', 'id', '1', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (246, '22', 'material_code', '物资编号', 'character varying', 'String', 'materialCode', '1', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (247, '22', 'material_name', '物资名称', 'character varying', 'String', 'materialName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (248, '22', 'material_type', '物资类型', 'character varying', 'String', 'materialType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'material_type', 4, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (249, '22', 'specification', '规格型号', 'character varying', 'String', 'specification', '0', '0', '0', '1', '1', '1', '0', 'EQ', NULL, '', 5, 'admin', '2025-05-27 17:06:28.966257', NULL, '2025-05-28 13:42:32.027258');
INSERT INTO "public"."gen_table_column" VALUES (277, '24', 'employee_id', '工号', 'character varying', 'String', 'employeeId', '0', '0', '0', '0', '1', '1', '0', 'EQ', NULL, '', 5, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (278, '24', 'employee_name', '名称', 'character varying', 'String', 'employeeName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (279, '24', 'access_method', '打卡方式', 'character varying', 'String', 'accessMethod', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'access_method', 7, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (280, '24', 'setting_content', '门禁详情', 'text', 'String', 'settingContent', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'textarea', '', 8, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (281, '24', 'result_json', '门禁结果', 'text', 'String', 'resultJson', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');
INSERT INTO "public"."gen_table_column" VALUES (282, '24', 'file_json', '文件内容', 'text', 'String', 'fileJson', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'textarea', '', 10, 'admin', '2025-05-28 23:32:21.524423', NULL, '2025-05-29 08:30:18.820887');

-- ----------------------------
-- Table structure for his_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."his_data";
CREATE TABLE "public"."his_data" (
  "id" int8 NOT NULL DEFAULT nextval('his_data_id_seq'::regclass),
  "station_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "thing_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "model_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "classify" varchar(12) COLLATE "pg_catalog"."default",
  "status" int8 DEFAULT 0,
  "field" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "value" numeric,
  "values" text COLLATE "pg_catalog"."default",
  "total" int8,
  "unit" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "pick_time" timestamptz(6) NOT NULL,
  "created_at" timestamptz(6),
  "updated_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of his_data
-- ----------------------------

-- ----------------------------
-- Table structure for index_exists
-- ----------------------------
DROP TABLE IF EXISTS "public"."index_exists";
CREATE TABLE "public"."index_exists" (
  "exists" bool
)
;

-- ----------------------------
-- Records of index_exists
-- ----------------------------
INSERT INTO "public"."index_exists" VALUES ('f');

-- ----------------------------
-- Table structure for mock_table
-- ----------------------------
DROP TABLE IF EXISTS "public"."mock_table";
CREATE TABLE "public"."mock_table" (
  "id" int4 NOT NULL DEFAULT nextval('moketableindex'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" date
)
;

-- ----------------------------
-- Records of mock_table
-- ----------------------------
INSERT INTO "public"."mock_table" VALUES (2, '2', '2025-05-09');
INSERT INTO "public"."mock_table" VALUES (4, '4', '2025-05-09');
INSERT INTO "public"."mock_table" VALUES (5, '5', '2025-05-09');
INSERT INTO "public"."mock_table" VALUES (7, '7', '2025-05-09');
INSERT INTO "public"."mock_table" VALUES (1, '1', '2025-05-09');
INSERT INTO "public"."mock_table" VALUES (3, '3', '2025-05-09');
INSERT INTO "public"."mock_table" VALUES (6, '6', '2025-05-09');

-- ----------------------------
-- Table structure for nowdata
-- ----------------------------
DROP TABLE IF EXISTS "public"."nowdata";
CREATE TABLE "public"."nowdata" (
  "tid" text COLLATE "pg_catalog"."default" NOT NULL,
  "pid" text COLLATE "pg_catalog"."default" NOT NULL,
  "sid" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default",
  "tname" text COLLATE "pg_catalog"."default",
  "pn" text COLLATE "pg_catalog"."default",
  "sname" text COLLATE "pg_catalog"."default",
  "display" text COLLATE "pg_catalog"."default",
  "unit_name" text COLLATE "pg_catalog"."default",
  "last_data_time" timestamptz(6)
)
;

-- ----------------------------
-- Records of nowdata
-- ----------------------------
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'Thermo01', 'float', '23.5', '智慧数采#1', '样气温度', '热电颗粒物01', '23.5', 'deg', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'KongTiao2', 'float', '12.5', '智慧数采#1', 'PM10', '空调02', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'KongTiao2', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物05', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'KongTiao2', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物05', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'KongTiao2', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物05', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'KongTiao2', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物05', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'KongTiao2', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物05', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'Thermo02', 'float', '1.0', '智慧数采#1', '斜率', '热电颗粒物02', '1.0', 'sum', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'Thermo02', 'float', '23.5', '智慧数采#1', '样气温度', '热电颗粒物02', '23.5', 'deg', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'Thermo02', 'float', '16.63', '智慧数采#1', '流量', '热电颗粒物02', '16.63', 'LPM', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'Thermo02', 'float', '0.0', '智慧数采#1', '截距', '热电颗粒物02', '0.0', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'Thermo03', 'float', '20.3', '智慧数采#1', '样气湿度', '热电颗粒物03', '20.3', '%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'Thermo03', 'float', '23.5', '智慧数采#1', '样气温度', '热电颗粒物03', '23.5', 'deg', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'phase_c_voltage', 'PowerMonitoring', 'float', '', '智慧数采#1', '站房C相电压', '电力监测', '0', 'Uc', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'phase_b_current', 'PowerMonitoring', 'float', '', '智慧数采#1', '站房B相电流', '电力监测', '0', 'Ib', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'active_power_phase_a', 'PowerMonitoring', 'float', '', '智慧数采#1', 'A相有功功率', '电力监测', '0', 'W', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'active_power_phase_c', 'PowerMonitoring', 'float', '', '智慧数采#1', 'C相有功功率', '电力监测', '0', 'W', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'reactive_power_phase_b', 'PowerMonitoring', 'float', '', '智慧数采#1', 'B相无功功率', '电力监测', '0', 'Var', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'power_factor_phase_a', 'PowerMonitoring', 'None', '', '智慧数采#1', 'A相功率因数', '电力监测', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'power_factor_phase_c', 'PowerMonitoring', 'float', '', '智慧数采#1', 'C相功率因数', '电力监测', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'fan_power', 'PowerMonitoring', 'float', '', '智慧数采#1', '风机功率', '电力监测', '0', 'W', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon1_power_state', 'AirconPower', 'float', '', '智慧数采#1', '空调1开机状态', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon1_set_temperature', 'AirconPower', 'float', '', '智慧数采#1', '空调1设定温度', '空调设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon1_wind_speed', 'AirconPower', 'float', '', '智慧数采#1', '空调1风速', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon2_power_state', 'AirconPower', 'float', '', '智慧数采#1', '空调2开机状态', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon2_wind_speed', 'AirconPower', 'float', '', '智慧数采#1', '空调2风速', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'cylinder_gas1_pressure', 'CylinderGas', 'float', '', '智慧数采#1', '钢瓶气1压力', '钢瓶气设备', '0', 'kPa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'cylinder_gas3_pressure', 'CylinderGas', 'float', '', '智慧数采#1', '钢瓶气3压力', '钢瓶气设备', '0', 'kPa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'co_absorber_temperature', 'GasDevice', 'float', '', '智慧数采#1', 'CO涤除器温度', '气体处理设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'fan_control', 'GasDevice', 'float', '', '智慧数采#1', '风机控制', '气体处理设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'calibrator_relay', 'Calibrator', 'float', '', '智慧数采#1', '校准仪继电器', '校准仪设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'calibration_valve2_control', 'Calibrator', 'float', '', '智慧数采#1', '校准阀2控制', '校准仪设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'calibration_valve4_control', 'Calibrator', 'float', '', '智慧数采#1', '校准阀4控制', '校准仪设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'smoke_sensor2_status', 'AlarmStatus', 'float', '1.0', '智慧数采#1', '烟感2状态（火警）', '报警状态', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'temperature_sensor2_status', 'AlarmStatus', 'float', '1.0', '智慧数采#1', '温感2状态（火警）', '报警状态', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'cylinder_gas_pressure_alarm_status', 'AlarmStatus', 'float', '', '智慧数采#1', '钢瓶气压力报警状态', '报警状态', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_input_voltage', 'UPS', 'float', '', '智慧数采#1', 'UPS输入电压', 'UPS设备', '0', 'V', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_output_load_percentage', 'UPS', 'float', '', '智慧数采#1', 'UPS输出负载百分比', 'UPS设备', '0', '%', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_battery_cell_voltage', 'UPS', 'float', '', '智慧数采#1', 'UPS电池单元电压', 'UPS设备', '0', 'V', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_status', 'UPS', 'float', '', '智慧数采#1', 'UPS状态', 'UPS设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10_concentration', 'AirDevice', 'float', 'null', '智慧数采#1', 'PM10浓度', '空气监测设备', 'null', 'ug/m3', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'vibration', 'Other', 'float', '', '智慧数采#1', '震动', '其他设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'room_humidity', 'StationBuilding', 'float', '', '智慧数采#1', '站房湿度', '站房信息', '0', '%RH', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_humidity', 'SamplingPipe', 'float', '', '智慧数采#1', '采样管湿度', '采样管设备', '0', '%RH', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_static_pressure', 'SamplingPipe', 'float', '', '智慧数采#1', '采样管静压', '采样管设备', '0', 'Kpa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10_actual_flow_rate', 'StationBuilding', 'float', '', '智慧数采#1', 'PM10工况流量', '站房信息', '0', 'L/min', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_address', 'SamplingPipe', 'None', '1.0', '智慧数采#1', '采样管地址', '采样管设备', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'phase_a_voltage', 'PowerMonitoring', 'float', '', '智慧数采#1', '站房A相电压', '电力监测', '0', 'Ua', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'Thermo03', 'float', '16.63', '智慧数采#1', '流量', '热电颗粒物03', '16.63', 'LPM', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'Thermo03', 'float', '1.0', '智慧数采#1', '斜率', '热电颗粒物03', '1.0', 'sum', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'Thermo03', 'float', '0.0', '智慧数采#1', '截距', '热电颗粒物03', '0.0', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'Thermo04', 'float', '20.3', '智慧数采#1', '样气湿度', '热电颗粒物04', '20.3', '%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'DIANLIB', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物04', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'DIANLIB', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物04', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'DIANLIB', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物04', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'DIANLIB', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物04', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'DIANLIB', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物04', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'DIANLIB', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物04', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'DIANLIC', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物04', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'DIANLIC', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物04', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'DIANLIC', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物04', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'Thermo04', 'float', '23.5', '智慧数采#1', '样气温度', '热电颗粒物04', '23.5', 'deg', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'Thermo04', 'float', '16.63', '智慧数采#1', '流量', '热电颗粒物04', '16.63', 'LPM', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'Thermo04', 'float', '1.0', '智慧数采#1', '斜率', '热电颗粒物04', '1.0', 'sum', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'Thermo04', 'float', '81.25', '智慧数采#1', 'PM10', '热电颗粒物04', '81.25', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'Thermo05', 'float', '20.3', '智慧数采#1', '样气湿度', '热电颗粒物05', '20.3', '%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'Thermo05', 'float', '23.5', '智慧数采#1', '样气温度', '热电颗粒物05', '23.5', 'deg', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'Thermo05', 'float', '16.63', '智慧数采#1', '流量', '热电颗粒物05', '16.63', 'LPM', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'Thermo05', 'float', '0.0', '智慧数采#1', '截距', '热电颗粒物05', '0.0', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'Thermo05', 'float', '1.0', '智慧数采#1', '斜率', '热电颗粒物05', '1.0', 'sum', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'Thermo05', 'float', '81.25', '智慧数采#1', 'PM10', '热电颗粒物05', '81.25', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'XianHe05', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物05', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'XianHe05', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物05', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'XianHe05', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物05', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'XianHe05', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物05', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'XianHe05', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物05', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'XianHe01', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物01', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'XianHe01', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物01', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'XianHe01', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物01', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'XianHe01', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物01', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'XianHe01', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物01', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'XianHe02', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物02', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'XianHe02', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物02', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'XianHe02', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物02', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'XianHe02', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物02', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'XianHe02', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物02', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'XianHe03', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物03', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'XianHe03', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物03', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'XianHe03', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物03', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'XianHe03', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物03', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'XianHe03', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物03', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'XianHe03', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物03', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'XianHe04', 'float', '12.5', '智慧数采#1', 'PM10', '先河颗粒物04', '12.5', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'XianHe04', 'float', 's3', '智慧数采#1', '斜率', '先河颗粒物04', 's3', '', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'XianHe04', 'float', 's2', '智慧数采#1', '截距', '先河颗粒物04', 's2', 'kPa', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'XianHe04', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物04', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'XianHe04', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物04', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'Thermo02', 'float', NULL, '智慧数采#1', 'PM10', '热电颗粒物02', NULL, NULL, '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'XianHe05', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物05', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'Thermo02', 'float', '11111', '智慧数采#1', '样气湿度', '热电颗粒物02', '20.3', '%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'XianHe01', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物01', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'XianHe02', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物02', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'Thermo03', 'float', '81.25', '智慧数采#1', 'PM10', '热电颗粒物03', '81.25', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10', 'Thermo01', 'float', NULL, '智慧数采#1', 'PM10', '热电颗粒物01', NULL, NULL, '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'DIANLIC', 'float', 't6', '智慧数采#1', '流量', '先河颗粒物04', 't6', '℃', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'DIANLIC', 'float', 't13', '智慧数采#1', '样气湿度', '先河颗粒物04', 't13', 'L/min', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'DIANLIC', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物04', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'Thermo04', 'float', '0.0', '智慧数采#1', '截距', '热电颗粒物04', '0.0', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'FlowTemp', 'XianHe04', 'float', 't12', '智慧数采#1', '样气温度', '先河颗粒物04', 't12', 'RH%', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampleRh', 'Thermo01', 'float', NULL, '智慧数采#1', '样气湿度', '热电颗粒物01', NULL, NULL, '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Slope', 'Thermo01', 'float', '15.24', '智慧数采#1', '斜率', '热电颗粒物01', '15.24', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Flow', 'Thermo01', 'float', '16.63', '智慧数采#1', '流量', '热电颗粒物01', '16.63', 'LPM', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'Tntercept', 'Thermo01', 'float', '0.0', '智慧数采#1', '截距', '热电颗粒物01', '0.0', 'ug/m3', '2025-02-21 11:00:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'phase_b_voltage', 'PowerMonitoring', 'float', '', '智慧数采#1', '站房B相电压', '电力监测', '0', 'Ub', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'phase_a_current', 'PowerMonitoring', 'float', '', '智慧数采#1', '站房A相电流', '电力监测', '0', 'Ia', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'phase_c_current', 'PowerMonitoring', 'float', '', '智慧数采#1', '站房C相电流', '电力监测', '0', 'Ic', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'active_power_phase_b', 'PowerMonitoring', 'float', '', '智慧数采#1', 'B相有功功率', '电力监测', '0', 'W', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'reactive_power_phase_a', 'PowerMonitoring', 'float', '', '智慧数采#1', 'A相无功功率', '电力监测', '0', 'Var', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'reactive_power_phase_c', 'PowerMonitoring', 'float', '', '智慧数采#1', 'C相无功功率', '电力监测', '0', 'Var', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'power_factor_phase_b', 'PowerMonitoring', 'float', '', '智慧数采#1', 'B相功率因数', '电力监测', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'voltage_frequency', 'PowerMonitoring', 'None', '', '智慧数采#1', '电压频率', '电力监测', '0', 'FR', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'heating_belt_power', 'PowerMonitoring', 'float', '', '智慧数采#1', '加热带功率', '电力监测', '0', 'W', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon1_wind_direction', 'AirconPower', 'float', '', '智慧数采#1', '空调1风向', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon1_operation_mode', 'AirconPower', 'float', '', '智慧数采#1', '空调1运行模式', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon2_wind_direction', 'AirconPower', 'float', '', '智慧数采#1', '空调2风向', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon2_operation_mode', 'AirconPower', 'float', '', '智慧数采#1', '空调2运行模式', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon2_current_temperature', 'AirconPower', 'float', '', '智慧数采#1', '空调2当前温度', '空调设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'cylinder_gas2_pressure', 'CylinderGas', 'float', '', '智慧数采#1', '钢瓶气2压力', '钢瓶气设备', '0', 'kPa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'zero_gas_pressure', 'GasDevice', 'float', '', '智慧数采#1', '零气压力', '气体处理设备', '0', 'kPa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'co_cylinder_gas_leak_status', 'GasDevice', 'float', '', '智慧数采#1', 'CO钢瓶气泄露状态', '气体处理设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'zero_gas_relay', 'GasDevice', 'float', '', '智慧数采#1', '零气继电器', '气体处理设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'calibration_valve1_control', 'Calibrator', 'float', '', '智慧数采#1', '校准阀1控制', '校准仪设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'calibration_valve3_control', 'Calibrator', 'float', '', '智慧数采#1', '校准阀3控制', '校准仪设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'smoke_sensor1_status', 'AlarmStatus', 'float', '1.0', '智慧数采#1', '烟感1状态（火警）', '报警状态', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'temperature_sensor1_status', 'AlarmStatus', 'float', '1.0', '智慧数采#1', '温感1状态（火警）', '报警状态', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'water_immersion_status', 'AlarmStatus', 'float', '1.0', '智慧数采#1', '水浸状态', '报警状态', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'zero_gas_pressure_alarm_status', 'AlarmStatus', 'None', '', '智慧数采#1', '零气压力报警状态', '报警状态', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_output_voltage', 'UPS', 'float', '', '智慧数采#1', 'UPS输出电压', 'UPS设备', '0', 'V', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_input_frequency', 'UPS', 'float', '', '智慧数采#1', 'UPS输入频率', 'UPS设备', '0', 'Hz', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'UPS_battery_temperature', 'UPS', 'float', '', '智慧数采#1', 'UPS电池温度', 'UPS设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM2_5_concentration', 'AirDevice', 'float', 'null', '智慧数采#1', 'PM2.5浓度', '空气监测设备', 'null', 'ug/m3', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'O3_concentration', 'AirDevice', 'float', 'null', '智慧数采#1', 'O3浓度', '空气监测设备', 'null', 'ppb', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'CO_concentration', 'AirDevice', 'float', 'null', '智慧数采#1', 'CO浓度', '空气监测设备', 'null', 'ppm', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'NO2_concentration', 'AirDevice', 'float', 'null', '智慧数采#1', 'NO2浓度', '空气监测设备', 'null', 'ppb', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_temperature', 'SamplingPipe', 'float', '', '智慧数采#1', '采样管温度', '采样管设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_velocity', 'SamplingPipe', 'float', '', '智慧数采#1', '采样管流速', '采样管设备', '0', 'm/s', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'SO2_concentration', 'AirDevice', 'float', 'null', '智慧数采#1', 'SO2浓度', '空气监测设备', 'null', 'ppb', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'lighting_control', 'StationBuilding', 'float', '', '智慧数采#1', '照明控制', '站房信息', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM2_5_standard_flow_rate', 'StationBuilding', 'float', '', '智慧数采#1', 'PM2.5标况流量', '站房信息', '0', 'L/min', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_leak_status', 'SamplingPipe', 'float', '', '智慧数采#1', '采样管漏水状态', '采样管设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'sampling_pipe_sampling_status', 'SamplingPipe', 'None', '', '智慧数采#1', '采样管采样状态', '采样管设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_temperature', 'WeatherDevice', 'float', 'null', '智慧数采#1', '温度', '气象设备', 'null', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_humidity', 'WeatherDevice', 'float', 'null', '智慧数采#1', '湿度', '气象设备', 'null', '%', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_pressure', 'WeatherDevice', 'float', 'null', '智慧数采#1', '大气压力', '气象设备', 'null', 'Kpa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_minute_rainfall', 'WeatherDevice', 'float', 'null', '智慧数采#1', '分钟雨量', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_hour_rainfall', 'WeatherDevice', 'float', 'null', '智慧数采#1', '小时雨量', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_24hour_rainfall', 'WeatherDevice', 'float', 'null', '智慧数采#1', '24小时雨量', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_accumulate_rainfall', 'WeatherDevice', 'float', 'null', '智慧数采#1', '累积雨量', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_total_solar_radiation', 'WeatherDevice', 'float', 'null', '智慧数采#1', '太阳光总辐射', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'heating_temperature', 'Other', 'float', '', '智慧数采#1', '加热温度', '其他设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'cylinder_gas_alarm_limit', 'Other', 'float', '', '智慧数采#1', '钢瓶气报警限值', '其他设备', '0', '%', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'equipment_status', 'StationBuilding', 'float', '', '智慧数采#1', '仪器状态', '站房信息', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'zero_gas_alarm_limit', 'Other', 'float', '', '智慧数采#1', '零气报警限值', '其他设备', '0', 'kPa', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'room_temperature', 'StationBuilding', 'float', '', '智慧数采#1', '站房温度', '站房信息', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'infrared_status', 'StationBuilding', 'float', '1.0', '智慧数采#1', '红外状态', '站房信息', '1.0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM10_standard_flow_rate', 'StationBuilding', 'float', '', '智慧数采#1', 'PM10标况流量', '站房信息', '0', 'L/min', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'PM2_5_actual_flow_rate', 'StationBuilding', 'float', '', '智慧数采#1', 'PM2.5工况流量', '站房信息', '0.0', 'L/min', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon1_current_temperature', 'AirconPower', 'float', '', '智慧数采#1', '空调1当前温度', '空调设备', '0', '℃', '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'aircon2_set_temperature', 'AirconPower', 'float', '', '智慧数采#1', '空调2设定温度', '空调设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'SO2_film_changing_instrument_status', 'FilmChanging', 'float', '', '智慧数采#1', 'SO2换膜仪器状态', '换模设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'NOx_film_changing_instrument_status', 'FilmChanging', 'float', '', '智慧数采#1', 'NOx换膜仪器状态', '换模设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'CO_film_changing_instrument_status', 'FilmChanging', 'float', '', '智慧数采#1', 'CO换膜仪器状态', '换模设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'O3_film_changing_instrument_status', 'FilmChanging', 'float', '', '智慧数采#1', 'O3换膜仪器状态', '换模设备', '0', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_wind_speed', 'WeatherDevice', 'float', 'null', '智慧数采#1', '风速', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');
INSERT INTO "public"."nowdata" VALUES ('IntelligentDataCollection', 'weather_wind_direction', 'WeatherDevice', 'float', 'null', '智慧数采#1', '风向', '气象设备', 'null', NULL, '2025-04-09 06:04:00+00');

-- ----------------------------
-- Table structure for para_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."para_info";
CREATE TABLE "public"."para_info" (
  "para_id" int4 NOT NULL DEFAULT nextval('paid'::regclass),
  "pa_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "pa_unit" varchar(255) COLLATE "pg_catalog"."default",
  "cmd" varchar(255) COLLATE "pg_catalog"."default",
  "cmd_name" varchar(255) COLLATE "pg_catalog"."default",
  "value_type" varchar(255) COLLATE "pg_catalog"."default",
  "pid" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "pname" varchar(255) COLLATE "pg_catalog"."default",
  "st_code" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "cmd_type" varchar(255) COLLATE "pg_catalog"."default",
  "orderby" int4,
  "create_time" timestamp(6),
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."para_info"."para_id" IS 'ID';
COMMENT ON COLUMN "public"."para_info"."pa_name" IS '参数名称';
COMMENT ON COLUMN "public"."para_info"."pa_unit" IS '参数单位';
COMMENT ON COLUMN "public"."para_info"."cmd" IS '参数指令';
COMMENT ON COLUMN "public"."para_info"."cmd_name" IS '指令名称';
COMMENT ON COLUMN "public"."para_info"."value_type" IS '数据类型';
COMMENT ON COLUMN "public"."para_info"."pid" IS '参数英文标识';
COMMENT ON COLUMN "public"."para_info"."pname" IS '参数中文标识';
COMMENT ON COLUMN "public"."para_info"."st_code" IS '设备编码';
COMMENT ON COLUMN "public"."para_info"."cmd_type" IS '指令类型';
COMMENT ON COLUMN "public"."para_info"."orderby" IS '排序';
COMMENT ON COLUMN "public"."para_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."para_info"."update_time" IS '更新时间';

-- ----------------------------
-- Records of para_info
-- ----------------------------
INSERT INTO "public"."para_info" VALUES (211, '空调2运行模式', NULL, NULL, NULL, 'float', 'aircon2_operation_mode', '空调2运行模式', 'AirconPower', NULL, 10, '2025-04-08 13:57:55.995', NULL);
INSERT INTO "public"."para_info" VALUES (212, '空调2风速', NULL, NULL, NULL, 'float', 'aircon2_wind_speed', '空调2风速', 'AirconPower', NULL, 11, '2025-04-08 13:58:09.694', NULL);
INSERT INTO "public"."para_info" VALUES (168, '仪器状态', NULL, NULL, NULL, 'float', 'equipment_status', '仪器状态', 'StationBuilding', NULL, 1, '2025-04-08 13:31:46', '2025-04-08 13:38:40.762');
INSERT INTO "public"."para_info" VALUES (169, '站房温度', '℃', NULL, NULL, 'float', 'room_temperature', '站房温度', 'StationBuilding', NULL, 2, '2025-04-08 13:33:46', '2025-04-08 13:38:43.691');
INSERT INTO "public"."para_info" VALUES (170, '站房湿度', '%RH', NULL, NULL, 'float', 'room_humidity', '站房湿度', 'StationBuilding', NULL, 3, '2025-04-08 13:35:57', '2025-04-08 13:38:48.306');
INSERT INTO "public"."para_info" VALUES (171, '照明控制', NULL, NULL, NULL, 'float', 'lighting_control', '照明控制', 'StationBuilding', NULL, 4, '2025-04-08 13:36:31', '2025-04-08 13:38:51.616');
INSERT INTO "public"."para_info" VALUES (172, '红外状态', NULL, NULL, NULL, 'float', 'infrared_status', '红外状态', 'StationBuilding', NULL, 5, '2025-04-08 13:36:49', '2025-04-08 13:38:54.229');
INSERT INTO "public"."para_info" VALUES (173, 'PM10标况流量', 'L/min', NULL, NULL, 'float', 'PM10_standard_flow_rate', 'PM10标况流量', 'StationBuilding', NULL, 6, '2025-04-08 13:37:10', '2025-04-08 13:38:57.772');
INSERT INTO "public"."para_info" VALUES (174, 'PM10工况流量', 'L/min', NULL, NULL, 'float', 'PM10_actual_flow_rate', 'PM10工况流量', 'StationBuilding', NULL, 7, '2025-04-08 13:37:34', '2025-04-08 13:39:00.652');
INSERT INTO "public"."para_info" VALUES (175, 'PM2.5标况流量', 'L/min', NULL, NULL, 'float', 'PM2_5_standard_flow_rate', 'PM2.5标况流量', 'StationBuilding', NULL, 8, '2025-04-08 13:37:53', '2025-04-08 13:39:03.624');
INSERT INTO "public"."para_info" VALUES (176, 'PM2.5工况流量', 'L/min', NULL, NULL, 'float', 'PM2_5_actual_flow_rate', 'PM2.5工况流量', 'StationBuilding', NULL, 9, '2025-04-08 13:38:10', '2025-04-08 13:39:06.435');
INSERT INTO "public"."para_info" VALUES (177, '采样管温度', '℃', NULL, NULL, 'float', 'sampling_pipe_temperature', '采样管温度', 'SamplingPipe', NULL, 1, '2025-04-08 13:39:47.226', NULL);
INSERT INTO "public"."para_info" VALUES (178, '采样管湿度', '%RH', NULL, NULL, 'float', 'sampling_pipe_humidity', '采样管湿度', 'SamplingPipe', NULL, 2, '2025-04-08 13:40:04.068', NULL);
INSERT INTO "public"."para_info" VALUES (179, '采样管流速', 'm/s', NULL, NULL, 'float', 'sampling_pipe_velocity', '采样管流速', 'SamplingPipe', NULL, 3, '2025-04-08 13:40:21.135', NULL);
INSERT INTO "public"."para_info" VALUES (180, '采样管静压', 'Kpa', NULL, NULL, 'float', 'sampling_pipe_static_pressure', '采样管静压', 'SamplingPipe', NULL, 4, '2025-04-08 13:40:37.575', NULL);
INSERT INTO "public"."para_info" VALUES (181, '采样管漏水状态', '℃', NULL, NULL, 'float', 'sampling_pipe_leak_status', '采样管漏水状态', 'SamplingPipe', NULL, 5, '2025-04-08 13:40:55', '2025-04-08 13:41:16.945');
INSERT INTO "public"."para_info" VALUES (182, '采样管地址', NULL, NULL, NULL, NULL, 'sampling_pipe_address', '采样管地址', 'SamplingPipe', NULL, 6, '2025-04-08 13:41:11', '2025-04-08 13:41:20.06');
INSERT INTO "public"."para_info" VALUES (183, '采样管采样状态', NULL, NULL, NULL, NULL, 'sampling_pipe_sampling_status', '采样管采样状态', 'SamplingPipe', NULL, 7, '2025-04-08 13:41:43.974', NULL);
INSERT INTO "public"."para_info" VALUES (184, '站房A相电压', 'Ua', NULL, NULL, 'float', 'phase_a_voltage', '站房A相电压', 'PowerMonitoring', NULL, 1, '2025-04-08 13:44:10.268', NULL);
INSERT INTO "public"."para_info" VALUES (185, '站房B相电压', 'Ub', NULL, NULL, 'float', 'phase_b_voltage', '站房B相电压', 'PowerMonitoring', NULL, 2, '2025-04-08 13:44:25.396', NULL);
INSERT INTO "public"."para_info" VALUES (186, '站房C相电压', 'Uc', NULL, NULL, 'float', 'phase_c_voltage', '站房C相电压', 'PowerMonitoring', NULL, 3, '2025-04-08 13:44:42.559', NULL);
INSERT INTO "public"."para_info" VALUES (187, '站房A相电流', 'Ia', NULL, NULL, 'float', 'phase_a_current', '站房A相电流', 'PowerMonitoring', NULL, 4, '2025-04-08 13:44:59.673', NULL);
INSERT INTO "public"."para_info" VALUES (188, '站房B相电流', 'Ib', NULL, NULL, 'float', 'phase_b_current', '站房B相电流', 'PowerMonitoring', NULL, 5, '2025-04-08 13:45:16.403', NULL);
INSERT INTO "public"."para_info" VALUES (189, '站房C相电流', 'Ic', NULL, NULL, 'float', 'phase_c_current', '站房C相电流', 'PowerMonitoring', NULL, 6, '2025-04-08 13:45:36.878', NULL);
INSERT INTO "public"."para_info" VALUES (190, 'A相有功功率', 'W', NULL, NULL, 'float', 'active_power_phase_a', 'A相有功功率', 'PowerMonitoring', NULL, 7, '2025-04-08 13:45:55.273', NULL);
INSERT INTO "public"."para_info" VALUES (191, 'B相有功功率', 'W', NULL, NULL, 'float', 'active_power_phase_b', 'B相有功功率', 'PowerMonitoring', NULL, 8, '2025-04-08 13:46:18.461', NULL);
INSERT INTO "public"."para_info" VALUES (192, 'C相有功功率', 'W', NULL, NULL, 'float', 'active_power_phase_c', 'C相有功功率', 'PowerMonitoring', NULL, 9, '2025-04-08 13:46:34.22', NULL);
INSERT INTO "public"."para_info" VALUES (193, 'A相无功功率', 'Var', NULL, NULL, 'float', 'reactive_power_phase_a', 'A相无功功率', 'PowerMonitoring', NULL, 10, '2025-04-08 13:46:53.577', NULL);
INSERT INTO "public"."para_info" VALUES (194, 'B相无功功率', 'Var', NULL, NULL, 'float', 'reactive_power_phase_b', 'B相无功功率', 'PowerMonitoring', NULL, 11, '2025-04-08 13:47:15.628', NULL);
INSERT INTO "public"."para_info" VALUES (195, 'C相无功功率', 'Var', NULL, NULL, 'float', 'reactive_power_phase_c', 'C相无功功率', 'PowerMonitoring', NULL, 12, '2025-04-08 13:47:32.924', NULL);
INSERT INTO "public"."para_info" VALUES (196, 'A相功率因数', NULL, NULL, NULL, NULL, 'power_factor_phase_a', 'A相功率因数', 'PowerMonitoring', NULL, 13, '2025-04-08 13:47:45.571', NULL);
INSERT INTO "public"."para_info" VALUES (197, 'B相功率因数', NULL, NULL, NULL, 'float', 'power_factor_phase_b', 'B相功率因数', 'PowerMonitoring', NULL, 14, '2025-04-08 13:47:56.743', NULL);
INSERT INTO "public"."para_info" VALUES (198, 'C相功率因数', NULL, NULL, NULL, 'float', 'power_factor_phase_c', 'C相功率因数', 'PowerMonitoring', NULL, 15, '2025-04-08 13:48:10.733', NULL);
INSERT INTO "public"."para_info" VALUES (199, '电压频率', 'FR', NULL, NULL, NULL, 'voltage_frequency', '电压频率', 'PowerMonitoring', NULL, 16, '2025-04-08 13:48:26.051', NULL);
INSERT INTO "public"."para_info" VALUES (200, '风机功率', 'W', NULL, NULL, 'float', 'fan_power', '风机功率', 'PowerMonitoring', NULL, 17, '2025-04-08 13:48:47.283', NULL);
INSERT INTO "public"."para_info" VALUES (201, '加热带功率', 'W', NULL, NULL, 'float', 'heating_belt_power', '加热带功率', 'PowerMonitoring', NULL, 18, '2025-04-08 13:49:01.1', NULL);
INSERT INTO "public"."para_info" VALUES (202, '空调1开机状态', NULL, NULL, NULL, 'float', 'aircon1_power_state', '空调1开机状态', 'AirconPower', NULL, 1, '2025-04-08 13:50:03.275', NULL);
INSERT INTO "public"."para_info" VALUES (203, '空调1风向', NULL, NULL, NULL, 'float', 'aircon1_wind_direction', '空调1风向', 'AirconPower', NULL, 2, '2025-04-08 13:56:07.341', NULL);
INSERT INTO "public"."para_info" VALUES (204, '空调1设定温度', '℃', NULL, NULL, 'float', 'aircon1_set_temperature', '空调1设定温度', 'AirconPower', NULL, 3, '2025-04-08 13:56:25.097', NULL);
INSERT INTO "public"."para_info" VALUES (205, '空调1运行模式', NULL, NULL, NULL, 'float', 'aircon1_operation_mode', '空调1运行模式', 'AirconPower', NULL, 4, '2025-04-08 13:56:39.467', NULL);
INSERT INTO "public"."para_info" VALUES (206, '空调1风速', NULL, NULL, NULL, 'float', 'aircon1_wind_speed', '空调1风速', 'AirconPower', NULL, 5, '2025-04-08 13:56:49.411', NULL);
INSERT INTO "public"."para_info" VALUES (207, '空调1当前温度', '℃', NULL, NULL, 'float', 'aircon1_current_temperature', '空调1当前温度', 'AirconPower', NULL, 6, '2025-04-08 13:57:06.069', NULL);
INSERT INTO "public"."para_info" VALUES (208, '空调2开机状态', NULL, NULL, NULL, 'float', 'aircon2_power_state', '空调2开机状态', 'AirconPower', NULL, 7, '2025-04-08 13:57:21.134', NULL);
INSERT INTO "public"."para_info" VALUES (209, '空调2风向', NULL, NULL, NULL, 'float', 'aircon2_wind_direction', '空调2风向', 'AirconPower', NULL, 8, '2025-04-08 13:57:32.571', NULL);
INSERT INTO "public"."para_info" VALUES (210, '空调2设定温度', NULL, NULL, NULL, 'float', 'aircon2_set_temperature', '空调2设定温度', 'AirconPower', NULL, 9, '2025-04-08 13:57:44.168', NULL);
INSERT INTO "public"."para_info" VALUES (213, '空调2当前温度', '℃', NULL, NULL, 'float', 'aircon2_current_temperature', '空调2当前温度', 'AirconPower', NULL, 12, '2025-04-08 13:58:23.499', NULL);
INSERT INTO "public"."para_info" VALUES (214, '钢瓶气1压力', 'kPa', NULL, NULL, 'float', 'cylinder_gas1_pressure', '钢瓶气1压力', 'CylinderGas', NULL, 1, '2025-04-08 13:58:58.736', NULL);
INSERT INTO "public"."para_info" VALUES (215, '钢瓶气2压力', 'kPa', NULL, NULL, 'float', 'cylinder_gas2_pressure', '钢瓶气2压力', 'CylinderGas', NULL, 2, '2025-04-08 13:59:12.666', NULL);
INSERT INTO "public"."para_info" VALUES (216, '钢瓶气3压力', 'kPa', NULL, NULL, 'float', 'cylinder_gas3_pressure', '钢瓶气3压力', 'CylinderGas', NULL, 3, '2025-04-08 13:59:28.356', NULL);
INSERT INTO "public"."para_info" VALUES (217, '零气压力', 'kPa', NULL, NULL, 'float', 'zero_gas_pressure', '零气压力', 'GasDevice', NULL, 1, '2025-04-08 13:59:51.929', NULL);
INSERT INTO "public"."para_info" VALUES (218, 'CO涤除器温度', '℃', NULL, NULL, 'float', 'co_absorber_temperature', 'CO涤除器温度', 'GasDevice', NULL, 2, '2025-04-08 14:00:05.268', NULL);
INSERT INTO "public"."para_info" VALUES (219, 'CO钢瓶气泄露状态', NULL, NULL, NULL, 'float', 'co_cylinder_gas_leak_status', 'CO钢瓶气泄露状态', 'GasDevice', NULL, 3, '2025-04-08 14:00:16.851', NULL);
INSERT INTO "public"."para_info" VALUES (220, '风机控制', NULL, NULL, NULL, 'float', 'fan_control', '风机控制', 'GasDevice', NULL, 4, '2025-04-08 14:00:29.023', NULL);
INSERT INTO "public"."para_info" VALUES (221, '零气继电器', NULL, NULL, NULL, 'float', 'zero_gas_relay', '零气继电器', 'GasDevice', NULL, 5, '2025-04-08 14:00:43.222', NULL);
INSERT INTO "public"."para_info" VALUES (222, '校准仪继电器', NULL, NULL, NULL, 'float', 'calibrator_relay', '校准仪继电器', 'Calibrator', NULL, 1, '2025-04-08 14:01:04.473', NULL);
INSERT INTO "public"."para_info" VALUES (223, '校准阀1控制', NULL, NULL, NULL, 'float', 'calibration_valve1_control', '校准阀1控制', 'Calibrator', NULL, 2, '2025-04-08 14:01:15.352', NULL);
INSERT INTO "public"."para_info" VALUES (224, '校准阀2控制', NULL, NULL, NULL, 'float', 'calibration_valve2_control', '校准阀2控制', 'Calibrator', NULL, 3, '2025-04-08 14:01:28.81', NULL);
INSERT INTO "public"."para_info" VALUES (225, '校准阀3控制', NULL, NULL, NULL, 'float', 'calibration_valve3_control', '校准阀3控制', 'Calibrator', NULL, 4, '2025-04-08 14:01:39.345', NULL);
INSERT INTO "public"."para_info" VALUES (226, '校准阀4控制', NULL, NULL, NULL, 'float', 'calibration_valve4_control', '校准阀4控制', 'Calibrator', NULL, 5, '2025-04-08 14:01:49.297', NULL);
INSERT INTO "public"."para_info" VALUES (227, '烟感1状态（火警）', NULL, NULL, NULL, 'float', 'smoke_sensor1_status', '烟感1状态（火警）', 'AlarmStatus', NULL, 1, '2025-04-08 14:09:04.157', NULL);
INSERT INTO "public"."para_info" VALUES (228, '烟感2状态（火警）', NULL, NULL, NULL, 'float', 'smoke_sensor2_status', '烟感2状态（火警）', 'AlarmStatus', NULL, 2, '2025-04-08 14:09:14.97', NULL);
INSERT INTO "public"."para_info" VALUES (229, '温感1状态（火警）', NULL, NULL, NULL, 'float', 'temperature_sensor1_status', '温感1状态（火警）', 'AlarmStatus', NULL, 3, '2025-04-08 14:09:24.81', NULL);
INSERT INTO "public"."para_info" VALUES (230, '温感2状态（火警）', NULL, NULL, NULL, 'float', 'temperature_sensor2_status', '温感2状态（火警）', 'AlarmStatus', NULL, 4, '2025-04-08 14:09:36.384', NULL);
INSERT INTO "public"."para_info" VALUES (231, '水浸状态', NULL, NULL, NULL, 'float', 'water_immersion_status', '水浸状态', 'AlarmStatus', NULL, 5, '2025-04-08 14:09:47.627', NULL);
INSERT INTO "public"."para_info" VALUES (232, '钢瓶气压力报警状态', NULL, NULL, NULL, 'float', 'cylinder_gas_pressure_alarm_status', '钢瓶气压力报警状态', 'AlarmStatus', NULL, 6, '2025-04-08 14:09:57.797', NULL);
INSERT INTO "public"."para_info" VALUES (233, '零气压力报警状态', NULL, NULL, NULL, NULL, 'zero_gas_pressure_alarm_status', '零气压力报警状态', 'AlarmStatus', NULL, 7, '2025-04-08 14:10:07.99', NULL);
INSERT INTO "public"."para_info" VALUES (234, 'UPS输入电压', 'V', NULL, NULL, 'float', 'UPS_input_voltage', 'UPS输入电压', 'UPS', NULL, 1, '2025-04-08 14:17:25.109', NULL);
INSERT INTO "public"."para_info" VALUES (235, 'UPS输出电压', 'V', NULL, NULL, 'float', 'UPS_output_voltage', 'UPS输出电压', 'UPS', NULL, 2, '2025-04-08 14:17:39.433', NULL);
INSERT INTO "public"."para_info" VALUES (236, 'UPS输出负载百分比', '%', NULL, NULL, 'float', 'UPS_output_load_percentage', 'UPS输出负载百分比', 'UPS', NULL, 3, '2025-04-08 14:17:55.62', NULL);
INSERT INTO "public"."para_info" VALUES (237, 'UPS输入频率', 'Hz', NULL, NULL, 'float', 'UPS_input_frequency', 'UPS输入频率', 'UPS', NULL, 4, '2025-04-08 14:18:08.745', NULL);
INSERT INTO "public"."para_info" VALUES (239, 'UPS电池温度', '℃', NULL, NULL, 'float', 'UPS_battery_temperature', 'UPS电池温度', 'UPS', NULL, 6, '2025-04-08 14:18:37.598', NULL);
INSERT INTO "public"."para_info" VALUES (240, 'UPS状态', NULL, NULL, NULL, 'float', 'UPS_status', 'UPS状态', 'UPS', NULL, 7, '2025-04-08 14:18:50.984', NULL);
INSERT INTO "public"."para_info" VALUES (238, 'UPS电池单元电压', 'V', NULL, NULL, 'float', 'UPS_battery_cell_voltage', 'UPS电池单元电压', 'UPS', NULL, 5, '2025-04-08 14:18:23', '2025-04-08 14:18:58.177');
INSERT INTO "public"."para_info" VALUES (241, 'PM2.5浓度', 'ug/m3', NULL, NULL, 'float', 'PM2_5_concentration', 'PM2.5浓度', 'AirDevice', NULL, 1, '2025-04-08 14:30:51.612', NULL);
INSERT INTO "public"."para_info" VALUES (242, 'PM10浓度', 'ug/m3', NULL, NULL, 'float', 'PM10_concentration', 'PM10浓度', 'AirDevice', NULL, 2, '2025-04-08 14:31:06.575', NULL);
INSERT INTO "public"."para_info" VALUES (243, 'O3浓度', 'ppb', NULL, NULL, 'float', 'O3_concentration', 'O3浓度', 'AirDevice', NULL, 3, '2025-04-08 14:31:21.074', NULL);
INSERT INTO "public"."para_info" VALUES (244, 'CO浓度', 'ppm', NULL, NULL, 'float', 'CO_concentration', 'CO浓度', 'AirDevice', NULL, 4, '2025-04-08 14:31:37.252', NULL);
INSERT INTO "public"."para_info" VALUES (245, 'NO2浓度', 'ppb', NULL, NULL, 'float', 'NO2_concentration', 'NO2浓度', 'AirDevice', NULL, 5, '2025-04-08 14:31:55.136', NULL);
INSERT INTO "public"."para_info" VALUES (246, 'SO2浓度', 'ppb', NULL, NULL, 'float', 'SO2_concentration', 'SO2浓度', 'AirDevice', NULL, 6, '2025-04-08 14:32:14.163', NULL);
INSERT INTO "public"."para_info" VALUES (247, 'SO2换膜仪器状态', NULL, NULL, NULL, 'float', 'SO2_film_changing_instrument_status', 'SO2换膜仪器状态', 'FilmChanging', NULL, 1, '2025-04-08 14:32:47.817', NULL);
INSERT INTO "public"."para_info" VALUES (248, 'NOx换膜仪器状态', NULL, NULL, NULL, 'float', 'NOx_film_changing_instrument_status', 'NOx换膜仪器状态', 'FilmChanging', NULL, 2, '2025-04-08 14:33:01.733', NULL);
INSERT INTO "public"."para_info" VALUES (249, 'CO换膜仪器状态', NULL, NULL, NULL, 'float', 'CO_film_changing_instrument_status', 'CO换膜仪器状态', 'FilmChanging', NULL, 3, '2025-04-08 14:33:14.765', NULL);
INSERT INTO "public"."para_info" VALUES (250, 'O3换膜仪器状态', NULL, NULL, NULL, 'float', 'O3_film_changing_instrument_status', 'O3换膜仪器状态', 'FilmChanging', NULL, 4, '2025-04-08 14:33:26.606', NULL);
INSERT INTO "public"."para_info" VALUES (251, '风速', NULL, NULL, NULL, 'float', 'weather_wind_speed', '风速', 'WeatherDevice', NULL, 1, '2025-04-08 14:34:16.402', NULL);
INSERT INTO "public"."para_info" VALUES (252, '风向', NULL, NULL, NULL, 'float', 'weather_wind_direction', '风向', 'WeatherDevice', NULL, 2, '2025-04-08 14:34:27.385', NULL);
INSERT INTO "public"."para_info" VALUES (253, '温度', '℃', NULL, NULL, 'float', 'weather_temperature', '温度', 'WeatherDevice', NULL, 3, '2025-04-08 14:34:41.794', NULL);
INSERT INTO "public"."para_info" VALUES (254, '湿度', '%', NULL, NULL, 'float', 'weather_humidity', '湿度', 'WeatherDevice', NULL, 4, '2025-04-08 14:34:54.761', NULL);
INSERT INTO "public"."para_info" VALUES (255, '大气压力', 'Kpa', NULL, NULL, 'float', 'weather_pressure', '大气压力', 'WeatherDevice', NULL, 5, '2025-04-08 14:35:11.048', NULL);
INSERT INTO "public"."para_info" VALUES (256, '分钟雨量', NULL, NULL, NULL, 'float', 'weather_minute_rainfall', '分钟雨量', 'WeatherDevice', NULL, 6, '2025-04-08 14:35:28.134', NULL);
INSERT INTO "public"."para_info" VALUES (257, '小时雨量', NULL, NULL, NULL, 'float', 'weather_hour_rainfall', '小时雨量', 'WeatherDevice', NULL, 7, '2025-04-08 14:35:43.834', NULL);
INSERT INTO "public"."para_info" VALUES (258, '24小时雨量', NULL, NULL, NULL, 'float', 'weather_24hour_rainfall', '24小时雨量', 'WeatherDevice', NULL, 8, '2025-04-08 14:35:57.01', NULL);
INSERT INTO "public"."para_info" VALUES (259, '累积雨量', NULL, NULL, NULL, 'float', 'weather_accumulate_rainfall', '累积雨量', 'WeatherDevice', NULL, 9, '2025-04-08 14:36:18.6', NULL);
INSERT INTO "public"."para_info" VALUES (260, '太阳光总辐射', NULL, NULL, NULL, 'float', 'weather_total_solar_radiation', '太阳光总辐射', 'WeatherDevice', NULL, 10, '2025-04-08 14:36:33.06', NULL);
INSERT INTO "public"."para_info" VALUES (262, '震动', NULL, NULL, NULL, 'float', 'vibration', '震动', 'Other', NULL, 2, '2025-04-08 14:37:11.449', NULL);
INSERT INTO "public"."para_info" VALUES (261, '加热温度', '℃', NULL, NULL, 'float', 'heating_temperature', '加热温度', 'Other', NULL, 1, '2025-04-08 14:36:57', '2025-04-08 14:37:20.007');
INSERT INTO "public"."para_info" VALUES (263, '钢瓶气报警限值', '%', NULL, NULL, 'float', 'cylinder_gas_alarm_limit', '钢瓶气报警限值', 'Other', NULL, 3, '2025-04-08 14:37:50.919', NULL);
INSERT INTO "public"."para_info" VALUES (264, '零气报警限值', 'kPa', NULL, NULL, 'float', 'zero_gas_alarm_limit', '零气报警限值', 'Other', NULL, 4, '2025-04-08 14:38:04.169', NULL);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_blob_triggers";
CREATE TABLE "public"."qrtz_blob_triggers" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "blob_data" bytea
)
;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_calendars";
CREATE TABLE "public"."qrtz_calendars" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "calendar_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "calendar" bytea NOT NULL
)
;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_cron_triggers";
CREATE TABLE "public"."qrtz_cron_triggers" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "cron_expression" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "time_zone_id" varchar(80) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO "public"."qrtz_cron_triggers" VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME17', 'DEFAULT', '* * * * * ?', 'Etc/UTC');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_fired_triggers";
CREATE TABLE "public"."qrtz_fired_triggers" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "entry_id" varchar(95) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "instance_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "fired_time" int8 NOT NULL,
  "sched_time" int8 NOT NULL,
  "priority" int4 NOT NULL,
  "state" varchar(16) COLLATE "pg_catalog"."default" NOT NULL,
  "job_name" varchar(200) COLLATE "pg_catalog"."default",
  "job_group" varchar(200) COLLATE "pg_catalog"."default",
  "is_nonconcurrent" varchar(20) COLLATE "pg_catalog"."default",
  "requests_recovery" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_job_details";
CREATE TABLE "public"."qrtz_job_details" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "job_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "job_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(250) COLLATE "pg_catalog"."default",
  "job_class_name" varchar(250) COLLATE "pg_catalog"."default" NOT NULL,
  "is_durable" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "is_nonconcurrent" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "is_update_data" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "requests_recovery" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "job_data" bytea
)
;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO "public"."qrtz_job_details" VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME17', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', 'false', 'true', 'false', 'false', E'\\254\\355\\000\\005sr\\000\\025org.quartz.JobDataMap\\237\\260\\203\\350\\277\\251\\260\\313\\002\\000\\000xr\\000&org.quartz.utils.StringKeyDirtyFlagMap\\202\\010\\350\\303\\373\\305](\\002\\000\\001Z\\000\\023allowsTransientDataxr\\000\\035org.quartz.utils.DirtyFlagMap\\023\\346.\\255(v\\012\\316\\002\\000\\002Z\\000\\005dirtyL\\000\\003mapt\\000\\017Ljava/util/Map;xp\\001sr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\001t\\000\\017TASK_PROPERTIESsr\\000\\036com.ruoyi.quartz.domain.SysJob\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\011L\\000\\012concurrentt\\000\\022Ljava/lang/String;L\\000\\016cronExpressionq\\000~\\000\\011L\\000\\014invokeTargetq\\000~\\000\\011L\\000\\010jobGroupq\\000~\\000\\011L\\000\\005jobIdt\\000\\020Ljava/lang/Long;L\\000\\007jobNameq\\000~\\000\\011L\\000\\015misfirePolicyq\\000~\\000\\011L\\000\\006statusq\\000~\\000\\011L\\000\\013triggerTypeq\\000~\\000\\011xr\\000''com.ruoyi.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\011L\\000\\012createTimet\\000\\020Ljava/util/Date;L\\000\\006paramsq\\000~\\000\\003L\\000\\006remarkq\\000~\\000\\011L\\000\\013searchValueq\\000~\\000\\011L\\000\\010updateByq\\000~\\000\\011L\\000\\012updateTimeq\\000~\\000\\014xpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001\\227K\\001\\272kxpppppt\\000\\0011t\\000\\013* * * * * ?t\\000?mokeBus.send("sms-qc","STATION_IC","160","2025-06-07 09:00:00")t\\000\\007DEFAULTsr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000\\021t\\000\\024\\347\\224\\265\\346\\265\\201\\345\\274\\202\\345\\270\\270\\346\\263\\242\\345\\212\\250-Ct\\000\\0011t\\000\\0011px\\000');

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_locks";
CREATE TABLE "public"."qrtz_locks" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "lock_name" varchar(40) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO "public"."qrtz_locks" VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');
INSERT INTO "public"."qrtz_locks" VALUES ('RuoyiScheduler', 'STATE_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_paused_trigger_grps";
CREATE TABLE "public"."qrtz_paused_trigger_grps" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_scheduler_state";
CREATE TABLE "public"."qrtz_scheduler_state" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "instance_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "last_checkin_time" int8 NOT NULL,
  "checkin_interval" int8 NOT NULL
)
;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO "public"."qrtz_scheduler_state" VALUES ('RuoyiScheduler', 'LAPTOP-3MPMV2DO1622082068199', 1622082356557, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_simple_triggers";
CREATE TABLE "public"."qrtz_simple_triggers" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "repeat_count" int8 NOT NULL,
  "repeat_interval" int8 NOT NULL,
  "times_triggered" int8 NOT NULL
)
;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_simprop_triggers";
CREATE TABLE "public"."qrtz_simprop_triggers" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "str_prop_1" varchar(512) COLLATE "pg_catalog"."default",
  "str_prop_2" varchar(512) COLLATE "pg_catalog"."default",
  "str_prop_3" varchar(512) COLLATE "pg_catalog"."default",
  "int_prop_1" int4,
  "int_prop_2" int4,
  "long_prop_1" int8,
  "long_prop_2" int8,
  "dec_prop_1" numeric(13,4),
  "dec_prop_2" numeric(13,4),
  "bool_prop_1" varchar(2) COLLATE "pg_catalog"."default",
  "bool_prop_2" varchar(2) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_triggers";
CREATE TABLE "public"."qrtz_triggers" (
  "sched_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "job_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "job_group" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(250) COLLATE "pg_catalog"."default",
  "next_fire_time" int8,
  "prev_fire_time" int8,
  "priority" int4,
  "trigger_state" varchar(16) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_type" varchar(8) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" int8 NOT NULL,
  "end_time" int8,
  "calendar_name" varchar(200) COLLATE "pg_catalog"."default",
  "misfire_instr" int2,
  "job_data" bytea
)
;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO "public"."qrtz_triggers" VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME17', 'DEFAULT', 'TASK_CLASS_NAME17', 'DEFAULT', NULL, 1754114079000, -1, 5, 'WAITING', 'CRON', 1754114079000, 0, NULL, -1, E'\\\\x');

-- ----------------------------
-- Table structure for realdata
-- ----------------------------
DROP TABLE IF EXISTS "public"."realdata";
CREATE TABLE "public"."realdata" (
  "pick_time" timestamptz(6),
  "tid" text COLLATE "pg_catalog"."default" NOT NULL,
  "pid" text COLLATE "pg_catalog"."default" NOT NULL,
  "sid" text COLLATE "pg_catalog"."default" NOT NULL,
  "mindex" int8 NOT NULL DEFAULT 0,
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "fv" numeric,
  "sv" text COLLATE "pg_catalog"."default",
  "iv" int8,
  "value" text COLLATE "pg_catalog"."default",
  "tname" text COLLATE "pg_catalog"."default",
  "pn" text COLLATE "pg_catalog"."default",
  "sname" text COLLATE "pg_catalog"."default",
  "display" text COLLATE "pg_catalog"."default",
  "unit_name" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of realdata
-- ----------------------------

-- ----------------------------
-- Table structure for sta_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."sta_info";
CREATE TABLE "public"."sta_info" (
  "sta_id" int4 NOT NULL DEFAULT nextval('stid'::regclass),
  "sta_name" varchar(255) COLLATE "pg_catalog"."default",
  "st_code" varchar(255) COLLATE "pg_catalog"."default",
  "com" varchar(255) COLLATE "pg_catalog"."default",
  "protocol_type" varchar(255) COLLATE "pg_catalog"."default",
  "st_number" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6),
  "last_data_time" timestamp(6),
  "device_type" varchar(255) COLLATE "pg_catalog"."default",
  "orderby" int4
)
;
COMMENT ON COLUMN "public"."sta_info"."sta_id" IS 'ID自增';
COMMENT ON COLUMN "public"."sta_info"."sta_name" IS '设备名称';
COMMENT ON COLUMN "public"."sta_info"."st_code" IS '设备编码';
COMMENT ON COLUMN "public"."sta_info"."com" IS '设备COM口';
COMMENT ON COLUMN "public"."sta_info"."protocol_type" IS '设备协议类型 支持MOUBUS,MODBUSTCP,CLINK';
COMMENT ON COLUMN "public"."sta_info"."st_number" IS '设备IDNUMBER';
COMMENT ON COLUMN "public"."sta_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sta_info"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sta_info"."last_data_time" IS '最后数据时间';
COMMENT ON COLUMN "public"."sta_info"."device_type" IS '设备类型  先河，热电';
COMMENT ON COLUMN "public"."sta_info"."orderby" IS '设备排序';

-- ----------------------------
-- Records of sta_info
-- ----------------------------
INSERT INTO "public"."sta_info" VALUES (17, '站房信息', 'StationBuilding', 'COM1', 'MOUBUS', '99', '2025-04-08 11:45:11.05', NULL, NULL, 'xianhe', 1);
INSERT INTO "public"."sta_info" VALUES (18, '采样管设备', 'SamplingPipe', 'COM1', 'MOUBUS', '99', '2025-04-08 11:55:02.328', NULL, NULL, 'xianhe', 2);
INSERT INTO "public"."sta_info" VALUES (19, '电力监测', 'PowerMonitoring', 'COM1', 'MOUBUS', '99', '2025-04-08 11:55:21.67', NULL, NULL, 'xianhe', 3);
INSERT INTO "public"."sta_info" VALUES (20, '空调设备', 'AirconPower', 'COM1', 'MOUBUS', '99', '2025-04-08 11:55:43.609', NULL, NULL, 'xianhe', 4);
INSERT INTO "public"."sta_info" VALUES (21, '钢瓶气设备', 'CylinderGas', 'COM1', 'MOUBUS', '99', '2025-04-08 11:56:02.726', NULL, NULL, 'xianhe', 5);
INSERT INTO "public"."sta_info" VALUES (22, '气体处理设备', 'GasDevice', 'COM1', 'MOUBUS', '99', '2025-04-08 11:56:23.301', NULL, NULL, 'xianhe', 6);
INSERT INTO "public"."sta_info" VALUES (23, '校准仪设备', 'Calibrator', 'COM1', 'MOUBUS', '99', '2025-04-08 11:56:46.636', NULL, NULL, 'xianhe', 7);
INSERT INTO "public"."sta_info" VALUES (24, '报警状态', 'AlarmStatus', 'COM1', 'MOUBUS', '99', '2025-04-08 11:57:04.207', NULL, NULL, 'xianhe', 8);
INSERT INTO "public"."sta_info" VALUES (25, 'UPS设备', 'UPS', 'COM1', 'MOUBUS', '99', '2025-04-08 11:57:20.621', NULL, NULL, 'xianhe', 9);
INSERT INTO "public"."sta_info" VALUES (26, '空气监测设备', 'AirDevice', 'COM1', 'MOUBUS', '99', '2025-04-08 11:57:39.367', NULL, NULL, 'xianhe', 10);
INSERT INTO "public"."sta_info" VALUES (27, '换模设备', 'FilmChanging', 'COM1', 'MOUBUS', '99', '2025-04-08 11:58:00.672', NULL, NULL, 'xianhe', 11);
INSERT INTO "public"."sta_info" VALUES (28, '气象设备', 'WeatherDevice', 'COM1', 'MOUBUS', '99', '2025-04-08 11:58:17.904', NULL, NULL, 'xianhe', 12);
INSERT INTO "public"."sta_info" VALUES (29, '其他设备', 'Other', 'COM1', 'MOUBUS', '99', '2025-04-08 11:58:35.256', NULL, NULL, 'xianhe', 13);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_config";
CREATE TABLE "public"."sys_config" (
  "config_id" int8 NOT NULL DEFAULT nextval('sys_config_config_id_seq'::regclass),
  "config_name" varchar(100) COLLATE "pg_catalog"."default",
  "config_key" varchar(100) COLLATE "pg_catalog"."default",
  "config_value" varchar(500) COLLATE "pg_catalog"."default",
  "config_type" char(1) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_config"."config_id" IS '参数主键';
COMMENT ON COLUMN "public"."sys_config"."config_name" IS '参数名称';
COMMENT ON COLUMN "public"."sys_config"."config_key" IS '参数键名';
COMMENT ON COLUMN "public"."sys_config"."config_value" IS '参数键值';
COMMENT ON COLUMN "public"."sys_config"."config_type" IS '系统内置（Y是 N否）';
COMMENT ON COLUMN "public"."sys_config"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_config"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_config"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_config" IS '参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO "public"."sys_config" VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-05-26 18:56:31', 'admin', '2021-05-27 09:07:43.532263', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO "public"."sys_config" VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-05-26 18:56:31', 'admin', '2021-05-27 10:15:52.394492', '初始化密码 123456');
INSERT INTO "public"."sys_config" VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-05-26 18:56:31', 'admin', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO "public"."sys_config" VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-02-14 02:51:47.23521', 'admin', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO "public"."sys_config" VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-02-14 02:51:47.274963', 'admin', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dept";
CREATE TABLE "public"."sys_dept" (
  "dept_id" int8 NOT NULL DEFAULT nextval('sys_dept_dept_id_seq'::regclass),
  "parent_id" int8 DEFAULT 0,
  "ancestors" varchar(50) COLLATE "pg_catalog"."default",
  "dept_name" varchar(30) COLLATE "pg_catalog"."default",
  "order_num" int4,
  "leader" varchar(20) COLLATE "pg_catalog"."default",
  "phone" varchar(11) COLLATE "pg_catalog"."default",
  "email" varchar(50) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT 0,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_dept"."dept_id" IS '部门id';
COMMENT ON COLUMN "public"."sys_dept"."parent_id" IS '父部门id';
COMMENT ON COLUMN "public"."sys_dept"."ancestors" IS '祖级列表';
COMMENT ON COLUMN "public"."sys_dept"."dept_name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_dept"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_dept"."leader" IS '负责人';
COMMENT ON COLUMN "public"."sys_dept"."phone" IS '联系电话';
COMMENT ON COLUMN "public"."sys_dept"."email" IS '邮箱';
COMMENT ON COLUMN "public"."sys_dept"."status" IS '部门状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dept"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sys_dept"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dept"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dept"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dept"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_dept" IS '部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO "public"."sys_dept" VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:27', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:27', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:27', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:28', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:28', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:28', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:28', '', NULL);
INSERT INTO "public"."sys_dept" VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:27', 'admin', '2021-05-27 09:05:25.083296');
INSERT INTO "public"."sys_dept" VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-26 18:56:27', 'admin', '2021-05-27 09:05:25.091901');
INSERT INTO "public"."sys_dept" VALUES (100, 0, '0', '塞默森科技', 0, '塞默森', '15888888888', 'sms@qq.com', '0', '0', 'admin', '2021-05-26 18:56:27', 'admin', '2025-03-07 14:33:25.539159');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_data";
CREATE TABLE "public"."sys_dict_data" (
  "dict_code" int8 NOT NULL DEFAULT nextval('sys_dict_data_dict_code_seq'::regclass),
  "dict_sort" int4,
  "dict_label" varchar(100) COLLATE "pg_catalog"."default",
  "dict_value" varchar(100) COLLATE "pg_catalog"."default",
  "dict_type" varchar(100) COLLATE "pg_catalog"."default",
  "css_class" varchar(100) COLLATE "pg_catalog"."default",
  "list_class" varchar(100) COLLATE "pg_catalog"."default",
  "is_default" char(1) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_dict_data"."dict_code" IS '字典编码';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_sort" IS '字典排序';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_label" IS '字典标签';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_value" IS '字典键值';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."sys_dict_data"."css_class" IS '样式属性（其他样式扩展）';
COMMENT ON COLUMN "public"."sys_dict_data"."list_class" IS '表格回显样式';
COMMENT ON COLUMN "public"."sys_dict_data"."is_default" IS '是否默认（Y是 N否）';
COMMENT ON COLUMN "public"."sys_dict_data"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dict_data"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dict_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict_data"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dict_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict_data"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_dict_data" IS '字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO "public"."sys_dict_data" VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-02-14 02:51:49.035039', '', NULL, '性别男');
INSERT INTO "public"."sys_dict_data" VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-14 02:51:49.074975', '', NULL, '性别女');
INSERT INTO "public"."sys_dict_data" VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-14 02:51:49.115008', '', NULL, '性别未知');
INSERT INTO "public"."sys_dict_data" VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-02-14 02:51:49.154987', '', NULL, '显示菜单');
INSERT INTO "public"."sys_dict_data" VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.195106', '', NULL, '隐藏菜单');
INSERT INTO "public"."sys_dict_data" VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-02-14 02:51:49.235052', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.275068', '', NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-02-14 02:51:49.295032', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.335383', '', NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-02-14 02:51:49.455638', '', NULL, '系统默认是');
INSERT INTO "public"."sys_dict_data" VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.495057', '', NULL, '系统默认否');
INSERT INTO "public"."sys_dict_data" VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-02-14 02:51:49.53504', '', NULL, '通知');
INSERT INTO "public"."sys_dict_data" VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-02-14 02:51:49.575082', '', NULL, '公告');
INSERT INTO "public"."sys_dict_data" VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-02-14 02:51:49.614936', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.654977', '', NULL, '关闭状态');
INSERT INTO "public"."sys_dict_data" VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-14 02:51:49.695066', '', NULL, '新增操作');
INSERT INTO "public"."sys_dict_data" VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-14 02:51:49.735099', '', NULL, '修改操作');
INSERT INTO "public"."sys_dict_data" VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.775112', '', NULL, '删除操作');
INSERT INTO "public"."sys_dict_data" VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-02-14 02:51:49.814982', '', NULL, '授权操作');
INSERT INTO "public"."sys_dict_data" VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-14 02:51:49.854954', '', NULL, '导出操作');
INSERT INTO "public"."sys_dict_data" VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-14 02:51:49.894998', '', NULL, '导入操作');
INSERT INTO "public"."sys_dict_data" VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:49.934925', '', NULL, '强退操作');
INSERT INTO "public"."sys_dict_data" VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-14 02:51:49.97508', '', NULL, '生成操作');
INSERT INTO "public"."sys_dict_data" VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:50.014975', '', NULL, '清空操作');
INSERT INTO "public"."sys_dict_data" VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-02-14 02:51:50.055038', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-02-14 02:51:50.094784', '', NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" VALUES (29, 0, '智慧数采#1', 'IntelligentDataCollection', 'sys_tid', NULL, 'default', NULL, '0', 'admin', '2025-02-14 11:28:33.096474', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (31, 0, '浮点数', 'float', 'sys_data_type', NULL, 'default', NULL, '0', 'admin', '2025-02-14 11:30:53.384984', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (32, 1, '字符串', 'string', 'sys_data_type', NULL, 'default', NULL, '0', 'admin', '2025-02-14 11:31:04.853931', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (30, 0, '智慧数采#1', '智慧数采#1', 'sys_tid_name', NULL, 'default', NULL, '0', 'admin', '2025-02-14 11:29:41.192463', 'admin', '2025-02-14 11:31:23.900957', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (33, 0, 'COM1', 'COM1', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:00.559976', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (34, 1, 'COM2', 'COM2', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:06.704006', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (35, 3, 'COM3', 'COM3', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:15.189404', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (36, 4, 'COM4', 'COM4', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:21.653649', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (37, 5, 'COM5', 'COM5', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:27.798961', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (38, 6, 'COM6', 'COM6', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:39.060904', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (39, 7, 'COM7', 'COM7', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:45.82049', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (40, 8, 'COM8', 'COM8', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:31:58.722149', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (41, 9, 'COM9', 'COM9', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:32:05.071043', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (42, 10, 'COM10', 'COM10', 'sys_device_com', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:32:12.546154', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (43, 0, 'MOUBUS', 'MOUBUS', 'sys_device_pro', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:35:59.051577', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (44, 1, 'MOUBUS-TCP', 'MODBUSTCP', 'sys_device_pro', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:36:15.742045', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (45, 2, 'CLINK', 'CLINK', 'sys_device_pro', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:36:21.681483', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (46, 0, '先河', 'xianhe', 'sys_device_type', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:39:13.507121', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (47, 1, '热电', 'redian', 'sys_device_type', NULL, 'default', NULL, '0', 'admin', '2025-02-14 13:39:21.289707', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (53, 0, '智能采集    ', 'IntelligentDataCollection ', 'thing_type', NULL, 'default', NULL, '0', 'admin', '2025-02-18 11:41:11.555552', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (59, 0, '导出', '1', 'task_type', NULL, 'default', NULL, '0', 'admin', '2025-02-24 13:53:00.336544', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (60, 1, '导入', '2', 'task_type', NULL, 'default', NULL, '0', 'admin', '2025-02-24 13:54:10.499903', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (61, 0, '等待', 'pending', 'task_status', NULL, 'default', NULL, '0', 'admin', '2025-02-24 14:20:36.145797', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (63, 2, '成功', 'completed', 'task_status', NULL, 'default', NULL, '0', 'admin', '2025-02-24 14:25:22.565434', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (62, 1, '进行中', 'processing', 'task_status', NULL, 'default', NULL, '0', 'admin', '2025-02-24 14:23:39.974646', 'admin', '2025-03-04 11:11:51.826286', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (57, 1, '正常工作', '1', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-02-18 13:48:37.695332', 'admin', '2025-06-25 15:26:56.821661', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (58, 0, '待机', '0', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-02-18 13:49:41.083357', 'admin', '2025-06-25 15:27:03.044748', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (48, 0, '进行中', '0', 'event_status', NULL, 'default', NULL, '0', 'admin', '2025-02-18 10:38:59.882603', 'admin', '2025-06-10 11:11:25.135639', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (50, 0, '普通', '0', 'event_security', NULL, 'default', NULL, '0', 'admin', '2025-02-18 10:42:10.310314', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (51, 1, '重要', '1', 'event_security', NULL, 'default', NULL, '0', 'admin', '2025-02-18 10:42:24.758055', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (52, 2, '紧急', '2', 'event_security', NULL, 'default', NULL, '0', 'admin', '2025-02-18 10:42:56.15506', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (64, 0, '温度高', '1', 'event_type', NULL, 'default', NULL, '0', 'admin', '2025-05-15 15:45:44.150987', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (65, 0, '门禁打开', '2', 'event_type', NULL, 'default', NULL, '0', 'admin', '2025-05-15 15:46:00.023575', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (72, 0, '设备间温度异常', '1', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:14:11.767225', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (73, 2, '设备间湿度异常', '2', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:14:31.955028', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (49, 1, '结束', '1', 'event_status', NULL, 'default', NULL, '0', 'admin', '2025-02-18 10:41:41.340735', 'admin', '2025-06-10 11:11:34.697908', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (69, 0, '零点核查', '0', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:13:34.698961', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (70, 2, '线性核查', '2', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:13:52.165704', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (71, 1, '跨度校准', '1', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:14:10.132452', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (67, 0, '计划任务', '0', 'quality_control_task_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:10:30.583954', 'admin', '2025-08-04 16:54:46.449977', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (66, 1, '手动任务', '1', 'quality_control_task_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:09:44.965132', 'admin', '2025-08-04 16:54:54.146312', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (68, 2, '现场任务', '2', 'quality_control_task_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:10:47.169554', 'admin', '2025-08-04 16:55:02.265462', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (74, 3, '设备间漏水', '3', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:14:41.820906', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (75, 4, '供电电源异常波动', '4', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:14:50.685013', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (76, 5, '稳压电源异常波动', '5', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:14:59.995441', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (77, 6, '电流异常波动', '6', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:09.021601', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (78, 7, '有毒有害物质泄露报警', '7', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:16.820676', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (79, 8, '标准气体泄漏', '8', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:24.301417', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (80, 9, '标准气体更换', '9', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:32.027893', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (81, 10, '颗粒物纸带更换', '10', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:40.413341', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (82, 11, '采样总管流速异常', '11', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:46.739274', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (83, 12, '采样总管温度异常', '12', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:15:53.263968', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (84, 13, '支管冷凝水预警', '13', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:16:00.277096', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (85, 14, '监测设备报警', '14', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:16:06.872528', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (86, 15, '断电和恢复报警', '15', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:16:13.098379', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (87, 16, '消防报警', '16', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:16:21.239054', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (88, 17, '异常进入报警', '17', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:16:27.974483', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (89, 18, '干扰报警', '18', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 11:16:34.752069', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (92, 2, '成功', '2', 'quality_control_execution_status', NULL, 'success', NULL, '0', 'admin', '2025-05-26 15:17:06.31282', 'admin', '2025-06-20 00:18:06.834949', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (94, 0, 'SO2', '1', 'quality_control_param', NULL, 'default', NULL, '0', 'admin', '2025-05-26 16:37:27.535872', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (98, 4, 'PM10', '5', 'quality_control_param', NULL, 'default', NULL, '0', 'admin', '2025-05-26 16:38:33.291337', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (99, 5, 'PM2.5', '6', 'quality_control_param', NULL, 'default', NULL, '0', 'admin', '2025-05-26 16:38:50.184871', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (95, 1, 'NOx', '2', 'quality_control_param', NULL, 'default', NULL, '0', 'admin', '2025-05-26 16:37:35.948963', 'admin', '2025-06-20 01:34:18.199537', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (102, 0, '空调设备', '0', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:06:45.194356', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (103, 1, '开关设备', '1', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:06:56.017125', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (104, 0, 'SO2滤膜管理', '1', 'maintenance_mode', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:13:15.69763', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (105, 1, 'NO2滤膜管理', '2', 'maintenance_mode', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:13:48.925126', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (106, 2, 'O3滤膜管理', '3', 'maintenance_mode', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:14:01.38454', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (107, 3, 'CO滤膜管理', '4', 'maintenance_mode', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:14:09.9849', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (108, 4, 'PM10切割器管理', '5', 'maintenance_mode', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:14:19.918036', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (109, 5, 'PM2.5切割器管理', '6', 'maintenance_mode', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:14:39.28783', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (110, 0, '空气检测子站巡检', '1', 'patrol_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 00:54:37.454371', 'admin', '2025-05-27 00:54:57.12447', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (111, 2, '门禁设备', '2', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 09:12:40.288281', 'admin', '2025-05-27 09:12:48.868392', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (113, 4, '巡检任务', 'Patrol', 'sys_job_group', NULL, 'primary', NULL, '0', 'admin', '2025-05-27 13:47:31.197995', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (114, 5, '维护任务', 'Maintenance', 'sys_job_group', NULL, 'primary', NULL, '0', 'admin', '2025-05-27 13:48:40.098734', 'admin', '2025-07-10 14:23:42.901771', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (10, 1, '自定义', 'DEFAULT', 'sys_job_group', '', 'info', 'Y', '0', 'admin', '2025-02-14 02:51:49.375243', 'admin', '2025-05-27 14:13:48.800001', '默认分组');
INSERT INTO "public"."sys_dict_data" VALUES (115, 0, 'CO气罐', '1', 'material_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 17:16:54.483273', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (116, 1, 'SO2气罐', '2', 'material_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 17:17:16.810759', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (117, 2, 'NOx气罐', '3', 'material_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 17:17:34.729256', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (121, 1, '刷卡', '2', 'access_method', NULL, 'default', NULL, '0', 'admin', '2025-05-29 00:34:46.841076', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (122, 3, '人脸', '4', 'access_method', NULL, 'default', NULL, '0', 'admin', '2025-05-29 00:36:09.739235', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (120, 2, '指纹', '3', 'access_method', NULL, 'default', NULL, '0', 'admin', '2025-05-29 00:34:25.932947', 'admin', '2025-05-29 00:36:30.519377', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (123, 0, '密码', '1', 'access_method', NULL, 'default', NULL, '0', 'admin', '2025-05-29 00:36:45.177667', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (118, 3, 'PM10纸带', '4', 'material_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 17:21:32.981206', 'admin', '2025-05-30 09:06:37.789065', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (119, 4, 'PM2.5纸带', '5', 'material_type', NULL, 'default', NULL, '0', 'admin', '2025-05-27 17:21:42.278688', 'admin', '2025-05-30 09:06:47.010958', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (128, 1, '警告', '1', 'alarm_security', NULL, 'default', NULL, '0', 'admin', '2025-06-01 16:49:51.825062', 'admin', '2025-06-05 08:53:11.220561', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (129, 2, '严重', '2', 'alarm_security', NULL, 'default', NULL, '0', 'admin', '2025-06-01 16:50:01.135368', 'admin', '2025-06-05 08:53:14.557168', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (112, 3, '质控任务', 'QualityControl', 'sys_job_group', NULL, 'success', NULL, '0', 'admin', '2025-05-27 13:45:31.862539', 'admin', '2025-07-10 14:22:41.781235', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (130, 0, '待处理', '0', 'alarm_status', NULL, 'warning', NULL, '0', 'admin', '2025-06-01 16:53:32.011631', 'admin', '2025-06-25 18:25:51.737995', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (131, 1, '已解决', '1', 'alarm_status', NULL, 'success', NULL, '0', 'admin', '2025-06-01 16:53:46.069448', 'admin', '2025-06-25 18:25:56.146295', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (127, 0, '普通', '0', 'alarm_security', NULL, 'default', NULL, '0', 'admin', '2025-06-01 16:49:40.781906', 'admin', '2025-06-05 08:55:38.199511', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (124, 0, '设备间温度异常', '1', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-01 16:47:25.63594', 'admin', '2025-06-07 11:29:33.414797', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (125, 1, '设备间湿度异常', '2', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-01 16:47:40.071343', 'admin', '2025-06-07 11:30:20.771489', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (126, 2, '设备间漏水', '3', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-01 16:48:09.783602', 'admin', '2025-06-07 11:30:30.959278', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (134, 40, '供电电源异常波动', '4', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:30:48.569093', 'admin', '2025-06-07 11:30:54.740125', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (135, 50, '稳压电源异常波动', '5', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:31:08.473505', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (136, 60, '电流异常波动', '6', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:31:23.262158', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (137, 80, '标准气体泄漏', '8', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:31:55.655304', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (138, 90, '标准气体更换', '9', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:32:28.363251', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (139, 100, '颗粒物纸带更换', '10', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:32:43.828883', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (140, 110, '采样总管流速异常', '11', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:33:00.794534', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (141, 120, '采样总管温度异常', '12', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:33:15.723963', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (142, 130, '支管冷凝水预警', '13', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:33:29.600934', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (143, 140, '监测设备报警', '14', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:33:54.028317', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (144, 150, '断电和恢复报警', '15', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:34:06.98217', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (93, 3, '失败', '3', 'quality_control_execution_status', NULL, 'danger', NULL, '0', 'admin', '2025-05-26 15:18:16.734112', 'admin', '2025-06-20 00:18:13.169187', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (96, 3, 'CO', '4', 'quality_control_param', NULL, 'default', NULL, '0', 'admin', '2025-05-26 16:38:03.219959', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (97, 2, 'O3', '3', 'quality_control_param', NULL, 'default', NULL, '0', 'admin', '2025-05-26 16:38:19.342376', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (100, 1, '手动', '1', 'maintenance_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 17:28:38.228859', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (101, 0, '自动', '0', 'maintenance_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 17:28:48.27327', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (145, 160, '消防报警', '16', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:34:24.45256', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (146, 170, '异常进入报警', '17', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:34:38.948851', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (147, 180, '干扰报警', '18', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-07 11:34:51.69625', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (148, 190, '物资更新异常', '19', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-12 14:24:10.968335', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (149, 200, '设备通讯异常', '20', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-12 14:26:18.710301', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (150, 210, '总管冷凝水预警', '21', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-06-12 14:26:31.890252', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (151, 0, '浮点数类型', 'float', 'env_realdata_data_type', NULL, 'default', NULL, '0', 'admin', '2025-06-13 14:43:43.613567', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (152, 1, '字符串类型', 'string', 'env_realdata_data_type', NULL, 'default', NULL, '0', 'admin', '2025-06-13 14:44:02.735329', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (153, 3, '整数类型', 'int', 'env_realdata_data_type', NULL, 'default', NULL, '0', 'admin', '2025-06-13 14:44:15.62426', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (90, 0, '等待中', '0', 'quality_control_execution_status', NULL, 'default', NULL, '0', 'admin', '2025-05-26 15:16:05.047366', 'admin', '2025-06-20 00:17:46.209776', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (91, 1, '执行中', '1', 'quality_control_execution_status', NULL, 'primary', NULL, '0', 'admin', '2025-05-26 15:16:20.231195', 'admin', '2025-06-20 00:18:00.712607', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (154, 4, '采样管温度', '4', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-06-23 09:21:25.137794', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (155, 5, '开关设备2', '5', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-06-23 09:21:43.748065', 'admin', '2025-06-23 09:47:53.636442', '反向设备0开1关');
INSERT INTO "public"."sys_dict_data" VALUES (156, 11, '零气校准', '11', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:27:21.679843', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (157, 12, '通零气体', '12', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:27:32.265286', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (158, 13, '标气校准', '13', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:27:41.768674', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (159, 14, '通校准气体', '14', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:27:47.835636', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (160, 21, '测量', '21', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:27:54.396275', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (161, 22, '校准', '22', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:27:59.828512', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (162, 23, '诊断', '23', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:28:15.169491', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (163, 24, '恢复', '24', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:28:25.625021', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (164, 25, '热机', '25', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:28:35.14672', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (165, 0, '无状态', '-1', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-06-25 15:28:53.179515', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (166, 6, '零点控制', '6', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-06-30 11:33:51.92276', 'admin', '2025-06-30 11:42:01.829046', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (167, 10, '报警修改', '10', 'sys_oper_type', NULL, 'danger', NULL, '0', 'admin', '2025-07-08 10:29:16.257902', 'admin', '2025-07-08 10:29:54.187003', '报警信息设置');
INSERT INTO "public"."sys_dict_data" VALUES (168, 11, '设备控制', '11', 'sys_oper_type', NULL, 'danger', NULL, '0', 'admin', '2025-07-08 10:29:30.013134', 'admin', '2025-07-08 10:30:04.218294', '设备控制设置');
INSERT INTO "public"."sys_dict_data" VALUES (169, 3, '精密度检查', '3', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-07-08 18:50:58.55686', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (170, 4, '准确度校准', '4', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-07-08 18:51:12.308369', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (171, 5, '转换率检查', '5', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-07-08 18:51:23.711976', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (172, 6, '非标跨度检查', '6', 'quality_control_type', NULL, 'default', NULL, '0', 'admin', '2025-07-08 18:52:14.92281', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (173, 220, '门禁报警', '22', 'alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-07-09 20:13:31.058674', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (174, 2, '人工核查', 'ManualCheck', 'sys_job_group', NULL, 'success', NULL, '0', 'admin', '2025-07-10 14:16:30.473593', 'admin', '2025-07-10 14:22:26.717563', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (175, 6, '聚合数据', 'aggregationDataTask', 'sys_job_group', NULL, 'warning', NULL, '0', 'admin', '2025-08-20 15:44:11.313712', 'admin', '2025-08-20 16:13:07.164842', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (176, 7, '创建分表', 'CreatePartitionTablesTask', 'sys_job_group', NULL, 'warning', NULL, '0', 'admin', '2025-08-20 15:44:44.595713', 'admin', '2025-08-20 16:57:36.539949', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (177, 201, 'zkteco门禁设备', '201', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-08-21 14:17:31.822285', 'admin', '2025-08-21 14:17:40.182145', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (178, 301, '纵横通-空调设备', '301', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-08-21 14:22:32.62381', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (179, 100, '其他', '100', 'material_type', NULL, 'default', NULL, '0', 'admin', '2025-08-22 14:24:28.477577', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (201, 0, 'sms-空调设备', '0', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:06:45.194356', 'admin', '2025-10-17 15:19:07.531812', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (202, 1, 'sms-开关设备', '1', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-05-26 18:06:56.017125', 'admin', '2025-10-17 15:19:12.972497', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (203, 4, 'sms-采样管温度', '4', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-06-23 09:21:25.137794', 'admin', '2025-10-17 15:19:20.156347', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (204, 5, 'sms-开关设备2', '5', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-06-23 09:21:43.748065', 'admin', '2025-10-17 15:19:24.10574', '反向设备0开1关');
INSERT INTO "public"."sys_dict_data" VALUES (205, 6, 'sms-零点控制', '6', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-06-30 11:33:51.92276', 'admin', '2025-10-17 15:19:28.561715', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (206, 1000, '空调设备', '1000', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-10-17 15:19:54.394466', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (207, 1001, '开关设备', '1001', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-10-17 15:20:17.709423', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (208, 1002, '门禁设备', '1002', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-10-17 15:20:28.291668', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (209, 1003, '无状态开关', '1003', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-10-17 15:20:42.400752', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (210, 1004, '数值设备', '1004', 'env_device_manager_device_type', NULL, 'default', NULL, '0', 'admin', '2025-10-17 15:20:57.227037', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (211, 1000, '多参数阈值报警', '1000', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-10-20 17:46:09.815128', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (212, 1010, '超出范围报警', '1010', 'env_alarm_type', NULL, 'default', NULL, '0', 'admin', '2025-10-20 17:46:43.035593', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (213, 2, '一小时数据', 'hour', 'data_type', NULL, 'default', NULL, '0', 'admin', '2025-10-25 14:37:16.194211', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (214, 1, '五分钟数据', 'minute', 'data_type', NULL, 'default', NULL, '0', 'admin', '2025-02-18 11:45:24.89278', 'admin', '2025-10-25 14:37:22.977364', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (215, 0, '一分钟数据', '1minute', 'data_type', NULL, 'default', NULL, '0', 'admin', '2025-10-25 14:37:40.164877', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (216, 8, '数据推送', 'ExecuteSiChuanHj212RuleTask', 'sys_job_group', NULL, 'primary', NULL, '0', 'admin', '2025-10-28 16:44:02.920978', 'admin', '2025-10-28 16:44:12.409992', NULL);
INSERT INTO "public"."sys_dict_data" VALUES (221, 102, '传感器报警', '102', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:41:13.963538', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (222, 103, '统计数据不足', '103', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:41:24.008637', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (223, 104, '维护', '104', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:41:31.609241', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (224, 105, '运行不良', '105', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:41:38.208359', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (225, 106, '等待数据恢复', '106', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:41:45.459223', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (226, 107, '校准 (质控)', '107', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:41:53.359884', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (227, 108, '数据突变', '108', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:01.016819', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (228, 109, '数据不变', '109', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:07.228441', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (229, 110, '超上限', '110', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:15.187918', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (230, 111, '超下限', '111', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:21.319352', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (231, 112, '零点检查', '112', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:28.310478', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (232, 113, '跨度检查', '113', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:34.737025', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (233, 114, '准确度检查', '114', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:41.217036', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (234, 115, '零点校准', '115', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:48.379127', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (235, 116, '跨度校准', '116', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:42:54.847377', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (236, 117, '流量检查', '117', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:01.558612', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (237, 118, '质量检查', '118', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:12.637005', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (238, 119, '检定零点漂移', '119', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:21.788244', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (239, 120, '检定跨度漂移', '120', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:28.036696', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (240, 121, '检定跨度重现性', '121', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:34.129175', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (241, 122, '检定多点跨度(线性)', '122', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:42.137651', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (242, 123, '精密度检查', '123', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:42.137651', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (244, 9999, '其他状态', '9999', 'data_sign', NULL, 'default', NULL, '0', 'admin', '2025-11-07 16:43:53.947877', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (245, 3, '日数据', 'day', 'data_type', NULL, 'default', NULL, '0', 'admin', '2025-12-24 12:00:00.194211', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_data" VALUES (246, 5, '中止中', '4', 'quality_control_execution_status', NULL, 'warning', NULL, '0', 'admin', '2025-12-31 14:47:14.123191', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_type";
CREATE TABLE "public"."sys_dict_type" (
  "dict_id" int8 NOT NULL DEFAULT nextval('sys_dict_type_dict_id_seq'::regclass),
  "dict_name" varchar(100) COLLATE "pg_catalog"."default",
  "dict_type" varchar(100) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_dict_type"."dict_id" IS '字典主键';
COMMENT ON COLUMN "public"."sys_dict_type"."dict_name" IS '字典名称';
COMMENT ON COLUMN "public"."sys_dict_type"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."sys_dict_type"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dict_type"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dict_type"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict_type"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dict_type"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict_type"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_dict_type" IS '字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO "public"."sys_dict_type" VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '菜单状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '系统开关列表');
INSERT INTO "public"."sys_dict_type" VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '任务状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '任务分组列表');
INSERT INTO "public"."sys_dict_type" VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '系统是否列表');
INSERT INTO "public"."sys_dict_type" VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '通知类型列表');
INSERT INTO "public"."sys_dict_type" VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '通知状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '操作类型列表');
INSERT INTO "public"."sys_dict_type" VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-05-26 18:56:30', '', NULL, '登录状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-05-26 18:56:30', 'admin', '2021-05-27 10:07:12.015926', '用户性别列表');
INSERT INTO "public"."sys_dict_type" VALUES (11, '系统标识', 'sys_tid', '0', 'admin', '2025-02-14 11:28:03.162922', 'admin', '2025-02-14 11:29:08.143238', NULL);
INSERT INTO "public"."sys_dict_type" VALUES (12, '系统标识名称', 'sys_tid_name', '0', 'admin', '2025-02-14 11:29:26.583566', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (13, '站房数据类型', 'sys_data_type', '0', 'admin', '2025-02-14 11:30:34.583798', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (14, 'COM口', 'sys_device_com', '0', 'admin', '2025-02-14 13:30:42.575637', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (15, '设备协议', 'sys_device_pro', '0', 'admin', '2025-02-14 13:35:49.12917', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (16, '设备类型', 'sys_device_type', '0', 'admin', '2025-02-14 13:38:49.587065', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (19, '采集类型', 'thing_type', '0', 'admin', '2025-02-18 11:38:46.341722', NULL, NULL, '采集类型');
INSERT INTO "public"."sys_dict_type" VALUES (20, '数据类型', 'data_type', '0', 'admin', '2025-02-18 11:44:53.281228', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (21, '数据标识', 'data_sign', '0', 'admin', '2025-02-18 13:48:12.679261', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (22, '任务类型', 'task_type', '0', 'admin', '2025-02-24 13:51:03.928634', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (23, '上传任务状态', 'task_status', '0', 'admin', '2025-02-24 14:13:08.210154', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (17, '事件状态', 'event_status', '0', 'admin', '2025-02-18 10:37:44.954497', 'admin', '2025-05-12 11:44:06.497462', NULL);
INSERT INTO "public"."sys_dict_type" VALUES (18, '事件安全', 'event_security', '0', 'admin', '2025-02-18 10:38:34.201997', 'admin', '2025-05-12 11:44:11.46665', NULL);
INSERT INTO "public"."sys_dict_type" VALUES (24, '事件类型', 'event_type', '0', 'admin', '2025-05-12 11:44:52.952691', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (25, '报警状态', 'alarm_status', '0', 'admin', '2025-05-16 11:48:11.138956', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (26, '报警等级', 'alarm_security', '0', 'admin', '2025-05-16 11:48:30.598662', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (27, '报警类型', 'alarm_type', '0', 'admin', '2025-05-16 11:48:48.834328', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (28, '质控任务类型', 'quality_control_task_type', '0', 'admin', '2025-05-26 11:07:53.395891', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (29, '质控类型', 'quality_control_type', '0', 'admin', '2025-05-26 11:12:55.826363', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (30, '报警管理-报警类型', 'env_alarm_type', '0', 'admin', '2025-05-26 11:13:41.077072', 'admin', '2025-05-26 11:13:55.286256', NULL);
INSERT INTO "public"."sys_dict_type" VALUES (31, '质控执行状态', 'quality_control_execution_status', '0', 'admin', '2025-05-26 15:15:02.800829', 'admin', '2025-05-26 15:15:34.284175', NULL);
INSERT INTO "public"."sys_dict_type" VALUES (32, '质控参数', 'quality_control_param', '0', 'admin', '2025-05-26 16:36:54.362425', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (33, '维护类型', 'maintenance_type', '0', 'admin', '2025-05-26 17:28:20.419693', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (34, '设备控制类型', 'env_device_manager_device_type', '0', 'admin', '2025-05-26 17:54:36.201053', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (35, '维护模式', 'maintenance_mode', '0', 'admin', '2025-05-26 18:12:44.276977', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (36, '巡检类型', 'patrol_type', '0', 'admin', '2025-05-27 00:54:03.223609', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (37, '物资类型', 'material_type', '0', 'admin', '2025-05-27 17:08:48.146628', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (38, '打卡方式', 'access_method', '0', 'admin', '2025-05-29 00:33:03.268122', NULL, NULL, NULL);
INSERT INTO "public"."sys_dict_type" VALUES (39, '原始数据类型', 'env_realdata_data_type', '0', 'admin', '2025-06-13 14:42:57.287575', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_job";
CREATE TABLE "public"."sys_job" (
  "job_id" int8 NOT NULL DEFAULT nextval('sys_job_job_id_seq'::regclass),
  "job_name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "job_group" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "invoke_target" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "cron_expression" varchar(255) COLLATE "pg_catalog"."default",
  "misfire_policy" varchar(20) COLLATE "pg_catalog"."default",
  "concurrent" char(1) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_job"."job_id" IS '任务ID';
COMMENT ON COLUMN "public"."sys_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."sys_job"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."sys_job"."invoke_target" IS '调用目标字符串';
COMMENT ON COLUMN "public"."sys_job"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "public"."sys_job"."misfire_policy" IS '计划执行错误策略（1立即执行 2执行一次 3放弃执行）';
COMMENT ON COLUMN "public"."sys_job"."concurrent" IS '是否并发执行（0允许 1禁止）';
COMMENT ON COLUMN "public"."sys_job"."status" IS '状态（0正常 1暂停）';
COMMENT ON COLUMN "public"."sys_job"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_job"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_job"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_job"."remark" IS '备注信息';
COMMENT ON TABLE "public"."sys_job" IS '定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO "public"."sys_job" (
    job_id, job_name, job_group, invoke_target, cron_expression, 
    misfire_policy, concurrent, status, create_by, create_time, 
    update_by, update_time, remark
) VALUES 
(11, '实时表分表', 'CreatePartitionTablesTask', 'CreatePartitionTablesTask.run(''realdata'',-2,2)', '0 0 0 * * ?', 1, 1, 0, 'admin', '2025/9/18 10:30', NULL, '2025/9/18 10:31', NULL),
(12, '历史表分表', 'CreatePartitionTablesTask', 'CreatePartitionTablesTask.run(''his_data'',-2,2)', '0 0 0 * * ?', 1, 1, 0, 'admin', '2025/9/18 10:30', NULL, '2025/9/18 10:31', NULL),
(13, '维护换膜', 'Maintenance', 'maintenanceTask.run(''no2_filter'')', '0 0 9 ? * 3', 1, 1, 1, 'admin', '2025/9/18 10:19', NULL, '2025/9/18 10:26', NULL),
(14, '每日子站巡检', 'Patrol', 'patrolTask.run(''substation_patrol'')', '0 10 0 * * ?', 1, 1, 0, 'admin', '2025/9/18 10:17', NULL, '2025/9/18 10:31', NULL),
(15, '质控报告定时自动生成', 'DEFAULT', 'qualityControlGenReportTask.run('''','''')', '0 0 1 * * ?', 1, 1, 0, 'admin', '2025/9/18 10:17', NULL, '2025/9/18 10:31', NULL),
(16, '一分钟数据聚合', 'aggregationDataTask', 'aggregationDataTask.run(''1minute'', '''', '''', false, 1, ''*'', ''*'')', '0 0/1 * * * ?', '3', '1', '0', 'admin', '2025-10-20 15:00:00', 'admin', '2025-10-25 15:00:00', NULL),
(17, '五分钟数据聚合', 'aggregationDataTask', 'aggregationDataTask.run(''minute'', '''', '''', false, 5, ''*'', ''*'')', '0 0/5 * * * ?', '3', '1', '0', 'admin', '2025-09-18 15:00:00', 'admin', '2025-10-25 15:00:54', NULL),
(18, '小时数据聚合', 'aggregationDataTask', 'aggregationDataTask.run(''hour'', '''', '''', false, 60, ''*'', ''*'')', '0 0 * * * ?', '3', '1', '0', 'admin', '2025-10-17 15:00:00', 'admin', '2025-10-25 15:00:00', NULL),
(19, '日数据聚合', 'aggregationDataTask', 'aggregationDataTask.run(''day'', '''', '''', false, 1440, ''*'', ''*'')', '20 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-17 15:00:00', 'admin', '2025-12-20 15:00:00', NULL),
(21, '零点检查-SO2', 'QualityControl', 'qualityControlTask.run(''SO2'',''zero_check'',''0'')', '0 0 0 * * ?', '1', '1', '1', 'admin', '2025-12-05 14:33:16', 'admin', '2025-12-05 14:33:16', NULL),
(22, '零点核查-NO2', 'QualityControl', 'qualityControlTask.run(''NO2'',''zero_check'',''0'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:55:14.844781', 'admin', '2025-12-05 10:57:11', NULL),
(23, '零点核查-O3', 'QualityControl', 'qualityControlTask.run(''O3'',''zero_check'',''0'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:46:13.236297', 'admin', '2025-12-05 10:57:39', NULL),
(24, '零点核查-CO', 'QualityControl', 'qualityControlTask.run(''CO'',''zero_check'',''0'')', '0 0 0 * * ?', '1', '1', '1', 'admin', '2025-12-05 10:54:45.252143', 'admin', '2025-12-05 14:30:25', NULL),
(25, '跨度核查-NO2', 'QualityControl', 'qualityControlTask.run(''NO2'',''span_check'',''0.4'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-03 17:10:59.987549', 'admin', '2025-12-05 11:20:24', NULL),
(26, '跨度核查-CO', 'QualityControl', 'qualityControlTask.run(''CO'',''span_check'',''40'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-03 17:10:37.283367', 'admin', '2025-12-05 11:20:40', NULL),
(27, '跨度核查-SO2', 'QualityControl', 'qualityControlTask.run(''SO2'',''span_check'',''0.4'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-03 17:09:48.549555', 'admin', '2025-12-05 11:20:51', NULL),
(28, '跨度核查-O3', 'QualityControl', 'qualityControlTask.run(''O3'',''span_check'',''0.4'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-03 14:56:45.13104', 'admin', '2025-12-05 11:21:03', NULL),
(29, '线性核查-SO2', 'QualityControl', 'qualityControlTask.run(''SO2'',''multi_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:55:52.856741', 'admin', '2025-12-05 10:56:29', NULL),
(30, '线性核查-NO2', 'QualityControl', 'qualityControlTask.run(''NO2'',''multi_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:02:59', 'admin', '2025-12-05 11:02:59', NULL),
(31, '线性核查-O3', 'QualityControl', 'qualityControlTask.run(''O3'',''multi_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:01:39', 'admin', '2025-12-05 11:01:39', NULL),
(32, '线性核查-CO', 'QualityControl', 'qualityControlTask.run(''CO'',''multi_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:02:10', 'admin', '2025-12-05 11:02:10', NULL),
(33, '精密度核查-NO2', 'QualityControl', 'qualityControlTask.run(''NO2'',''precision_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:42:07', 'admin', '2025-12-05 10:58:02', NULL),
(34, '精密度核查-CO', 'QualityControl', 'qualityControlTask.run(''CO'',''precision_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:41:23', 'admin', '2025-12-05 10:58:11', NULL),
(35, '精密度核查-O3', 'QualityControl', 'qualityControlTask.run(''O3'',''precision_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:40:52', 'admin', '2025-12-05 10:58:21', NULL),
(36, '精密度核查-SO2', 'QualityControl', 'qualityControlTask.run(''SO2'',''precision_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 10:40:06', 'admin', '2025-12-05 10:58:30', NULL),
(37, '准确度审核-SO2 ', 'QualityControl', 'qualityControlTask.run(''SO2'',''accuracy_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:11:51', 'admin', '2025-12-05 11:11:51', NULL),
(38, '准确度审核-O3', 'QualityControl', 'qualityControlTask.run(''O3'',''accuracy_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:12:20', 'admin', '2025-12-05 11:12:20', NULL),
(39, '准确度审核-CO', 'QualityControl', 'qualityControlTask.run(''CO'',''accuracy_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:12:55', 'admin', '2025-12-05 11:12:55', NULL),
(40, '准确度审核-NO2', 'QualityControl', 'qualityControlTask.run(''NO2'',''accuracy_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:13:29', 'admin', '2025-12-05 11:13:29', NULL),
(41, '转换效率检查-NOx', 'QualityControl', 'qualityControlTask.run(''NO2'',''conversion_check'',''1'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-12-05 11:16:27', 'admin', '2025-12-05 13:11:46', NULL),
(42, '人工核查-NO2', 'ManualCheck', 'qualityControlCustomTask.run(''NO2'', ''180'', ''3'', ''20'', ''0.400'', ''跨度检查'')', '0 0 4 * * ?', '3', '1', '1', 'admin', '2025-11-26 11:53:00', 'admin', '2025-12-05 11:21:24', NULL),
(43, '人工核查-CO', 'ManualCheck', 'qualityControlCustomTask.run(''CO'', ''180'', ''3'', ''20'', ''40.000'', ''跨度检查'')', '0 0 1 * * ?', '3', '1', '1', 'admin', '2025-11-26 11:40:45', 'admin', '2025-12-05 11:21:34', NULL),
(44, '人工核查-O3', 'ManualCheck', 'qualityControlCustomTask.run(''O3'', ''180'', ''3'', ''20'', ''0.400'', ''跨度检查'')', '0 0 2 * * ?', '3', '1', '1', 'admin', '2025-11-25 16:37:44', 'admin', '2025-12-05 11:21:44', NULL),
(45, '人工核查-SO2', 'ManualCheck', 'qualityControlCustomTask.run(''SO2'', ''180'', ''1'', ''10'', ''0.400'', ''跨度检查'')', '0 0 0 * * ?', '3', '1', '1', 'admin', '2025-11-25 16:34:55', 'admin', '2025-12-05 11:21:54', NULL);

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_job_log";
CREATE TABLE "public"."sys_job_log" (
  "job_log_id" int8 NOT NULL DEFAULT nextval('sys_job_log_job_log_id_seq'::regclass),
  "job_name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "job_group" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "invoke_target" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "job_message" varchar(500) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "exception_info" varchar(2000) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_job_log"."job_log_id" IS '任务日志ID';
COMMENT ON COLUMN "public"."sys_job_log"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."sys_job_log"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."sys_job_log"."invoke_target" IS '调用目标字符串';
COMMENT ON COLUMN "public"."sys_job_log"."job_message" IS '日志信息';
COMMENT ON COLUMN "public"."sys_job_log"."status" IS '执行状态（0正常 1失败）';
COMMENT ON COLUMN "public"."sys_job_log"."exception_info" IS '异常信息';
COMMENT ON COLUMN "public"."sys_job_log"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_job_log" IS '定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_logininfor";
CREATE TABLE "public"."sys_logininfor" (
  "info_id" int8 NOT NULL DEFAULT nextval('sys_logininfor_info_id_seq'::regclass),
  "user_name" varchar(50) COLLATE "pg_catalog"."default",
  "ipaddr" varchar(128) COLLATE "pg_catalog"."default",
  "login_location" varchar(255) COLLATE "pg_catalog"."default",
  "browser" varchar(50) COLLATE "pg_catalog"."default",
  "os" varchar(50) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "msg" varchar(255) COLLATE "pg_catalog"."default",
  "login_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_logininfor"."info_id" IS '访问ID';
COMMENT ON COLUMN "public"."sys_logininfor"."user_name" IS '用户账号';
COMMENT ON COLUMN "public"."sys_logininfor"."ipaddr" IS '登录IP地址';
COMMENT ON COLUMN "public"."sys_logininfor"."login_location" IS '登录地点';
COMMENT ON COLUMN "public"."sys_logininfor"."browser" IS '浏览器类型';
COMMENT ON COLUMN "public"."sys_logininfor"."os" IS '操作系统';
COMMENT ON COLUMN "public"."sys_logininfor"."status" IS '登录状态（0成功 1失败）';
COMMENT ON COLUMN "public"."sys_logininfor"."msg" IS '提示消息';
COMMENT ON COLUMN "public"."sys_logininfor"."login_time" IS '访问时间';
COMMENT ON TABLE "public"."sys_logininfor" IS '系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_menu";
CREATE TABLE "public"."sys_menu" (
  "menu_id" int8 NOT NULL DEFAULT nextval('sys_menu_menu_id_seq'::regclass),
  "menu_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" int8 DEFAULT 0,
  "order_num" int4,
  "path" varchar(200) COLLATE "pg_catalog"."default",
  "component" varchar(255) COLLATE "pg_catalog"."default",
  "query" varchar(255) COLLATE "pg_catalog"."default",
  "route_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_frame" int4,
  "is_cache" int4 DEFAULT 0,
  "menu_type" char(1) COLLATE "pg_catalog"."default",
  "visible" char(1) COLLATE "pg_catalog"."default",
  "status" int2,
  "perms" varchar(100) COLLATE "pg_catalog"."default",
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "public"."sys_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_menu"."path" IS '路由地址';
COMMENT ON COLUMN "public"."sys_menu"."component" IS '组件路径';
COMMENT ON COLUMN "public"."sys_menu"."query" IS '路由参数';
COMMENT ON COLUMN "public"."sys_menu"."route_name" IS '路由名称';
COMMENT ON COLUMN "public"."sys_menu"."is_frame" IS '是否为外链（0是 1否）';
COMMENT ON COLUMN "public"."sys_menu"."is_cache" IS '是否缓存（0缓存 1不缓存）';
COMMENT ON COLUMN "public"."sys_menu"."menu_type" IS '菜单类型（M目录 C菜单 F按钮）';
COMMENT ON COLUMN "public"."sys_menu"."visible" IS '菜单状态（0显示 1隐藏）';
COMMENT ON COLUMN "public"."sys_menu"."status" IS '菜单状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_menu"."perms" IS '权限标识';
COMMENT ON COLUMN "public"."sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."sys_menu"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_menu"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_menu"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_menu" IS '菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO "public"."sys_menu" VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', 0, '', 'system', 'admin', '2025-02-14 02:51:53.524904', '', NULL, '系统管理目录');
INSERT INTO "public"."sys_menu" VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', 0, '', 'monitor', 'admin', '2025-02-14 02:51:53.564887', '', NULL, '系统监控目录');
INSERT INTO "public"."sys_menu" VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', 0, '', 'tool', 'admin', '2025-02-14 02:51:53.605457', '', NULL, '系统工具目录');
INSERT INTO "public"."sys_menu" VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', 0, 'system:user:list', 'user', 'admin', '2025-02-14 02:51:53.684767', '', NULL, '用户管理菜单');
INSERT INTO "public"."sys_menu" VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', 0, 'system:role:list', 'peoples', 'admin', '2025-02-14 02:51:53.725169', '', NULL, '角色管理菜单');
INSERT INTO "public"."sys_menu" VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', 0, 'system:menu:list', 'tree-table', 'admin', '2025-02-14 02:51:53.764913', '', NULL, '菜单管理菜单');
INSERT INTO "public"."sys_menu" VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', 0, 'system:dept:list', 'tree', 'admin', '2025-02-14 02:51:53.804968', '', NULL, '部门管理菜单');
INSERT INTO "public"."sys_menu" VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', 0, 'system:post:list', 'post', 'admin', '2025-02-14 02:51:53.844733', '', NULL, '岗位管理菜单');
INSERT INTO "public"."sys_menu" VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', 0, 'system:dict:list', 'dict', 'admin', '2025-02-14 02:51:53.884929', '', NULL, '字典管理菜单');
INSERT INTO "public"."sys_menu" VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', 0, 'system:config:list', 'edit', 'admin', '2025-02-14 02:51:53.924742', '', NULL, '参数设置菜单');
INSERT INTO "public"."sys_menu" VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', 0, 'system:notice:list', 'message', 'admin', '2025-02-14 02:51:53.964899', '', NULL, '通知公告菜单');
INSERT INTO "public"."sys_menu" VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', 0, '', 'log', 'admin', '2025-02-14 02:51:54.004842', '', NULL, '日志管理菜单');
INSERT INTO "public"."sys_menu" VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', 0, 'monitor:online:list', 'online', 'admin', '2025-02-14 02:51:54.045083', '', NULL, '在线用户菜单');
INSERT INTO "public"."sys_menu" VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', 0, 'monitor:druid:list', 'druid', 'admin', '2025-02-14 02:51:54.124893', '', NULL, '数据监控菜单');
INSERT INTO "public"."sys_menu" VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', 0, 'monitor:server:list', 'server', 'admin', '2025-02-14 02:51:54.164947', '', NULL, '服务监控菜单');
INSERT INTO "public"."sys_menu" VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', 0, 'monitor:cache:list', 'redis', 'admin', '2025-02-14 02:51:54.204911', '', NULL, '缓存监控菜单');
INSERT INTO "public"."sys_menu" VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', 0, 'monitor:cache:list', 'redis-list', 'admin', '2025-02-14 02:51:54.244865', '', NULL, '缓存列表菜单');
INSERT INTO "public"."sys_menu" VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', 0, 'tool:build:list', 'build', 'admin', '2025-02-14 02:51:54.284917', '', NULL, '表单构建菜单');
INSERT INTO "public"."sys_menu" VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', 0, 'tool:gen:list', 'code', 'admin', '2025-02-14 02:51:54.324914', '', NULL, '代码生成菜单');
INSERT INTO "public"."sys_menu" VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', 0, 'tool:swagger:list', 'swagger', 'admin', '2025-02-14 02:51:54.365003', '', NULL, '系统接口菜单');
INSERT INTO "public"."sys_menu" VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', 0, 'monitor:logininfor:list', 'logininfor', 'admin', '2025-02-14 02:51:54.444661', '', NULL, '登录日志菜单');
INSERT INTO "public"."sys_menu" VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:query', '#', 'admin', '2025-02-14 02:51:54.485146', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:add', '#', 'admin', '2025-02-14 02:51:54.524926', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:edit', '#', 'admin', '2025-02-14 02:51:54.564866', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:remove', '#', 'admin', '2025-02-14 02:51:54.604834', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:export', '#', 'admin', '2025-02-14 02:51:54.645563', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:import', '#', 'admin', '2025-02-14 02:51:54.684938', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', 0, 'system:user:resetPwd', '#', 'admin', '2025-02-14 02:51:54.724966', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', 0, 'system:role:query', '#', 'admin', '2025-02-14 02:51:54.744818', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', 0, 'system:role:add', '#', 'admin', '2025-02-14 02:51:54.764731', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', 0, 'system:role:edit', '#', 'admin', '2025-02-14 02:51:54.804704', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', 0, 'system:role:remove', '#', 'admin', '2025-02-14 02:51:54.824673', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', 0, 'system:role:export', '#', 'admin', '2025-02-14 02:51:54.865002', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', 0, 'system:menu:query', '#', 'admin', '2025-02-14 02:51:54.904626', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', 0, 'system:menu:add', '#', 'admin', '2025-02-14 02:51:54.944896', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', 0, 'system:menu:edit', '#', 'admin', '2025-02-14 02:51:54.984865', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', 0, 'system:menu:remove', '#', 'admin', '2025-02-14 02:51:55.024884', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', 0, 'system:dept:query', '#', 'admin', '2025-02-14 02:51:55.064788', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', 0, 'system:dept:add', '#', 'admin', '2025-02-14 02:51:55.104913', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', 0, 'system:dept:edit', '#', 'admin', '2025-02-14 02:51:55.146693', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', 0, 'system:dept:remove', '#', 'admin', '2025-02-14 02:51:55.184842', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', 0, 'system:post:query', '#', 'admin', '2025-02-14 02:51:55.224649', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', 0, 'system:post:add', '#', 'admin', '2025-02-14 02:51:55.264918', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', 0, 'system:post:edit', '#', 'admin', '2025-02-14 02:51:55.30683', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', 0, 'system:post:remove', '#', 'admin', '2025-02-14 02:51:55.344995', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', 0, 'system:post:export', '#', 'admin', '2025-02-14 02:51:55.38491', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:dict:query', '#', 'admin', '2025-02-14 02:51:55.424858', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:dict:add', '#', 'admin', '2025-02-14 02:51:55.464848', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:dict:edit', '#', 'admin', '2025-02-14 02:51:55.504884', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:dict:remove', '#', 'admin', '2025-02-14 02:51:55.544838', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:dict:export', '#', 'admin', '2025-02-14 02:51:55.584884', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:config:query', '#', 'admin', '2025-02-14 02:51:55.624728', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:config:add', '#', 'admin', '2025-02-14 02:51:55.664801', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:config:edit', '#', 'admin', '2025-02-14 02:51:55.704846', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:config:remove', '#', 'admin', '2025-02-14 02:51:55.744877', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:config:export', '#', 'admin', '2025-02-14 02:51:55.784832', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:notice:query', '#', 'admin', '2025-02-14 02:51:55.824863', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:notice:add', '#', 'admin', '2025-02-14 02:51:55.864648', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:notice:edit', '#', 'admin', '2025-02-14 02:51:55.904953', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', 0, 'system:notice:remove', '#', 'admin', '2025-02-14 02:51:55.944873', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:operlog:query', '#', 'admin', '2025-02-14 02:51:55.984883', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:operlog:remove', '#', 'admin', '2025-02-14 02:51:56.024872', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:operlog:export', '#', 'admin', '2025-02-14 02:51:56.064878', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:logininfor:query', '#', 'admin', '2025-02-14 02:51:56.104939', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:logininfor:remove', '#', 'admin', '2025-02-14 02:51:56.144879', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:logininfor:export', '#', 'admin', '2025-02-14 02:51:56.184868', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:logininfor:unlock', '#', 'admin', '2025-02-14 02:51:56.224894', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:online:query', '#', 'admin', '2025-02-14 02:51:56.264886', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:online:batchLogout', '#', 'admin', '2025-02-14 02:51:56.304858', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:online:forceLogout', '#', 'admin', '2025-02-14 02:51:56.344666', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:job:query', '#', 'admin', '2025-02-14 02:51:56.38487', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:job:add', '#', 'admin', '2025-02-14 02:51:56.424837', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:job:edit', '#', 'admin', '2025-02-14 02:51:56.464885', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:job:remove', '#', 'admin', '2025-02-14 02:51:56.504945', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:job:changeStatus', '#', 'admin', '2025-02-14 02:51:56.544612', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', 0, 'monitor:job:export', '#', 'admin', '2025-02-14 02:51:56.584876', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', 0, 'tool:gen:query', '#', 'admin', '2025-02-14 02:51:56.627857', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', 0, 'tool:gen:edit', '#', 'admin', '2025-02-14 02:51:56.664794', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', 0, 'tool:gen:remove', '#', 'admin', '2025-02-14 02:51:56.704888', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', 0, 'tool:gen:import', '#', 'admin', '2025-02-14 02:51:56.744963', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', 0, 'tool:gen:preview', '#', 'admin', '2025-02-14 02:51:56.785135', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', 0, 'tool:gen:code', '#', 'admin', '2025-02-14 02:51:56.824824', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2002, '设备管理', 2001, 1, 'staInfo', 'station/staInfo/index', NULL, '', 1, 0, 'C', '0', 0, 'station:staInfo:list', '#', 'admin', '2025-02-14 05:44:24.255505', '', NULL, '站点管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2003, '设备参数管理', 2001, 1, 'paraInfo', 'station/paraInfo/index', NULL, '', 1, 0, 'C', '0', 0, 'station:paraInfo:list', '#', 'admin', '2025-02-14 07:53:54.23964', '', NULL, '设备参数管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2004, '事件报警', 2000, 0, 'events', 'station/events/index', NULL, '', 1, 0, 'C', '0', 0, 'station:events:list', 'button', 'admin', '2025-02-18 09:23:54.162942', 'admin', '2025-02-18 09:27:53.83108', NULL);
INSERT INTO "public"."sys_menu" VALUES (2006, '单点多参查询', 2000, 1, 'oMdata', 'station/oMdata/index', NULL, '', 1, 0, 'C', '0', 0, 'station:oMdata:list', 'clipboard', 'admin', '2025-02-19 10:38:16.598847', 'admin', '2025-02-19 10:43:03.44635', NULL);
INSERT INTO "public"."sys_menu" VALUES (2007, '多点单参数据查询', 2000, 3, 'mOdata', 'station/mOdata/index', NULL, '', 1, 0, 'C', '0', 0, 'station:mOdata:list', 'cascader', 'admin', '2025-02-19 10:52:04.138498', NULL, NULL, NULL);
INSERT INTO "public"."sys_menu" VALUES (2008, '数据导入导出', 2000, 5, 'task', 'station/tasks/index', NULL, '', 1, 0, 'C', '0', 0, 'task:tasks:list', 'clipboard', 'admin', '2025-02-24 16:03:36.196166', 'admin', '2025-03-05 14:20:17.375332', NULL);
INSERT INTO "public"."sys_menu" VALUES (2005, '数据查询', 2000, 1, 'data', 'station/data/index', NULL, '', 1, 0, 'C', '1', 0, 'station:data:list', 'cascader', 'admin', '2025-02-18 14:40:09.07481', 'admin', '2025-03-07 14:42:44.712388', NULL);
INSERT INTO "public"."sys_menu" VALUES (2001, '设备管理', 0, 0, 'device', NULL, NULL, '', 1, 0, 'M', '1', 0, NULL, 'international', 'admin', '2025-02-14 13:34:22.73074', 'admin', '2025-05-22 09:27:36.191998', NULL);
INSERT INTO "public"."sys_menu" VALUES (2000, '数据管理', 0, 0, 'data', NULL, NULL, '', 1, 0, 'M', '1', 0, NULL, 'list', 'admin', '2025-02-14 11:43:24.468634', 'admin', '2025-05-22 09:27:41.479378', NULL);
INSERT INTO "public"."sys_menu" VALUES (2029, '任务查询', 2008, 1, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'task:tasks:query', '#', 'admin', '2025-03-10 09:32:01.776105', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2030, '任务新增', 2008, 2, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'task:tasks:add', '#', 'admin', '2025-03-10 09:32:01.808538', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2031, '任务修改', 2008, 3, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'task:tasks:edit', '#', 'admin', '2025-03-10 09:32:01.839387', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2032, '任务删除', 2008, 4, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'task:tasks:remove', '#', 'admin', '2025-03-10 09:32:01.858534', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2033, '任务导出', 2008, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'task:tasks:export', '#', 'admin', '2025-03-10 09:32:01.88911', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2034, '站点查询', 2002, 1, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:staInfo:query', '#', 'admin', '2025-03-10 09:32:01.908674', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2035, '站点新增', 2002, 2, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:staInfo:add', '#', 'admin', '2025-03-10 09:32:01.928123', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2036, '站点修改', 2002, 3, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:staInfo:edit', '#', 'admin', '2025-03-10 09:32:01.959117', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2037, '站点删除', 2002, 4, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:staInfo:remove', '#', 'admin', '2025-03-10 09:32:01.989084', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2038, '站点导出', 2002, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:staInfo:export', '#', 'admin', '2025-03-10 09:32:02.008488', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2039, '设备参数查询', 2003, 1, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:paraInfo:query', '#', 'admin', '2025-03-10 09:32:02.02963', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2040, '设备参数新增', 2003, 2, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:paraInfo:add', '#', 'admin', '2025-03-10 09:32:02.052896', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2041, '设备参数修改', 2003, 3, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:paraInfo:edit', '#', 'admin', '2025-03-10 09:32:02.070851', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2042, '设备参数删除', 2003, 4, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:paraInfo:remove', '#', 'admin', '2025-03-10 09:32:02.089934', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2043, '设备参数导出', 2003, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:paraInfo:export', '#', 'admin', '2025-03-10 09:32:02.109927', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2051, '导出', 2006, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, '	station:oMdata:export', '#', 'admin', '2025-03-10 09:32:02.109927', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2052, '导出', 2007, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, '	station:mOdata:export', '#', 'admin', '2025-03-10 09:32:02.109927', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2053, 'history查询', 2005, 1, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:data:query', '#', 'admin', '2025-03-10 17:06:59.848621', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2054, 'history新增', 2005, 2, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:data:add', '#', 'admin', '2025-03-10 17:06:59.869611', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2055, 'history修改', 2005, 3, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:data:edit', '#', 'admin', '2025-03-10 17:06:59.898378', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2056, 'history删除', 2005, 4, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:data:remove', '#', 'admin', '2025-03-10 17:06:59.919112', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2057, 'history导出', 2005, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:data:export', '#', 'admin', '2025-03-10 17:06:59.948616', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2044, '事件查询', 2004, 1, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:events:query', '#', 'admin', '2025-03-10 09:32:02.128169', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2045, '事件新增', 2004, 2, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:events:add', '#', 'admin', '2025-03-10 09:32:02.151635', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2046, '事件修改', 2004, 3, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:events:edit', '#', 'admin', '2025-03-10 09:32:02.16813', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2047, '事件删除', 2004, 4, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:events:remove', '#', 'admin', '2025-03-10 09:32:02.188126', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2048, '事件导出', 2004, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'station:events:export', '#', 'admin', '2025-03-10 09:32:02.218151', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2064, '质控记录', 2000, 1, 'env_quality_control_record', 'quality_control/env_quality_control_record/index', NULL, '', 1, 0, 'C', '0', 0, 'quality_control:env_quality_control_record:list', '#', 'admin', '2025-05-25 19:30:47.109974', '', NULL, '质控记录菜单');
INSERT INTO "public"."sys_menu" VALUES (2065, '质控记录查询', 2064, 1, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'quality_control:env_quality_control_record:query', '#', 'admin', '2025-05-25 19:32:03.266479', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2066, '质控记录新增', 2064, 2, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'quality_control:env_quality_control_record:add', '#', 'admin', '2025-05-25 19:32:03.283488', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2067, '质控记录修改', 2064, 3, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'quality_control:env_quality_control_record:edit', '#', 'admin', '2025-05-25 19:32:03.396714', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2068, '质控记录删除', 2064, 4, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'quality_control:env_quality_control_record:remove', '#', 'admin', '2025-05-25 19:32:03.413222', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2069, '质控记录导出', 2064, 5, '#', '', NULL, '', 1, 0, 'F', '0', 0, 'quality_control:env_quality_control_record:export', '#', 'admin', '2025-05-25 19:32:03.499236', '', NULL, '');
INSERT INTO "public"."sys_menu" VALUES (110, '任务管理', 2072, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', 0, 'monitor:job:list', 'job', 'admin', '2025-02-14 02:51:54.084977', 'admin', '2025-05-27 13:41:22.357679', '定时任务菜单');
INSERT INTO "public"."sys_menu" VALUES (2072, '任务管理', 0, 10, 'taskjob', NULL, NULL, '', 1, 0, 'M', '0', 0, NULL, 'job', 'admin', '2025-05-27 13:40:08.94874', 'admin', '2025-05-27 13:41:59.028487', NULL);
INSERT INTO "public"."sys_menu" VALUES (2073, '日志管理', 0, 11, 'log', NULL, NULL, '', 1, 0, 'M', '0', 0, NULL, 'log', 'admin', '2025-05-28 15:59:23.086081', 'admin', '2025-05-28 15:59:33.295241', NULL);
INSERT INTO "public"."sys_menu" VALUES (500, '操作日志', 2073, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', 0, 'monitor:operlog:list', 'form', 'admin', '2025-02-14 02:51:54.404905', 'admin', '2025-05-28 15:59:49.364251', '操作日志菜单');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_notice";
CREATE TABLE "public"."sys_notice" (
  "notice_id" int8 NOT NULL DEFAULT nextval('sys_notice_notice_id_seq'::regclass),
  "notice_title" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_type" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_content" text COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_notice"."notice_id" IS '公告ID';
COMMENT ON COLUMN "public"."sys_notice"."notice_title" IS '公告标题';
COMMENT ON COLUMN "public"."sys_notice"."notice_type" IS '公告类型（1通知 2公告）';
COMMENT ON COLUMN "public"."sys_notice"."notice_content" IS '公告内容';
COMMENT ON COLUMN "public"."sys_notice"."status" IS '公告状态（0正常 1关闭）';
COMMENT ON COLUMN "public"."sys_notice"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_notice"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_notice"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_notice"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_notice"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_notice" IS '通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO "public"."sys_notice" VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', '\xe7bbb4e68aa4e58685e5aeb9', '0', 'admin', '2021-05-26 18:56:31', '', NULL, '管理员');
INSERT INTO "public"."sys_notice" VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', '\', '0', 'admin', '2021-05-26 18:56:31', 'admin', '2021-05-27 09:08:41.403262', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_oper_log";
CREATE TABLE "public"."sys_oper_log" (
  "oper_id" int8 NOT NULL DEFAULT nextval('sys_oper_log_oper_id_seq'::regclass),
  "title" varchar(50) COLLATE "pg_catalog"."default",
  "business_type" int4,
  "method" varchar(255) COLLATE "pg_catalog"."default",
  "request_method" varchar(10) COLLATE "pg_catalog"."default",
  "operator_type" int4,
  "oper_name" varchar(50) COLLATE "pg_catalog"."default",
  "dept_name" varchar(50) COLLATE "pg_catalog"."default",
  "oper_url" varchar(255) COLLATE "pg_catalog"."default",
  "oper_ip" varchar(128) COLLATE "pg_catalog"."default",
  "oper_location" varchar(255) COLLATE "pg_catalog"."default",
  "oper_param" varchar(2000) COLLATE "pg_catalog"."default",
  "json_result" varchar(2000) COLLATE "pg_catalog"."default",
  "status" int4,
  "error_msg" varchar(2000) COLLATE "pg_catalog"."default",
  "oper_time" timestamp(6),
  "cost_time" int8 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."sys_oper_log"."oper_id" IS '日志主键';
COMMENT ON COLUMN "public"."sys_oper_log"."title" IS '模块标题';
COMMENT ON COLUMN "public"."sys_oper_log"."business_type" IS '业务类型（0其它 1新增 2修改 3删除）';
COMMENT ON COLUMN "public"."sys_oper_log"."method" IS '方法名称';
COMMENT ON COLUMN "public"."sys_oper_log"."request_method" IS '请求方式';
COMMENT ON COLUMN "public"."sys_oper_log"."operator_type" IS '操作类别（0其它 1后台用户 2手机端用户）';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_name" IS '操作人员';
COMMENT ON COLUMN "public"."sys_oper_log"."dept_name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_url" IS '请求URL';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_ip" IS '主机地址';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_location" IS '操作地点';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_param" IS '请求参数';
COMMENT ON COLUMN "public"."sys_oper_log"."json_result" IS '返回参数';
COMMENT ON COLUMN "public"."sys_oper_log"."status" IS '操作状态（0正常 1异常）';
COMMENT ON COLUMN "public"."sys_oper_log"."error_msg" IS '错误消息';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_time" IS '操作时间';
COMMENT ON TABLE "public"."sys_oper_log" IS '操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO "public"."sys_oper_log" VALUES (3142, '任务管理', 3, 'com.ruoyi.quartz.controller.SysJobController.remove()', 'DELETE', 1, 'admin', '研发部门', '/monitor/job/47,46,45,43,42,41,40,39,38,37', '127.0.0.1', '内网IP', '[47,46,45,43,42,41,40,39,38,37]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-18 10:38:06.750137', 529);
INSERT INTO "public"."sys_oper_log" VALUES (3143, '任务管理', 3, 'com.ruoyi.quartz.controller.SysJobController.remove()', 'DELETE', 1, 'admin', '研发部门', '/monitor/job/36,35,34,33,31,30,29,28,27,26', '127.0.0.1', '内网IP', '[36,35,34,33,31,30,29,28,27,26]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-18 10:38:10.073191', 479);
INSERT INTO "public"."sys_oper_log" VALUES (3144, '任务管理', 3, 'com.ruoyi.quartz.controller.SysJobController.remove()', 'DELETE', 1, 'admin', '研发部门', '/monitor/job/25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6', '127.0.0.1', '内网IP', '[25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-18 10:38:15.634593', 929);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_post";
CREATE TABLE "public"."sys_post" (
  "post_id" int8 NOT NULL DEFAULT nextval('sys_post_post_id_seq'::regclass),
  "post_code" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "post_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "post_sort" int4 NOT NULL,
  "status" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_post"."post_id" IS '岗位ID';
COMMENT ON COLUMN "public"."sys_post"."post_code" IS '岗位编码';
COMMENT ON COLUMN "public"."sys_post"."post_name" IS '岗位名称';
COMMENT ON COLUMN "public"."sys_post"."post_sort" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_post"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_post"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_post"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_post"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_post"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_post"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_post" IS '岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO "public"."sys_post" VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-05-26 18:56:28', '', NULL, '');
INSERT INTO "public"."sys_post" VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-05-26 18:56:28', '', NULL, '');
INSERT INTO "public"."sys_post" VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-05-26 18:56:28', '', NULL, '');
INSERT INTO "public"."sys_post" VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-05-26 18:56:28', 'admin', '2021-05-27 09:07:17.160973', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "role_id" int8 NOT NULL DEFAULT nextval('sys_role_role_id_seq'::regclass),
  "role_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "role_key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "role_sort" int4 NOT NULL,
  "data_scope" char(1) COLLATE "pg_catalog"."default",
  "menu_check_strictly" bool,
  "dept_check_strictly" bool,
  "status" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT 0,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."sys_role"."role_key" IS '角色权限字符串';
COMMENT ON COLUMN "public"."sys_role"."role_sort" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_role"."data_scope" IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
COMMENT ON COLUMN "public"."sys_role"."menu_check_strictly" IS '菜单树选择项是否关联显示';
COMMENT ON COLUMN "public"."sys_role"."dept_check_strictly" IS '部门树选择项是否关联显示';
COMMENT ON COLUMN "public"."sys_role"."status" IS '角色状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_role"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sys_role"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_role"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_role"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_role"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_role"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_role" IS '角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO "public"."sys_role" VALUES (1, '超级管理员', 'admin', 1, '1', 't', 't', '0', '0', 'admin', '2021-05-26 18:56:28', '', NULL, '超级管理员');
INSERT INTO "public"."sys_role" VALUES (2, '普通角色', 'common', 2, '2', 'f', 'f', '0', '0', 'admin', '2021-05-26 18:56:28', 'admin', '2025-03-10 17:12:49.701523', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_dept";
CREATE TABLE "public"."sys_role_dept" (
  "role_id" int8 NOT NULL,
  "dept_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_dept"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_dept"."dept_id" IS '部门ID';
COMMENT ON TABLE "public"."sys_role_dept" IS '角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO "public"."sys_role_dept" VALUES (2, 100);
INSERT INTO "public"."sys_role_dept" VALUES (2, 101);
INSERT INTO "public"."sys_role_dept" VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_menu";
CREATE TABLE "public"."sys_role_menu" (
  "role_id" int8 NOT NULL,
  "menu_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_menu"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_menu"."menu_id" IS '菜单ID';
COMMENT ON TABLE "public"."sys_role_menu" IS '角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO "public"."sys_role_menu" VALUES (2, 2001);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2002);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2034);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2035);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2036);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2037);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2038);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2003);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2039);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2040);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2043);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2000);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2004);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2044);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2048);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2005);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2053);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2054);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2055);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2056);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2057);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2006);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2051);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2007);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2052);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2008);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2029);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2030);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2033);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1);
INSERT INTO "public"."sys_role_menu" VALUES (2, 100);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1001);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1002);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1003);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1004);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1005);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1006);
INSERT INTO "public"."sys_role_menu" VALUES (2, 101);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1007);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1008);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1009);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1010);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1011);
INSERT INTO "public"."sys_role_menu" VALUES (2, 102);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1012);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1013);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1014);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1015);
INSERT INTO "public"."sys_role_menu" VALUES (2, 103);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1016);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1017);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1018);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1019);
INSERT INTO "public"."sys_role_menu" VALUES (2, 104);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1020);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1021);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1022);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1023);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1024);
INSERT INTO "public"."sys_role_menu" VALUES (2, 105);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1025);
INSERT INTO "public"."sys_role_menu" VALUES (2, 106);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1030);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1031);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1032);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1033);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1034);
INSERT INTO "public"."sys_role_menu" VALUES (2, 107);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1035);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1036);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1037);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1038);
INSERT INTO "public"."sys_role_menu" VALUES (2, 108);
INSERT INTO "public"."sys_role_menu" VALUES (2, 500);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1039);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1040);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1041);
INSERT INTO "public"."sys_role_menu" VALUES (2, 501);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1042);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1043);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1044);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1045);
INSERT INTO "public"."sys_role_menu" VALUES (2, 2);
INSERT INTO "public"."sys_role_menu" VALUES (2, 109);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1046);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1047);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1048);
INSERT INTO "public"."sys_role_menu" VALUES (2, 110);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1049);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1050);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1051);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1052);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1053);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1054);
INSERT INTO "public"."sys_role_menu" VALUES (2, 111);
INSERT INTO "public"."sys_role_menu" VALUES (2, 112);
INSERT INTO "public"."sys_role_menu" VALUES (2, 113);
INSERT INTO "public"."sys_role_menu" VALUES (2, 114);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1055);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1056);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1057);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1058);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1059);
INSERT INTO "public"."sys_role_menu" VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "user_id" int8 NOT NULL DEFAULT nextval('sys_user_user_id_seq'::regclass),
  "dept_id" int8,
  "user_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "nick_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "user_type" varchar(2) COLLATE "pg_catalog"."default",
  "email" varchar(50) COLLATE "pg_catalog"."default",
  "phonenumber" varchar(11) COLLATE "pg_catalog"."default",
  "sex" char(1) COLLATE "pg_catalog"."default",
  "avatar" varchar(100) COLLATE "pg_catalog"."default",
  "password" varchar(100) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default",
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "login_ip" varchar(128) COLLATE "pg_catalog"."default",
  "login_date" timestamp(6),
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user"."dept_id" IS '部门ID';
COMMENT ON COLUMN "public"."sys_user"."user_name" IS '用户账号';
COMMENT ON COLUMN "public"."sys_user"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "public"."sys_user"."user_type" IS '用户类型（00系统用户）';
COMMENT ON COLUMN "public"."sys_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "public"."sys_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "public"."sys_user"."sex" IS '用户性别（0男 1女 2未知）';
COMMENT ON COLUMN "public"."sys_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "public"."sys_user"."password" IS '密码';
COMMENT ON COLUMN "public"."sys_user"."status" IS '帐号状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_user"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sys_user"."login_ip" IS '最后登录IP';
COMMENT ON COLUMN "public"."sys_user"."login_date" IS '最后登录时间';
COMMENT ON COLUMN "public"."sys_user"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_user"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_user" IS '用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO "public"."sys_user" VALUES (2, 105, 'ry', '测试', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-05-25 19:58:36.506', 'admin', '2021-05-26 18:56:28', 'admin', '2025-05-25 19:58:36.49013', '测试员');
INSERT INTO "public"."sys_user" VALUES (1, 103, 'admin', '管理员', '00', 'dreamfalls@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-09-18 10:02:36.896', 'admin', '2021-05-26 18:56:28', '', '2025-09-18 10:02:35.219592', '管理员');
INSERT INTO "public"."sys_user" VALUES (3, 100, 'smsbidui', '塞默森比对', NULL, '123@qq.com', '13888888888', NULL, NULL, '$2a$10$yQdHZNK8VVx7WX0fnsPT/uVdKg54t6RVz174QlY/JYKrsOODzEKK.', '0', '0', '127.0.0.1', '2025-06-24 22:13:37.477', 'admin', '2025-03-07 14:34:39.995037', NULL, '2025-06-24 22:13:37.120127', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_post";
CREATE TABLE "public"."sys_user_post" (
  "user_id" int8 NOT NULL,
  "post_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_post"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_post"."post_id" IS '岗位ID';
COMMENT ON TABLE "public"."sys_user_post" IS '用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO "public"."sys_user_post" VALUES (1, 1);
INSERT INTO "public"."sys_user_post" VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "user_id" int8 NOT NULL,
  "role_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_role"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_role"."role_id" IS '角色ID';
COMMENT ON TABLE "public"."sys_user_role" IS '用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO "public"."sys_user_role" VALUES (1, 1);
INSERT INTO "public"."sys_user_role" VALUES (2, 2);
INSERT INTO "public"."sys_user_role" VALUES (3, 2);

-- ----------------------------
-- Table structure for table_name
-- ----------------------------
DROP TABLE IF EXISTS "public"."table_name";
CREATE TABLE "public"."table_name" (
  "id" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1
),
  "create_time" date,
  "name" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of table_name
-- ----------------------------
INSERT INTO "public"."table_name" VALUES (2, '2025-05-12', '1');

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS "public"."tasks";
CREATE TABLE "public"."tasks" (
  "task_id" int4 NOT NULL DEFAULT nextval('tasks_task_id_seq'::regclass),
  "task_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "task_type" int4 NOT NULL,
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "request_content" text COLLATE "pg_catalog"."default",
  "task_status" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'pending'::character varying,
  "response_content" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "notes" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."tasks"."task_id" IS '任务ID';
COMMENT ON COLUMN "public"."tasks"."task_name" IS '任务名称';
COMMENT ON COLUMN "public"."tasks"."task_type" IS '任务类型';
COMMENT ON COLUMN "public"."tasks"."start_time" IS '任务开始时间';
COMMENT ON COLUMN "public"."tasks"."end_time" IS '任务结束时间';
COMMENT ON COLUMN "public"."tasks"."request_content" IS '任务内容';
COMMENT ON COLUMN "public"."tasks"."task_status" IS '任务状态';
COMMENT ON COLUMN "public"."tasks"."response_content" IS '返回内容';
COMMENT ON COLUMN "public"."tasks"."create_time" IS '任务创建时间';
COMMENT ON COLUMN "public"."tasks"."update_time" IS '任务更新时间';
COMMENT ON COLUMN "public"."tasks"."create_by" IS '任务创建人';
COMMENT ON COLUMN "public"."tasks"."update_by" IS '任务修改人';
COMMENT ON COLUMN "public"."tasks"."notes" IS '任务备注信息';
COMMENT ON TABLE "public"."tasks" IS '任务表，用于存储任务相关信息';

-- ----------------------------
-- Records of tasks
-- ----------------------------
INSERT INTO "public"."tasks" VALUES (18, '导出123', 1, '2025-03-08 10:48:14.053', '2025-03-08 10:48:52.065', '{"stationIds":"XianHe01,XianHe02,XianHe03","beginPickTime":"2025-01-08 00:00:00","endPickTime":"2025-01-09 00:00:00","classify":"minute","fileUrl":null}', 'completed', '{"msg":"导出完成，点击下载！","success":1,"fileUrl":"/profile\\ExportImportData\\18.zip"}', '2025-03-08 10:48:14.053', '2025-03-08 10:48:52.068', 'admin', '系统', '导出啊');
INSERT INTO "public"."tasks" VALUES (9, '导出任务一', 1, '2025-03-06 00:00:00', '2025-03-06 16:00:32.858', NULL, 'completed', '{"msg":"系统异常","success":0}', '2025-03-06 15:42:31.429', '2025-03-06 16:00:32.866', NULL, '系统', NULL);
INSERT INTO "public"."tasks" VALUES (19, '测试', 2, '2025-03-08 10:54:18.389', '2025-03-08 10:54:53.569', '{"stationIds":"","beginPickTime":"2025-03-01 00:00:00","endPickTime":"2025-03-08 00:00:00","classify":"minute","fileUrl":null}', 'completed', '{"msg":"系统异常","success":0}', '2025-03-08 10:54:18.389', '2025-03-08 10:54:53.569', 'admin', '系统', '123');
INSERT INTO "public"."tasks" VALUES (20, '123', 1, '2025-03-08 10:54:49.389', '2025-03-08 10:55:51.328', '{"stationIds":"XianHe01,XianHe02","beginPickTime":"2025-01-08 00:00:00","endPickTime":"2025-01-09 00:00:00","classify":"minute","fileUrl":null}', 'completed', '{"msg":"导出完成，点击下载！","success":1,"fileUrl":"/profile\\ExportImportData\\20.zip"}', '2025-03-08 10:54:49.389', '2025-03-08 10:55:51.328', 'admin', '系统', NULL);
INSERT INTO "public"."tasks" VALUES (11, '导出任务04', 1, '2025-03-06 00:00:00', '2025-03-06 16:50:23.957', NULL, 'completed', '{"msg":"系统异常","success":0}', '2025-03-06 16:42:02.24', '2025-03-06 16:50:23.957', NULL, '系统', NULL);
INSERT INTO "public"."tasks" VALUES (21, '导入34567', 2, '2025-03-08 16:51:13.005', '2025-03-08 16:51:51.145', '{"stationIds":"","beginPickTime":"2025-03-08 08:00:00","endPickTime":"2025-03-08 09:00:00","classify":"minute","fileUrl":null}', 'completed', '{"msg":"系统异常","success":0}', '2025-03-08 16:51:13.005', '2025-03-08 16:51:51.145', 'admin', '系统', NULL);
INSERT INTO "public"."tasks" VALUES (13, '导出任务20250306', 1, '2025-03-06 00:00:00', '2025-03-06 16:55:08.464', NULL, 'completed', '{"msg":"系统异常","success":0}', '2025-03-06 16:53:14.78', '2025-03-06 16:55:08.464', NULL, '系统', NULL);
INSERT INTO "public"."tasks" VALUES (22, '任务名称2', 2, '2025-03-08 16:57:05.956', '2025-03-08 16:57:57.772', '{"stationIds":"","classify":"minute","fileUrl":"/profile/upload/2025/03/08/2月度考核表-李跃明_20250308165700A003.xlsx"}', 'completed', '{"msg":"数据导入失败：D:\\ruoyi\\uploadPath\\upload\\2025\\03\\08\\2月度考核表-李跃明_20250308165700A003.xlsx (系统找不到指定的文件。)","success":0}', '2025-03-08 16:57:05.956', '2025-03-08 16:57:57.772', 'admin', '系统', NULL);
INSERT INTO "public"."tasks" VALUES (7, '数据导出', 1, '2025-03-04 00:00:00', '2025-03-04 17:09:34.954', '{
"stationIds":"XianHe02,XianHe01",
    "beginPickTime":"2025-01-02 00:00:00",
    "endPickTime":"2025-01-03 00:00:00",
    "classify":"minute"
}', 'completed', '{"msg":"成功","success":1,"fileUrl":"/profile\\ExportImportData\\7.zip"}', '2025-03-04 11:41:29.722', '2025-03-04 17:09:34.957', NULL, '系统', NULL);
INSERT INTO "public"."tasks" VALUES (23, '导入20250310', 2, '2025-03-10 09:50:35.857', '2025-03-10 09:50:40.996', '{"stationIds":"","classify":"minute","fileUrl":"/profile/upload/2025/03/10/2月度考核表-李跃明_20250310095031A003.xlsx"}', 'completed', '{"msg":"数据导入失败：D:\\ruoyi\\uploadPath\\upload\\2025\\03\\10\\2月度考核表-李跃明_20250310095031A003.xlsx (系统找不到指定的文件。)","success":0}', '2025-03-10 09:50:35.857', '2025-03-10 09:50:40.996', 'admin', '系统', NULL);
INSERT INTO "public"."tasks" VALUES (8, '数据导入', 2, '2025-03-06 16:01:09', '2025-03-06 16:58:29.54', '{"stationIds":"XianHe01","classify":"minute","fileUrl":"/profile/upload/2025/03/05/数据导入模板_20250305141948A002.xlsx"}', 'completed', '{"msg":"数据导入结束,请点击下载导入结果！","success":1,"fileUrl":"/profile/upload/2025/03/05/数据导入模板_20250305141948A002_result.xlsx"}', '2025-03-05 14:20:06.216', '2025-03-06 16:58:29.542', NULL, '系统', NULL);
INSERT INTO "public"."tasks" VALUES (24, '导入222222', 2, '2025-03-10 09:55:00.791', '2025-03-10 09:55:40.977', '{"stationIds":"","classify":"minute","fileUrl":"/profile/upload/2025/03/10/a_20250310095458A004.xlsx"}', 'completed', '{"msg":"数据导入失败：D:\\ruoyi\\uploadPath\\upload\\2025\\03\\10\\a_20250310095458A004.xlsx (系统找不到指定的文件。)","success":0}', '2025-03-10 09:55:00.791', '2025-03-10 09:55:40.977', 'admin', '系统', NULL);
INSERT INTO "public"."tasks" VALUES (25, '导出2222222', 1, '2025-03-10 09:56:28.569', '2025-03-10 09:56:41.544', '{"stationIds":"XianHe02","beginPickTime":"2025-03-09 00:00:00","endPickTime":"2025-03-10 00:00:00","classify":"minute","fileUrl":""}', 'completed', '{"msg":"导出完成，点击下载！","success":1,"fileUrl":"/profile\\ExportImportData\\25.zip"}', '2025-03-10 09:56:28.569', '2025-03-10 09:56:41.544', 'admin', '系统', 'ff');
INSERT INTO "public"."tasks" VALUES (26, '导入adfddd', 2, '2025-03-10 09:57:15.582', '2025-03-10 09:57:40.984', '{"stationIds":null,"classify":"minute","fileUrl":"/profile/upload/2025/03/10/a_20250310095710A005.xlsx"}', 'completed', '{"msg":"数据导入失败：D:\\ruoyi\\uploadPath\\upload\\2025\\03\\10\\a_20250310095710A005.xlsx (系统找不到指定的文件。)","success":0}', '2025-03-10 09:57:15.582', '2025-03-10 09:57:40.984', 'admin', '系统', NULL);
INSERT INTO "public"."tasks" VALUES (27, 'sssss11111', 2, '2025-03-10 09:58:03.049', '2025-03-10 09:58:40.983', '{"stationIds":null,"classify":"minute","fileUrl":"/profile/upload/2025/03/10/2月度考核表-李跃明_20250310095749A006.xlsx"}', 'completed', '{"msg":"数据导入失败：D:\\ruoyi\\uploadPath\\upload\\2025\\03\\10\\2月度考核表-李跃明_20250310095749A006.xlsx (系统找不到指定的文件。)","success":0}', '2025-03-10 09:58:03.049', '2025-03-10 09:58:40.983', 'admin', '系统', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS "public"."user";
CREATE TABLE "public"."user" (
  "id" int4 NOT NULL DEFAULT nextval('user_id_seq'::regclass),
  "username" varchar(100) COLLATE "pg_catalog"."default",
  "password" varchar(100) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO "public"."user" VALUES (1, 'admin', 'admin');

-- ----------------------------
-- Function structure for find_in_set
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."find_in_set"(int8, varchar);
CREATE OR REPLACE FUNCTION "public"."find_in_set"(int8, varchar)
  RETURNS "pg_catalog"."bool" AS $BODY$
DECLARE
    STR ALIAS FOR $1;
    STRS ALIAS FOR $2;
    POS INTEGER;
    STATUS BOOLEAN;
BEGIN
    SELECT POSITION( ','||STR||',' IN ','||STRS||',') INTO POS;
    IF POS > 0 THEN
        STATUS = TRUE;
    ELSE
        STATUS = FALSE;
    END IF;
    RETURN STATUS;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for his_data_partition_trigger
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."his_data_partition_trigger"();
CREATE OR REPLACE FUNCTION "public"."his_data_partition_trigger"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
DECLARE
insert_statement TEXT;
    iso_week INT;          -- 改用INT存储周数，避免文本比较
    iso_year INT;          -- 存储正确的ISO周年份
    partition_table TEXT;
BEGIN
    -- 直接获取符合ISO 8601的周和年份（PostgreSQL内置函数更准确）
SELECT
    EXTRACT(ISOYEAR FROM NEW.pick_time)::INT,
        EXTRACT(WEEK FROM NEW.pick_time)::INT
INTO iso_year, iso_week;

-- 构造分区表名（使用ISO年+ISO周，无需手动调整）
partition_table := 'his_data_' || iso_year || '_' || iso_week;

    -- 构造带ON CONFLICT DO UPDATE的插入语句
    insert_statement := '
        INSERT INTO ' || quote_ident(partition_table) || ' (
            station_id, thing_id, model_id, classify, status,
            field, value, values, total, unit, pick_time,
            created_at, updated_at
        ) VALUES (
            $1.station_id, $1.thing_id, $1.model_id, $1.classify, $1.status,
            $1.field, $1.value, $1.values, $1.total, $1.unit, $1.pick_time,
            $1.created_at, $1.updated_at
        )
        ON CONFLICT (station_id, model_id, classify, pick_time)
        DO UPDATE SET
            thing_id = EXCLUDED.thing_id,
            status = EXCLUDED.status,
            field = EXCLUDED.field,
            value = EXCLUDED.value,
            values = EXCLUDED.values,
            total = EXCLUDED.total,
            unit = EXCLUDED.unit,
            updated_at = EXCLUDED.updated_at
    ';

    -- 执行插入语句（增加异常捕获，避免触发器崩溃）
BEGIN
EXECUTE insert_statement USING NEW;
EXCEPTION
        WHEN undefined_table THEN
            RAISE EXCEPTION '分区表 % 不存在，请先创建', partition_table;
WHEN OTHERS THEN
            RAISE EXCEPTION '插入分区表 % 失败：%', partition_table, SQLERRM;
END;

RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for realdata_partition_trigger
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."realdata_partition_trigger"();
CREATE OR REPLACE FUNCTION "public"."realdata_partition_trigger"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
DECLARE
insert_statement TEXT;
    iso_week INT;
BEGIN
SELECT EXTRACT(WEEK FROM NEW.pick_time)::INT INTO iso_week;
insert_statement := 'INSERT INTO realdata_' || iso_week || ' VALUES ($1.*)';

BEGIN
EXECUTE insert_statement USING NEW;
EXCEPTION
        WHEN undefined_table THEN
            RAISE EXCEPTION '分区表 realdata_% 不存在，请先创建', iso_week;
END;

RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for substring_index
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."substring_index"(varchar, varchar, int4);
CREATE OR REPLACE FUNCTION "public"."substring_index"(varchar, varchar, int4)
  RETURNS "pg_catalog"."varchar" AS $BODY$
DECLARE
tokens varchar[];
length integer ;
indexnum integer;
BEGIN
tokens := pg_catalog.string_to_array($1, $2);
length := pg_catalog.array_upper(tokens, 1);
indexnum := length - ($3 * -1) + 1;
IF $3 >= 0 THEN
RETURN pg_catalog.array_to_string(tokens[1:$3], $2);
ELSE
RETURN pg_catalog.array_to_string(tokens[indexnum:length], $2);
END IF;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT
  COST 100;

-- ----------------------------
-- View structure for list_column
-- ----------------------------
DROP VIEW IF EXISTS "public"."list_column";
CREATE VIEW "public"."list_column" AS  SELECT c.relname AS table_name,
    a.attname AS column_name,
    d.description AS column_comment,
        CASE
            WHEN a.attnotnull AND con.conname IS NULL THEN 1
            ELSE 0
        END AS is_required,
        CASE
            WHEN con.conname IS NOT NULL THEN 1
            ELSE 0
        END AS is_pk,
    a.attnum AS sort,
        CASE
            WHEN "position"(pg_get_expr(ad.adbin, ad.adrelid), ((c.relname::text || '_'::text) || a.attname::text) || '_seq'::text) > 0 THEN 1
            ELSE 0
        END AS is_increment,
    btrim(
        CASE
            WHEN t.typelem <> 0::oid AND t.typlen = '-1'::integer THEN 'ARRAY'::text
            ELSE
            CASE
                WHEN t.typtype = 'd'::"char" THEN format_type(t.typbasetype, NULL::integer)
                ELSE format_type(a.atttypid, NULL::integer)
            END
        END, '"'::text) AS column_type
   FROM pg_attribute a
     JOIN (pg_class c
     JOIN pg_namespace n ON c.relnamespace = n.oid) ON a.attrelid = c.oid
     LEFT JOIN pg_description d ON d.objoid = c.oid AND a.attnum = d.objsubid
     LEFT JOIN pg_constraint con ON con.conrelid = c.oid AND (a.attnum = ANY (con.conkey))
     LEFT JOIN pg_attrdef ad ON a.attrelid = ad.adrelid AND a.attnum = ad.adnum
     LEFT JOIN pg_type t ON a.atttypid = t.oid
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND a.attnum > 0 AND n.nspname = 'public'::name AND NOT a.attisdropped
  ORDER BY c.relname, a.attnum;

-- ----------------------------
-- View structure for list_table
-- ----------------------------
DROP VIEW IF EXISTS "public"."list_table";
CREATE VIEW "public"."list_table" AS  SELECT c.relname AS table_name,
    obj_description(c.oid) AS table_comment,
    CURRENT_TIMESTAMP AS create_time,
    CURRENT_TIMESTAMP AS update_time
   FROM pg_class c
     LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE (c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND c.relname !~~ 'spatial_%'::text AND n.nspname = 'public'::name AND n.nspname <> ''::name;




-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."env_quality_control_report_id_seq"
OWNED BY "public"."env_quality_control_report"."id";
SELECT setval('"public"."env_quality_control_report_id_seq"', 111, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."gen_table_column_column_id_seq"
OWNED BY "public"."gen_table_column"."column_id";
SELECT setval('"public"."gen_table_column_column_id_seq"', 301, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."gen_table_table_id_seq"
OWNED BY "public"."gen_table"."table_id";
SELECT setval('"public"."gen_table_table_id_seq"', 25, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."his_data_id_seq"', 206868, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."moketableindex"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."paid"', 264, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."stid"', 29, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_config_config_id_seq"
OWNED BY "public"."sys_config"."config_id";
SELECT setval('"public"."sys_config_config_id_seq"', 100, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_dept_dept_id_seq"
OWNED BY "public"."sys_dept"."dept_id";
SELECT setval('"public"."sys_dept_dept_id_seq"', 110, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_dict_data_dict_code_seq"
OWNED BY "public"."sys_dict_data"."dict_code";
SELECT setval('"public"."sys_dict_data_dict_code_seq"', 300, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_dict_type_dict_id_seq"
OWNED BY "public"."sys_dict_type"."dict_id";
SELECT setval('"public"."sys_dict_type_dict_id_seq"', 39, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_job_job_id_seq"
OWNED BY "public"."sys_job"."job_id";
SELECT setval('"public"."sys_job_job_id_seq"', 60, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_job_log_job_log_id_seq"
OWNED BY "public"."sys_job_log"."job_log_id";
SELECT setval('"public"."sys_job_log_job_log_id_seq"', 12604, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_logininfor_info_id_seq"
OWNED BY "public"."sys_logininfor"."info_id";
SELECT setval('"public"."sys_logininfor_info_id_seq"', 635, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_menu_menu_id_seq"
OWNED BY "public"."sys_menu"."menu_id";
SELECT setval('"public"."sys_menu_menu_id_seq"', 2074, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_notice_notice_id_seq"
OWNED BY "public"."sys_notice"."notice_id";
SELECT setval('"public"."sys_notice_notice_id_seq"', 3, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_oper_log_oper_id_seq"
OWNED BY "public"."sys_oper_log"."oper_id";
SELECT setval('"public"."sys_oper_log_oper_id_seq"', 3144, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_post_post_id_seq"
OWNED BY "public"."sys_post"."post_id";
SELECT setval('"public"."sys_post_post_id_seq"', 5, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_role_role_id_seq"
OWNED BY "public"."sys_role"."role_id";
SELECT setval('"public"."sys_role_role_id_seq"', 3, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_user_user_id_seq"
OWNED BY "public"."sys_user"."user_id";
SELECT setval('"public"."sys_user_user_id_seq"', 3, true);


-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."tasks_task_id_seq"
OWNED BY "public"."tasks"."task_id";
SELECT setval('"public"."tasks_task_id_seq"', 27, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_id_seq"
OWNED BY "public"."user"."id";
SELECT setval('"public"."user_id_seq"', 1, true);

-- ----------------------------
-- Auto increment value for env_access_control_records
-- ----------------------------
SELECT setval('"public"."env_access_control_records_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_access_control_records
-- ----------------------------
CREATE INDEX "idx_env_access_control_records_access_method" ON "public"."env_access_control_records" USING btree (
  "access_method" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_access_control_records_create_time" ON "public"."env_access_control_records" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);
CREATE INDEX "idx_env_access_control_records_device_name" ON "public"."env_access_control_records" USING btree (
  "device_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_access_control_records_employee_id" ON "public"."env_access_control_records" USING btree (
  "employee_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_access_control_records
-- ----------------------------
ALTER TABLE "public"."env_access_control_records" ADD CONSTRAINT "env_access_control_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table env_alarm_settings
-- ----------------------------
CREATE INDEX "idx_env_alarm_settings_alarm_type" ON "public"."env_alarm_settings" USING btree (
  "alarm_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_alarm_settings
-- ----------------------------
ALTER TABLE "public"."env_alarm_settings" ADD CONSTRAINT "env_alarm_settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_data_manager_alarms
-- ----------------------------
SELECT setval('"public"."env_data_manager_alarms_alarm_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_data_manager_alarms
-- ----------------------------
CREATE INDEX "idx_env_data_manager_alarm_type_start_time" ON "public"."env_data_manager_alarms" USING btree (
  "alarm_type" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sta_code_start_time_env_data_manager_alarm" ON "public"."env_data_manager_alarms" USING btree (
  "sta_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_start_time_data_manager_alarms" ON "public"."env_data_manager_alarms" USING btree (
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_data_manager_alarms
-- ----------------------------
ALTER TABLE "public"."env_data_manager_alarms" ADD CONSTRAINT "env_data_manager_alarms_pkey" PRIMARY KEY ("alarm_id");

-- ----------------------------
-- Auto increment value for env_data_manager_events
-- ----------------------------
SELECT setval('"public"."env_data_manager_events_event_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_data_manager_events
-- ----------------------------
CREATE INDEX "idx_env_data_manager_event_type_start_time" ON "public"."env_data_manager_events" USING btree (
  "event_type" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sta_code_start_time_env_data_manager_event" ON "public"."env_data_manager_events" USING btree (
  "sta_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_start_time_by_env_data_manager_events" ON "public"."env_data_manager_events" USING btree (
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_data_manager_events
-- ----------------------------
ALTER TABLE "public"."env_data_manager_events" ADD CONSTRAINT "env_data_manager_events_pkey" PRIMARY KEY ("event_id");

-- ----------------------------
-- Auto increment value for env_device_setting_records
-- ----------------------------
SELECT setval('"public"."env_device_setting_records_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_device_setting_records
-- ----------------------------
CREATE INDEX "idx_env_data_device_setting_records_device_id" ON "public"."env_device_setting_records" USING btree (
  "device_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_data_device_setting_records_device_setting_time" ON "public"."env_device_setting_records" USING btree (
  "device_setting_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_device_setting_records
-- ----------------------------
ALTER TABLE "public"."env_device_setting_records" ADD CONSTRAINT "env_device_setting_records_pkey" PRIMARY KEY ("id");



-- ----------------------------
-- Indexes structure for table env_device_settings
-- ----------------------------
CREATE INDEX "idx_env_device_settings_device_id" ON "public"."env_device_settings" USING btree (
  "device_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_device_settings_device_type" ON "public"."env_device_settings" USING btree (
  "device_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_device_settings
-- ----------------------------
ALTER TABLE "public"."env_device_settings" ADD CONSTRAINT "env_device_settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_maintenance_records
-- ----------------------------
SELECT setval('"public"."env_maintenance_records_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_maintenance_records
-- ----------------------------
CREATE INDEX "idx_env_maintenance_records_maintenance_mode" ON "public"."env_maintenance_records" USING btree (
  "maintenance_mode" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_maintenance_records_maintenance_time" ON "public"."env_maintenance_records" USING btree (
  "maintenance_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);
CREATE INDEX "idx_env_maintenance_records_maintenance_type" ON "public"."env_maintenance_records" USING btree (
  "maintenance_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_maintenance_records
-- ----------------------------
ALTER TABLE "public"."env_maintenance_records" ADD CONSTRAINT "env_maintenance_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_maintenance_settings
-- ----------------------------
SELECT setval('"public"."env_maintenance_settings_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_maintenance_settings
-- ----------------------------
CREATE INDEX "idx_env_maintenance_settings_current_status" ON "public"."env_maintenance_settings" USING btree (
  "current_status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_maintenance_settings_expiry_time" ON "public"."env_maintenance_settings" USING btree (
  "expiry_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_maintenance_settings_maintenance_mode" ON "public"."env_maintenance_settings" USING btree (
  "maintenance_mode" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_maintenance_settings
-- ----------------------------
ALTER TABLE "public"."env_maintenance_settings" ADD CONSTRAINT "env_maintenance_settings_pkey" PRIMARY KEY ("id");


-- ----------------------------
-- Indexes structure for table env_material_manager
-- ----------------------------
CREATE UNIQUE INDEX "idx_env_material_manager_material_code" ON "public"."env_material_manager" USING btree (
  "material_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_material_manager_material_type" ON "public"."env_material_manager" USING btree (
  "material_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table env_material_manager
-- ----------------------------
ALTER TABLE "public"."env_material_manager" ADD CONSTRAINT "unique_material_code" UNIQUE ("material_code");

-- ----------------------------
-- Primary Key structure for table env_material_manager
-- ----------------------------
ALTER TABLE "public"."env_material_manager" ADD CONSTRAINT "env_material_manager_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_material_records
-- ----------------------------
SELECT setval('"public"."env_material_records_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_material_records
-- ----------------------------
CREATE INDEX "idx_env_material_records_material_code" ON "public"."env_material_records" USING btree (
  "material_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_material_records_usage_time" ON "public"."env_material_records" USING btree (
  "usage_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_material_records
-- ----------------------------
ALTER TABLE "public"."env_material_records" ADD CONSTRAINT "env_material_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_patrol_records
-- ----------------------------
SELECT setval('"public"."env_patrol_records_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_patrol_records
-- ----------------------------
CREATE INDEX "idx_env_patrol_records_generation_time" ON "public"."env_patrol_records" USING btree (
  "generation_time" "pg_catalog"."timestamp_ops" DESC NULLS LAST
);
CREATE INDEX "idx_env_patrol_records_patrol_type" ON "public"."env_patrol_records" USING btree (
  "patrol_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_patrol_records
-- ----------------------------
ALTER TABLE "public"."env_patrol_records" ADD CONSTRAINT "env_patrol_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_patrol_settings
-- ----------------------------
SELECT setval('"public"."env_patrol_settings_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_patrol_settings
-- ----------------------------
CREATE INDEX "idx_env_patrol_settings_setting_type" ON "public"."env_patrol_settings" USING btree (
  "setting_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_patrol_settings
-- ----------------------------
ALTER TABLE "public"."env_patrol_settings" ADD CONSTRAINT "env_patrol_settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_patrol_statistics
-- ----------------------------
SELECT setval('"public"."env_patrol_statistics_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_patrol_statistics
-- ----------------------------
CREATE INDEX "idx_env_patrol_statistics_period_time_range" ON "public"."env_patrol_statistics" USING btree (
  "period_start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "period_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_patrol_statistics_statistics_type" ON "public"."env_patrol_statistics" USING btree (
  "statistics_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_patrol_statistics
-- ----------------------------
ALTER TABLE "public"."env_patrol_statistics" ADD CONSTRAINT "env_patrol_statistics_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_quality_control_plan
-- ----------------------------
SELECT setval('"public"."env_quality_control_plan_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_quality_control_plan
-- ----------------------------
CREATE INDEX "idx_env_quality_control_plan_plan_time_range" ON "public"."env_quality_control_plan" USING btree (
  "plan_start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "plan_end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_quality_control_plan_quality_control_type" ON "public"."env_quality_control_plan" USING btree (
  "quality_control_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_quality_control_plan
-- ----------------------------
ALTER TABLE "public"."env_quality_control_plan" ADD CONSTRAINT "env_quality_control_plan_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for env_quality_control_records
-- ----------------------------
SELECT setval('"public"."env_quality_control_records_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table env_quality_control_records
-- ----------------------------
CREATE INDEX "idx_env_quality_control_records_execution_status" ON "public"."env_quality_control_records" USING btree (
  "execution_status" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_quality_control_records_quality_control_plan_id" ON "public"."env_quality_control_records" USING btree (
  "quality_control_plan_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_quality_control_records_quality_control_type" ON "public"."env_quality_control_records" USING btree (
  "quality_control_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_env_quality_control_records_time_range" ON "public"."env_quality_control_records" USING btree (
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_quality_control_records
-- ----------------------------
ALTER TABLE "public"."env_quality_control_records" ADD CONSTRAINT "env_quality_control_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table env_quality_control_report
-- ----------------------------
CREATE INDEX "idx_filer" ON "public"."env_quality_control_report" USING btree (
  "filer" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_gas_type" ON "public"."env_quality_control_report" USING btree (
  "gas_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_instrument_name" ON "public"."env_quality_control_report" USING btree (
  "instrument_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_instrument_no" ON "public"."env_quality_control_report" USING btree (
  "instrument_no" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_report_date" ON "public"."env_quality_control_report" USING btree (
  "report_date" "pg_catalog"."date_ops" ASC NULLS LAST
);
CREATE INDEX "idx_report_name" ON "public"."env_quality_control_report" USING btree (
  "report_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_report_type" ON "public"."env_quality_control_report" USING btree (
  "report_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_reviewer" ON "public"."env_quality_control_report" USING btree (
  "reviewer" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table env_quality_control_report
-- ----------------------------
ALTER TABLE "public"."env_quality_control_report" ADD CONSTRAINT "env_quality_control_report_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE "public"."gen_table" ADD CONSTRAINT "gen_table_pkey" PRIMARY KEY ("table_id");

-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE "public"."gen_table_column" ADD CONSTRAINT "gen_table_column_pkey" PRIMARY KEY ("column_id");

-- ----------------------------
-- Indexes structure for table his_data
-- ----------------------------
CREATE INDEX "idx_his_data_id" ON "public"."his_data" USING btree (
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_his_data_model_id" ON "public"."his_data" USING btree (
  "model_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_his_data_pick_time" ON "public"."his_data" USING btree (
  "pick_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_his_data_query" ON "public"."his_data" USING btree (
  "station_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "model_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "classify" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "pick_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table his_data
-- ----------------------------
CREATE TRIGGER "insert_his_data_partition_trigger" BEFORE INSERT ON "public"."his_data"
FOR EACH ROW
EXECUTE PROCEDURE "public"."his_data_partition_trigger"();

-- ----------------------------
-- Uniques structure for table his_data
-- ----------------------------
ALTER TABLE "public"."his_data" ADD CONSTRAINT "his_data_unique_station_model_classify_time" UNIQUE ("station_id", "model_id", "classify", "pick_time");

-- ----------------------------
-- Primary Key structure for table his_data
-- ----------------------------
ALTER TABLE "public"."his_data" ADD CONSTRAINT "his_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table mock_table
-- ----------------------------
ALTER TABLE "public"."mock_table" ADD CONSTRAINT "mock_table_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table nowdata
-- ----------------------------
CREATE UNIQUE INDEX "pid_sid_tid_index" ON "public"."nowdata" USING btree (
  "tid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "pid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "sid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table para_info
-- ----------------------------
ALTER TABLE "public"."para_info" ADD CONSTRAINT "paraInfo_copy1_pkey1" PRIMARY KEY ("para_id", "pid");

-- ----------------------------
-- Primary Key structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_blob_triggers" ADD CONSTRAINT "QRTZ_BLOB_TRIGGERS_pkey" PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_calendars
-- ----------------------------
ALTER TABLE "public"."qrtz_calendars" ADD CONSTRAINT "QRTZ_CALENDARS_pkey" PRIMARY KEY ("sched_name", "calendar_name");

-- ----------------------------
-- Primary Key structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_cron_triggers" ADD CONSTRAINT "QRTZ_CRON_TRIGGERS_pkey" PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_fired_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_fired_triggers" ADD CONSTRAINT "QRTZ_FIRED_TRIGGERS_pkey" PRIMARY KEY ("sched_name", "entry_id");

-- ----------------------------
-- Primary Key structure for table qrtz_job_details
-- ----------------------------
ALTER TABLE "public"."qrtz_job_details" ADD CONSTRAINT "QRTZ_JOB_DETAILS_pkey" PRIMARY KEY ("sched_name", "job_name", "job_group");

-- ----------------------------
-- Primary Key structure for table qrtz_locks
-- ----------------------------
ALTER TABLE "public"."qrtz_locks" ADD CONSTRAINT "QRTZ_LOCKS_pkey" PRIMARY KEY ("sched_name", "lock_name");

-- ----------------------------
-- Primary Key structure for table qrtz_paused_trigger_grps
-- ----------------------------
ALTER TABLE "public"."qrtz_paused_trigger_grps" ADD CONSTRAINT "QRTZ_PAUSED_TRIGGER_GRPS_pkey" PRIMARY KEY ("sched_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_scheduler_state
-- ----------------------------
ALTER TABLE "public"."qrtz_scheduler_state" ADD CONSTRAINT "QRTZ_SCHEDULER_STATE_pkey" PRIMARY KEY ("sched_name", "instance_name");

-- ----------------------------
-- Primary Key structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simple_triggers" ADD CONSTRAINT "QRTZ_SIMPLE_TRIGGERS_pkey" PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simprop_triggers" ADD CONSTRAINT "QRTZ_SIMPROP_TRIGGERS_pkey" PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Indexes structure for table qrtz_triggers
-- ----------------------------
CREATE INDEX "sched_name" ON "public"."qrtz_triggers" USING btree (
  "sched_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "job_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "job_group" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_triggers" ADD CONSTRAINT "QRTZ_TRIGGERS_pkey" PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Indexes structure for table realdata
-- ----------------------------
CREATE INDEX "idx_realdata_pick_time" ON "public"."realdata" USING btree (
  "pick_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_realdata_pid" ON "public"."realdata" USING btree (
  "pid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_realdata_query" ON "public"."realdata" USING btree (
  "sid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "pid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "pick_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table realdata
-- ----------------------------
CREATE TRIGGER "insert_realdata_partition_trigger" BEFORE INSERT ON "public"."realdata"
FOR EACH ROW
EXECUTE PROCEDURE "public"."realdata_partition_trigger"();

-- ----------------------------
-- Indexes structure for table sta_info
-- ----------------------------
CREATE UNIQUE INDEX "stcode_index_copy2" ON "public"."sta_info" USING btree (
  "st_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sta_info
-- ----------------------------
ALTER TABLE "public"."sta_info" ADD CONSTRAINT "staInfo_copy1_pkey1" PRIMARY KEY ("sta_id");

-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE "public"."sys_config" ADD CONSTRAINT "sys_config_pkey" PRIMARY KEY ("config_id");

-- ----------------------------
-- Primary Key structure for table sys_dept
-- ----------------------------
ALTER TABLE "public"."sys_dept" ADD CONSTRAINT "sys_dept_pkey" PRIMARY KEY ("dept_id");

-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE "public"."sys_dict_data" ADD CONSTRAINT "sys_dict_data_pkey" PRIMARY KEY ("dict_code");

-- ----------------------------
-- Indexes structure for table sys_dict_type
-- ----------------------------
CREATE INDEX "dict_type" ON "public"."sys_dict_type" USING btree (
  "dict_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "public"."sys_dict_type" ADD CONSTRAINT "sys_dict_type_pkey" PRIMARY KEY ("dict_id");

-- ----------------------------
-- Primary Key structure for table sys_job
-- ----------------------------
ALTER TABLE "public"."sys_job" ADD CONSTRAINT "sys_job_pkey" PRIMARY KEY ("job_id", "job_name", "job_group");

-- ----------------------------
-- Primary Key structure for table sys_job_log
-- ----------------------------
ALTER TABLE "public"."sys_job_log" ADD CONSTRAINT "sys_job_log_pkey" PRIMARY KEY ("job_log_id");

-- ----------------------------
-- Primary Key structure for table sys_logininfor
-- ----------------------------
ALTER TABLE "public"."sys_logininfor" ADD CONSTRAINT "sys_logininfor_pkey" PRIMARY KEY ("info_id");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "public"."sys_menu" ADD CONSTRAINT "sys_menu_pkey" PRIMARY KEY ("menu_id");

-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE "public"."sys_notice" ADD CONSTRAINT "sys_notice_pkey" PRIMARY KEY ("notice_id");

-- ----------------------------
-- Primary Key structure for table sys_oper_log
-- ----------------------------
ALTER TABLE "public"."sys_oper_log" ADD CONSTRAINT "sys_oper_log_pkey" PRIMARY KEY ("oper_id");

-- ----------------------------
-- Primary Key structure for table sys_post
-- ----------------------------
ALTER TABLE "public"."sys_post" ADD CONSTRAINT "sys_post_pkey" PRIMARY KEY ("post_id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sys_role_pkey" PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table sys_role_dept
-- ----------------------------
ALTER TABLE "public"."sys_role_dept" ADD CONSTRAINT "sys_role_dept_pkey" PRIMARY KEY ("role_id", "dept_id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "public"."sys_role_menu" ADD CONSTRAINT "sys_role_menu_pkey" PRIMARY KEY ("role_id", "menu_id");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "sys_user_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_post
-- ----------------------------
ALTER TABLE "public"."sys_user_post" ADD CONSTRAINT "sys_user_post_pkey" PRIMARY KEY ("user_id", "post_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("user_id", "role_id");

-- ----------------------------
-- Auto increment value for table_name
-- ----------------------------
SELECT setval('"public"."table_name_id_seq"', 1, false);

-- ----------------------------
-- Primary Key structure for table table_name
-- ----------------------------
ALTER TABLE "public"."table_name" ADD CONSTRAINT "table_name_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table tasks
-- ----------------------------
ALTER TABLE "public"."tasks" ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("task_id");

-- ----------------------------
-- Uniques structure for table user
-- ----------------------------
ALTER TABLE "public"."user" ADD CONSTRAINT "user_username_key" UNIQUE ("username");

-- ----------------------------
-- Primary Key structure for table user
-- ----------------------------
ALTER TABLE "public"."user" ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table para_info
-- ----------------------------
ALTER TABLE "public"."para_info" ADD CONSTRAINT "paraInfo_copy1_stCode_fkey1" FOREIGN KEY ("st_code") REFERENCES "public"."sta_info" ("st_code") ON DELETE SET NULL ON UPDATE SET NULL;

-- ----------------------------
-- Foreign Keys structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_blob_triggers" ADD CONSTRAINT "QRTZ_BLOB_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_cron_triggers" ADD CONSTRAINT "QRTZ_CRON_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simple_triggers" ADD CONSTRAINT "QRTZ_SIMPLE_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simprop_triggers" ADD CONSTRAINT "QRTZ_SIMPROP_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_triggers" ADD CONSTRAINT "QRTZ_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "job_name", "job_group") REFERENCES "public"."qrtz_job_details" ("sched_name", "job_name", "job_group") ON DELETE NO ACTION ON UPDATE NO ACTION;
