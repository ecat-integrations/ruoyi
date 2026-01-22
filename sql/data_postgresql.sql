-- ----------------------------
-- Table structure for his_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."his_data";
CREATE TABLE "public"."his_data" (
  id SERIAL NOT NULL,
  "station_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL, --//站点id
  "thing_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,   --//设备id
  "model_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,   --//参数id
  "classify" varchar(12) COLLATE "pg_catalog"."default",            --//数据类型 minute hour day 
  "status" int8 DEFAULT 0,                                          --//数据状态 1正常 0异常
  "field" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,      --//参数中文名
  "value" numeric,                                                  --//参数值
  "values" text COLLATE "pg_catalog"."default",                     --//参数备注，异常备注
  "total" int8,                                                     --//统计条数，聚合统计的条数
  "unit" varchar(10) COLLATE "pg_catalog"."default" DEFAULT ''::character varying, --// 单位
  "pick_time" timestamptz(6) NOT NULL,  --// 数据时间
  "created_at" timestamptz(6),
  "updated_at" timestamptz(6)
)
;

-- ----------------------------
-- Table structure for realdata
-- ----------------------------
DROP TABLE IF EXISTS "public"."realdata";
CREATE TABLE "public"."realdata" (
  "pick_time" timestamptz(6),  --// 数据时间
  "tid" text COLLATE "pg_catalog"."default" NOT NULL, --// 设备id
  "pid" text COLLATE "pg_catalog"."default" NOT NULL, --// 参数id
  "sid" text COLLATE "pg_catalog"."default" NOT NULL, --// 站点id
  "mindex" int8 NOT NULL DEFAULT 0,                   
  "type" text COLLATE "pg_catalog"."default" NOT NULL,
  "fv" numeric,
  "sv" text COLLATE "pg_catalog"."default",
  "iv" int8,
  "value" text COLLATE "pg_catalog"."default", --// 值
  "tname" text COLLATE "pg_catalog"."default",  --// 设备名称
  "pn" text COLLATE "pg_catalog"."default",      --// 参数名称
  "sname" text COLLATE "pg_catalog"."default",   --// 站点名称
  "display" text COLLATE "pg_catalog"."default",  
  "unit_name" text COLLATE "pg_catalog"."default" --// 单位
)
;

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS "public"."events";
CREATE TABLE "public"."events" (
  event_id SERIAL NOT NULL,
  "event_type" int4 NOT NULL,
  "start_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamp(6),
  "description" text COLLATE "pg_catalog"."default",
  "severity_level" varchar(20) COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'Active'::character varying,
  "created_by" varchar(50) COLLATE "pg_catalog"."default",
  "updated_by" varchar(50) COLLATE "pg_catalog"."default",
  "sta_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'Unknown'::character varying
)
;
COMMENT ON COLUMN "public"."events"."event_id" IS '唯一标识每个事件的主键，自动生成。';
COMMENT ON COLUMN "public"."events"."event_type" IS '事件类型编码，用于区分不同事件。具体含义由系统维护（例如：0=设备离线，1=温度报警等）。';
COMMENT ON COLUMN "public"."events"."start_time" IS '事件开始的时间戳，记录事件发生的具体时间。';
COMMENT ON COLUMN "public"."events"."update_time" IS '事件最后更新的时间戳，用于跟踪事件的最新状态。';
COMMENT ON COLUMN "public"."events"."end_time" IS '事件结束的时间戳，表示事件已解决或关闭。';
COMMENT ON COLUMN "public"."events"."description" IS '事件的详细描述信息，用于记录事件的具体内容。';
COMMENT ON COLUMN "public"."events"."severity_level" IS '事件的严重性级别，用于快速评估事件的紧急程度。';
COMMENT ON COLUMN "public"."events"."status" IS '事件的状态，用于跟踪事件的处理进度（如活跃、已解决等）。';
COMMENT ON COLUMN "public"."events"."created_by" IS '创建事件的用户或系统名称。';
COMMENT ON COLUMN "public"."events"."updated_by" IS '更新事件的用户或系统名称。';
COMMENT ON COLUMN "public"."events"."sta_code" IS '监测点编码，用于标识事件发生的具体设备或位置。';
COMMENT ON TABLE "public"."events" IS '事件表，用于记录系统中的各种事件（包括报警、通知、异常等）。';

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS "public"."tasks";
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    task_name VARCHAR(255) NOT NULL,
    task_type INTEGER NOT NULL,  -- 新增字段：任务类型
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    request_content TEXT,
    task_status VARCHAR(50) NOT NULL DEFAULT 'pending',
    response_content TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_by VARCHAR(64),
    update_by VARCHAR(64),
    notes TEXT
);

-- 为表添加注释
COMMENT ON TABLE tasks IS '任务表，用于存储任务相关信息';
-- 为字段添加注释
COMMENT ON COLUMN tasks.task_id IS '任务ID';
COMMENT ON COLUMN tasks.task_name IS '任务名称';
COMMENT ON COLUMN tasks.task_type IS '任务类型';
COMMENT ON COLUMN tasks.start_time IS '任务开始时间';
COMMENT ON COLUMN tasks.end_time IS '任务结束时间';
COMMENT ON COLUMN tasks.request_content IS '任务内容';
COMMENT ON COLUMN tasks.task_status IS '任务状态';
COMMENT ON COLUMN tasks.response_content IS '返回内容';
COMMENT ON COLUMN tasks.create_time IS '任务创建时间';
COMMENT ON COLUMN tasks.update_time IS '任务更新时间';
COMMENT ON COLUMN tasks.create_by IS '任务创建人';
COMMENT ON COLUMN tasks.update_by IS '任务修改人';
COMMENT ON COLUMN tasks.notes IS '任务备注信息';


-- ----------------------------
-- Table structure for sta_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."sta_info";
CREATE TABLE sta_info(
    sta_id SERIAL NOT NULL,
    sta_name varchar(255),
    st_code varchar(255),
    com varchar(255),
    protocol_type varchar(255),
    st_number varchar(255),
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_time timestamp without time zone,
    last_data_time timestamp without time zone,
    device_type varchar(255),
    orderby integer,
    PRIMARY KEY(sta_id)
);
CREATE UNIQUE INDEX stcode_index_copy2 ON sta_info USING btree ("st_code");
COMMENT ON COLUMN sta_info.sta_id IS 'ID自增';
COMMENT ON COLUMN sta_info.sta_name IS '设备名称';
COMMENT ON COLUMN sta_info.st_code IS '设备编码';
COMMENT ON COLUMN sta_info.com IS '设备COM口';
COMMENT ON COLUMN sta_info.protocol_type IS '设备协议类型 支持MOUBUS,MODBUSTCP,CLINK';
COMMENT ON COLUMN sta_info.st_number IS '设备IDNUMBER';
COMMENT ON COLUMN sta_info.create_time IS '创建时间';
COMMENT ON COLUMN sta_info.update_time IS '更新时间';
COMMENT ON COLUMN sta_info.last_data_time IS '最后数据时间';
COMMENT ON COLUMN sta_info.device_type IS '设备类型  先河，热电';
COMMENT ON COLUMN sta_info.orderby IS '设备排序';

-- ----------------------------
-- Table structure for para_info
-- ----------------------------
-- Generated by the database client.
DROP TABLE IF EXISTS "public"."para_info";
CREATE TABLE para_info(
    para_id SERIAL NOT NULL,
    pa_name varchar(255) NOT NULL,
    pa_unit varchar(255),
    cmd varchar(255),
    cmd_name varchar(255),
    value_type varchar(255),
    pid varchar(255) NOT NULL,
    pname varchar(255),
    st_code varchar(255) NOT NULL,
    cmd_type varchar(255),
    orderby integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    PRIMARY KEY(para_id,pid),
    CONSTRAINT paraInfo_copy1_stCode_fkey1 FOREIGN key(st_code) REFERENCES sta_info(st_code)
);
COMMENT ON COLUMN para_info.para_id IS 'ID';
COMMENT ON COLUMN para_info.pa_name IS '参数名称';
COMMENT ON COLUMN para_info.pa_unit IS '参数单位';
COMMENT ON COLUMN para_info.cmd IS '参数指令';
COMMENT ON COLUMN para_info.cmd_name IS '指令名称';
COMMENT ON COLUMN para_info.value_type IS '数据类型';
COMMENT ON COLUMN para_info.pid IS '参数英文标识';
COMMENT ON COLUMN para_info.pname IS '参数中文标识';
COMMENT ON COLUMN para_info.st_code IS '设备编码';
COMMENT ON COLUMN para_info.cmd_type IS '指令类型';
COMMENT ON COLUMN para_info.orderby IS '排序';
COMMENT ON COLUMN para_info.create_time IS '创建时间';
COMMENT ON COLUMN para_info.update_time IS '更新时间';

