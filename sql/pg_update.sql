/*
 文件说明:
   更新 env_alarm_settings、env_device_settings 表数据
 前提条件:
   本机已安装并正常运行 PostgreSQL 服务，目标库中已存在对应表结构
 执行方式:
   psql -h <host> -p <port> -U <user> -d <dbname> -f pg_update.sql
   或在 pgAdmin Query Tool 中打开本文件后执行
 脚本做了什么:
   1. 清空 env_alarm_settings 报警管理表数据，重新插入最新基础数据
   2. 清空 env_device_settings 设备管理表数据， 重新插入最新基础数据
   3. 将 sys_job 中「实时表分表」「历史表分表」任务的 status 更新为 1 关闭 ， 调整质控报告及零跨质控任务默认执行时间
   4. 纠正 env_material_manager 耗材管理表中滤纸带错别字
   5. 更新 sys_menu 系统菜单表，隐藏系统监控和系统工具,调整日志管理菜单

 Date: 08/08/2026
*/

BEGIN;

SET search_path TO public;

-- =============================================
-- 1. env_alarm_settings
-- =============================================
DELETE FROM "public"."env_alarm_settings";

INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (1, '13', '{"id":1,"device_info":{"logicdevice_station.filter_changer.o3":["branch_temp"],"logicdevice_station.filter_changer.co":["branch_temp"],"logicdevice_station.filter_changer.nox":["branch_temp"],"logicdevice_station.filter_changer.so2":["branch_temp"]},"name":"支管冷凝水预警","description":"当露点温度高于设备间温度时，给出预示并建议空调设定值","icon":"Cloud","category":"sampling","enabled":true,"configurable":true,"configs":[{"label":"支管温度校准量","type":"number","value":1,"min":-10,"max":10,"step":0.1,"class":"coefficient"},{"label":"","type":"setting","dew_point_device_id":"logicdevice.meteo","dew_point_param_id":"dew_point"}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:48:12', '2026-06-05 11:27:58.085', 73);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (2, '10', '{"id":2,"device_info":{"logicdevice_station.paper_tape.pm10":["remaining_spots"],"logicdevice_station.paper_tape.pm25":["remaining_spots"]},"name":"颗粒物纸带更换","description":"当纸带剩余量低于阈值，给出更换预警提示","icon":"HardDrive","category":"equipment","enabled":true,"configurable":true,"configs":[{"label":"剩余量阈值 (%)","type":"number","value":70,"min":0,"max":100,"step":1},{"label":"","type":"setting","logicdevice_station.paper_tape.pm10":"total_spots","logicdevice_station.paper_tape.pm25":"total_spots"}]}', 'admin', 'admin', '2025-05-26 13:47:40', '2026-03-18 16:42:24.878', 140);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (3, '14', '{"id":72,"device_info":{"logicdevice.nox":["alarm_status"],"logicdevice.so2":["alarm_status"],"logicdevice.co":["alarm_status"],"logicdevice.o3":["alarm_status"],"logicdevice_station.calibrator":["alarm_status"],"logicdevice.pm25":["alarm_status"],"logicdevice.pm10":["alarm_status"]},"name":"监测设备报警","description":"当各个监测设备出现报警时触发","icon":"Settings","category":"equipment","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:20', '2025-06-12 16:37:20.758', 80);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (4, '8', '{"id":4,"device_info":{"logicdevice_station.indoor_pollutant":["so2_indoor","o3_indoor","no2_indoor","co_indoor"]},"name":"标准气体泄漏","description":"当检测到标气泄露，超出阈值范围，启动报警并自动开启排风扇","icon":"Wind","category":"gas","enabled":true,"configurable":true,"configs":[{"label":"站房 CO 浓度阈值（PPM）","type":"number","value":0.5,"min":-10,"max":1000,"step":1,"class":"co_concentration"},{"label":"站房 NO2 浓度阈值（PPM）","type":"number","value":0.5,"min":-10,"max":1000,"step":1,"class":"no2_concentration"},{"label":"站房 SO2 浓度阈值（PPM）","type":"number","value":0.5,"min":-10,"max":1000,"step":1,"class":"so2_concentration"},{"label":"","type":"setting","device_id":"logicdevice_station.exhaust_fan","param_id":"speed"}]}', 'admin', 'admin', '2025-05-26 13:47:19', '2026-03-19 09:11:33.757', 120);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (5, '9', '{"id":5,"device_info":{"logicdevice_station.standard_gas.co":["gas_pressure_remaining"],"logicdevice_station.standard_gas.so2":["gas_pressure_remaining"],"logicdevice_station.standard_gas.nox":["gas_pressure_remaining"]},"name":"标准气体更换","description":"当标准气体剩余量低于阈值范围，给出更换预警提示","icon":"Battery","category":"gas","enabled":true,"configurable":true,"configs":[{"label":"SO2 钢瓶气压力阈值（kPa）","type":"number","value":0,"min":0,"max":100000,"step":1,"class":"co"},{"label":"NOX 钢瓶气压力阈值（kPa）","type":"number","value":0,"min":0,"max":100000,"step":1,"class":"so2"},{"label":"CO 钢瓶气压力阈值（kPa）","type":"number","value":0,"min":0,"max":100000,"step":1,"class":"nox"}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:47:29', '2026-06-04 17:44:07.063', 130);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (6, '17', '{"id":138,"device_info":{"logicdevice_station.camera.1":["intrusion_alarm"],"logicdevice_station.camera.2":["intrusion_alarm"],"logicdevice_station.camera.3":["intrusion_alarm"],"logicdevice_station.camera.4":["intrusion_alarm"]},"name":"异常进入报警","description":"当有人进入站房区域，给出报警提示","icon":"User","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:44', '2025-06-04 12:01:08.268', 180);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (7, '4', '{"id":7,"device_info":{"logicdevice_station.power_meter":["voltage_a","voltage_b","voltage_c"]},"name":"供电电源异常波动","description":"当供电电源的电压超过设定范围，且持续时间超过设定时间，触发报警","icon":"Bolt","category":"power","enabled":true,"configurable":true,"configs":[{"label":"电压范围 (V)","type":"range","value":[198,242],"min":150,"max":300,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'admin', '2025-05-26 13:46:23', '2026-02-04 10:07:34.019', 40);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (8, '3', '{"id":67,"device_info":{"logicdevice_station.security_alarm":["water_leak"]},"name":"设备间漏水","description":"当设备间任一采样口位置发生漏水，水浸传感器触发报警","icon":"Droplet","category":"environment","enabled":true,"configurable":false}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:46:10', '2026-06-04 17:38:53.21', 30);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (9, '12', '{"id":9,"device_info":{"logicdevice_station.sampling_tube":["temperature"]},"name":"采样总管温度异常","description":"当采样总管内样气温度超出阈值范围，且持续时间超过设定时间，触发报警","icon":"Thermometer","category":"sampling","enabled":true,"configurable":true,"configs":[{"label":"温度范围 (℃)","type":"range","value":[30,40],"min":-20,"max":60,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:48:03', '2026-06-05 10:16:09.862', 70);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (10, '2', '{"id":10,"device_info":{"logicdevice_station.th":["humidity"]},"name":"设备间湿度异常","description":"当设备间的湿度传感器测量值超出阈值范围，且持续时间超过设定时间，触发报警","icon":{"name":"Warning","__name":"warning"},"category":"environment","enabled":true,"configurable":true,"configs":[{"label":"湿度范围 (%)","type":"range","value":[30,80],"min":0,"max":100,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:45:50', '2026-06-04 17:55:50.361', 20);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (11, '5', '{"id":11,"device_info":{"logicdevice_station.ups":["input_voltage"]},"name":"稳压电源异常波动","description":"当稳压电源的电压超过设定范围，且持续时间超过设定时间，触发报警","icon":"Gauge","category":"power","enabled":true,"configurable":true,"configs":[{"label":"电压范围 (V)","type":"range","value":[198,242],"min":150,"max":300,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:46:35', '2026-06-04 17:51:48.819', 41);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (12, '16', '{"id":73,"device_info":{"logicdevice_station.security_alarm":["smoke_1","smoke_2"]},"name":"消防报警","description":"当站房发生火情时，烟感报警装置启动报警并主动切断供电电源","icon":"Flame","category":"security","enabled":true,"configurable":true,"configs":[{"label":"","type":"setting","device_id":"logicdevice_station.voltage_regulator","param_id":"relay_ch2"}]}
', 'admin', 'admin', '2025-05-26 13:48:37', '2025-07-08 11:34:26.558', 90);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (13, '11', '{"id":13,"device_info":{"logicdevice_station.sampling_tube":["retention_time"]},"name":"采样总管流速异常","description":"当采样总管内样气的滞留时间大于设定值，且持续时间超过设定时间，触发报警","icon":"Fan","category":"sampling","enabled":true,"configurable":true,"configs":[{"label":"滞留时间 (s)","type":"number","value":2,"min":0,"max":60,"step":1,"class":"retention"},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:47:53', '2026-06-05 11:09:45.893', 71);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (14, '15', '{"id":137,"device_info":{"logicdevice_station.ups":["input_voltage"]},"name":"断电和恢复报警","description":"当监测场地发生断电特殊情况，给出断电报警提示；电源恢复后，给出来电恢复报警提示","icon":"Power","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:29', '2025-06-04 12:01:00.519', 170);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (15, '1', '{"id":15,"device_info":{"logicdevice_station.th":["temperature"]},"name":"设备间温度异常","description":"当设备间的温度传感器测量值超出阈值范围，且持续时间超过设定时间，触发报警","icon":"Thermometer","category":"environment","enabled":true,"configurable":true,"configs":[{"label":"温度范围 (℃)","type":"range","value":[20,30],"min":-20,"max":60,"step":1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:39:44', '2026-06-04 17:55:48.072', 10);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (16, '18', '{"id":74,"device_info":{"logicdevice_station.camera.1":["interference_alarm"],"logicdevice_station.camera.2":["interference_alarm"],"logicdevice_station.camera.3":["interference_alarm"],"logicdevice_station.camera.4":["interference_alarm"]},"name":"干扰报警","description":"自动识别雾炮喷淋等站房周边人为干扰行为，并给出报警提示","icon":"EyeOff","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2025-05-26 13:48:51', '2025-05-26 17:03:57.441', 100);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (17, '6', '{"id":17,"device_info":{"logicdevice_station.power_meter":["current_a","current_b","current_c"]},"name":"电流异常波动","description":"当供电电流突然升高或降低，超出阈值范围，且持续时间超过设定时间，触发报警","icon":"Zap","category":"power","enabled":true,"configurable":true,"configs":[{"label":"电流范围 (A)","type":"range","value":[0,10],"min":0,"max":30,"step":0.1},{"label":"持续时间","type":"duration","value":5,"min":1,"max":60,"step":1}]}', 'admin', 'Admin7s9k2G5', '2025-05-26 13:46:51', '2026-06-04 18:00:44.014', 50);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (19, '23', '{"id":19,"device_info":{"logicdevice_station.indoor_pollutant":["pm10_indoor","pm25_indoor"]},"name":"站房洁净度报警","description":"站房洁净度报警，根据站房颗粒物来判断","icon":"Battery","category":"gas","enabled":true,"configurable":true,"configs":[{"label":"PM10报警阈值","type":"number","value":30,"min":0,"max":100000,"step":0.01,"class":"pm10_indoor"},{"label":"PM2.5报警阈值","type":"number","value":20,"min":0,"max":100000,"step":0.01,"class":"pm25_indoor"}]}', 'admin', 'admin', '2025-11-11 16:07:59', '2026-03-19 09:11:41.367', 200);
INSERT INTO "public"."env_alarm_settings" ("id", "alarm_type", "setting_content", "created_by", "updated_by", "create_time", "update_time", "sort") VALUES (20, '22', '{"id":139,"device_info":{"sms-qc":["infrared_status"]},"name":"门禁报警","description":"当非法人员使用门禁时触发报警！","icon":"User","category":"security","enabled":true,"configurable":false}', 'admin', 'admin', '2026-06-05 06:32:28.186255', '2026-06-05 06:32:28.186255', 220);

-- 重置 env_alarm_settings 序列
SELECT setval(pg_get_serial_sequence('public.env_alarm_settings', 'id'), COALESCE((SELECT MAX(id) FROM "public"."env_alarm_settings"), 1), true);

-- =============================================
-- 2. env_device_settings
-- =============================================
DELETE FROM "public"."env_device_settings";

INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (2, '门禁', '0', 50, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.access_control","logoType":"door","onlineAttributeId":"lock_status","commandList":[{"commandName":"门禁控制","attributeId":"door_control","displayType":"command_stateless"},{"commandName":"当前门锁状态","attributeId":"lock_status","displayType":"value"}]}', 'logicdevice_station.access_control', 'admin', 'Admin7s9k2G5', '2025-05-27 09:16:08', '2026-05-27 10:30:01.768');
INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (6, '空调01', '0', 10, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.air_conditioner.ac1","logoType":"air-conditioner","online":true,"onlineAttributeId":"power_status","commandList":[{"commandName":"温度调节","attributeId":"setpoint_temp","displayType":"value_change","valueUtil":"℃","changeType":"int","changeStep":1,"changeNumberMax":30,"changeNumberMin":16,"changeNumberDecimal":1},{"commandName":"电源","attributeId":"power_status","displayType":"command"},{"commandName":"风机转速","attributeId":"fan_speed","displayType":"command"},{"commandName":"运行模式","attributeId":"running_mode","displayType":"command"}]}', 'logicdevice_station.air_conditioner.ac1', 'admin', 'admin', '2025-05-27 09:06:05', '2025-11-03 16:45:20.435');
INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (7, '空调02', '0', 20, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.air_conditioner.ac2","logoType":"air-conditioner","online":true,"onlineAttributeId":"power_status","commandList":[{"commandName":"温度调节","attributeId":"setpoint_temp","displayType":"value_change","valueUtil":"℃","changeType":"int","changeStep":1,"changeNumberMax":30,"changeNumberMin":16,"changeNumberDecimal":1},{"commandName":"电源","attributeId":"power_status","displayType":"command"},{"commandName":"风机转速","attributeId":"fan_speed","displayType":"command"},{"commandName":"运行模式","attributeId":"running_mode","displayType":"command"}]}', 'logicdevice_station.air_conditioner.ac2', 'admin', 'admin', '2025-05-27 09:08:06', '2025-11-03 16:45:38.93');
INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (3, '室内灯光', '0', 30, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.lighting","logoType":"light","onlineAttributeId":"switch_status","commandList":[{"commandName":"电源","attributeId":"switch_status","displayType":"command"}]}', 'logicdevice_station.lighting', 'admin', 'admin', '2025-05-27 09:09:21', '2025-11-03 16:45:52.869');
INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (4, '排风扇', '0', 40, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.exhaust_fan","logoType":"fan","onlineAttributeId":"speed","commandList":[{"commandName":"电源","attributeId":"speed","displayType":"command"}]}', 'logicdevice_station.exhaust_fan', 'admin', 'admin', '2025-05-27 09:13:31', '2025-11-03 16:46:19.95');
INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (5, '智能稳压电源', '0', 73, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.voltage_regulator","logoType":"power","onlineAttributeId":"relay_ch1","commandList":[{"commandName":"第一路继电器","attributeId":"relay_ch1","displayType":"command"},{"commandName":"第二路继电器","attributeId":"relay_ch2","displayType":"command"},{"commandName":"第三路继电器","attributeId":"relay_ch3","displayType":"command"},{"commandName":"第四路继电器","attributeId":"relay_ch4","displayType":"command"}]}', 'logicdevice_station.voltage_regulator', 'admin', 'admin', '2025-06-23 09:36:27', '2025-11-03 16:48:38.031');
INSERT INTO "public"."env_device_settings" ("id", "device_name", "device_type", "sort", "setting_content", "device_id", "created_by", "updated_by", "create_time", "update_time") VALUES (1, '智能采样管', '0', 60, '{"deviceType":"logicDevice","deviceId":"logicdevice_station.sampling_tube","logoType":"tube","onlineAttributeId":"heating_actual_temp","commandList":[{"commandName":"实时加热温度","attributeId":"heating_actual_temp","displayType":"value","valueUtil":"℃"},{"commandName":"加热温度调节","attributeId":"heating_set_temp","displayType":"value_change","valueUtil":"℃","changeType":"int","changeStep":5,"changeNumberMax":50,"changeNumberMin":30,"changeNumberDecimal":0}]}', 'logicdevice_station.sampling_tube', 'admin', 'admin', '2025-06-23 09:14:38', '2025-11-03 16:47:54.951');

-- 重置 env_device_settings 序列
SELECT setval(pg_get_serial_sequence('public.env_device_settings', 'id'), COALESCE((SELECT MAX(id) FROM "public"."env_device_settings"), 1), true);

-- =============================================
-- 3. sys_job：同步实时表/历史表分表任务 status
--    init 后,新pg需要关闭这两条分表任务 status 可能为 0 启用，统一更新为 1 关闭
--    init 后,质控报告生成时间调整到每日 00:05:00
--    init 后,调整四气态的每个零或跨默认 间隔30分钟
-- =============================================
UPDATE "public"."sys_job"
SET "status" = '1',
    "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" IN (11, 12)
   OR ("job_name" IN ('实时表分表', '历史表分表')
       AND "job_group" = 'CreatePartitionTablesTask');

UPDATE "public"."sys_job"
SET "cron_expression" = '0 5 0 * * ?',
    "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" IN (15)
   OR ("job_name" IN ('质控报告定时自动生成')
    AND "job_group" = 'DEFAULT');


UPDATE "public"."sys_job" SET "cron_expression" = '0 0 3 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 21 OR ("job_name" = '零点检查-SO2' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 30 3 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 27 OR ("job_name" = '跨度检查-SO2' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 0 4 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 23 OR ("job_name" = '零点检查-O3' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 30 4 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 28 OR ("job_name" = '跨度检查-O3' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 0 5 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 24 OR ("job_name" = '零点检查-CO' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 30 5 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 26 OR ("job_name" = '跨度检查-CO' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 0 6 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 22 OR ("job_name" = '零点检查-NO2' AND "job_group" = 'QualityControl');
UPDATE "public"."sys_job" SET "cron_expression" = '0 30 6 * * ?', "update_time" = CURRENT_TIMESTAMP
WHERE "job_id" = 25 OR ("job_name" = '跨度检查-NO2' AND "job_group" = 'QualityControl');


-- =============================================
-- 4. env_material_manager：更新滤纸带错别字
-- =============================================
DELETE FROM "public"."env_material_manager";

INSERT INTO "public"."env_material_manager" VALUES (1, 'CO-102NSDIU2', 'CO钢瓶气', '1', 'ASDN50MPA', 'XX公司', '2025-06-01', '2025-07-01', '2025-06-09 17:51:16', 8.000, 'L', 8.000, 1, '设备旁边', NULL, 'admin', 'admin', '2025-06-09 17:52:27', '2025-06-09 17:55:07', '{"concentration":6012000,"pressureAutoLastTime":"2026-08-14 00:00:00","pressureRemain":"10000.0","total_pressure":"11000"}');
INSERT INTO "public"."env_material_manager" VALUES (2, 'SO2-SUI2SIX', 'SO2钢瓶气', '2', 'ASDASD50MP', 'XX公司', '2025-06-01', '2025-07-01', '2025-06-09 17:52:31', 8.000, 'L', 8.000, 1, '设备旁边', NULL, 'admin', 'admin', '2025-06-09 17:53:07', '2025-08-06 15:42:38', '{"concentration":60360,"pressureAutoLastTime":"2026-08-14 00:00:00","pressureRemain":"10000.0","total_pressure":"11000"}');
INSERT INTO "public"."env_material_manager" VALUES (3, 'NO--SD92NX', 'NOx钢瓶气', '3', '1313SADA', 'XX公司', '2025-06-01', '2025-07-01', '2025-06-09 17:53:10', 8.000, 'L', 8.000, 1, '设备旁边', NULL, 'admin', 'admin', '2025-06-09 17:53:46', '2025-08-06 15:42:40', '{"concentration":60400,"pressureAutoLastTime":"2026-08-14 00:00:00","pressureRemain":"10000.0","total_pressure":"11000"}');
INSERT INTO "public"."env_material_manager" VALUES (4, 'PM25-23SDASDM', 'PM2.5滤纸带', '5', 'ER23', '赛默森', '2025-06-01', '2025-07-01', '2025-06-09 17:54:25', 800.000, '个', 780.000, 1, 'PM2.5设备', NULL, 'admin', 'admin', '2025-06-09 17:54:58', '2025-08-06 15:42:42', '');
INSERT INTO "public"."env_material_manager" VALUES (5, '测试PM10', 'PM10滤纸带', '4', '撒旦撒', '赛默森', '2025-06-01', '2025-07-01', '2025-06-09 17:55:14', 800.000, '个', 8.000, 2, 'PM10设备', NULL, 'admin', 'admin', '2025-06-09 17:55:40', '2025-09-10 09:06:27', '{}');
INSERT INTO "public"."env_material_manager" VALUES (6, 'PM10-ZD-2193SNDN', 'PM10滤纸带', '4', 'SDWQE', '赛默森', '2025-06-01', '2025-07-01', '2025-06-09 17:53:48', 800.000, '个', 780.000, 1, 'PM10设备', NULL, 'admin', 'admin', '2025-06-09 17:54:24', '2025-09-10 09:06:29', '');

-- 重置 env_material_manager 序列
SELECT setval(pg_get_serial_sequence('public.env_material_manager', 'id'), COALESCE((SELECT MAX(id) FROM "public"."env_material_manager"), 1), true);


-- =============================================
-- 5. sys_menu：隐藏系统监控和系统工具,调整日志管理菜单
-- =============================================
UPDATE "public"."sys_menu"
SET "visible" = '1',
    "update_time" = CURRENT_TIMESTAMP
WHERE "menu_id" IN (2, 3, 2073)
   OR ("menu_name" IN ('系统监控', '系统工具', '日志管理')
    AND "menu_type" = 'M'
    AND "parent_id" = '0');

UPDATE "public"."sys_menu"
SET "visible" = '1',
    "update_time" = CURRENT_TIMESTAMP
WHERE "menu_id" IN (105, 106)
   OR ("menu_name" IN ('字典管理', '参数设置')
    AND "menu_type" = 'C'
    AND "parent_id" = '1');

UPDATE "public"."sys_menu"
SET "parent_id" = 108,
    "update_time" = CURRENT_TIMESTAMP
WHERE "menu_id" IN (500)
   OR ("menu_name" IN ('操作日志')
    AND "menu_type" = 'C'
    AND "parent_id" = '2073');

COMMIT;


-- ADM 鉴权权限行（决策 C，2026-08-08；AC14 全对齐 2026-08-08 bug-record-20260808-231014）：
-- env-air-device-manager 全部 controller 逐方法 @PreAuthorize 的权限 key（含 AirDeviceController /air_device/* 11 端点）。
-- 落 ruoyi sys_menu（perm 管理用；菜单显示由动态 jar module-config.json 负责，故本处仅建隐藏父目录 + F 按钮 perms，不重复侧边栏）。
-- 库：ruoyi 主库（PostgreSQL）public schema。app 不自动跑；运维执行，幂等（DO 块守卫，可重跑——重复执行不报错不重复插）。
-- admin 角色（role_id=1）授予全部 adm:* —— admin 用户(user_id=1)持 *:*:* 通配本就全过，此授权让【非 user_id=1 的 admin 角色用户】也获得 adm:*（ruoyi:仅 user_id=1 isAdmin 享 *:*:*，其余用户走角色 menu perms）。
-- 非本批权限的用户 → @PreAuthorize 403（E2E-10 边界；adm:device:edit 缺失 → /air_device 写端点 403，防低权篡改设备绑定拓扑）。

DO $$
DECLARE
p text;
    mid bigint;
    parent bigint;
BEGIN
    -- 隐藏父目录（visible='1' 隐藏，避与 module-config 菜单重复；仅作 perm 分组容器）
SELECT menu_id INTO parent FROM sys_menu WHERE menu_name = '空气设备管理(权限)' AND menu_type = 'M';
IF parent IS NULL THEN
        parent := (SELECT coalesce(max(menu_id), 0) + 1 FROM sys_menu);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache,
                     menu_type, visible, status, perms, icon, create_time, update_time, remark)
VALUES (parent, '空气设备管理(权限)', 0, 90, 'adm-perm', NULL, '', 1, 0,
        'M', '1', '0', '', '#', now(), now(),
        'ADM 监控权限父目录(隐藏:visible=1);菜单显示走动态 jar module-config.json,此仅 sys_menu perm 管理容器');
END IF;

    -- 18 个 adm:* 权限（F 按钮）+ 授 admin 角色
    FOREACH p IN ARRAY ARRAY[
        'adm:monitor:list',
        'adm:alarm:list',
        'adm:changerecord:list',
        'adm:rulelimit:list', 'adm:rulelimit:add', 'adm:rulelimit:remove',
        'adm:alarmrule:list', 'adm:alarmrule:add',
        'adm:manualtag:list', 'adm:manualtag:add', 'adm:manualtag:edit',
        'adm:backfill:add', 'adm:backfill:list',
        'adm:device:list', 'adm:device:edit',
        'adm:displayunit:list', 'adm:displayunit:add', 'adm:displayunit:remove'
    ] LOOP
        -- 权限行不存在则建
        IF NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = p) THEN
            mid := (SELECT coalesce(max(menu_id), 0) + 1 FROM sys_menu);
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache,
                     menu_type, visible, status, perms, icon, create_time, update_time, remark)
VALUES (mid, p, parent, 0, '', NULL, '', 1, 0,
        'F', '0', '0', p, '#', now(), now(),
        'ADM 权限(决策C @PreAuthorize,见 requirements §4.5)');
END IF;
        -- 授 admin 角色(role_id=1)
        IF NOT EXISTS (SELECT 1 FROM sys_role_menu rm JOIN sys_menu m ON rm.menu_id = m.menu_id
                       WHERE rm.role_id = 1 AND m.perms = p) THEN
            INSERT INTO sys_role_menu(role_id, menu_id)
            VALUES (1, (SELECT menu_id FROM sys_menu WHERE perms = p));
END IF;
END LOOP;
END $$;

-- 验证查询（运维跑后核）：select perms from sys_menu where perms like 'adm:%' order by perms;


-- ADM 监控业务表（限值/恒值规则 + 报警 + 变更追溯 + 人工打标）。
-- 库：ruoyi 主库（PostgreSQL）public schema。app 不自动跑（无 flyway）；运维执行，幂等。
-- 与 adm_data.sql（数据表）互补：本文件是 6 张业务配置/流水表，adm_data.sql 是 TimescaleDB 采样/统计。
--
-- 列清单严格对齐 mapper XML 的 <sql id="cols"> 与 resultMap（逐列交叉核对，不臆造列）：
--   类型约定与 adm_data.sql 一致：业务键 varchar(64)、时间 timestamptz（跨时区/回补不歧义）、数值 numeric(18,6)。
--   主键 BIGSERIAL；alarm 表主键名为 alarm_id（非 id，见 AdmAlarmMapper）。
--   索引按 mapper 实际查询条件派生（selectByLogicAttr/selectActiveByLogicAttr/selectList 等），非猜测。
-- 业务键统一 logic_device_unique_id（稳定 varchar，AdmLogicDeviceIds 常量；非运行时铸造 deviceId，跨环境稳定）。

-- ===== §1 限值规则 adm_rule_limit（界面 2；粒度 logic_device+attr 唯一）=====
-- min/max 同 NULL = 该参数不参与限值判定（不臆造 enabled 开关；约束由 service/mapper 强制）。
CREATE TABLE IF NOT EXISTS adm_rule_limit
(
    id                     BIGSERIAL    PRIMARY KEY,
    logic_device_unique_id varchar(64)  NOT NULL,                 -- 参数槽 uniqueId（AdmLogicDeviceIds 常量）
    attr_id                varchar(64)  NOT NULL,                 -- logic attr id（如 so2/concentration）
    min_value              numeric(18,6),                          -- 下限；NULL = 不设下限
    max_value              numeric(18,6),                          -- 上限；NULL = 不设上限
    limit_unit             varchar(32),                            -- 限值单位；判定时与采样 nativeUnit 换算后比
    throttle_minutes       integer,                                -- 报警频率限流周期（分钟）；NULL = 每次越界都记
    created_at             timestamptz   NOT NULL DEFAULT now(),   -- BaseEntity.createTime
    updated_at             timestamptz   NOT NULL DEFAULT now(),   -- BaseEntity.updateTime
    CONSTRAINT uk_rule_limit_logic_attr UNIQUE (logic_device_unique_id, attr_id)  -- mapper upsert ON CONFLICT 依赖
    );
COMMENT ON TABLE  adm_rule_limit IS 'ADM 限值规则;粒度(logic_device,attr)唯一;min/max 同 NULL=不判定;upsert 走 uk_rule_limit_logic_attr';
COMMENT ON COLUMN adm_rule_limit.throttle_minutes IS '报警限流周期(分钟);NULL=每次越界都记 alarm;非 NULL=同周期内同(device,attr)只记一次';

-- ===== §2 报警规则主表 adm_alarm_rule（界面 3；报警大类容器，恒值是当前判定算法；每参数槽一行）=====
-- 双阀:主表 enabled AND 子表 adm_alarm_rule_attr.enabled 都 true 才判定该 attr。
CREATE TABLE IF NOT EXISTS adm_alarm_rule
(
    id                     BIGSERIAL    PRIMARY KEY,
    logic_device_unique_id varchar(64)  NOT NULL,                 -- 参数槽 uniqueId
    enabled                boolean      NOT NULL DEFAULT false,    -- 主表总开关;false=该参数槽整体不参与恒值判定
    duration_minutes       integer      NOT NULL,                  -- 恒值判定连续采样周期(分钟);窗内波动小于容差才报恒值
    created_at             timestamptz   NOT NULL DEFAULT now(),
    updated_at             timestamptz   NOT NULL DEFAULT now(),
    CONSTRAINT uk_alarm_rule_logic UNIQUE (logic_device_unique_id)  -- mapper upsert ON CONFLICT 依赖;useGeneratedKeys 回填 id
    );
COMMENT ON TABLE adm_alarm_rule IS 'ADM 报警规则主表(报警大类容器,恒值是当前判定算法);每参数槽一行;双阀(主表 enabled AND 子表 attr enabled)';

-- ===== §3 报警规则子表 adm_alarm_rule_attr（attr 级开关）=====
-- 外键指向 adm_alarm_rule.id;ON DELETE CASCADE 因 attr 行无父表则无意义(父删则子删,防孤儿);service 亦显式 deleteByAlarmRuleId。
CREATE TABLE IF NOT EXISTS adm_alarm_rule_attr
(
    id                     BIGSERIAL    PRIMARY KEY,
    alarm_rule_id         bigint       NOT NULL,
    logic_device_unique_id varchar(64)  NOT NULL,                 -- 冗余存(主表也存)便单表查询
    attr_id                varchar(64)  NOT NULL,
    enabled                boolean      NOT NULL DEFAULT false,    -- 该 attr 是否参与恒值判定;与主表 enabled 双阀 AND
    created_at             timestamptz   NOT NULL DEFAULT now(),
    updated_at             timestamptz   NOT NULL DEFAULT now(),
    CONSTRAINT fk_alarm_rule_attr_parent FOREIGN KEY (alarm_rule_id) REFERENCES adm_alarm_rule(id) ON DELETE CASCADE,
    CONSTRAINT uk_alarm_rule_attr_logic_attr UNIQUE (alarm_rule_id, logic_device_unique_id, attr_id)  -- mapper upsert ON CONFLICT 依赖
    );
COMMENT ON TABLE adm_alarm_rule_attr IS 'ADM 报警规则子表(attr 级开关);FK adm_alarm_rule ON DELETE CASCADE;业务键(alarm_rule_id,logic_device,attr)唯一';

-- ===== §4 报警记录 adm_alarm（界面 4 列表）=====
-- alarmType/status/eventType 等存枚举 name() 字符串(不用 PG 枚举类型,避 DynamicJarLoader 误扫 AttributeStatus 反射)。
-- 主键名 alarm_id(非 id);ACTIVE→INACTIVE 时 update 补 end_time;created_by/updated_by 是 alarm 表独立审计列。
CREATE TABLE IF NOT EXISTS adm_alarm
(
    alarm_id               BIGSERIAL    PRIMARY KEY,              -- 主键名 alarm_id(非 id,见 AdmAlarmMapper resultMap)
    logic_device_unique_id varchar(64)  NOT NULL,
    attr_id                varchar(64)  NOT NULL,
    alarm_type             varchar(64)  NOT NULL,                 -- 异常类别(AttributeStatus 枚举 name(),如 ABNORMAL/OVER_UPPER_LIMIT)
    measured_value         numeric(18,6),                          -- 触发时实测值
    limit_value            numeric(18,6),                          -- 触发时阈值(min/max/容差),复盘用
    status                 varchar(16)  NOT NULL DEFAULT 'ACTIVE', -- 业务状态:ACTIVE(越界中)/INACTIVE(已恢复)
    start_time             timestamptz  NOT NULL,                  -- 越界开始时间;ACTIVE 报警起点;同身份续期时不动
    end_time               timestamptz,                            -- 越界结束时间;ACTIVE 时 NULL,INACTIVE 填恢复时刻(sweep 写)
    last_breach_time       timestamptz,                            -- 最近越限心跳时间;sweep 判闭依据(last_breach_time+窗口<now 则闭);同身份续期时 UPDATE 此列
    created_by             varchar(64),                            -- 创建人(alarm 表审计列,独立于 BaseEntity.createBy)
    updated_by             varchar(64),                            -- 更新人(alarm 表审计列)
    created_at             timestamptz  NOT NULL DEFAULT now(),
    updated_at             timestamptz  NOT NULL DEFAULT now()
    );
-- 限流查询 selectActiveByLogicAttr(logic_device,attr,alarm_type,status='ACTIVE' order start_time desc limit 1)+ 列表 selectList 复合条件
CREATE INDEX IF NOT EXISTS idx_alarm_logic_attr_type_status_time
    ON adm_alarm (logic_device_unique_id, attr_id, alarm_type, status, start_time DESC);
-- 身份去重硬兜底(D6 单一心跳窗模型):同一(logic_device,attr,alarm_type)同时只一条 ACTIVE。
-- 逻辑已保证 upsertOrExtend 续期不插新,此 partial unique index 防 bug/并发(同身份并发越限二选一)。
-- WHERE status='ACTIVE' 偏索引——已恢复(INACTIVE)行不占唯一约束位,历史可有多条同身份已闭记录。
CREATE UNIQUE INDEX IF NOT EXISTS uk_alarm_active_identity
    ON adm_alarm (logic_device_unique_id, attr_id, alarm_type)
    WHERE status = 'ACTIVE';
COMMENT ON TABLE  adm_alarm IS 'ADM 报警记录;D6 单一心跳窗模型——同身份(logic_device,attr,alarm_type)同时只一条 ACTIVE;upsertOrExtend 续期 last_breach_time 不插新;sweep 闭 last_breach_time+窗口<now 的 ACTIVE;alarm_type/status 存枚举 name() 字符串(避 DynamicJarLoader 扫枚举)';
COMMENT ON COLUMN adm_alarm.status IS 'ACTIVE=越界中;INACTIVE=已恢复;DDL 默认 ACTIVE(mapper insert 亦显式传)';
COMMENT ON COLUMN adm_alarm.last_breach_time IS '最近越限心跳时间(D6 心跳窗模型);sweep 判闭依据(last_breach_time+throttle_minutes<now 则闭);同身份续期时 UPDATE 此列+measured_value,start_time 不动';

-- ===== §5 设备变更追溯 adm_device_change_record（界面 5;append-only 审计流水,无 updated_at）=====
-- eventType 5 种:FIRST_BIND/REBIND/REPLACE/UNBIND/RECONFIGURE;仅 REPLACE 填 prev_physical_device_unique_id。
-- append-only:无 updated_at(只 created_at);不做 in-place 更新。
CREATE TABLE IF NOT EXISTS adm_device_change_record
(
    id                            BIGSERIAL    PRIMARY KEY,
    logic_device_unique_id        varchar(64)  NOT NULL,
    attr_id                       varchar(64)  NOT NULL,
    event_type                    varchar(32)  NOT NULL,          -- FIRST_BIND/REBIND/REPLACE/UNBIND/RECONFIGURE
    physical_device_unique_id     varchar(64),                     -- 变更后物理设备 uniqueId;UNBIND 时 NULL
    prev_physical_device_unique_id varchar(64),                    -- 变更前物理设备 uniqueId;仅 REPLACE 有值
    vendor                        varchar(64),                     -- 厂商(如 sailhero);固化审计避免后续改 entry 失真
    model                         varchar(64),                     -- 型号(如 XHS2000BV3)
    serial_number                 varchar(64),                     -- 序列号
    change_summary                text,                            -- 变更摘要(人类可读一句话)
    operator                      varchar(64),                     -- 操作者(用户名/系统标识)
    occurred_at                   timestamptz  NOT NULL,           -- 变更发生时间(业务时间,独立于 created_at 入库时间)
    created_at                    timestamptz  NOT NULL DEFAULT now()
    );
-- 列表 selectList(logic_device,attr + occurred_at 时间段,order occurred_at desc)
CREATE INDEX IF NOT EXISTS idx_change_logic_attr_time
    ON adm_device_change_record (logic_device_unique_id, attr_id, occurred_at DESC);
COMMENT ON TABLE adm_device_change_record IS 'ADM 设备变更追溯(append-only 审计);occurred_at 业务时间;仅 REPLACE 填 prev_physical_device_unique_id;无 updated_at';

-- ===== §6 人工打标主表 adm_manual_tag（界面 6;无 status 列,四态由时间推导;无 updated_at）=====
-- 四态(运行时推导,canceled_at 优先于 actual_end,两者互斥):
--   已取消=canceled_at IS NOT NULL(无论时间窗,作废/误标);
--   已结束=canceled_at IS NULL AND actual_end IS NOT NULL(维护/校准正常提前完成);
--   进行中=canceled_at IS NULL AND actual_end IS NULL AND now∈[started_at,planned_end_at];
--   已过期=canceled_at IS NULL AND actual_end IS NULL AND now>planned_end_at。到点(过期)不写 canceled_at 也不写 actual_end。
CREATE TABLE IF NOT EXISTS adm_manual_tag
(
    id                     BIGSERIAL    PRIMARY KEY,
    logic_device_unique_id varchar(64)  NOT NULL,
    tag_type               varchar(64)  NOT NULL,                 -- 打标类型(AttributeStatus 枚举 name(),如 MAINTENANCE/CALIBRATION)
    started_at             timestamptz  NOT NULL,                  -- 打标开始时间(窗起点)
    planned_end_at         timestamptz  NOT NULL,                  -- 计划结束时间(窗终点;到点不写 canceled_at 也不写 actual_end)
    actual_end             timestamptz,                            -- 实际结束时间;NULL=未结束;维护/校准正常提前完成时人为填(区别于 canceled_at 作废)
    canceled_at            timestamptz,                            -- 取消时间;NULL=未取消;仅人为主动作废时填
    operator               varchar(64),                            -- 操作者(用户名)
    remark                 text,                                   -- 备注(人工说明)
    created_at             timestamptz  NOT NULL DEFAULT now()
    );
-- 列表 selectList(logic_device,tag_type,started_at 时间段)+ 冲突/进行中查询(均 canceled_at IS NULL AND actual_end IS NULL 子集)
CREATE INDEX IF NOT EXISTS idx_tag_logic_started ON adm_manual_tag (logic_device_unique_id, started_at DESC);
CREATE INDEX IF NOT EXISTS idx_tag_active_overlap ON adm_manual_tag (logic_device_unique_id, started_at, planned_end_at)
    WHERE canceled_at IS NULL;  -- 偏索引覆盖"未取消"超集;selectActiveOverlapping/selectAllInProgress 在此基础上再过滤 actual_end IS NULL
COMMENT ON TABLE  adm_manual_tag IS 'ADM 人工打标主表;无 status 列(四态由时间推导);canceled_at 作废/actual_end 正常结束(互斥,仅人为填);过期不填两者;tag_type 存枚举 name()';
COMMENT ON COLUMN adm_manual_tag.actual_end IS '实际结束时间;NULL=未结束;维护/校准正常提前完成时人为填,区别于 canceled_at(作废);过期(到点)不写此处(自然推进结果)';
COMMENT ON COLUMN adm_manual_tag.canceled_at IS '取消时间;NULL=未取消;仅人为主动作废填,过期(到点)不写此处(自然时间推进结果)';

-- ===== §7 人工打标子表 adm_manual_tag_attr（打标作用的 attr 列表;无 updated_at）=====
-- 外键指向 adm_manual_tag.id;ON DELETE CASCADE(父删则子删,防孤儿,attr 行无父表则无意义)。
CREATE TABLE IF NOT EXISTS adm_manual_tag_attr
(
    id                     BIGSERIAL    PRIMARY KEY,
    manual_tag_id          bigint       NOT NULL,
    logic_device_unique_id varchar(64)  NOT NULL,                 -- 冗余存便单表查询
    attr_id                varchar(64)  NOT NULL,
    created_at             timestamptz  NOT NULL DEFAULT now(),
    CONSTRAINT fk_manual_tag_attr_parent FOREIGN KEY (manual_tag_id) REFERENCES adm_manual_tag(id) ON DELETE CASCADE,
    CONSTRAINT uk_manual_tag_attr_tag_logic_attr UNIQUE (manual_tag_id, logic_device_unique_id, attr_id)
    );
COMMENT ON TABLE adm_manual_tag_attr IS 'ADM 人工打标子表(打标作用的 attr 列表);FK adm_manual_tag ON DELETE CASCADE;业务键(manual_tag_id,logic_device,attr)唯一';

-- ===== §8 历史回补 job adm_backfill_job（回补上传页历史表，2026-08-08 新增）=====
-- 用户每次上传分钟级 Excel/CSV = 一条 job；持久化（重启不丢），异步推进 RUNNING→SUCCESS/FAILED。
-- 完全异步：上传即建 RUNNING job 返 jobId，后台 parse→insert→refresh 推进进度。
-- status/phase 存字符串（RUNNING/SUCCESS/FAILED/PAUSED/CANCELLED + PARSING/INSERTING/REFRESHING/RECOMPUTING），不用 PG 枚举（避 DynamicJarLoader 扫枚举）。
-- 2026-08-11 扩展为通用微批 job 表：job_type 判别上传(BACKFILL_UPLOAD) / 手动窗口重算(MANUAL_RECOMPUTE) / 配置切换全量重算(REINIT_PRIME)；
--   重算 job 走微批循环（AdmMicroBatchWindowSplitter 拆批 + engine.materialize 逐批），二维进度 planned_granularities/current_granularity/last_completed_batch_end 精准定位续算位点。
CREATE TABLE IF NOT EXISTS adm_backfill_job
(
    job_id        varchar(64)  PRIMARY KEY,                 -- uuid（上传时生成；非自增，异步 jobId 须上传即返）
    file_name     varchar(255),                             -- 上传文件名（原文件名，审计）；仅 BACKFILL_UPLOAD 有值，MANUAL_RECOMPUTE/REINIT_PRIME 无文件=NULL
    file_size     bigint,                                   -- 文件字节数；仅 BACKFILL_UPLOAD 有值，重算类 job=NULL
    status        varchar(16)  NOT NULL DEFAULT 'RUNNING',  -- RUNNING/SUCCESS/FAILED
    phase         varchar(16),                              -- 当前阶段 PARSING/INSERTING/REFRESHING（RUNNING 时）
    total_rows    integer      NOT NULL DEFAULT 0,          -- 解析总行数
    success_rows  integer      NOT NULL DEFAULT 0,          -- 成功落库行数
    fail_rows     integer      NOT NULL DEFAULT 0,          -- 行级错误行数（容错导入，非整批失败）
    window_start  timestamptz,                              -- 上传采样 min(data_time)（回算 stat 重物化窗下界）
    window_end    timestamptz,                              -- 上传采样 max(data_time)（回算 stat 重物化窗上界）
    progress      integer      NOT NULL DEFAULT 0,          -- 0-100（阶段+行数折算）
    error_summary text,                                     -- 失败摘要（parse/零有效行/refresh 异常；行级错误取前 N 条）
    job_type                  varchar(20)  NOT NULL DEFAULT 'BACKFILL_UPLOAD',  -- job 类型判别（BACKFILL_UPLOAD=回补上传 / MANUAL_RECOMPUTE=手动窗口重算 / REINIT_PRIME=配置切换全量重算）；创建后不可变，INSERT 时定
    planned_granularities     varchar(64),                              -- 重算 job 须重算的粒度列表（逗号拼接 StatGranularity 名，如 MINUTE,5MIN,HOUR,DAY）；BACKFILL_UPLOAD 为 NULL（走单趟 refresh 不走微批循环）；二维进度第 1 维（哪些粒度要做）
    current_granularity       varchar(8),                               -- 当前正在重算的粒度（StatGranularity 名）；二维进度第 1 维指针（planned 列表定位）；开始前/该粒度完成后为 NULL
    last_completed_batch_end  timestamptz,                              -- 当前粒度内最后完成的微批终点（timestamptz=UTC 存储 ISO 8601，应用层用统一时间 utils 解析/换算）；二维进度第 2 维指针（粒度内续算位点，下批从此点 split）；该粒度未开始/已完成时为 NULL
    created_by    varchar(64),
    updated_by    varchar(64),
    created_at    timestamptz  NOT NULL DEFAULT now(),
    updated_at    timestamptz  NOT NULL DEFAULT now()
    );
-- 历史表查询 selectList（status 筛选 + created_at 倒序分页）
CREATE INDEX IF NOT EXISTS idx_backfill_job_status_created
    ON adm_backfill_job (status, created_at DESC);
COMMENT ON TABLE  adm_backfill_job IS 'ADM 历史回补/重算 job 记录(通用微批 job 表);job_type 判别 BACKFILL_UPLOAD=回补上传 / MANUAL_RECOMPUTE=手动窗口重算 / REINIT_PRIME=配置切换全量重算;持久化重启不丢;status RUNNING/SUCCESS/FAILED + PAUSED(暂停可续) / CANCELLED(取消终态);phase PARSING/INSERTING/REFRESHING(上传) + RECOMPUTING(重算微批);二维进度 planned_granularities(第1维 哪些粒度) + current_granularity(第1维指针) + last_completed_batch_end(第2维 粒度内续算位点);所有 timestamptz 列 UTC 存储 ISO 8601,应用层用统一时间 utils 解析/换算';
COMMENT ON COLUMN adm_backfill_job.job_id IS 'uuid;非自增(异步须上传即返 jobId);controller POST /upload 生成';
COMMENT ON COLUMN adm_backfill_job.window_start IS '上传采样的 min(data_time);回算 stat 重物化窗口下界;路径 A/B 各自 engine.materialize 全 4 级 over 该窗';
COMMENT ON COLUMN adm_backfill_job.fail_rows IS '行级错误行数(容错导入非整批失败);非法槽/attr/时间/value 类型/未知标记的行计此,明细入 error_summary';
COMMENT ON COLUMN adm_backfill_job.job_type IS 'job 类型判别(BACKFILL_UPLOAD/MANUAL_RECOMPUTE/REINIT_PRIME);创建后不可变 INSERT 时定;决定走哪条处理路径(上传=parse+insert+单趟 refresh / 重算=微批循环 engine.materialize)';
COMMENT ON COLUMN adm_backfill_job.planned_granularities IS '重算 job 须重算的粒度列表(逗号拼接 StatGranularity 名,如 MINUTE,5MIN,HOUR,DAY);二维进度第 1 维(哪些粒度要做);BACKFILL_UPLOAD 为 NULL(走单趟 refresh)';
COMMENT ON COLUMN adm_backfill_job.current_granularity IS '当前正在重算的粒度(StatGranularity 名);二维进度第 1 维指针(planned 列表定位);开始前/该粒度完成后为 NULL';
COMMENT ON COLUMN adm_backfill_job.last_completed_batch_end IS '当前粒度内最后完成的微批终点(timestamptz=UTC ISO 8601);二维进度第 2 维指针(粒度内续算位点,下批从此点 split);该粒度未开始/已完成时为 NULL';

-- ===== §7 展示单位偏好 adm_display_unit_pref（已废，bug-record-20260812-162223）=====
-- 读写表分裂根因：本表曾作单位偏好写入口，但读出口（snapshot/SSE/history）已迁 adm_config_unit（MONITOR/HISTORY purpose 行），
-- 写偏读正中 bug。表 + AdmDisplayUnitPref entity + AdmDisplayUnitPrefMapper 已删，偏好读写统一在 adm_config_unit（DDL 见 §6.7）。


-- ADM 监控数据表（TimescaleDB：实时明细 hypertable + 分钟/5分/时/日 PG 声明式月度分区父表[app 自管物化 + app 自管分区 ensure] + 全局/每参数/审计配置表 + 压缩 + retention）。
-- 库：ruoyi 主库（PostgreSQL）public schema + TimescaleDB 扩展。app 不自动跑（无 flyway）；运维执行。
-- 前置：CREATE EXTENSION IF NOT EXISTS timescaledb;（本文件首行已含，幂等）
-- 业务键：logic_device_unique_id + attr_id（非运行时 deviceId；AdmLogicDeviceIds 常量 + AttrIdDevice 常量，重启稳定）。
-- 设计要点（2026-08-11 可配置聚合引擎重构；2026-08-14 stat 月度分区化）：四级 stat **PG 声明式月度分区父表 +
--   app 自管物化 + app 自管分区 ensure**（AdmStatPartitionManager 写路径三时机收口；minute←raw, 5min←minute, hour←minute,
--   day←hour），支撑 §3.7 统计有效条数门控——每级物化 avg_value/avg_value_valid/valid_count/total_count，有效性按「有效子桶数」向上传播；
--   物化由 app 调度器/回补/reconfig 触发（INSERT…SELECT + ON CONFLICT upsert，非数据库自动 refresh policy）；区间模式 interval_mode 进 PK
--   支持多 mode 并存（BACK (L,R] / FRONT [S,E)，HJ663 国标用 BACK）；多标记用 statuses_text 冗余列 + string_agg(DISTINCT) 聚合；
--   raw 压缩 7 天回补窗口 + 2 年 retention（Timescale）；stat 表月度裸分区长期保留供历史查询与上报
--   （2026-08-14 去压缩改分区：月表直接 UPDATE，回补免 decompress→modify→recompress 三步舞）。
-- 旧 4 级连续聚合视图（adm_data_stat_minute/_5min/_hour/_day，原 TimescaleDB CAGG）已 DROP（HJ663 (L,R] 与固定 [S,E) time_bucket 模型级互斥，已实证）。

CREATE EXTENSION IF NOT EXISTS timescaledb;

-- ===== §3.3 adm_data_sample — 实时明细 hypertable（raw，完全不动）=====
-- 一行 = 一设备 + 一参数 + 一值 + 多标记 + 一时间（纵表，参数增减=加行不动表结构）
-- raw.unit 存 UnitInfo.getName()（采样时采集原生单位符号，如 ug/m3 ASCII）；stat 物化首级 raw→minute 换算源。
CREATE TABLE adm_data_sample
(
    logic_device_unique_id varchar(64)  NOT NULL,            -- 参数槽 uniqueId（AdmLogicDeviceIds 常量）
    attr_id                varchar(64)  NOT NULL,            -- logic attr id（AttrIdDevice 常量）
    data_time             timestamptz  NOT NULL,            -- 采样时间（hypertable 分区列；datetime 语义用 timestamptz 保证回补跨时区不歧义）
    value_num              numeric(18,6),                     -- 数值业务值（浓度/风速等；文本参数为 NULL）
    value_text             text,                              -- 文本业务值（少数文本参数；数值参数为 NULL）
    statuses               text[]       NOT NULL,             -- 多标记快照（AttributeStatus 枚举名数组，registry 全量，含 POLL）；支持 GIN 索引按标记查历史
    statuses_text          text         NOT NULL,             -- statuses 规范化排序逗号拼接冗余列（写时由 statuses 排序去重生成，如 'CALIBRATION,OVER_UPPER_LIMIT'）；专为 stat 物化 string_agg 聚合（app 物化 SQL 聚合，非数据库自动聚合）
    unit                   varchar(32),                       -- 业务单位（UnitInfo.getName() 原生符号，denormalized 便纵表自洽 + raw→minute 换算源）
    source                 varchar(16)  NOT NULL DEFAULT 'POLL' -- 数据来源标记：POLL=实时采集 / BACKFILL=用户回补导入
);

-- 分区为 hypertable（按 data_time，1 day 一个 chunk）；if_not_exists 使脚本可重跑
SELECT create_hypertable('adm_data_sample', 'data_time', chunk_time_interval => INTERVAL '1 day', if_not_exists => TRUE);

-- 启用列存压缩：segmentby 这两列加速「按设备+参数+时间段」的压缩存储与查询。
-- 正确 API 是 ALTER TABLE ... SET (timescaledb.compress, ...)；create_compression_hypertable
-- 不是 TimescaleDB 合法函数（曾误用，致本脚本整文件隐式事务回滚、表与连续聚合视图全未建）。
ALTER TABLE adm_data_sample SET (
    timescaledb.compress,
    timescaledb.compress_segmentby = 'logic_device_unique_id, attr_id',
    timescaledb.compress_orderby   = 'data_time DESC'
    );

-- 普通查询索引（未压缩区 + segmentby 已覆盖压缩区主路径）；IF NOT EXISTS 使脚本可重跑
CREATE INDEX IF NOT EXISTS idx_sample_logic_attr_time ON adm_data_sample (logic_device_unique_id, attr_id, data_time DESC);
-- 按标记查历史（如"所有 CALIBRATION 采样"）；GIN 支持 text[] 包含查询
CREATE INDEX IF NOT EXISTS idx_sample_statuses_gin ON adm_data_sample USING GIN (statuses);

COMMENT ON COLUMN adm_data_sample.data_time IS '采样时间;hypertable 分区列;datetime 语义用 timestamptz 实现(回补跨时区/夏令时不歧义,TimescaleDB 对 timestamptz 分区支持最完整)';
COMMENT ON COLUMN adm_data_sample.statuses IS '该采样时刻 registry 全量多标记快照(AttributeStatus 枚举名数组,含 POLL/NORMAL);多标记贯穿实时层;回补数据则取导入时刻的标记;支持 GIN 索引按标记查历史';
COMMENT ON COLUMN adm_data_sample.statuses_text IS 'statuses 规范化排序逗号拼接冗余列;专为 stat 物化 string_agg 聚合(app 物化 SQL,非数据库自动聚合;写时由 statuses Set 排序生成,两列同源)';
COMMENT ON COLUMN adm_data_sample.unit IS 'UnitInfo.getName() 原生单位符号(如 ug/m3 ASCII / °C / W/m²);raw→minute 首级物化换算源;非 getFullUnitString key 形式(此处存符号便纵表自洽+审计)';
COMMENT ON COLUMN adm_data_sample.source IS 'POLL=驱动实时采集写入;BACKFILL=用户历史回补导入写入;区分两类便于审计 + 回补回算定位';

-- ===== drop 旧 4 级连续聚合视图（HJ663 (L,R] 与固定 [S,E) time_bucket 模型级互斥，物理退场）=====
-- DROP...CASCADE 是清旧 CAGG 及其依赖 refresh job 的正规机制（幂等 IF EXISTS，CASCADE 连带删 refresh policy job）。
-- 历史曾配 DELETE FROM timescaledb_information.jobs 做「双保险」清残留 refresh job，但 timescaledb_information.jobs
-- 是视图不可 DELETE（psycopg2 apply 报 ObjectNotInPrerequisiteState: cannot delete from view "jobs"），
-- 且 CAGG 物理退场后无残留 refresh job 需清，故移除该 DELETE；如未来确有孤儿 job 须清，用 remove_job(job_id) 非 DELETE。
DROP MATERIALIZED VIEW IF EXISTS adm_data_stat_day   CASCADE;
DROP MATERIALIZED VIEW IF EXISTS adm_data_stat_hour  CASCADE;
DROP MATERIALIZED VIEW IF EXISTS adm_data_stat_5min  CASCADE;
DROP MATERIALIZED VIEW IF EXISTS adm_data_stat_minute CASCADE;

-- ===== 重建 4 stat 分区父表（同名 + 物化列含双态门控 valid_count/total_count + PK[含 interval_mode] + 复合索引）=====
-- 分区父表替代旧连续聚合视图：物化由 app 调度器/回补/reconfig 触发（INSERT…SELECT + ON CONFLICT upsert），非数据库自动 refresh policy。
-- 物化列与旧连续聚合视图逐字一致（avg_value/avg_value_valid/min/max/sample_count/valid_count/total_count/statuses_summary/unit），
-- 双态门控查询层零改动。两处新增：① PRIMARY KEY（连续聚合视图无 PK，plain 表 upsert 必需）；② interval_mode smallint（进 PK 支持多 mode 并存）。
-- PK(data_time, series, interval_mode)：多 mode 并存下同桶 BACK/FRONT 各自独立一行；ON CONFLICT 按 4 列定冲突（回补/重算幂等）；
-- PG 声明式分区要求 PK 含分区键 data_time（满足，父表 PK/索引自动级联各月分区）。复合索引(series, mode, data_time DESC) 支撑历史查询主力（查询恒带 mode 等值过滤）。
-- 月度分区（2026-08-14 去压缩改分区）：PARTITION BY RANGE (data_time) 按 UTC 月一表（如 adm_data_stat_minute_202608，
--   data_time 是 UTC 网格存储故月边界按 UTC 对齐）；分区由 app 层 AdmStatPartitionManager.ensureStatPartitions 幂等
--   ensure（写路径三时机收口：引擎每粒度写前 / 启动当月+下月 / 回补提交前），不引 pg_partman（零部署依赖、时机可控）。
-- 不建 DEFAULT 分区（严格模式，有意为之）：缺分区时 INSERT 显式报错，暴露 ensure 收口漏洞——静默兜底会把漏调
--   掩盖成数据黑洞；SELECT 天然安全（PG 对缺分区只裁剪不报错），故只有写路径需要 ensure。
-- 本 DDL 只建父表不建任何分区：stat 是派生数据（raw 是真相源），部署后 reinit prime / recompute 全量重算时
--   分区由写路径 ensure 自动建（无生产环境，迁移走 drop+重建+recompute，不搬旧数据）。

-- 分钟统计（层级基础层 ← raw；物化时 FROM adm_data_sample）
CREATE TABLE IF NOT EXISTS adm_data_stat_minute (
                                                    data_time             timestamptz NOT NULL,   -- 桶标注（BACK=右沿 (L,R] 桶标=R / FRONT=左沿 [S,E) 桶标=S，由 engine 物化时按 interval_mode 定）
                                                    logic_device_unique_id varchar(64) NOT NULL,
    attr_id               varchar(64) NOT NULL,
    interval_mode         smallint    NOT NULL,   -- 区间模式(FRONT=1 前标[S,E) / BACK=2 后标(L,R],§7.1 AdmIntervalMode.code 作 DB↔enum 转换);进 PK 多 mode 并存
    avg_value        double precision,            -- 全量均值（未达阈值分支取）
    avg_value_valid  double precision,            -- §3.7 仅有效样本均值（达阈值分支取）
    min_value        double precision,
    max_value        double precision,
    sample_count     bigint,
    valid_count      bigint,                       -- §3.7 有效样本数（阈值分子）
    total_count      bigint,                       -- §3.7 非空值计数（minute 阈值分母）
    statuses_summary text,                         -- 规范化组合去重（app 物化 SQL string_agg(DISTINCT statuses_text, ',')）
    unit             varchar(64),                  -- STORAGE 业务标准单位（UnitInfo.getFullUnitString key 形式，物化时从 adm_config_unit STORAGE 行取；denormalize 便审计/降级展示）
    is_valid         boolean,                       -- 判定层（2026-08-11 S3 新增）：桶是否达本粒度有效阈值（minute marker-based / 5min≥0.75 / hour≥45 / day≥20）；级联父桶 mean-of-valid 只计 is_valid=true 子桶；前端不读此列（展示走 statuses_summary 标记层）
    CONSTRAINT pk_stat_minute PRIMARY KEY (data_time, logic_device_unique_id, attr_id, interval_mode)
    ) PARTITION BY RANGE (data_time);
CREATE INDEX IF NOT EXISTS idx_stat_minute_logic_attr_time
    ON adm_data_stat_minute (logic_device_unique_id, attr_id, interval_mode, data_time DESC);
COMMENT ON TABLE adm_data_stat_minute IS '分钟统计月度分区父表(层级基础层←raw;app 自管物化;PG 声明式 RANGE 分区按 UTC 月,分区由 AdmStatPartitionManager 写路径 ensure,无 DEFAULT 分区缺分区 INSERT 显式报错);§3.7 双态门控列 avg_value/avg_value_valid/valid_count/total_count;valid=有效样本(NORMAL+非空值);interval_mode 进 PK 多 mode 并存(BACK/FRONT);回补/reinit/调度 由 app INSERT…SELECT ON CONFLICT 自底向上重算;物化由 stat/engine/AdmStatAggregationEngine 驱动;is_valid 判定层（2026-08-11 S3，级联父桶 mean-of-valid 只计 is_valid=true 子桶，前端不读）;statuses_summary 标记层（前端展示，无效纯计数补 INSUFFICIENT）';

-- 5 分钟统计（层级 ← minute；子分钟有效占比≥75% 计为有效子桶；物化时 FROM adm_data_stat_minute）
CREATE TABLE IF NOT EXISTS adm_data_stat_5min (
                                                  data_time             timestamptz NOT NULL,
                                                  logic_device_unique_id varchar(64) NOT NULL,
    attr_id               varchar(64) NOT NULL,
    interval_mode         smallint    NOT NULL,
    avg_value        double precision,
    avg_value_valid  double precision,
    min_value        double precision,
    max_value        double precision,
    sample_count     bigint,
    valid_count      bigint,
    total_count      bigint,
    statuses_summary text,
    unit             varchar(64),
    is_valid         boolean,                       -- 判定层（2026-08-11 S3 新增）：5min 桶达有效子分钟占比≥0.75 阈值；级联 hour 物化时只计 is_valid=true 子桶；前端不读此列（展示走 statuses_summary 标记层）
    CONSTRAINT pk_stat_5min PRIMARY KEY (data_time, logic_device_unique_id, attr_id, interval_mode)
    ) PARTITION BY RANGE (data_time);
CREATE INDEX IF NOT EXISTS idx_stat_5min_logic_attr_time
    ON adm_data_stat_5min (logic_device_unique_id, attr_id, interval_mode, data_time DESC);
COMMENT ON TABLE adm_data_stat_5min IS '5分钟统计月度分区父表(层级←minute;子分钟有效占比≥75%计有效子桶;§3.7 输出阈值 valid_count/total_count≥0.75;mean-of-means 均值;PG 声明式月度分区,分区由 AdmStatPartitionManager ensure);interval_mode 进 PK 多 mode 并存;物化由 app INSERT…SELECT ON CONFLICT 驱动;is_valid 判定层（2026-08-11 S3，达占比≥0.75 阈值；级联 hour mean-of-valid 只计 true 子桶；前端不读）';

-- 小时统计（层级 ← minute；子分钟有效占比≥75% 计为有效子桶；输出阈值 valid_count≥45 GB/T 有效分钟；物化时 FROM adm_data_stat_minute）
CREATE TABLE IF NOT EXISTS adm_data_stat_hour (
                                                  data_time             timestamptz NOT NULL,
                                                  logic_device_unique_id varchar(64) NOT NULL,
    attr_id               varchar(64) NOT NULL,
    interval_mode         smallint    NOT NULL,
    avg_value        double precision,
    avg_value_valid  double precision,
    min_value        double precision,
    max_value        double precision,
    sample_count     bigint,
    valid_count      bigint,
    total_count      bigint,
    statuses_summary text,
    unit             varchar(64),
    is_valid         boolean,                       -- 判定层（2026-08-11 S3 新增）：hour 桶达有效分钟数≥45 阈值（GB/T）；级联 day 物化时只计 is_valid=true 子桶；O₃-8h 窗桶（attr_id=o3_8h）同口径（窗内有效小时≥6）；前端不读此列
    CONSTRAINT pk_stat_hour PRIMARY KEY (data_time, logic_device_unique_id, attr_id, interval_mode)
    ) PARTITION BY RANGE (data_time);
CREATE INDEX IF NOT EXISTS idx_stat_hour_logic_attr_time
    ON adm_data_stat_hour (logic_device_unique_id, attr_id, interval_mode, data_time DESC);
COMMENT ON TABLE adm_data_stat_hour IS '小时统计月度分区父表(层级←minute;子分钟有效占比≥75%计有效子桶;§3.7 输出阈值 valid_count≥45 GB/T 有效分钟;PG 声明式月度分区,分区由 AdmStatPartitionManager ensure);interval_mode 进 PK 多 mode 并存;物化由 app INSERT…SELECT ON CONFLICT 驱动;is_valid 判定层（2026-08-11 S3，达≥45 有效分钟阈值；级联 day mean-of-valid 只计 true 子桶；O₃-8h 窗桶 attr_id=o3_8h 同口径窗内≥6；前端不读）';

-- 日统计（层级 ← hour；子小时 valid_count≥45 计为有效子桶；输出阈值 valid_count≥20 GB/T 有效小时；物化时 FROM adm_data_stat_hour）
CREATE TABLE IF NOT EXISTS adm_data_stat_day (
                                                 data_time             timestamptz NOT NULL,
                                                 logic_device_unique_id varchar(64) NOT NULL,
    attr_id               varchar(64) NOT NULL,
    interval_mode         smallint    NOT NULL,
    avg_value        double precision,
    avg_value_valid  double precision,
    min_value        double precision,
    max_value        double precision,
    sample_count     bigint,
    valid_count      bigint,
    total_count      bigint,
    statuses_summary text,
    unit             varchar(64),
    is_valid         boolean,                       -- 判定层（2026-08-11 S3 新增）：day 桶达有效小时数≥20 阈值（GB/T）；O₃-8h 日桶（attr_id=o3_8h）同口径（17 窗有效窗≥13）；前端不读此列（展示走 statuses_summary 标记层）
    CONSTRAINT pk_stat_day PRIMARY KEY (data_time, logic_device_unique_id, attr_id, interval_mode)
    ) PARTITION BY RANGE (data_time);
CREATE INDEX IF NOT EXISTS idx_stat_day_logic_attr_time
    ON adm_data_stat_day (logic_device_unique_id, attr_id, interval_mode, data_time DESC);
COMMENT ON TABLE adm_data_stat_day IS '日统计月度分区父表(层级←hour;子小时 valid_count≥45 计有效子桶;输出阈值 valid_count≥20 GB/T 有效小时;PG 声明式月度分区,分区由 AdmStatPartitionManager ensure);interval_mode 进 PK 多 mode 并存;物化由 app INSERT…SELECT ON CONFLICT 驱动;is_valid 判定层（2026-08-11 S3，达≥20 有效小时阈值；O₃-8h 日桶 attr_id=o3_8h 同口径 17 窗≥13；前端不读）';

-- ===== stat 表压缩已移除（2026-08-14 月度分区化，替代旧 stat SET compress 块）=====
-- stat 四表改 PG 声明式月度分区裸表：月表内直接 UPDATE/DELETE（回补免 decompress→modify→recompress 三步舞，
-- 旧块曾致回补 M3-Phase8 双路径复杂化）；空间回收改 DROP TABLE 整月表。Timescale 压缩仅保留 raw（adm_data_sample）。

-- ===== refresh policy 已删（连续聚合视图退场，refresh 改 app 调度器 AdmStatRefreshScheduler）=====

-- ===== §6.6 adm_config_stat — 全局运行时配置（KV 一项一行；决策7）=====
-- 运行时可改（无需重启 core）；@Value 启动期一次性读做不到运行时改，故 DB 化。
-- KV 读取 SELECT config_key,config_value 成 Map，按 key 严格解析类型（非法抛不兜底）。
CREATE TABLE adm_config_stat (
                                 config_key   varchar(64) PRIMARY KEY,            -- 配置项名
                                 config_value varchar(255) NOT NULL,              -- 配置值(文本;按 key 由 app 严格解析+校验类型,非法抛不兜底)
                                 updated_at   timestamptz NOT NULL DEFAULT now()
);
INSERT INTO adm_config_stat (config_key, config_value) VALUES
                                                           ('default_display_mode',      'BACK'),       -- 前端默认展示 mode(查看视角): BACK=后标 (L,R] 0-1点→1点 HJ663 默认 / FRONT=前标 [S,E) 0-1点→0点;前端历史页 BACK/FRONT toggle 初值,缺省 mode 走此;PUT 须 ∈ materialization_mode.modes()(scope=BACK 时不可选 FRONT)
                                                           ('rounding_method',           'HALF_EVEN'),  -- 修约方法统一(HALF_EVEN 银行家;code 常量镜像入表便于审计/未来扩展)
                                                           ('default_storage_precision', '3'),          -- 物化逐级修约默认精度(每参数可在 adm_config_unit STORAGE 行 precision 覆盖;0..6)
                                                           ('default_display_precision', '3'),          -- 读路径展示默认精度(每参数可在 adm_config_unit MONITOR/HISTORY 行 precision 覆盖;0..6)
                                                           ('materialization_mode',      'BOTH'),       -- 物化范围: BACK=只算后标 / FRONT=只算前标 / BOTH=两标都算(默认,前端切 view 永远有数据);调度器/物化按此遍历 mode 集合各跑一趟四级级联;切换 scope 不删已物化的另一 mode 桶(历史不可变)
                                                           ('micro_batch_max_buckets',   '60')          -- 微批每批最多物化多少个该粒度的 stat 桶(行预算,统一跨粒度);各粒度换算时间窗不同:minute=60min/批 5min=300min/批 hour=60h/批 day=60天/批;范围[1,60];回算/回补大时段拆批+可中断续算
    ON CONFLICT (config_key) DO NOTHING;
COMMENT ON TABLE adm_config_stat IS 'ADM 统计全局运行时配置(KV 一项一行);config_key 项名/config_value 文本值(按 key 解析类型);default_display_mode 前端默认展示 mode(查看视角,缺省 mode 走此,不触发重物化——历史不可变,配置改只 reload 热生效影响新物化);materialization_mode 物化范围(BACK/FRONT/BOTH,调度器/物化按 mode 集合遍历;切换不删老桶);micro_batch_max_buckets 微批每批最大桶数(回算拆批用);rounding_method 统一 HALF_EVEN;default_*_precision 每参数精度的全局默认(被 adm_config_unit 覆盖);@Value 启动期一次性无法运行时改故 DB 化';

-- ===== §6.7 adm_config_unit — 每参数目标配置（用途字段窄行；决策5+7）=====
-- purpose 区分 STORAGE/MONITOR/HISTORY，每 (series, purpose) 一行窄行；unit+precision 是同用途语义伴侣合一行（决策7 删独立 rounding 表）。
-- STORAGE.unit = HJ663 业务标准上报单位（DDL seed，非采集原生），覆盖 2026-08-09 存储铁律（仅 stat 物化层；实时 attr state 仍存 native）。
-- unit 存 UnitInfo.getFullUnitString() key 形式（如 AirMassUnit.UGM3，经 UnitInfoFactory.getEnum 可逆解码）；非 getName 符号（ug/m3）亦非人类符号（µg/m³）——
--   与现有 AdmDisplayUnitService 惯例一致 + 设计注释一致（seed 示例曾误用符号，bug-record-20260811-121000 修正）。
-- unit NULL = 无量纲（如紫外指数 core 无单位枚举；物化直通不换算，与 raw.unit NULL 一致）。
-- series 集编译期闭合（AdmLogicDeviceIds 7 uniqueId × AirParam 19 参数）、STORAGE.unit 与设备无关、跨 rebind 稳定 → DDL seed 可行，bind 流程不碰本表。
CREATE TABLE adm_config_unit (
                                 logic_device_unique_id varchar(64) NOT NULL,
                                 attr_id                varchar(64) NOT NULL,
                                 purpose                varchar(16) NOT NULL,   -- 用途(枚举 AdmUnitPurpose,非魔法串):STORAGE 物化存储单位+逐级修约精度 / MONITOR 卡片展示单位+精度 / HISTORY 历史展示单位+精度
                                 unit                   varchar(64),            -- 目标单位(UnitInfo.getFullUnitString() key 形式,经 UnitInfoFactory.getEnum 反解;NULL=无量纲如紫外指数);SQL DDL 种子=HJ663 业务标准上报单位
                                 precision              smallint,               -- 该用途修约精度 0..6;NULL→回退 adm_config_stat 的 default_{storage|display}_precision
                                 aggregation_mode       varchar(32) NOT NULL DEFAULT 'STANDARD',  -- series stat 聚合模式(AdmAggregationMode.name()):STANDARD 气态/分钟型PM走 mean-of-means cascade / PM_HOUR_REPRESENTATIVE hour-repeat 型PM(β射线/TEOM)hour 桶取 02 分代表值;series 级属性(与 purpose 无关,STORAGE 行是真相源);仅物化 hour 桶路由消费
                                 applicable_granularities smallint,                               -- 该 series 适用物化粒度位掩码(bit0=分/bit1=5分/bit2=时/bit3=日,AdmGranularityMask);监测参数=15(0b1111 全粒度)/状态参数=3(0b0011 仅分+5分,非主污染诊断量诊断历史趋势不需时日聚合);NULL 视为全粒度(向后兼容迁移前旧行);物化引擎 materializeCascade/materializeOnly 按 app 内存掩码过滤(minute/5min task 算状态参数、hour/day task 跳过)
                                 created_by             varchar(64),
                                 updated_by             varchar(64),
                                 created_at             timestamptz NOT NULL DEFAULT now(),
                                 updated_at             timestamptz NOT NULL DEFAULT now(),
                                 CONSTRAINT pk_config_unit PRIMARY KEY (logic_device_unique_id, attr_id, purpose)
);
COMMENT ON TABLE adm_config_unit IS 'ADM 每参数目标配置(用途字段窄行);purpose 区分 STORAGE/MONITOR/HISTORY;unit 目标单位 getFullUnitString key 形式(NULL=无量纲,SQL seed=HJ663 业务标准上报单位,覆盖 2026-08-09 存储铁律仅 stat 层);precision 该用途修约精度(NULL=全局默认);STORAGE.unit 闭合 series 集(7 uniqueId×19 参数)DDL seed 与设备无关跨 rebind 稳定不需 bind 钩子;native unit 仅 raw→minute 换算源;applicable_granularities series 适用物化粒度位掩码(监测参数=15 全粒度/状态参数=3 仅分+5分,NULL=全粒度兼容)';

-- SQL DDL 种子：8 SINGLE_SOURCE 浓度 series（so2/co/o3/no/no2/nox/pm10/pm25）× 4 purpose（STORAGE/STANDARD/MONITOR/HISTORY）
-- + 11 MULTI_SOURCE 气象 series × 1 purpose（仅 STORAGE）= 43 行。unit=UnitInfo.getFullUnitString() key 形式。
-- 2026-08-12 改（用户铁律：标准单位也存 DB，standard/custom 同走 purpose→换算一条路径，与 logic device attr 解耦）：
--   STORAGE   = HJ663 业务标准上报单位（物化层，覆盖 2026-08-09 存储铁律仅 stat 层；浓度 series 与设备无关跨 rebind 稳定）。
--   STANDARD  = 标准展示浓度单位（默认除 CO 外均 ug/m³，CO=mg/m³；与 STORAGE 同值因业务标准=上报标准）。
--   MONITOR/HISTORY = 自定义展示浓度单位（SO₂/NOx 类(NO/NO₂/NOₓ)/O₃=ppb，CO=ppm，颗粒物=ug/m³ 不换算）。
-- 气象仅 STORAGE：STANDARD/MONITOR/HISTORY 不配行 → 读出口按 native unit 展示（保底；用户规则：未配参数如气象/未来设备状态参数显原生，非兜底）。
-- uv_index STORAGE 亦 NULL（无量纲，core 无单位枚举，物化直通）；visibility=KM（HJ663 标准，raw native=M 物化换算）。
-- ON CONFLICT DO UPDATE SET unit：重跑覆盖旧行 unit（误配修复/默认改重跑即生效；precision 不在 UPDATE 列保留用户定制精度）。
-- ⚠ 部署库迁移注意：旧 seed 曾为气象满配 3 purpose（33 行），新 seed 砍到仅 STORAGE（11 行）——重跑本 INSERT 不删旧行，
--   部署库须先 DELETE adm_config_unit WHERE logic_device_unique_id='logicdevice.meteo' AND purpose IN ('STANDARD','MONITOR','HISTORY')（旧 seed 无 STANDARD 故仅 MONITOR/HISTORY 22 行孤儿）。
INSERT INTO adm_config_unit (logic_device_unique_id, attr_id, purpose, unit) VALUES
                                                                                 -- SO₂（标准 µg/m³ / 自定义 ppb）
                                                                                 ('logicdevice.so2', 'so2', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.so2', 'so2', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.so2', 'so2', 'MONITOR', 'AirVolumeUnit.PPB'),
                                                                                 ('logicdevice.so2', 'so2', 'HISTORY', 'AirVolumeUnit.PPB'),
                                                                                 -- CO（量级独异：标准 mg/m³ / 自定义 ppm）
                                                                                 ('logicdevice.co', 'co', 'STORAGE', 'AirMassUnit.MGM3'),
                                                                                 ('logicdevice.co', 'co', 'STANDARD', 'AirMassUnit.MGM3'),
                                                                                 ('logicdevice.co', 'co', 'MONITOR', 'AirVolumeUnit.PPM'),
                                                                                 ('logicdevice.co', 'co', 'HISTORY', 'AirVolumeUnit.PPM'),
                                                                                 -- O₃（标准 µg/m³ / 自定义 ppb）
                                                                                 ('logicdevice.o3', 'o3', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.o3', 'o3', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.o3', 'o3', 'MONITOR', 'AirVolumeUnit.PPB'),
                                                                                 ('logicdevice.o3', 'o3', 'HISTORY', 'AirVolumeUnit.PPB'),
                                                                                 -- NO（属 logicdevice.nox；标准 µg/m³ / 自定义 ppb）
                                                                                 ('logicdevice.nox', 'no', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.nox', 'no', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.nox', 'no', 'MONITOR', 'AirVolumeUnit.PPB'),
                                                                                 ('logicdevice.nox', 'no', 'HISTORY', 'AirVolumeUnit.PPB'),
                                                                                 -- NO₂（标准 µg/m³ / 自定义 ppb）
                                                                                 ('logicdevice.nox', 'no2', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.nox', 'no2', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.nox', 'no2', 'MONITOR', 'AirVolumeUnit.PPB'),
                                                                                 ('logicdevice.nox', 'no2', 'HISTORY', 'AirVolumeUnit.PPB'),
                                                                                 -- NOₓ（标准 µg/m³ / 自定义 ppb）
                                                                                 ('logicdevice.nox', 'nox', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.nox', 'nox', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.nox', 'nox', 'MONITOR', 'AirVolumeUnit.PPB'),
                                                                                 ('logicdevice.nox', 'nox', 'HISTORY', 'AirVolumeUnit.PPB'),
                                                                                 -- PM10（颗粒物 attrId=pm_concentration 与 PM2.5 共用；标准/自定义均 µg/m³ 不换算）
                                                                                 ('logicdevice.pm10', 'pm_concentration', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.pm10', 'pm_concentration', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.pm10', 'pm_concentration', 'MONITOR', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.pm10', 'pm_concentration', 'HISTORY', 'AirMassUnit.UGM3'),
                                                                                 -- PM2.5（attrId=pm_concentration；标准/自定义均 µg/m³ 不换算）
                                                                                 ('logicdevice.pm25', 'pm_concentration', 'STORAGE', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.pm25', 'pm_concentration', 'STANDARD', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.pm25', 'pm_concentration', 'MONITOR', 'AirMassUnit.UGM3'),
                                                                                 ('logicdevice.pm25', 'pm_concentration', 'HISTORY', 'AirMassUnit.UGM3'),
                                                                                 -- 气象 11 参数（共享 logicdevice.meteo）— 仅 STORAGE；STANDARD/MONITOR/HISTORY 不配 → 读出口 native 保底
                                                                                 -- 风速 m/s
                                                                                 ('logicdevice.meteo', 'wind_speed', 'STORAGE', 'SpeedUnit.METER_PER_SECOND'),
                                                                                 -- 风向 度（NoConversionUnit.Degree；core 无独立 enum，getName=Degree）
                                                                                 ('logicdevice.meteo', 'wind_direction', 'STORAGE', 'NoConversionUnit.Degree'),
                                                                                 -- 温度 ℃
                                                                                 ('logicdevice.meteo', 'temperature', 'STORAGE', 'TemperatureUnit.CELSIUS'),
                                                                                 -- 湿度 %（RatioUnit.PERCENT；core 无 %RH 复合单位，HJ663 %RH 即此）
                                                                                 ('logicdevice.meteo', 'humidity', 'STORAGE', 'RatioUnit.PERCENT'),
                                                                                 -- 气压 hPa
                                                                                 ('logicdevice.meteo', 'atmospheric_pressure', 'STORAGE', 'PressureUnit.HPA'),
                                                                                 -- 降水 mm
                                                                                 ('logicdevice.meteo', 'precipitation', 'STORAGE', 'DistanceUnit.MM'),
                                                                                 -- 太阳辐射 W/m²
                                                                                 ('logicdevice.meteo', 'solar_radiation', 'STORAGE', 'IrradianceUnit.W_PER_SQUARE_METER'),
                                                                                 -- 紫外辐射 W/m²
                                                                                 ('logicdevice.meteo', 'uv_radiation', 'STORAGE', 'IrradianceUnit.W_PER_SQUARE_METER'),
                                                                                 -- 紫外指数 无量纲（NULL；core 无单位枚举，MeteoLogicDeviceMapping 显式传 null）
                                                                                 ('logicdevice.meteo', 'uv_index', 'STORAGE', NULL),
                                                                                 -- 日照时长 h
                                                                                 ('logicdevice.meteo', 'sunshine_duration', 'STORAGE', 'TimeDeltaUnit.HOUR'),
                                                                                 -- 能见度 km（HJ663 标准；raw native=DistanceUnit.M，物化 m→km 换算）
                                                                                 ('logicdevice.meteo', 'visibility', 'STORAGE', 'DistanceUnit.KM')
    ON CONFLICT (logic_device_unique_id, attr_id, purpose) DO UPDATE SET unit = EXCLUDED.unit, updated_at = now();

-- PM10/PM2.5 hour-repeat 聚合模式 seed（设计 §3.1：颗粒物 β 射线/TEOM 物理整点锁值，hour stat 取 02 分代表值非 mean-of-means）。
-- aggregation_mode 是 series 级属性（与 purpose 无关，STORAGE 行是真相源），该 series 下所有 purpose 行同 mode；
-- 故 UPDATE 全 purpose 行保 series 内一致（引擎只读 STORAGE 行路由，但全行同 mode 避免 series 内撕裂）。
-- 新 ADM 无生产（adm-no-prod-no-backward-compat）直接改 DDL 不写迁移；气态/气象 series 不命中保留默认 STANDARD。
UPDATE adm_config_unit
SET aggregation_mode = 'PM_HOUR_REPRESENTATIVE', updated_at = now()
WHERE logic_device_unique_id IN ('logicdevice.pm10', 'logicdevice.pm25')
  AND attr_id = 'pm_concentration';

-- 现有 19 监测参数 STORAGE 行回填全粒度掩码（0b1111=15：分/5分/时/日）——一次性数据修正，非独立迁移脚本（L0-7）。
-- 加列前的旧行 applicable_granularities=NULL → 物化引擎视 NULL 为全粒度（向后兼容过渡态）；此处显式回填 15 固化语义。
-- 状态参数 STORAGE 行由运行时 bind req3-hook 写入（掩码=3，仅分+5分），不在此静态 seed（状态参数集非闭集，随机型而异）。
UPDATE adm_config_unit
SET applicable_granularities = 15
WHERE purpose = 'STORAGE' AND applicable_granularities IS NULL;

-- ===== §6.8 adm_stat_compute_log — 计算执行审计（每次计算逐粒度一行；决策9）=====
-- 元数据+摘要不存每桶明细（明细在 stat 表，存了翻倍违 ms 预算）。window_start/end 按前后标开闭。配置快照固化本次算法。
CREATE TABLE adm_stat_compute_log (
                                      id                bigserial    PRIMARY KEY,
                                      granularity       varchar(8)   NOT NULL,   -- 本次计算粒度(minute/5min/hour/day);全量重算/回补逐级各一行
                                      trigger_source    varchar(16)  NOT NULL,   -- 触发源(枚举 AdmComputeTrigger,非魔法串):SCHEDULE 定时增量 / RECONFIG 配置切换全量重算 / BACKFILL 回补 / MANUAL 手动
                                      window_start      timestamptz  NOT NULL,   -- 本次计算覆盖的数据时间窗口起点(开闭由 interval_mode 定:BACK 此端开 / FRONT 此端闭)
                                      window_end        timestamptz  NOT NULL,   -- 本次计算覆盖的数据时间窗口终点(开闭由 interval_mode 定:BACK 此端闭=桶标注 / FRONT 此端开)
                                      interval_mode     varchar(8)   NOT NULL,   -- 配置快照:本次用的前后标(BACK/FRONT)
                                      rounding_method   varchar(16)  NOT NULL,   -- 配置快照:本次修约法(HALF_EVEN)
                                      default_precision smallint     NOT NULL,   -- 配置快照:本次全局默认精度(每参数精度见 adm_config_unit 当时行,审计级不逐参数存)
                                      bucket_count      integer,                 -- 摘要:本次计算产出的桶数(SUCCESS 时非 NULL;FAILED 时 NULL)
                                      started_at        timestamptz  NOT NULL,   -- 计算执行开始时刻(调度触发/调用入口)
                                      ended_at          timestamptz  NOT NULL,   -- 计算执行完成时刻(写 stat 完成后)
                                      status            varchar(8)   NOT NULL,   -- SUCCESS / FAILED(严格枚举 AdmComputeStatus,未知抛)
                                      error             text,                    -- FAILED 时异常摘要(消息+根因;SUCCESS 为 NULL)
                                      created_at        timestamptz  NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_compute_log_window ON adm_stat_compute_log (granularity, window_start, window_end);
CREATE INDEX IF NOT EXISTS idx_compute_log_started ON adm_stat_compute_log (started_at DESC);
COMMENT ON TABLE adm_stat_compute_log IS '统计计算执行审计(每次计算逐粒度一行);元数据+摘要不存每桶明细(明细在 stat 表);window_start/end 按前后标开闭;配置快照(interval_mode/rounding/default_precision)固化本次算法;trigger_source 标触发源;status+error 追溯失败';

-- ===== §4.3 压缩策略（N 天前 chunk 自动压缩；仅 raw——stat 已月度分区化不压缩）=====
-- raw=7 天（近 7 天可自由 INSERT 回补，超 7 天压缩只读）；stat 四表 2026-08-14 起 PG 月度分区裸表，无压缩策略
-- （旧 stat 30/365/3650 天策略随分区化一并移除）。幂等守卫。
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM timescaledb_information.jobs WHERE proc_name = 'policy_compression' AND hypertable_name = 'adm_data_sample') THEN
    PERFORM add_compression_policy('adm_data_sample',     INTERVAL '7 days');
END IF;
END $$;

-- ===== §4.4 retention（次要；压缩已解决空间，retention 仅清极老原始明细）=====
-- 原始明细 2 年后清理；stat 月度分区表长期保留供历史查询与上报（无 retention；极老月份按需 DROP 整月表）。幂等守卫。
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM timescaledb_information.jobs WHERE proc_name = 'policy_retention' AND hypertable_name = 'adm_data_sample') THEN
    PERFORM add_retention_policy('adm_data_sample', INTERVAL '2 years');
END IF;
END $$;
