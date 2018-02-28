-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: 10.140.234.255    Database: camel
-- ------------------------------------------------------
-- Server version	5.6.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` text COMMENT '地址',
  `road_address` text COMMENT '街道地址',
  `lon` int(11) DEFAULT NULL COMMENT '经纬度',
  `lat` int(11) DEFAULT NULL COMMENT '经纬度',
  `fk_bill_number` varchar(24) DEFAULT NULL COMMENT '订单号',
  `fk_province_code` varchar(6) DEFAULT NULL COMMENT '省编码',
  `fk_city_code` varchar(6) DEFAULT NULL COMMENT '城市编码',
  `fk_area_code` varchar(6) DEFAULT NULL COMMENT '地区编码',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `area_list`
--

DROP TABLE IF EXISTS `area_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_code` varchar(6) DEFAULT NULL,
  `count_start_off` int(11) DEFAULT NULL,
  `volume_start_off` int(11) DEFAULT NULL,
  `count_reality` int(11) DEFAULT NULL,
  `volume_reality` int(11) DEFAULT NULL,
  `start_punctuality_rate` float DEFAULT NULL,
  `count_should_arrival` int(11) DEFAULT NULL,
  `volume_should_arrival` int(11) DEFAULT NULL,
  `count_arrived` int(11) DEFAULT NULL,
  `volume_arrived` int(11) DEFAULT NULL,
  `arrival_punctuality_rate` float DEFAULT NULL,
  `counts_over_threedays` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `award_fine`
--

DROP TABLE IF EXISTS `award_fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `award_fine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `award_fine_type` int(11) DEFAULT NULL,
  `award_fine_date` timestamp NULL DEFAULT NULL,
  `award_fine_money` decimal(18,4) DEFAULT NULL,
  `award_description` varchar(512) DEFAULT NULL,
  `trans_number` varchar(15) DEFAULT NULL,
  `carrier_name` varchar(512) DEFAULT NULL,
  `carrier_id` varchar(32) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_award_fine_pk` (`award_fine_type`,`award_fine_date`),
  KEY `index_award_fine_carrier_name` (`carrier_name`(255)),
  KEY `index_award_fine_trans_number` (`trans_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_price`
--

DROP TABLE IF EXISTS `base_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `base_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `run_mode` int(11) NOT NULL,
  `truck_type` decimal(18,4) NOT NULL,
  `mileage_start` decimal(18,4) NOT NULL,
  `mileage_end` decimal(18,4) NOT NULL,
  `base_price` decimal(18,4) NOT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_base_price_pk` (`run_mode`,`truck_type`,`mileage_start`,`mileage_end`,`effective_time`),
  KEY `index_base_price_commit_status` (`commit_status`),
  KEY `index_base_price_effective_time` (`effective_time`),
  KEY `index_base_price_run_mode` (`run_mode`),
  KEY `index_base_price_truck_type` (`truck_type`),
  KEY `index_base_price_mileage_start` (`mileage_start`),
  KEY `index_base_price_mileage_end` (`mileage_end`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `benchmark_oil_prices`
--

DROP TABLE IF EXISTS `benchmark_oil_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `benchmark_oil_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `run_mode` int(11) NOT NULL,
  `benchmark_oil_prices` decimal(18,4) NOT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_benchmark_oil_prices_pk` (`run_mode`,`effective_time`),
  KEY `index_benchmark_oil_prices_commit_status` (`commit_status`),
  KEY `index_benchmark_oil_prices_effective_time` (`effective_time`),
  KEY `index_benchmark_oil_prices_run_mode` (`run_mode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bid_line_price`
--

DROP TABLE IF EXISTS `bid_line_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bid_line_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_shipper_project_line_id` int(11) DEFAULT NULL,
  `fk_project_id` int(11) DEFAULT NULL,
  `fk_line_id` int(11) DEFAULT NULL,
  `fk_shipper_id` int(11) DEFAULT NULL,
  `order_times` int(11) NOT NULL,
  `fk_truck_type_id` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blp_un` (`fk_shipper_project_line_id`,`fk_truck_type_id`,`order_times`),
  KEY `fk_line_id` (`fk_line_id`),
  KEY `fk_project_id` (`fk_project_id`),
  KEY `fk_shipper_id` (`fk_shipper_id`),
  KEY `fk_truck_type_id` (`fk_truck_type_id`),
  CONSTRAINT `bid_line_price_ibfk_1` FOREIGN KEY (`fk_line_id`) REFERENCES `line` (`id`),
  CONSTRAINT `bid_line_price_ibfk_2` FOREIGN KEY (`fk_project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `bid_line_price_ibfk_3` FOREIGN KEY (`fk_shipper_id`) REFERENCES `shippers` (`id`),
  CONSTRAINT `bid_line_price_ibfk_4` FOREIGN KEY (`fk_shipper_project_line_id`) REFERENCES `shipper_project_line` (`id`),
  CONSTRAINT `bid_line_price_ibfk_5` FOREIGN KEY (`fk_truck_type_id`) REFERENCES `truck_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bid_result`
--

DROP TABLE IF EXISTS `bid_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bid_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_shipper_id` int(11) DEFAULT NULL,
  `fk_line_id` int(11) DEFAULT NULL,
  `fk_project_id` int(11) DEFAULT NULL,
  `fk_user_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `br_un` (`fk_shipper_id`,`fk_project_id`,`fk_line_id`),
  KEY `fk_line_id` (`fk_line_id`),
  KEY `fk_project_id` (`fk_project_id`),
  KEY `fk_user_id` (`fk_user_id`),
  CONSTRAINT `bid_result_ibfk_1` FOREIGN KEY (`fk_line_id`) REFERENCES `line` (`id`),
  CONSTRAINT `bid_result_ibfk_2` FOREIGN KEY (`fk_project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `bid_result_ibfk_3` FOREIGN KEY (`fk_shipper_id`) REFERENCES `shippers` (`id`),
  CONSTRAINT `bid_result_ibfk_4` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_number` varchar(32) DEFAULT NULL,
  `bill_date` timestamp NULL DEFAULT NULL,
  `settlement_bill_number` varchar(32) DEFAULT NULL,
  `accrual_run_expense` decimal(18,4) DEFAULT NULL,
  `facing_slip_cost_total` decimal(18,4) DEFAULT NULL,
  `custom_award_fine` decimal(18,4) DEFAULT NULL,
  `award_fine_total` decimal(18,4) DEFAULT NULL,
  `vehicle_operation_management_cost` decimal(18,4) DEFAULT NULL,
  `paid_to_withhold_total` decimal(18,4) DEFAULT NULL,
  `final_money` decimal(18,4) DEFAULT NULL,
  `bill_state` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bills_pk` (`bill_number`),
  KEY `index_bills_bill_date` (`bill_date`),
  KEY `index_bills_settlement_bill_number` (`settlement_bill_number`),
  KEY `index_bills_bill_state` (`bill_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camel_line`
--

DROP TABLE IF EXISTS `camel_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camel_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_no` varchar(32) DEFAULT NULL,
  `line_name` varchar(100) DEFAULT NULL,
  `start_location_code` varchar(45) DEFAULT NULL,
  `start_location_name` varchar(100) DEFAULT NULL,
  `end_location_code` varchar(45) DEFAULT NULL,
  `end_location_name` varchar(100) DEFAULT NULL,
  `enable_at` timestamp NULL DEFAULT NULL,
  `disable_at` timestamp NULL DEFAULT NULL,
  `trans_type` varchar(12) DEFAULT NULL,
  `line_property` varchar(12) DEFAULT NULL,
  `line_type` int(11) DEFAULT NULL,
  `full_distance` float DEFAULT NULL,
  `line_status` int(11) DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  `start_location_id` int(11) DEFAULT NULL,
  `end_location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_camel_line_line_no` (`line_no`),
  KEY `start_location_id` (`start_location_id`),
  KEY `end_location_id` (`end_location_id`),
  KEY `ix_camel_line_start_location_name` (`start_location_name`),
  KEY `ix_camel_line_line_name` (`line_name`),
  KEY `ix_camel_line_end_location_code` (`end_location_code`),
  KEY `ix_camel_line_disable_at` (`disable_at`),
  KEY `ix_camel_line_line_property` (`line_property`),
  KEY `ix_camel_line_end_location_name` (`end_location_name`),
  KEY `ix_camel_line_enable_at` (`enable_at`),
  KEY `ix_camel_line_start_location_code` (`start_location_code`),
  KEY `ix_camel_line_trans_type` (`trans_type`),
  KEY `ix_camel_line_line_status` (`line_status`),
  CONSTRAINT `camel_line_ibfk_1` FOREIGN KEY (`start_location_id`) REFERENCES `transport_location` (`id`),
  CONSTRAINT `camel_line_ibfk_2` FOREIGN KEY (`end_location_id`) REFERENCES `transport_location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camel_truck`
--

DROP TABLE IF EXISTS `camel_truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camel_truck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(7) NOT NULL COMMENT '车牌',
  `vehicle_type` varchar(32) DEFAULT NULL COMMENT '车辆类型  驾驶证上面的那个车辆类型',
  `brand` varchar(32) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(32) DEFAULT NULL COMMENT '车辆型号',
  `engine_model` varchar(32) DEFAULT NULL COMMENT '发动机型号',
  `power` float DEFAULT NULL COMMENT '功率',
  `horsepower` float DEFAULT NULL COMMENT '马力',
  `vin` varchar(32) DEFAULT NULL COMMENT '车辆识别代码',
  `truck_length` float DEFAULT NULL COMMENT '车长',
  `truck_width` float DEFAULT NULL COMMENT '车宽',
  `truck_height` float DEFAULT NULL COMMENT '车高',
  `carriage_length` float DEFAULT NULL COMMENT '车厢长',
  `carriage_width` float DEFAULT NULL COMMENT '车厢宽',
  `carriage_height` float DEFAULT NULL COMMENT '车厢高',
  `carriage_type` tinyint(1) DEFAULT NULL COMMENT '车厢类型 1.厢式 2.高栏',
  `volume` float DEFAULT NULL COMMENT '方位',
  `total_mass` float DEFAULT NULL COMMENT '总质量',
  `equipment_mass` float DEFAULT NULL COMMENT '装备质量',
  `limit_mass` float DEFAULT NULL COMMENT '核定载质量',
  `limit_person` int(11) DEFAULT NULL COMMENT '限载人数',
  `belong_to` varchar(32) NOT NULL COMMENT '机动车所有人',
  `purchase_at` date DEFAULT NULL COMMENT '机动车购买日期',
  `abolish_at` date DEFAULT NULL COMMENT '机动车报废日期',
  `vehicle_license_no` int(32) DEFAULT NULL COMMENT '车辆行驶证号',
  `voc_no` varchar(32) DEFAULT NULL COMMENT '车辆营运证号',
  `insurance_from` date DEFAULT NULL COMMENT '保险购买日期',
  `insurance_end` date DEFAULT NULL COMMENT '保险到期日期',
  `insurance_com` varchar(32) DEFAULT NULL COMMENT '投保公司',
  `insurance_amount` float DEFAULT NULL COMMENT '保险金额',
  `url_vehicle_license` varchar(512) DEFAULT NULL COMMENT '车辆行驶证',
  `url_voc` varchar(512) DEFAULT NULL COMMENT '车辆营运证',
  `url_vrc` varchar(512) DEFAULT NULL COMMENT '车辆登记证书',
  `url_truck_jqx` varchar(512) DEFAULT NULL COMMENT '车辆交强险保单',
  `url_truck_syx` varchar(512) DEFAULT NULL COMMENT '车辆商业保险单',
  `truck_type` tinyint(1) NOT NULL COMMENT '车辆类别 1.一般货车 2.挂车头 3.挂厢',
  `truck_status` tinyint(1) NOT NULL COMMENT '车辆状态 1.正常 2.注销',
  `create_at` timestamp NULL DEFAULT NULL COMMENT ' 创建时间 ',
  `update_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL COMMENT '货物名称',
  `number` int(11) DEFAULT NULL COMMENT '货物件数',
  `packing_type` tinyint(4) DEFAULT NULL COMMENT '包装类型',
  `weight` float DEFAULT NULL COMMENT '重量',
  `type` tinyint(4) DEFAULT NULL COMMENT '货物类型',
  `fk_bill_number` varchar(24) DEFAULT NULL COMMENT '订单号',
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carrier`
--

DROP TABLE IF EXISTS `carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_name` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carrier_truck_commit`
--

DROP TABLE IF EXISTS `carrier_truck_commit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrier_truck_commit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_black` int(11) DEFAULT '2',
  `is_temp_truck` int(11) DEFAULT NULL,
  `cg_commit_result` int(11) DEFAULT NULL,
  `qy_commit_result` int(11) DEFAULT NULL,
  `is_online` int(11) DEFAULT NULL,
  `is_net` int(11) DEFAULT NULL,
  `fk_carrier_id` int(11) DEFAULT NULL,
  `fk_truck_plate` varchar(7) DEFAULT NULL,
  `vehicle_type` double DEFAULT NULL,
  `volumn` double DEFAULT NULL,
  `real_vehicle_type` double DEFAULT NULL,
  `real_volumn` double DEFAULT NULL,
  `line_property` varchar(45) DEFAULT NULL,
  `is_forbidden` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `is_onway` int(11) DEFAULT NULL,
  `operator` varchar(50) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `reason` varchar(900) DEFAULT NULL,
  `shipper_name` varchar(100) DEFAULT NULL,
  `is_want_formal` int(11) DEFAULT '1',
  `real_long` double DEFAULT NULL,
  `real_width` double DEFAULT NULL,
  `real_height` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_carrier_truck_commit_fk_truck_plate` (`fk_truck_plate`),
  KEY `ix_carrier_truck_commit_cg_commit_result` (`cg_commit_result`),
  KEY `ix_carrier_truck_commit_fk_carrier_id` (`fk_carrier_id`),
  KEY `ix_carrier_truck_commit_is_temp_truck` (`is_temp_truck`),
  KEY `ix_carrier_truck_commit_qy_commit_result` (`qy_commit_result`),
  CONSTRAINT `carrier_truck_commit_ibfk_1` FOREIGN KEY (`fk_carrier_id`) REFERENCES `shippers` (`id`),
  CONSTRAINT `carrier_truck_plate` FOREIGN KEY (`fk_truck_plate`) REFERENCES `trucks` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=3899 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carrier_truck_commit_his`
--

DROP TABLE IF EXISTS `carrier_truck_commit_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrier_truck_commit_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_temp_truck` int(11) DEFAULT NULL,
  `cg_commit_result` int(11) DEFAULT NULL,
  `qy_commit_result` int(11) DEFAULT NULL,
  `is_black` int(11) DEFAULT '2',
  `is_online` int(11) DEFAULT NULL,
  `is_net` int(11) DEFAULT NULL,
  `fk_carrier_id` int(11) DEFAULT NULL,
  `fk_truck_plate` varchar(7) DEFAULT NULL,
  `vehicle_type` double DEFAULT NULL,
  `line_property` varchar(45) DEFAULT NULL,
  `is_forbidden` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `operator` varchar(50) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `reason` varchar(900) DEFAULT NULL,
  `volumn` double DEFAULT NULL,
  `real_volumn` double DEFAULT NULL,
  `real_vehicle_type` double DEFAULT NULL,
  `action` int(11) DEFAULT NULL,
  `real_long` double DEFAULT NULL,
  `real_width` double DEFAULT NULL,
  `real_height` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_carrier_truck_commit_his_cg_commit_result` (`cg_commit_result`),
  KEY `ix_carrier_truck_commit_his_fk_carrier_id` (`fk_carrier_id`),
  KEY `ix_carrier_truck_commit_his_fk_truck_plate` (`fk_truck_plate`),
  KEY `ix_carrier_truck_commit_his_qy_commit_result` (`qy_commit_result`),
  CONSTRAINT `carrier_truck_commit_his_ibfk_1` FOREIGN KEY (`fk_carrier_id`) REFERENCES `shippers` (`id`),
  CONSTRAINT `carrier_truck_commit_his_ibfk_2` FOREIGN KEY (`fk_truck_plate`) REFERENCES `trucks` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=9071 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carrier_user`
--

DROP TABLE IF EXISTS `carrier_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrier_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) DEFAULT NULL,
  `role_type` int(11) NOT NULL,
  `username` varchar(32) DEFAULT NULL,
  `fullname` varchar(32) DEFAULT NULL,
  `com_type` int(11) NOT NULL,
  `address` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_carrier_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commit_his`
--

DROP TABLE IF EXISTS `commit_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commit_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(128) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `shipper_id` int(11) DEFAULT NULL,
  `manager_id` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1324 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commits`
--

DROP TABLE IF EXISTS `commits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(128) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `star` tinyint(1) NOT NULL,
  `shipper_id` int(11) DEFAULT NULL,
  `temp_approved` int(11) NOT NULL DEFAULT '1',
  `manager_id` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_lists`
--

DROP TABLE IF EXISTS `contact_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_shipper_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `trans_center_list` varchar(600) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shipper_id` (`fk_shipper_id`),
  CONSTRAINT `contact_lists_ibfk_1` FOREIGN KEY (`fk_shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost_prediction`
--

DROP TABLE IF EXISTS `cost_prediction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cost_prediction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_no` varchar(32) NOT NULL,
  `oil_price_departure_id` int(11) DEFAULT NULL,
  `departure_oil_price` decimal(18,4) DEFAULT NULL,
  `oil_price_arrival_point_id` int(11) DEFAULT NULL,
  `arrival_point_oil_price` decimal(18,4) DEFAULT NULL,
  `oil_prices` decimal(18,4) DEFAULT NULL,
  `settlement_price` decimal(18,4) DEFAULT NULL,
  `accrual_run_expense` decimal(18,4) DEFAULT NULL,
  `cost_prediction_state` int(11) DEFAULT NULL,
  `execution_specification` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `price_mode` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cost_prediction_pk` (`settlement_no`),
  KEY `index_cost_prediction_cost_prediction_state` (`cost_prediction_state`)
) ENGINE=InnoDB AUTO_INCREMENT=172231 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost_prediction_his`
--

DROP TABLE IF EXISTS `cost_prediction_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cost_prediction_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_no` varchar(32) NOT NULL,
  `functional_specification` varchar(256) DEFAULT NULL,
  `log_specification` varchar(256) DEFAULT NULL,
  `execution_specification` varchar(256) DEFAULT NULL,
  `execution_state` int(11) DEFAULT NULL,
  `executor` int(11) DEFAULT NULL,
  `execution_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cost_prediction_his_settlement_no` (`settlement_no`)
) ENGINE=InnoDB AUTO_INCREMENT=11501 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_data`
--

DROP TABLE IF EXISTS `dashboard_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_number` varchar(15) DEFAULT NULL,
  `line_name` varchar(1000) DEFAULT NULL,
  `full_take_time` varchar(100) DEFAULT NULL,
  `start_code` varchar(6) DEFAULT NULL,
  `end_code` varchar(6) DEFAULT NULL,
  `plate` varchar(8) DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `run_mode` int(11) DEFAULT NULL,
  `vehicle_type` varchar(45) DEFAULT NULL,
  `carrier_name` varchar(512) DEFAULT NULL,
  `report_type` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `startoff_time` timestamp NULL DEFAULT NULL,
  `on_way_time` timestamp NULL DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL,
  `unusual_time` timestamp NULL DEFAULT NULL,
  `abolish_time` timestamp NULL DEFAULT NULL,
  `jg_fc_time` timestamp NULL DEFAULT NULL,
  `jg_jc_time` timestamp NULL DEFAULT NULL,
  `trans_status` int(11) DEFAULT NULL,
  `jg_status` int(11) DEFAULT NULL,
  `expect_time` timestamp NULL DEFAULT NULL,
  `start_ontime` int(11) DEFAULT NULL,
  `arrived_ontime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_unusual_time` (`unusual_time`),
  KEY `idx_complete_time` (`complete_time`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_expect_time` (`expect_time`),
  KEY `idx_trans_status` (`trans_status`),
  KEY `idx_jg_status` (`jg_status`)
) ENGINE=InnoDB AUTO_INCREMENT=680506 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dispatcher_scan_record`
--

DROP TABLE IF EXISTS `dispatcher_scan_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispatcher_scan_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_username` varchar(11) NOT NULL COMMENT '司机用户名',
  `scan_type` int(11) NOT NULL COMMENT '1、到车扫描；2、发车扫描',
  `fk_location_code` varchar(6) NOT NULL COMMENT '调度员所属转运中',
  `fk_operator_id` int(11) DEFAULT NULL,
  `fk_trans_number` varchar(15) DEFAULT NULL,
  `upload_time` timestamp NULL DEFAULT NULL COMMENT '记录上传时间',
  `create_at` timestamp NULL DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `zh_gps` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_operator_create` (`fk_operator_id`,`create_at`)
) ENGINE=InnoDB AUTO_INCREMENT=364280 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `driver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(11) DEFAULT NULL COMMENT '用户表ID',
  `plate` varchar(8) DEFAULT NULL COMMENT '车牌号',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `fk_carrier_id` int(11) DEFAULT NULL COMMENT '承运商外键',
  PRIMARY KEY (`id`),
  KEY `idx_fk_user_id` (`fk_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76696 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `driver_live_reporting`
--

DROP TABLE IF EXISTS `driver_live_reporting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `driver_live_reporting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_urls` text COMMENT '图片本地地址;分开',
  `content` text COMMENT '内容',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `report_type` int(4) DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL COMMENT '承运单号',
  `uuid` varchar(36) DEFAULT NULL,
  `fk_user_id` int(11) DEFAULT NULL,
  `s_lon` int(11) DEFAULT NULL COMMENT '经纬度',
  `s_lat` int(11) DEFAULT NULL COMMENT '经纬度',
  `start_time` varchar(45) DEFAULT NULL,
  `s_address` text,
  `e_lon` int(11) DEFAULT NULL,
  `e_lat` int(11) DEFAULT NULL COMMENT '加油费',
  `end_time` varchar(45) DEFAULT NULL COMMENT 'lqf',
  `e_address` text,
  `flag` varchar(8) DEFAULT NULL,
  `plate` varchar(8) DEFAULT NULL,
  `input_type` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fk_trans_number` (`fk_trans_number`),
  KEY `index_uuid` (`uuid`),
  KEY `idx_endtime` (`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=508799 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fence`
--

DROP TABLE IF EXISTS `fence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fence_id` varchar(256) DEFAULT NULL COMMENT '围栏ID',
  `fence_name` varchar(256) DEFAULT NULL COMMENT '围栏名称',
  `radius` int(11) DEFAULT NULL COMMENT '围栏半径',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `th_trigger_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '第三方围栏触发时间',
  `trigger_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '围栏触发时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '围栏状态 1：创建 2：触发',
  `fk_trans_number` varchar(24) DEFAULT NULL COMMENT '承运单号',
  `fk_location_code` varchar(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_name` (`fence_name`(255)),
  KEY `index_trans_number` (`fk_trans_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4302024 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fence_record`
--

DROP TABLE IF EXISTS `fence_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fence_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fence_name` varchar(255) DEFAULT NULL,
  `trigger_time` timestamp NULL DEFAULT NULL,
  `trigger_type` int(11) DEFAULT NULL,
  `action` int(11) DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fence_name` (`fence_name`,`trigger_time`,`action`)
) ENGINE=InnoDB AUTO_INCREMENT=3953617 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geo_code`
--

DROP TABLE IF EXISTS `geo_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_code` int(11) NOT NULL,
  `ad_name` varchar(32) NOT NULL,
  `ad_type` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ad_name` (`ad_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jg_carrier`
--

DROP TABLE IF EXISTS `jg_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jg_carrier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_id` varchar(120) NOT NULL COMMENT '金刚承运商id',
  `name` varchar(120) DEFAULT NULL COMMENT '承运商名称',
  `code` varchar(10) DEFAULT NULL COMMENT '承运商编码',
  `address` varchar(1000) DEFAULT NULL COMMENT '承运商地址',
  `telephone_number` varchar(20) DEFAULT NULL COMMENT '承运商联系电话',
  `fax_no` varchar(20) DEFAULT NULL COMMENT '承运商传真号码',
  `affiliated_company` varchar(120) DEFAULT NULL COMMENT '所属公司',
  `affiliated_company_name` varchar(120) DEFAULT NULL COMMENT '所属公司名称',
  `status` varchar(12) DEFAULT NULL COMMENT '承运商状态,正常:VALID;注销:INVALID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `carrier_id` (`carrier_id`),
  KEY `index_code` (`code`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jg_tdar_record`
--

DROP TABLE IF EXISTS `jg_tdar_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jg_tdar_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orgCode` varchar(45) NOT NULL,
  `opCode` varchar(3) NOT NULL,
  `waybillNo` varchar(24) NOT NULL,
  `vehiclePlateNo` varchar(8) NOT NULL,
  `lineNo` varchar(100) NOT NULL,
  `linefrequencyNo` varchar(45) DEFAULT NULL,
  `camel_create_time` timestamp NULL DEFAULT NULL,
  `jg_createTime` varchar(19) DEFAULT NULL,
  `uploadTime` varchar(19) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91521 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jg_transport_departure_arrival_record`
--

DROP TABLE IF EXISTS `jg_transport_departure_arrival_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jg_transport_departure_arrival_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orgCode` varchar(45) NOT NULL,
  `opCode` varchar(3) NOT NULL,
  `waybillNo` varchar(24) NOT NULL,
  `vehiclePlateNo` varchar(8) DEFAULT NULL,
  `lineNo` varchar(100) DEFAULT NULL,
  `linefrequencyNo` varchar(100) DEFAULT NULL,
  `creat_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `jg_createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uploadTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uploadDate` varchar(19) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_name` (`waybillNo`),
  KEY `index_waybillNo_opCode_orgCode` (`waybillNo`,`opCode`,`orgCode`)
) ENGINE=InnoDB AUTO_INCREMENT=27437601 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_no` varchar(100) NOT NULL,
  `line_name` varchar(1000) DEFAULT NULL,
  `start_org_code` varchar(45) DEFAULT NULL,
  `start_org_name` varchar(45) DEFAULT NULL,
  `transfer_center_set` varchar(1000) DEFAULT NULL,
  `end_org_code` varchar(45) DEFAULT NULL,
  `end_org_name` varchar(45) DEFAULT NULL,
  `line_frequency_no` varchar(45) DEFAULT NULL,
  `line_frequency_name` varchar(1000) DEFAULT NULL,
  `start_time` varchar(45) DEFAULT NULL,
  `end_time` varchar(45) DEFAULT NULL,
  `status` int(2) DEFAULT NULL,
  `day_span` int(2) DEFAULT NULL,
  `full_take_time` varchar(45) DEFAULT NULL,
  `full_distance` varchar(45) DEFAULT NULL,
  `line_property` varchar(1) DEFAULT NULL,
  `trans_type` varchar(45) DEFAULT NULL,
  `line_status` int(2) DEFAULT NULL,
  `fre_status` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `line_type` int(11) DEFAULT NULL COMMENT '1:临时线路，2:正式线路',
  PRIMARY KEY (`id`),
  KEY `index_name` (`line_no`),
  KEY `index_line_name` (`line_name`(255)),
  KEY `index_line_frequency_no` (`line_frequency_no`),
  KEY `index_startorgcode` (`start_org_code`),
  KEY `index_line_status` (`line_status`)
) ENGINE=InnoDB AUTO_INCREMENT=119079 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_frequency`
--

DROP TABLE IF EXISTS `line_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_frequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route_code` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `depart_time` varchar(10) DEFAULT NULL,
  `take_time` int(11) DEFAULT NULL,
  `days_ago` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `frequency_index` (`route_code`,`data_type`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_op_history`
--

DROP TABLE IF EXISTS `line_op_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_op_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `operator` varchar(10) DEFAULT NULL,
  `op_type` varchar(10) DEFAULT NULL,
  `content` text,
  `op_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `history_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_route`
--

DROP TABLE IF EXISTS `line_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `property` varchar(10) DEFAULT NULL,
  `start_point_code` varchar(50) DEFAULT NULL,
  `start_point_name` varchar(100) DEFAULT NULL,
  `end_point_code` varchar(50) DEFAULT NULL,
  `end_point_name` varchar(100) DEFAULT NULL,
  `distance` varchar(10) DEFAULT NULL,
  `take_time` int(11) DEFAULT NULL,
  `trans_type` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `verify` int(11) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `creator` varchar(10) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `route_index` (`code`,`data_type`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_rs_section`
--

DROP TABLE IF EXISTS `line_rs_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_rs_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rs_section_index` (`code`,`data_type`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_section`
--

DROP TABLE IF EXISTS `line_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `start_point_code` varchar(50) DEFAULT NULL,
  `start_point_name` varchar(100) DEFAULT NULL,
  `end_point_code` varchar(50) DEFAULT NULL,
  `end_point_name` varchar(100) DEFAULT NULL,
  `velocity` varchar(10) DEFAULT NULL,
  `distance` varchar(10) DEFAULT NULL,
  `take_time` int(11) DEFAULT NULL,
  `trans_type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `verify` int(11) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `creator` varchar(10) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `section_index_1` (`code`,`data_type`),
  KEY `section_index_2` (`trans_type`,`start_point_code`,`end_point_code`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_tl_frequency`
--

DROP TABLE IF EXISTS `line_tl_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_tl_frequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `point_code` varchar(50) DEFAULT NULL,
  `point_name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `depart_time` varchar(10) DEFAULT NULL,
  `arrive_time` varchar(10) DEFAULT NULL,
  `stay_time` int(11) DEFAULT NULL,
  `days_ago` int(11) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `take_time` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT NULL,
  `days_ago_stranded` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tl_frequency_index` (`code`,`data_type`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_trip`
--

DROP TABLE IF EXISTS `line_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_trip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route_code` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(10) DEFAULT NULL,
  `preset_car_num` int(11) DEFAULT NULL,
  `real_car_num` int(11) DEFAULT NULL,
  `run_type` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `data_type` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_index` (`route_code`,`data_type`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_trip_extend`
--

DROP TABLE IF EXISTS `line_trip_extend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_trip_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route_code` varchar(50) DEFAULT NULL,
  `trip_code` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `validity` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `run_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ex_trip_index_1` (`code`),
  KEY `ex_trip_index_2` (`trip_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_trip_rs_truck`
--

DROP TABLE IF EXISTS `line_trip_rs_truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_trip_rs_truck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `validity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rs_truck_index` (`code`,`validity`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) CHARACTER SET latin1 NOT NULL COMMENT '登录名',
  `token` varchar(36) CHARACTER SET latin1 NOT NULL COMMENT '登录标识',
  `app_ver` varchar(16) CHARACTER SET latin1 DEFAULT NULL COMMENT '前端应用版本',
  `device_id` varchar(36) CHARACTER SET latin1 DEFAULT NULL COMMENT '设备ID',
  `device_type` tinyint(4) DEFAULT NULL COMMENT '设备类型0:pc,1:ios,2:android',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登录时间',
  `login_type` tinyint(4) DEFAULT NULL COMMENT '登录类型0:登进,1:登出',
  PRIMARY KEY (`id`),
  KEY `index_login_time` (`login_time`),
  KEY `idx_userid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=945050 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logistics_bill_desc`
--

DROP TABLE IF EXISTS `logistics_bill_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logistics_bill_desc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_number` varchar(24) NOT NULL COMMENT '订单号',
  `consignor_name` varchar(24) DEFAULT NULL,
  `consignor_email` varchar(24) DEFAULT NULL,
  `consignor_phone` varchar(15) DEFAULT NULL,
  `consignor_mobile` varchar(15) DEFAULT NULL,
  `at_address` text,
  `consignee_name` varchar(24) DEFAULT NULL,
  `consignee_email` varchar(24) DEFAULT NULL,
  `consignee_phone` varchar(15) DEFAULT NULL,
  `consignee_mobile` varchar(15) DEFAULT NULL,
  `to_address` text,
  `at_date` date DEFAULT NULL,
  `at_segment_type` tinyint(4) DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `to_segment_type` tinyint(4) DEFAULT NULL,
  `delivery_type` tinyint(4) DEFAULT NULL,
  `note` text,
  `is_receipt` tinyint(1) DEFAULT NULL,
  `receipt_count` int(11) DEFAULT NULL,
  `receipt_number` int(11) DEFAULT NULL,
  `total_account` float DEFAULT NULL,
  `xf_account` float DEFAULT NULL,
  `df_account` float DEFAULT NULL,
  `hdf_account` float DEFAULT NULL,
  `yj_account` float DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fk_operator_id` int(11) DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  `fk_at_address_id` int(11) DEFAULT NULL,
  `fk_to_address_id` int(11) DEFAULT NULL,
  `dianf_account` float DEFAULT NULL,
  `cargo_total_weight` float DEFAULT NULL,
  `cargo_total_volumn` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notify_his`
--

DROP TABLE IF EXISTS `notify_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `message_type` tinyint(4) DEFAULT NULL,
  `push_type` tinyint(4) DEFAULT NULL COMMENT '1：push 2:short message',
  `push_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_fail` tinyint(1) DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation_log`
--

DROP TABLE IF EXISTS `operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(11) DEFAULT NULL,
  `subsys_name` varchar(32) DEFAULT NULL,
  `action` varchar(32) DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `request_data` text,
  `response_data` text,
  `remote_addr` varchar(20) DEFAULT NULL,
  `http_user_agent` varchar(128) DEFAULT NULL,
  `resp_status` varchar(20) DEFAULT NULL,
  `url` text,
  PRIMARY KEY (`id`),
  KEY `index_createat` (`create_at`)
) ENGINE=InnoDB AUTO_INCREMENT=84938 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(24) NOT NULL COMMENT '订单号',
  `carrier_code` varchar(24) DEFAULT NULL COMMENT '承运商编码',
  `carrier_name` varchar(120) DEFAULT NULL COMMENT '承运商名称',
  `line_no` varchar(24) DEFAULT NULL,
  `line_name` varchar(120) DEFAULT NULL,
  `origin` varchar(6) DEFAULT NULL COMMENT '始发地编码',
  `origin_field` varchar(2) DEFAULT NULL COMMENT '始发地场地编码',
  `destination` varchar(6) DEFAULT NULL COMMENT '目的地编码',
  `destination_field` varchar(2) DEFAULT NULL COMMENT '目的地场地编码',
  `antipate_arrive_time` datetime DEFAULT NULL COMMENT '要求到车时间',
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态',
  `order_type` varchar(12) DEFAULT NULL COMMENT '订单类型,vehicle:整车;breakweight:零担',
  `demand_carriage_type` varchar(4) DEFAULT NULL COMMENT '需求车厢类型,GL:高栏;XS:厢式',
  `demand_vehicle_amount` int(11) DEFAULT NULL COMMENT '需求车辆总数',
  `carrier_vehicle_amount` int(11) DEFAULT NULL COMMENT '承运商派车总数',
  `dispatcher_vehicle_amount` int(11) DEFAULT NULL COMMENT '调度派车总数',
  `cargo_name` varchar(128) DEFAULT NULL COMMENT '货物名称',
  `cargo_volume` varchar(11) DEFAULT NULL COMMENT '货物体积',
  `cargo_weight` varchar(8) DEFAULT NULL COMMENT '货物重量',
  `carrier_send_vehicle_flag` int(11) DEFAULT NULL COMMENT '承运商派车标记,1:承运商未派车;2:承运商已派车;3:中心调度异常派车;',
  `dis_send_vehicle_flag` int(11) DEFAULT NULL COMMENT '调度派车标记,1:承运商未派车;2:承运商已派车;3:中心调度异常派车;',
  `fk_operator_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `create_date` date DEFAULT NULL COMMENT '创单日期',
  `create_time` datetime DEFAULT NULL COMMENT '创单时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_count`
--

DROP TABLE IF EXISTS `order_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` date DEFAULT NULL COMMENT '日期',
  `order_amount` int(11) DEFAULT NULL COMMENT '总数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_date` (`order_date`),
  KEY `index_order_date` (`order_date`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_demand`
--

DROP TABLE IF EXISTS `order_demand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_demand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_order_number` varchar(24) NOT NULL COMMENT '订单号',
  `carriage_length_type` varchar(11) DEFAULT NULL COMMENT '需求车厢长度类型',
  `vehicle_amount` int(11) DEFAULT NULL COMMENT '车辆数',
  `demand_if_exception` int(3) DEFAULT NULL COMMENT '需求是否异常',
  `demand_exception_type` int(3) DEFAULT NULL COMMENT '需求异常类型',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `fk_operator_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `flag` int(3) DEFAULT NULL COMMENT '数据标记,1:有效;2:历史',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_order_number` (`fk_order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=531 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_flow`
--

DROP TABLE IF EXISTS `order_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_order_number` varchar(24) DEFAULT NULL COMMENT '订单号',
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  `fk_operator_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_order_number` (`fk_order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_operation_record`
--

DROP TABLE IF EXISTS `order_operation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_operation_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_order_number` varchar(24) DEFAULT NULL COMMENT '订单号',
  `action` int(11) DEFAULT NULL COMMENT '操作类型',
  `op_time` datetime DEFAULT NULL COMMENT '操作时间',
  `fk_operator_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_order_number` (`fk_order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_vehicle`
--

DROP TABLE IF EXISTS `order_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_order_number` varchar(24) NOT NULL COMMENT '订单号',
  `vehicle_type` varchar(11) DEFAULT NULL COMMENT '需求车型',
  `send_vehicle_type` int(11) DEFAULT NULL COMMENT '派车类别,1:一般车辆;2:挂车头与挂车厢;3:挂车头;4:挂车厢',
  `plate` varchar(7) DEFAULT NULL COMMENT '车牌',
  `carriage_plate` varchar(7) DEFAULT NULL COMMENT '车厢车牌',
  `carriage_type` varchar(4) DEFAULT NULL COMMENT '车厢类型,GL:高栏;XS:厢式',
  `carriage_length_type` varchar(11) DEFAULT NULL COMMENT '车厢长度类型',
  `antipate_arrive_time` datetime DEFAULT NULL COMMENT '预计到车时间',
  `driver_name` varchar(45) DEFAULT NULL COMMENT '司机姓名',
  `driver_telephone` varchar(11) DEFAULT NULL COMMENT '司机手机号',
  `arrive_status` int(3) DEFAULT NULL COMMENT '到车状态,1:未到达;2:已到达;3:未知',
  `arrive_time` datetime DEFAULT NULL COMMENT '实际到车时间',
  `vehicle_if_exception` int(3) DEFAULT NULL COMMENT '车辆是否异常,1:正常;2:异常',
  `vehicle_exception_type` int(3) DEFAULT NULL COMMENT '车辆异常类型',
  `remark` varchar(1000) DEFAULT NULL COMMENT '车辆备注',
  `fk_operator_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `flag` int(3) DEFAULT NULL COMMENT '数据标记,1:有效;2:历史',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_order_number` (`fk_order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `about` text NOT NULL,
  `begin_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `begin_time_01` timestamp NULL DEFAULT NULL,
  `end_time_01` timestamp NULL DEFAULT NULL,
  `begin_time_02` timestamp NULL DEFAULT NULL,
  `end_time_02` timestamp NULL DEFAULT NULL,
  `begin_time_03` timestamp NULL DEFAULT NULL,
  `end_time_03` timestamp NULL DEFAULT NULL,
  `lines` text,
  `run_mode` tinyint(4) NOT NULL,
  `trucks` text,
  `major_truck` int(11) DEFAULT NULL,
  `person_in_charge_name` varchar(32) NOT NULL,
  `cid_num` varchar(18) NOT NULL,
  `contact` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `bid_paper` text NOT NULL,
  `bid_notice` text NOT NULL,
  `status` int(11) NOT NULL,
  `pub_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_project_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_line`
--

DROP TABLE IF EXISTS `project_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_project_id` int(11) DEFAULT NULL,
  `fk_line_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pl_un` (`fk_project_id`,`fk_line_id`),
  KEY `fk_line_id` (`fk_line_id`),
  CONSTRAINT `project_line_ibfk_1` FOREIGN KEY (`fk_line_id`) REFERENCES `line` (`id`),
  CONSTRAINT `project_line_ibfk_2` FOREIGN KEY (`fk_project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_truck_type`
--

DROP TABLE IF EXISTS `project_truck_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_truck_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_project_id` int(11) NOT NULL,
  `fk_truck_type_id` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pt_un` (`fk_project_id`,`fk_truck_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_departure_arrival`
--

DROP TABLE IF EXISTS `qr_departure_arrival`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qr_departure_arrival` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lon` int(11) DEFAULT NULL,
  `lat` int(11) DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `child_code` varchar(2) DEFAULT NULL,
  `record_type` int(11) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  `fk_operator_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `valid_arrival` varchar(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_fktransnumber_validarrival` (`fk_trans_number`,`valid_arrival`)
) ENGINE=InnoDB AUTO_INCREMENT=169850 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_departure_arrival_record`
--

DROP TABLE IF EXISTS `qr_departure_arrival_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qr_departure_arrival_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lon` int(11) DEFAULT NULL,
  `lat` int(11) DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `child_code` varchar(2) DEFAULT NULL,
  `record_type` int(11) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  `fk_operator_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `valid_arrival` varchar(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_comple` (`fk_trans_number`,`code`,`record_type`,`valid_arrival`),
  KEY `idx_fktransnumber_code_validarrival_recordtype` (`fk_trans_number`,`code`,`valid_arrival`,`record_type`)
) ENGINE=InnoDB AUTO_INCREMENT=182331 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qr_record`
--

DROP TABLE IF EXISTS `qr_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qr_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_driver_id` int(11) DEFAULT NULL,
  `plate` varchar(8) DEFAULT NULL,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  `operator_type` int(11) DEFAULT NULL COMMENT '1、司机绑定；2、司机解绑；3、司机被踢',
  `fk_operator_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_trans_number` (`fk_trans_number`)
) ENGINE=InnoDB AUTO_INCREMENT=1885364 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `real_oil_prices`
--

DROP TABLE IF EXISTS `real_oil_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `real_oil_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province_code` varchar(8) DEFAULT NULL,
  `center_code` varchar(8) DEFAULT NULL,
  `real_oil_price` decimal(18,4) NOT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_real_oil_prices_pk` (`province_code`,`center_code`,`effective_time`),
  KEY `index_real_oil_prices_commit_status` (`commit_status`),
  KEY `index_real_oil_prices_effective_time` (`effective_time`),
  KEY `index_real_oil_prices_center_code` (`center_code`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_process_record`
--

DROP TABLE IF EXISTS `report_process_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_process_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` text NOT NULL COMMENT '报表文件名，文件名组成 MD5(当前时间戳+用户名)',
  `start_at` timestamp NULL DEFAULT NULL COMMENT '报表统计起始时间',
  `end_at` timestamp NULL DEFAULT NULL COMMENT '报表统计截止时间',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录入库时间',
  `complete_at` timestamp NULL DEFAULT NULL COMMENT '报表完成或异常结束时间',
  `report_type` int(11) NOT NULL COMMENT '报表所在位置',
  `url` text NOT NULL COMMENT '报表类型，1.运单报表；2.异常报表',
  `operator` varchar(16) DEFAULT NULL,
  `location_code` varchar(6) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '报表状态，1.正在生成；2.完成，可下载；3.异常结束',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2392 DEFAULT CHARSET=utf8 COMMENT='报表进程记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rs_cq_trans`
--

DROP TABLE IF EXISTS `rs_cq_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rs_cq_trans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_number` varchar(24) NOT NULL COMMENT '运单号',
  `cq_number` varchar(24) NOT NULL COMMENT '车签号',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_trans_number_cq` (`trans_number`,`cq_number`),
  KEY `index_trans_number` (`trans_number`),
  KEY `index_cq_number` (`cq_number`)
) ENGINE=InnoDB AUTO_INCREMENT=869057 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rs_lt_truck`
--

DROP TABLE IF EXISTS `rs_lt_truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rs_lt_truck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qr_code` varchar(100) DEFAULT NULL,
  `line_no` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rs_qr_driver`
--

DROP TABLE IF EXISTS `rs_qr_driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rs_qr_driver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qr_code` varchar(8) NOT NULL COMMENT '二维码编号',
  `fk_driver_id` int(11) NOT NULL COMMENT '司机外键',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qr_code_index` (`qr_code`),
  UNIQUE KEY `key_qr_code_driver` (`qr_code`,`fk_driver_id`),
  KEY `index_qr_code_fk_driver_id` (`qr_code`,`fk_driver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=926847 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seal_price`
--

DROP TABLE IF EXISTS `seal_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seal_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mileage_start` decimal(18,4) NOT NULL,
  `mileage_end` decimal(18,4) NOT NULL,
  `base_price` decimal(18,4) NOT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_seal_price_pk` (`mileage_start`,`mileage_end`,`effective_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settlement_bill`
--

DROP TABLE IF EXISTS `settlement_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlement_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_bill_number` varchar(32) DEFAULT NULL,
  `settlement_no` varchar(32) DEFAULT NULL,
  `trans_number` varchar(512) DEFAULT NULL,
  `oil_price_departure_id` int(11) DEFAULT NULL,
  `departure_oil_price` decimal(18,4) DEFAULT NULL,
  `oil_price_arrival_point_id` int(11) DEFAULT NULL,
  `arrival_point_oil_price` decimal(18,4) DEFAULT NULL,
  `oil_prices` decimal(18,4) DEFAULT NULL,
  `settlement_price` decimal(18,4) DEFAULT NULL,
  `accrual_run_expense` decimal(18,4) DEFAULT NULL,
  `bill_number` varchar(32) DEFAULT NULL,
  `execution_specification` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_settlement_bill_pk` (`settlement_bill_number`),
  KEY `index_settlement_bill_settlement_no` (`settlement_no`),
  KEY `index_settlement_bill_trans_number` (`trans_number`(255)),
  KEY `index_settlement_bill_bill_number` (`bill_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settlements`
--

DROP TABLE IF EXISTS `settlements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_no` varchar(32) NOT NULL,
  `settlement_type` int(11) NOT NULL,
  `trans_status` int(11) DEFAULT NULL,
  `trans_number` varchar(256) DEFAULT NULL,
  `order_number` varchar(256) DEFAULT NULL,
  `cq_number` varchar(256) DEFAULT NULL,
  `carrier_name` varchar(512) DEFAULT NULL,
  `carrier_id` varchar(32) DEFAULT NULL,
  `contract_subject` varchar(256) DEFAULT NULL,
  `depart_time` timestamp NULL DEFAULT NULL,
  `depart_date` date DEFAULT NULL,
  `arrival_time` timestamp NULL DEFAULT NULL,
  `plate` varchar(128) DEFAULT NULL,
  `trailer` varchar(128) DEFAULT NULL,
  `line_no` varchar(100) DEFAULT NULL,
  `full_distance` int(11) DEFAULT NULL,
  `run_mode` int(11) DEFAULT NULL,
  `settlement_mode` int(11) DEFAULT NULL,
  `truck_type` decimal(18,4) DEFAULT NULL,
  `settlement_weight` decimal(18,4) DEFAULT NULL,
  `settlement_number` int(11) DEFAULT NULL,
  `is_link` int(11) DEFAULT NULL,
  `is_blank` int(11) DEFAULT NULL,
  `commit_status` int(11) DEFAULT NULL,
  `is_merge` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `start_org_code` varchar(45) DEFAULT NULL,
  `end_org_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_settlements_pk` (`settlement_no`),
  KEY `index_settlements_carrier_name` (`carrier_name`(255)),
  KEY `index_settlements_settlement_type` (`settlement_type`),
  KEY `index_settlements_trans_number` (`trans_number`(255)),
  KEY `index_settlements_depart_date` (`depart_date`),
  KEY `index_settlements_plate` (`plate`),
  KEY `index_settlements_line_no` (`line_no`),
  KEY `index_settlements_run_mode` (`run_mode`),
  KEY `index_settlements_settlement_mode` (`settlement_mode`),
  KEY `index_settlements_commit_status` (`commit_status`)
) ENGINE=InnoDB AUTO_INCREMENT=171469 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settlements_his`
--

DROP TABLE IF EXISTS `settlements_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlements_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_no` varchar(32) NOT NULL,
  `settlement_type` int(11) NOT NULL,
  `trans_status` int(11) DEFAULT NULL,
  `trans_number` varchar(256) DEFAULT NULL,
  `order_number` varchar(256) DEFAULT NULL,
  `cq_number` varchar(256) DEFAULT NULL,
  `carrier_name` varchar(512) DEFAULT NULL,
  `carrier_id` varchar(32) DEFAULT NULL,
  `contract_subject` varchar(256) DEFAULT NULL,
  `depart_time` timestamp NULL DEFAULT NULL,
  `depart_date` date DEFAULT NULL,
  `arrival_time` timestamp NULL DEFAULT NULL,
  `plate` varchar(128) DEFAULT NULL,
  `trailer` varchar(128) DEFAULT NULL,
  `line_no` varchar(100) DEFAULT NULL,
  `full_distance` int(11) DEFAULT NULL,
  `run_mode` int(11) DEFAULT NULL,
  `settlement_mode` int(11) DEFAULT NULL,
  `truck_type` decimal(18,4) DEFAULT NULL,
  `settlement_weight` decimal(18,4) DEFAULT NULL,
  `settlement_number` int(11) DEFAULT NULL,
  `is_link` int(11) DEFAULT NULL,
  `is_blank` int(11) DEFAULT NULL,
  `commit_status` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `operation_time` timestamp NULL DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `operation_type` int(11) DEFAULT NULL,
  `after_combine_settlement_number` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_settlements_his_after_combine_settlement_number` (`after_combine_settlement_number`),
  KEY `index_settlements_his_pk` (`settlement_no`,`operation_type`,`operation_time`),
  KEY `index_settlements_his_settlement_no` (`settlement_no`),
  KEY `index_settlements_his_settlement_type` (`settlement_type`),
  KEY `index_settlements_his_operation_type` (`operation_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settlements_verify_his`
--

DROP TABLE IF EXISTS `settlements_verify_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settlements_verify_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_no` varchar(32) NOT NULL,
  `verifier_id` int(11) NOT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_result` int(11) DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_settlements_verify_his_settlement_no` (`settlement_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_commit`
--

DROP TABLE IF EXISTS `shipper_commit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipper_commit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_shipper_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `module` int(11) DEFAULT NULL,
  `answer` varchar(900) DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_return` int(11) DEFAULT '1',
  `return_reason` varchar(900) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shipper_id` (`fk_shipper_id`),
  CONSTRAINT `fk_shipper_id` FOREIGN KEY (`fk_shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1137 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_commit_his`
--

DROP TABLE IF EXISTS `shipper_commit_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipper_commit_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_shipper_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `module` int(11) DEFAULT NULL,
  `answer` varchar(900) DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `is_return` int(11) DEFAULT '1',
  `return_reason` varchar(900) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipper_id` (`fk_shipper_id`),
  CONSTRAINT `shipper_id` FOREIGN KEY (`fk_shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2335 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_network`
--

DROP TABLE IF EXISTS `shipper_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipper_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_id` varchar(32) DEFAULT NULL,
  `carrier_name` varchar(512) NOT NULL,
  `whether_network` int(11) DEFAULT NULL,
  `carrier_settlement_ratio` decimal(18,4) DEFAULT NULL,
  `commit_status` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shipper_network_carrier_name` (`carrier_name`(255))
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_order`
--

DROP TABLE IF EXISTS `shipper_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipper_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(24) NOT NULL COMMENT '订单号',
  `origin` varchar(6) DEFAULT NULL COMMENT '始发地编码',
  `destination` varchar(6) DEFAULT NULL COMMENT '目的地编码',
  `carrier_code` varchar(24) DEFAULT NULL COMMENT '承运商编码',
  `antipate_arrive_time` datetime DEFAULT NULL COMMENT '预计到车时间',
  `order_type` varchar(12) DEFAULT NULL COMMENT '订单类型',
  `order_carriage_type` varchar(4) DEFAULT NULL COMMENT '订单车厢类型,GL:高栏;XS:厢式',
  `order_vehicle_amount` int(11) DEFAULT NULL COMMENT '订单车辆总数',
  `cargo_name` varchar(128) DEFAULT NULL COMMENT '货物名称',
  `cargo_volume` varchar(11) DEFAULT NULL COMMENT '货物体积',
  `cargo_weight` varchar(8) DEFAULT NULL COMMENT '货物重量',
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态',
  `create_date` date DEFAULT NULL COMMENT '创单日期',
  `create_time` datetime DEFAULT NULL COMMENT '创单时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `line_no` varchar(1000) DEFAULT NULL,
  `order_property` varchar(3) DEFAULT NULL COMMENT '订单属性,1正常,2异常',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `index_origin` (`origin`),
  KEY `index_create_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipper_project_line`
--

DROP TABLE IF EXISTS `shipper_project_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipper_project_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_shipper_id` int(11) DEFAULT NULL,
  `fk_project_line_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spl_un` (`fk_project_line_id`,`fk_shipper_id`),
  KEY `fk_shipper_id` (`fk_shipper_id`),
  CONSTRAINT `shipper_project_line_ibfk_1` FOREIGN KEY (`fk_project_line_id`) REFERENCES `project_line` (`id`),
  CONSTRAINT `shipper_project_line_ibfk_2` FOREIGN KEY (`fk_shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shippers`
--

DROP TABLE IF EXISTS `shippers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shippers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `com_name` varchar(30) NOT NULL,
  `com_about` varchar(200) NOT NULL,
  `better_area` varchar(256) NOT NULL,
  `buss_id` varchar(20) NOT NULL,
  `url_buss_id` varchar(128) DEFAULT NULL,
  `buss_money` varchar(20) NOT NULL,
  `entp_id` varchar(20) NOT NULL,
  `url_entp_id` varchar(128) DEFAULT NULL,
  `trans_id` varchar(20) NOT NULL,
  `url_trans_id` varchar(128) DEFAULT NULL,
  `url_insurance` varchar(128) DEFAULT NULL,
  `legalp_name` varchar(20) NOT NULL,
  `legalp_home` varchar(20) NOT NULL,
  `legalp_cid` varchar(18) NOT NULL,
  `legalp_phone` varchar(25) NOT NULL,
  `legalp_email` varchar(50) NOT NULL,
  `url_fcid` varchar(128) NOT NULL,
  `url_bcid` varchar(128) NOT NULL,
  `tax_id` varchar(20) NOT NULL,
  `url_tax` varchar(128) DEFAULT NULL,
  `b_account` varchar(30) NOT NULL,
  `b_com` varchar(30) NOT NULL,
  `b_bank` varchar(30) NOT NULL,
  `url_b_passport` varchar(128) DEFAULT NULL,
  `url_b_taxer` varchar(128) DEFAULT NULL,
  `url_profit` varchar(128) DEFAULT NULL,
  `url_audit_report` varchar(128) DEFAULT NULL,
  `url_addtax` varchar(128) DEFAULT NULL,
  `url_property` varchar(128) DEFAULT NULL,
  `contact_name` varchar(20) NOT NULL,
  `contact_cid` varchar(18) NOT NULL,
  `contact_home` varchar(20) NOT NULL,
  `contact_phone` varchar(25) NOT NULL,
  `contact_email` varchar(50) NOT NULL,
  `contact_postion` varchar(20) NOT NULL,
  `contact_depart` varchar(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `standard_price`
--

DROP TABLE IF EXISTS `standard_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standard_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_id` varchar(32) DEFAULT NULL,
  `carrier_name` varchar(512) NOT NULL,
  `line_no` varchar(100) NOT NULL,
  `truck_type` decimal(18,4) NOT NULL,
  `run_mode` int(11) NOT NULL,
  `settlement_mode` int(11) NOT NULL,
  `standard_price` decimal(18,4) NOT NULL,
  `is_link` int(11) DEFAULT NULL,
  `cost` decimal(18,4) DEFAULT NULL,
  `income` decimal(18,4) DEFAULT NULL,
  `oil_fee` decimal(18,4) DEFAULT NULL,
  `transit_expenses` decimal(18,4) DEFAULT NULL,
  `other` decimal(18,4) DEFAULT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `is_new` int(11) NOT NULL DEFAULT '0',
  `start_org_code` varchar(45) DEFAULT NULL,
  `end_org_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_standard_price_pk` (`carrier_name`(255),`line_no`,`truck_type`,`run_mode`,`settlement_mode`,`is_link`,`effective_time`),
  KEY `index_standard_price_commit_status` (`commit_status`),
  KEY `index_standard_price_effective_time` (`effective_time`),
  KEY `index_standard_price_carrier_name` (`carrier_name`(255)),
  KEY `index_is_new` (`is_new`)
) ENGINE=InnoDB AUTO_INCREMENT=38734 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `star`
--

DROP TABLE IF EXISTS `star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `star` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shipper_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `manager_id` (`manager_id`),
  KEY `shipper_id` (`shipper_id`),
  CONSTRAINT `fk_star_User_id` FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`),
  CONSTRAINT `star_ibfk_2` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_mot_unit_vehicle_owner`
--

DROP TABLE IF EXISTS `t_mot_unit_vehicle_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_mot_unit_vehicle_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_owner_id` varchar(100) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `company_address` varchar(1000) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `fax_no` varchar(20) DEFAULT NULL,
  `version_no` int(11) DEFAULT NULL,
  `unit_vehicle_owner_no` varchar(100) DEFAULT NULL,
  `vehicle_owned_company` varchar(100) DEFAULT NULL,
  `company_code` varchar(7) DEFAULT NULL,
  `owned_company_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=731 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_truck`
--

DROP TABLE IF EXISTS `temp_truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_truck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) DEFAULT NULL,
  `length` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `run_mode` int(11) DEFAULT NULL,
  `carrier_type` tinyint(4) DEFAULT NULL,
  `qr_code` varchar(8) DEFAULT NULL,
  `content` text,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `three_judgement`
--

DROP TABLE IF EXISTS `three_judgement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `three_judgement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shipper_id` int(11) NOT NULL,
  `q_manager_id` int(11) DEFAULT NULL,
  `q_judge_time` timestamp NULL DEFAULT NULL,
  `q_status` int(11) DEFAULT NULL,
  `q_answer` varchar(125) DEFAULT NULL,
  `c_manager_id` int(11) DEFAULT NULL,
  `c_judge_time` timestamp NULL DEFAULT NULL,
  `c_status` int(11) DEFAULT NULL,
  `c_answer` varchar(125) DEFAULT NULL,
  `f_manager_id` int(11) DEFAULT NULL,
  `f_judge_time` timestamp NULL DEFAULT NULL,
  `f_status` int(11) DEFAULT NULL,
  `f_answer` varchar(125) DEFAULT NULL,
  `reset_manager_id` varchar(125) DEFAULT NULL,
  `reset_reason` varchar(120) DEFAULT NULL,
  `reset_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shipper_id` (`shipper_id`),
  CONSTRAINT `three_judgement_ibfk_1` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `three_judgement_his`
--

DROP TABLE IF EXISTS `three_judgement_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `three_judgement_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shipper_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `manager_role` int(11) NOT NULL,
  `judge_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `answer` varchar(125) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `manager_id` (`manager_id`),
  KEY `shipper_id` (`shipper_id`),
  CONSTRAINT `three_judgement_his_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`),
  CONSTRAINT `three_judgement_his_ibfk_2` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1075 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trans_center`
--

DROP TABLE IF EXISTS `trans_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trans_center` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `trans_name` varchar(50) NOT NULL,
  `initial_name` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trans_department`
--

DROP TABLE IF EXISTS `trans_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trans_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(64) NOT NULL COMMENT '部门名称',
  `dept_type` tinyint(4) DEFAULT NULL COMMENT '部门类型 0:总部,1:分部',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trans_ticket_decl`
--

DROP TABLE IF EXISTS `trans_ticket_decl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trans_ticket_decl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_ticket` varchar(7) NOT NULL COMMENT '营运单号',
  `user_id` varchar(16) NOT NULL COMMENT '用户登录名',
  `input_date` datetime NOT NULL COMMENT '录入日期',
  `trans_date` date DEFAULT NULL COMMENT '运单生成或者修改日期',
  `orgin_station` varchar(11) DEFAULT NULL COMMENT '始发中心',
  `route_name` varchar(32) DEFAULT NULL COMMENT '线路名称',
  `route_type` tinyint(4) DEFAULT NULL COMMENT '线路类型',
  `plate` varchar(8) DEFAULT NULL COMMENT '车牌号',
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '实际发车时间',
  `plan_start_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '规定发车时间',
  `relay_station` varchar(256) DEFAULT NULL COMMENT '经停中心',
  `end_station` varchar(32) DEFAULT NULL COMMENT '目的中心',
  `cq_number` varchar(10) DEFAULT NULL COMMENT '车签',
  `pkg_number` int(6) DEFAULT NULL COMMENT '货物件数',
  `pkg_weight` float DEFAULT NULL COMMENT '货物重量',
  `pkg_volume` float DEFAULT NULL COMMENT '货物体积',
  `load_rate` float DEFAULT NULL COMMENT '装载率',
  `plan_distance` float DEFAULT NULL COMMENT '路线距离',
  `plan_runtime` float DEFAULT NULL COMMENT '预计运行时间（小时）',
  `carrier` varchar(64) DEFAULT NULL COMMENT '承运公司',
  `out_volume` float DEFAULT NULL COMMENT '爆仓',
  `fix_bug` text COMMENT '爆仓解决措施',
  `bus_type` tinyint(4) DEFAULT NULL COMMENT '班车类型1:正班车2:加班车',
  `note` text COMMENT '备注',
  `trunk_length` float DEFAULT NULL COMMENT '车厢长度',
  `trunk_volume` float DEFAULT NULL COMMENT '车厢体积',
  `trunk_type` tinyint(4) DEFAULT NULL COMMENT '车辆类型',
  `dept_name` varchar(64) DEFAULT NULL COMMENT '部门名称',
  `fk_dept_id` int(11) DEFAULT NULL COMMENT '转运管理部外键',
  `iscancel` tinyint(4) DEFAULT '0' COMMENT '是否是作废单号0:不是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transit_center_decl`
--

DROP TABLE IF EXISTS `transit_center_decl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transit_center_decl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `center_name` varchar(128) NOT NULL COMMENT '中心名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_departure_arrival_record`
--

DROP TABLE IF EXISTS `transport_departure_arrival_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_departure_arrival_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `trans_number` varchar(24) NOT NULL COMMENT '运单号',
  `plate` varchar(8) NOT NULL COMMENT '车牌号',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status_time` timestamp NULL DEFAULT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1:到达 2:出发',
  `lon` int(11) DEFAULT NULL,
  `lat` int(11) DEFAULT NULL,
  `address` text COMMENT '地址',
  `fk_driver_id` int(11) DEFAULT NULL COMMENT '司机ID外键',
  `fk_location_code` varchar(6) DEFAULT NULL,
  `fk_operator_id` int(11) DEFAULT NULL COMMENT '操作员外键',
  `source_type` int(11) DEFAULT NULL,
  `jg_trigger_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_trans_number_code_type` (`trans_number`,`fk_location_code`,`type`),
  KEY `record_index_name` (`fk_location_code`),
  KEY `tp_number_index_name` (`trans_number`),
  KEY `index_trans_location_type` (`trans_number`,`fk_location_code`,`type`),
  KEY `index_status_time` (`status_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2310248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_location`
--

DROP TABLE IF EXISTS `transport_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '\\',
  `name` varchar(256) DEFAULT NULL,
  `address` text,
  `road_address` text,
  `radius_b` int(11) DEFAULT NULL,
  `radius_s` int(11) DEFAULT NULL,
  `lon` int(11) DEFAULT NULL,
  `lat` int(11) DEFAULT NULL,
  `country_code` varchar(8) DEFAULT NULL,
  `country_name` varchar(64) DEFAULT NULL,
  `province_code` varchar(8) DEFAULT NULL,
  `province_name` varchar(64) DEFAULT NULL,
  `city_code` varchar(8) DEFAULT NULL,
  `city_name` varchar(64) DEFAULT NULL,
  `area_code` varchar(8) DEFAULT NULL,
  `area_name` varchar(64) DEFAULT NULL,
  `fk_province_code` varchar(6) DEFAULT NULL,
  `fk_city_code` varchar(6) DEFAULT NULL,
  `fk_area_code` varchar(6) DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `child_code` varchar(2) DEFAULT NULL,
  `contact` varchar(24) DEFAULT NULL COMMENT '联系人',
  `telephone` varchar(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `short_name` varchar(20) DEFAULT NULL,
  `yard_name` varchar(20) DEFAULT NULL,
  `yard_short_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_code` (`code`),
  KEY `index_province_code` (`province_code`)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_protocol`
--

DROP TABLE IF EXISTS `transport_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_protocol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_number` varchar(15) DEFAULT NULL,
  `start_time` varchar(16) DEFAULT NULL,
  `end_time` varchar(16) DEFAULT NULL,
  `settlement_mode` varchar(4) DEFAULT NULL,
  `driver_freight` float DEFAULT NULL,
  `note` text,
  `plate` varchar(8) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `fk_driver_id` int(11) DEFAULT NULL,
  `fk_to_location_code` varchar(6) NOT NULL COMMENT '出发地编码',
  `fk_at_location_code` varchar(6) NOT NULL COMMENT '到达地编码',
  `fk_operator_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `status_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `relay_status` int(4) DEFAULT NULL COMMENT '中转状态，个位1：到达 2：出发；十位：经停顺序，index=1',
  `is_onway` int(2) DEFAULT NULL COMMENT '是否在途 1:在途 2:到达',
  `is_temp_truck` int(2) DEFAULT NULL,
  `is_overtime` int(2) DEFAULT NULL,
  `line_no` varchar(100) DEFAULT NULL,
  `carrier_name` varchar(512) DEFAULT NULL,
  `is_link` int(11) DEFAULT NULL,
  `link` varchar(15) DEFAULT NULL,
  `run_mode` int(11) DEFAULT NULL,
  `voucher` varchar(64) NOT NULL,
  `vehicle_type` varchar(45) DEFAULT NULL,
  `fk_truck_id` int(11) NOT NULL COMMENT '车辆表ID',
  `trailer_head` varchar(8) DEFAULT NULL,
  `line_property` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trans_number` (`trans_number`),
  KEY `index_number` (`trans_number`),
  KEY `tp_number_index_name` (`plate`),
  KEY `IDX_CREATE_TIME` (`create_time`),
  KEY `index_at_location` (`fk_at_location_code`),
  KEY `index_to_location` (`fk_to_location_code`),
  KEY `index_trans_number_status_time` (`trans_number`,`status_time`),
  KEY `index_fk_driver_id` (`fk_driver_id`),
  KEY `index_carrier_name` (`carrier_name`(255)),
  KEY `index_start_time` (`start_time`),
  KEY `index_plate` (`plate`),
  KEY `index_status` (`status`),
  KEY `trailer_head_index` (`trailer_head`),
  KEY `idx_createdate` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1103345 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_protocol_cq`
--

DROP TABLE IF EXISTS `transport_protocol_cq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_protocol_cq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_number` varchar(24) NOT NULL,
  `cq_number` varchar(24) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_operator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_trans_number` (`trans_number`),
  KEY `idx_cq_number` (`cq_number`)
) ENGINE=InnoDB AUTO_INCREMENT=470737 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_protocol_flow`
--

DROP TABLE IF EXISTS `transport_protocol_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_protocol_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL,
  `status_time` timestamp NULL DEFAULT NULL,
  `lon` int(11) DEFAULT NULL,
  `lat` int(11) DEFAULT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  `fk_operator_id` int(11) DEFAULT NULL,
  `address` text,
  `content` text COMMENT '运单状态改变备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `trans_number_status` (`fk_trans_number`,`status`),
  KEY `index_name` (`fk_trans_number`),
  KEY `index_trans_status` (`fk_trans_number`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4217975 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_protocol_note`
--

DROP TABLE IF EXISTS `transport_protocol_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_protocol_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note` text,
  `note_type` int(11) NOT NULL DEFAULT '2',
  `fk_trans_number` varchar(15) NOT NULL,
  `fk_operator_id` int(11) NOT NULL,
  `upload_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `line_no` varchar(100) DEFAULT NULL,
  `location_code` varchar(6) DEFAULT NULL,
  `line_property` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fk_trans_number` (`fk_trans_number`),
  KEY `index_note_type` (`note_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1284408 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transport_protocol_relay`
--

DROP TABLE IF EXISTS `transport_protocol_relay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_protocol_relay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_number` varchar(24) NOT NULL COMMENT '运单号',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `location_code` varchar(6) NOT NULL COMMENT '地标编码',
  `start_time` varchar(16) DEFAULT NULL COMMENT '规定发车时间',
  `end_time` varchar(16) DEFAULT NULL COMMENT '规定到车时间',
  `index` tinyint(4) DEFAULT NULL COMMENT '中转顺序 从1开始',
  `location_code_type` int(11) DEFAULT NULL COMMENT '1:起点编码;2:经停点编码;3:终点编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `trans_number_code` (`trans_number`,`location_code`),
  KEY `index_trans_number` (`trans_number`),
  KEY `index_location` (`location_code`),
  KEY `index_trans_number_location_code_type` (`trans_number`,`location_code_type`),
  KEY `index_trans_number_location_code_and_type` (`trans_number`,`location_code`,`location_code_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2358640 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trigger_record`
--

DROP TABLE IF EXISTS `trigger_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_trans_number` varchar(24) DEFAULT NULL,
  `fk_location_code` varchar(6) DEFAULT NULL,
  `fk_child_code` varchar(6) DEFAULT NULL,
  `trigger_time` timestamp NULL DEFAULT NULL,
  `trigger_type` tinyint(4) DEFAULT NULL,
  `comt_type` tinyint(4) DEFAULT NULL,
  `operationer` varchar(32) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2445671 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `troubletrans`
--

DROP TABLE IF EXISTS `troubletrans`;
/*!50001 DROP VIEW IF EXISTS `troubletrans`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `troubletrans` (
  `trans_number` tinyint NOT NULL,
  `plate` tinyint NOT NULL,
  `line_no` tinyint NOT NULL,
  `carrier_name` tinyint NOT NULL,
  `report_id` tinyint NOT NULL,
  `create_time` tinyint NOT NULL,
  `line_property` tinyint NOT NULL,
  `report_content` tinyint NOT NULL,
  `report_type` tinyint NOT NULL,
  `input_type` tinyint NOT NULL,
  `fk_user_id` tinyint NOT NULL,
  `start_time` tinyint NOT NULL,
  `end_time` tinyint NOT NULL,
  `provision_start_time` tinyint NOT NULL,
  `s_address` tinyint NOT NULL,
  `e_address` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `truck`
--

DROP TABLE IF EXISTS `truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(7) NOT NULL,
  `vehicle_no` varchar(45) DEFAULT NULL,
  `length` float DEFAULT NULL,
  `wide` float DEFAULT NULL,
  `high` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '车厢类型,0高栏:,1:厢式',
  `vehicle_type` varchar(45) DEFAULT NULL,
  `run_mode` int(11) DEFAULT NULL,
  `qr_code` varchar(8) DEFAULT NULL COMMENT '二维码编号',
  `line_property` varchar(45) DEFAULT NULL,
  `is_temp_truck` int(11) DEFAULT NULL,
  `is_forbidden` int(11) DEFAULT NULL,
  `org_code` varchar(6) DEFAULT NULL,
  `carrier_name` varchar(512) DEFAULT NULL,
  `carrier_code` varchar(10) DEFAULT NULL COMMENT '承运商编码',
  `fk_carrier_id` int(11) DEFAULT NULL COMMENT '承运商外键',
  `if_valid` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `is_onway` int(11) NOT NULL DEFAULT '0',
  `trailers` tinyint(4) DEFAULT NULL COMMENT '是否挂车  1挂车 0 非挂车',
  `plate_type` int(11) DEFAULT NULL COMMENT '车辆类型,1:一般车辆,2:挂车头,3:挂车厢',
  `container_length` varchar(10) DEFAULT NULL COMMENT '车厢长度',
  `container_wide` varchar(10) DEFAULT NULL COMMENT '车厢宽度',
  `container_high` varchar(10) DEFAULT NULL COMMENT '车厢高度',
  `container_model` varchar(10) DEFAULT NULL COMMENT '车厢类型,XS:厢式,GL:高栏',
  PRIMARY KEY (`id`,`plate`),
  KEY `IDX_PLATE` (`plate`),
  KEY `index_plate_is_onway` (`plate`,`is_onway`),
  KEY `index_carrier_name` (`carrier_name`(255))
) ENGINE=InnoDB AUTO_INCREMENT=161068 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truck_coefficient`
--

DROP TABLE IF EXISTS `truck_coefficient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck_coefficient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `truck_type` decimal(18,4) NOT NULL,
  `single_kilometer_fuel_consumption` decimal(18,4) NOT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `verify_time` timestamp NULL DEFAULT NULL,
  `verify_explain` varchar(256) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_truck_coefficient_pk` (`truck_type`,`single_kilometer_fuel_consumption`,`effective_time`),
  KEY `index_truck_coefficient_commit_status` (`commit_status`),
  KEY `index_truck_coefficient_effective_time` (`effective_time`),
  KEY `index_truck_coefficient_truck_type` (`truck_type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truck_cost`
--

DROP TABLE IF EXISTS `truck_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck_cost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `truck_type` decimal(18,4) NOT NULL,
  `mileage_start` decimal(18,4) NOT NULL,
  `mileage_end` decimal(18,4) NOT NULL,
  `base_price` decimal(18,4) NOT NULL,
  `effective_time` date NOT NULL,
  `commit_status` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_truck_cost_pk` (`truck_type`,`mileage_start`,`mileage_end`,`effective_time`),
  KEY `index_truck_cost_commit_status` (`commit_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `truck_type`
--

DROP TABLE IF EXISTS `truck_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `length` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trucks`
--

DROP TABLE IF EXISTS `trucks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trucks` (
  `plate` varchar(7) NOT NULL,
  `truck_type` tinyint(4) DEFAULT NULL,
  `carriage_type` tinyint(4) DEFAULT NULL,
  `url_vrc` varchar(512) DEFAULT NULL,
  `brand` varchar(25) DEFAULT NULL,
  `vehicle_model` varchar(25) DEFAULT NULL,
  `vehicle_num` varchar(30) DEFAULT NULL,
  `engine_model` varchar(30) DEFAULT NULL,
  `power` double DEFAULT NULL,
  `horsepower` double DEFAULT NULL,
  `vin` varchar(20) DEFAULT NULL,
  `truck_length` double DEFAULT NULL,
  `truck_width` double DEFAULT NULL,
  `truck_height` double DEFAULT NULL,
  `carriage_length` double DEFAULT NULL,
  `carriage_width` double DEFAULT NULL,
  `carriage_height` double DEFAULT NULL,
  `vehicle_send_date` date DEFAULT NULL,
  `url_vehicle_license` varchar(512) DEFAULT NULL,
  `belong_to` varchar(25) DEFAULT NULL,
  `total_mass` double DEFAULT NULL,
  `limit_mass` double DEFAULT NULL,
  `tow_weight` double DEFAULT NULL,
  `limit_person` int(11) DEFAULT NULL,
  `equipment_mass` double DEFAULT NULL,
  `licence_date` date DEFAULT NULL,
  `mandatory_scrapping_date` date DEFAULT NULL,
  `url_voc` varchar(512) DEFAULT NULL,
  `voc_send_date` date DEFAULT NULL,
  `url_truck_jqx` varchar(512) DEFAULT NULL,
  `jqx_total_cost` double DEFAULT NULL,
  `jqx_num` varchar(30) DEFAULT NULL,
  `jqx_bf_cost` double DEFAULT NULL,
  `jqx_start_date` date DEFAULT NULL,
  `jqx_end_date` date DEFAULT NULL,
  `jqx_travel_tax_amount` double DEFAULT NULL,
  `url_truck_syx` varchar(512) DEFAULT NULL,
  `syx_total_cost` double DEFAULT NULL,
  `syx_num` varchar(30) DEFAULT NULL,
  `third_person_cost` double DEFAULT NULL,
  `third_person_nocount` tinyint(4) DEFAULT NULL,
  `car_personnel_risks_cost` double DEFAULT NULL,
  `car_personnel_risks_nocount` tinyint(4) DEFAULT NULL,
  `car_personnel_risks_ck_cost` double DEFAULT NULL,
  `car_personnel_risks_ck_nocount` tinyint(4) DEFAULT NULL,
  `count_seat` tinyint(4) DEFAULT NULL,
  `car_lost_cost` double DEFAULT NULL,
  `car_lost_nocount` tinyint(4) DEFAULT NULL,
  `syx_start_date` date DEFAULT NULL,
  `syx_end_date` date DEFAULT NULL,
  `url_others_insurance` varchar(512) DEFAULT NULL,
  `others_insurance_cost` double DEFAULT NULL,
  `additional_risk_cost` double DEFAULT NULL,
  `additional_risk_num` varchar(30) DEFAULT NULL,
  `additional_risk_type` varchar(30) DEFAULT NULL,
  `additional_risk_start_date` date DEFAULT NULL,
  `additional_risk_end_date` date DEFAULT NULL,
  `locator_device_ishave` tinyint(4) DEFAULT NULL,
  `device_supplier` varchar(20) DEFAULT NULL,
  `data_get` varchar(20) DEFAULT NULL,
  `device_model` varchar(20) DEFAULT NULL,
  `device_type` varchar(20) DEFAULT NULL,
  `shipper_id` int(11) DEFAULT NULL,
  `committer` varchar(30) DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  `url_vrc_two` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `shipper_id` (`shipper_id`),
  KEY `ix_carrier_trucks_plate` (`plate`),
  CONSTRAINT `trucks_ibfk_1` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trunk`
--

DROP TABLE IF EXISTS `trunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trunk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) CHARACTER SET latin1 NOT NULL COMMENT '车牌号',
  `length` float DEFAULT NULL COMMENT '长度',
  `volume` float DEFAULT NULL COMMENT '体积',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(256) CHARACTER SET latin1 NOT NULL COMMENT '密码',
  `email` varchar(64) DEFAULT NULL,
  `mobile` varchar(11) CHARACTER SET latin1 DEFAULT NULL COMMENT '移动电话号码',
  `telephone` varchar(12) CHARACTER SET latin1 DEFAULT NULL COMMENT '座机号码',
  `role_type` tinyint(4) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(32) DEFAULT NULL,
  `fullname` varchar(32) DEFAULT NULL,
  `photo_url` text,
  `zh_name` varchar(128) DEFAULT NULL COMMENT '名称  v0.1版本',
  `user_no` varchar(16) CHARACTER SET latin1 DEFAULT NULL COMMENT '登录名 v0.1版本',
  `registration_id` varchar(36) DEFAULT NULL,
  `fk_location_code` varchar(45) DEFAULT NULL,
  `fk_dept_id` int(11) DEFAULT NULL COMMENT '部门外键  v0.1版本',
  `update_time` timestamp NULL DEFAULT NULL,
  `source` int(11) NOT NULL DEFAULT '1' COMMENT '注册来源',
  `user_type` int(11) DEFAULT '2',
  `address` varchar(128) DEFAULT NULL,
  `com_type` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_no`),
  KEY `index_username` (`username`),
  KEY `unique_user_no` (`user_no`),
  KEY `unique_email` (`email`),
  KEY `unique_mobile` (`mobile`),
  KEY `unique_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=78366 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(256) NOT NULL,
  `com_name` varchar(30) NOT NULL,
  `com_type` int(11) NOT NULL,
  `address` varchar(128) DEFAULT NULL,
  `role` int(11) NOT NULL,
  `passwd_expire` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version_info`
--

DROP TABLE IF EXISTS `version_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `app_ver` varchar(32) NOT NULL,
  `device_type` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `troubletrans`
--

/*!50001 DROP TABLE IF EXISTS `troubletrans`*/;
/*!50001 DROP VIEW IF EXISTS `troubletrans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`test_camel`@`%` SQL SECURITY INVOKER */
/*!50001 VIEW `troubletrans` AS (select `transport_protocol`.`trans_number` AS `trans_number`,`transport_protocol`.`plate` AS `plate`,`transport_protocol`.`line_no` AS `line_no`,`transport_protocol`.`carrier_name` AS `carrier_name`,`driver_live_reporting`.`id` AS `report_id`,`transport_protocol`.`create_time` AS `create_time`,`transport_protocol`.`line_property` AS `line_property`,`driver_live_reporting`.`content` AS `report_content`,`driver_live_reporting`.`report_type` AS `report_type`,`driver_live_reporting`.`input_type` AS `input_type`,`driver_live_reporting`.`fk_user_id` AS `fk_user_id`,`driver_live_reporting`.`start_time` AS `start_time`,`driver_live_reporting`.`end_time` AS `end_time`,`transport_protocol`.`start_time` AS `provision_start_time`,`driver_live_reporting`.`s_address` AS `s_address`,`driver_live_reporting`.`e_address` AS `e_address` from (`transport_protocol` join `driver_live_reporting`) where (`transport_protocol`.`trans_number` = `driver_live_reporting`.`fk_trans_number`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-30 16:33:01
