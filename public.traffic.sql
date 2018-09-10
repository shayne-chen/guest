/*
Navicat PGSQL Data Transfer

Source Server         : 62
Source Server Version : 90601
Source Host           : 192.168.9.62:5432
Source Database       : traffic
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90601
File Encoding         : 65001

Date: 2018-09-10 14:00:48
*/


-- ----------------------------
-- Sequence structure for tb_config_unid_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tb_config_unid_seq";
CREATE SEQUENCE "public"."tb_config_unid_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;

-- ----------------------------
-- Sequence structure for tb_tflow_data_unid_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tb_tflow_data_unid_seq";
CREATE SEQUENCE "public"."tb_tflow_data_unid_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 2334885
 CACHE 1;
SELECT setval('"public"."tb_tflow_data_unid_seq"', 2334885, true);

-- ----------------------------
-- Sequence structure for tb_traffic_unid_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tb_traffic_unid_seq";
CREATE SEQUENCE "public"."tb_traffic_unid_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 5747
 CACHE 1;
SELECT setval('"public"."tb_traffic_unid_seq"', 5747, true);

-- ----------------------------
-- Table structure for tb_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_config";
CREATE TABLE "public"."tb_config" (
"unid" int8 DEFAULT nextval('tb_config_unid_seq'::regclass) NOT NULL,
"xsend_all" bool,
"xsend_type" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Table structure for tb_face
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_face";
CREATE TABLE "public"."tb_face" (
"unid" varchar COLLATE "default" NOT NULL,
"traffic_unid" varchar COLLATE "default" NOT NULL,
"state" varchar(255) COLLATE "default",
"sex" varchar(255) COLLATE "default",
"upbody_color" varchar(255) COLLATE "default",
"lobody_color" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "public"."tb_face"."unid" IS '主键';
COMMENT ON COLUMN "public"."tb_face"."traffic_unid" IS '交通大类unid';
COMMENT ON COLUMN "public"."tb_face"."state" IS '识别状态';
COMMENT ON COLUMN "public"."tb_face"."sex" IS '性别';
COMMENT ON COLUMN "public"."tb_face"."upbody_color" IS '上半身颜色';
COMMENT ON COLUMN "public"."tb_face"."lobody_color" IS '下半身颜色';

-- ----------------------------
-- Table structure for tb_lib
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_lib";
CREATE TABLE "public"."tb_lib" (
"big_lib_code" varchar(255) COLLATE "default" NOT NULL,
"sub_lib_code" varchar(255) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Table structure for tb_lib_vehicle
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_lib_vehicle";
CREATE TABLE "public"."tb_lib_vehicle" (
"unid" varchar(32) COLLATE "default" NOT NULL,
"lib_code" varchar(16) COLLATE "default",
"plate_text" varchar(32) COLLATE "default",
"plate_type" varchar(32) COLLATE "default",
"vehicle_type" varchar(16) COLLATE "default",
"body_color" varchar(16) COLLATE "default",
"logo_main" varchar(32) COLLATE "default",
"logo_sub" varchar(16) COLLATE "default",
"owner" varchar(32) COLLATE "default",
"deleted" bool,
"create_dt" timestamp(3)
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Table structure for tb_tflow_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_tflow_data";
CREATE TABLE "public"."tb_tflow_data" (
"unid" int8 DEFAULT nextval('tb_tflow_data_unid_seq'::regclass) NOT NULL,
"event_unid" varchar(32) COLLATE "default" NOT NULL,
"detection_type" varchar(15) COLLATE "default",
"road_code" varchar(10) COLLATE "default",
"direction_code" varchar(15) COLLATE "default",
"sample_dura" int8,
"sample_num" float8,
"velocity" float8,
"velocity_unit" varchar(50) COLLATE "default",
"occupy" float8,
"distance" float8,
"queue_length" float8
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "public"."tb_tflow_data"."velocity" IS '流速';
COMMENT ON COLUMN "public"."tb_tflow_data"."velocity_unit" IS '流速单位';
COMMENT ON COLUMN "public"."tb_tflow_data"."occupy" IS '车道占有率';
COMMENT ON COLUMN "public"."tb_tflow_data"."distance" IS '车头间距';

-- ----------------------------
-- Table structure for tb_tflow_event
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_tflow_event";
CREATE TABLE "public"."tb_tflow_event" (
"unid" varchar(32) COLLATE "default" NOT NULL,
"task_id" varchar(32) COLLATE "default" NOT NULL,
"task_type" varchar(32) COLLATE "default",
"subtask_id" varchar(32) COLLATE "default" NOT NULL,
"source_type" varchar(50) COLLATE "default" NOT NULL,
"event_type" varchar(50) COLLATE "default" NOT NULL,
"event_dt" timestamp(3),
"device_name" varchar(255) COLLATE "default",
"location_name" varchar(255) COLLATE "default",
"event_id" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Table structure for tb_traffic
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_traffic";
CREATE TABLE "public"."tb_traffic" (
"unid" varchar(255) COLLATE "default" DEFAULT nextval('tb_traffic_unid_seq'::regclass) NOT NULL,
"event_cate" varchar(255) COLLATE "default" NOT NULL,
"task_id" varchar(255) COLLATE "default",
"task_type" varchar(255) COLLATE "default",
"subtask_id" varchar(225) COLLATE "default",
"source_type" varchar(255) COLLATE "default",
"event_type" varchar(255) COLLATE "default",
"dev_unid" varchar(225) COLLATE "default",
"vchan_refid" varchar(225) COLLATE "default",
"vdev_unid" varchar(225) COLLATE "default",
"vchan_duid" varchar(225) COLLATE "default",
"event_dt" timestamp(3) NOT NULL,
"plate_color_code" varchar(255) COLLATE "default",
"plate_text" varchar(255) COLLATE "default",
"location_code" varchar(255) COLLATE "default",
"lane_code" varchar(255) COLLATE "default",
"direction_code" varchar(255) COLLATE "default",
"body_type_code" varchar(255) COLLATE "default",
"device_name" varchar(255) COLLATE "default",
"illegal_code" varchar(255) COLLATE "default",
"illegal_state" bool,
"body_color_code" varchar(255) COLLATE "default",
"body_logo_code" varchar(255) COLLATE "default",
"refinedFeature_rAnnualInspection" bool,
"refinedFeature_rDecoration" bool,
"refinedFeature_rPendant" bool,
"refinedFeature_rSunshading" bool,
"xcycle_type" varchar(255) COLLATE "default",
"location_name" varchar(500) COLLATE "default",
"event_id" varchar(32) COLLATE "default" DEFAULT 0,
"shoot_dt" timestamp(3),
"is_active" bool DEFAULT true
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "public"."tb_traffic"."plate_color_code" IS '车牌颜色';
COMMENT ON COLUMN "public"."tb_traffic"."plate_text" IS '车牌号';
COMMENT ON COLUMN "public"."tb_traffic"."location_code" IS '位置编码';
COMMENT ON COLUMN "public"."tb_traffic"."lane_code" IS '车道号';
COMMENT ON COLUMN "public"."tb_traffic"."direction_code" IS '卡口方向编码';
COMMENT ON COLUMN "public"."tb_traffic"."body_type_code" IS '车辆类型编码';
COMMENT ON COLUMN "public"."tb_traffic"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."tb_traffic"."illegal_code" IS '违法行为编码';
COMMENT ON COLUMN "public"."tb_traffic"."illegal_state" IS '违法信息是否可用';
COMMENT ON COLUMN "public"."tb_traffic"."body_color_code" IS '车身颜色';
COMMENT ON COLUMN "public"."tb_traffic"."body_logo_code" IS '车标编码';
COMMENT ON COLUMN "public"."tb_traffic"."refinedFeature_rAnnualInspection" IS '年检标';
COMMENT ON COLUMN "public"."tb_traffic"."refinedFeature_rDecoration" IS '摆件';
COMMENT ON COLUMN "public"."tb_traffic"."refinedFeature_rPendant" IS '吊坠';
COMMENT ON COLUMN "public"."tb_traffic"."refinedFeature_rSunshading" IS '遮阳板';
COMMENT ON COLUMN "public"."tb_traffic"."xcycle_type" IS '非机动车类型';

-- ----------------------------
-- Table structure for tb_vehicle_owner
-- ----------------------------
DROP TABLE IF EXISTS "public"."tb_vehicle_owner";
CREATE TABLE "public"."tb_vehicle_owner" (
"unid" varchar(32) COLLATE "default" NOT NULL,
"cnsf_id" varchar(32) COLLATE "default",
"cnjs_id" varchar(32) COLLATE "default",
"name" varchar(128) COLLATE "default",
"phone" varchar(32) COLLATE "default",
"note" varchar(3072) COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------
ALTER SEQUENCE "public"."tb_config_unid_seq" OWNED BY "tb_config"."unid";
ALTER SEQUENCE "public"."tb_tflow_data_unid_seq" OWNED BY "tb_tflow_data"."unid";
ALTER SEQUENCE "public"."tb_traffic_unid_seq" OWNED BY "tb_traffic"."unid";

-- ----------------------------
-- Primary Key structure for table tb_config
-- ----------------------------
ALTER TABLE "public"."tb_config" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Primary Key structure for table tb_face
-- ----------------------------
ALTER TABLE "public"."tb_face" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Primary Key structure for table tb_lib
-- ----------------------------
ALTER TABLE "public"."tb_lib" ADD PRIMARY KEY ("big_lib_code");

-- ----------------------------
-- Indexes structure for table tb_lib_vehicle
-- ----------------------------
CREATE UNIQUE INDEX "tb_lib_vehicle_plate_text_idx" ON "public"."tb_lib_vehicle" USING btree ("plate_text");

-- ----------------------------
-- Primary Key structure for table tb_lib_vehicle
-- ----------------------------
ALTER TABLE "public"."tb_lib_vehicle" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Primary Key structure for table tb_tflow_data
-- ----------------------------
ALTER TABLE "public"."tb_tflow_data" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Primary Key structure for table tb_tflow_event
-- ----------------------------
ALTER TABLE "public"."tb_tflow_event" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Indexes structure for table tb_traffic
-- ----------------------------
CREATE INDEX "tb_traffic_event_dt" ON "public"."tb_traffic" USING btree ("event_id" DESC NULLS LAST);
CREATE INDEX "tb_traffic_plate_text" ON "public"."tb_traffic" USING btree ("event_cate" DESC NULLS LAST, "plate_text" DESC NULLS LAST, "event_id" DESC NULLS LAST);
CREATE INDEX "tb_traffic_index" ON "public"."tb_traffic" USING btree ("event_cate" DESC, "source_type" DESC, "event_type" DESC, "task_type" DESC, "task_id" DESC, "subtask_id" DESC, "location_code" DESC, "plate_color_code" DESC, "plate_text" DESC, "lane_code" DESC, "direction_code" DESC, "body_type_code" DESC, "device_name" DESC, "illegal_code" DESC, "illegal_state" DESC, "body_color_code" DESC, "refinedFeature_rAnnualInspection" DESC, "refinedFeature_rDecoration" DESC, "refinedFeature_rPendant" DESC, "refinedFeature_rSunshading" DESC, "body_logo_code" DESC, "xcycle_type" DESC, "location_name" DESC, "event_dt" DESC, "shoot_dt" DESC);

-- ----------------------------
-- Primary Key structure for table tb_traffic
-- ----------------------------
ALTER TABLE "public"."tb_traffic" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Indexes structure for table tb_vehicle_owner
-- ----------------------------
CREATE UNIQUE INDEX "tb_vehicle_owner_cnsf_id_idx" ON "public"."tb_vehicle_owner" USING btree ("cnsf_id");
CREATE UNIQUE INDEX "tb_vehicle_owner_cnjs_id_idx" ON "public"."tb_vehicle_owner" USING btree ("cnjs_id");

-- ----------------------------
-- Primary Key structure for table tb_vehicle_owner
-- ----------------------------
ALTER TABLE "public"."tb_vehicle_owner" ADD PRIMARY KEY ("unid");

-- ----------------------------
-- Foreign Key structure for table "public"."tb_lib_vehicle"
-- ----------------------------
ALTER TABLE "public"."tb_lib_vehicle" ADD FOREIGN KEY ("owner") REFERENCES "public"."tb_vehicle_owner" ("unid") ON DELETE NO ACTION ON UPDATE NO ACTION;
