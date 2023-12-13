-- MySQL dump 10.13  Distrib 5.7.42, for Linux (x86_64)
--
-- Host: localhost    Database: AssignAide_development
-- ------------------------------------------------------
-- Server version	5.7.42

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
-- Table structure for table `active_storage_attachments`
--

DROP TABLE IF EXISTS `active_storage_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_storage_attachments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `record_type` varchar(255) NOT NULL,
  `record_id` bigint(20) NOT NULL,
  `blob_id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_attachments_uniqueness` (`record_type`,`record_id`,`name`,`blob_id`),
  KEY `index_active_storage_attachments_on_blob_id` (`blob_id`),
  CONSTRAINT `fk_rails_c3b3935057` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_attachments`
--

LOCK TABLES `active_storage_attachments` WRITE;
/*!40000 ALTER TABLE `active_storage_attachments` DISABLE KEYS */;
INSERT INTO `active_storage_attachments` VALUES (6,'image','Cast',1,6,'2023-12-09 04:23:03.464047'),(7,'image','ActiveStorage::VariantRecord',5,7,'2023-12-09 04:23:09.579117');
/*!40000 ALTER TABLE `active_storage_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_storage_blobs`
--

DROP TABLE IF EXISTS `active_storage_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_storage_blobs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `metadata` text,
  `service_name` varchar(255) NOT NULL,
  `byte_size` bigint(20) NOT NULL,
  `checksum` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_blobs_on_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_blobs`
--

LOCK TABLES `active_storage_blobs` WRITE;
/*!40000 ALTER TABLE `active_storage_blobs` DISABLE KEYS */;
INSERT INTO `active_storage_blobs` VALUES (6,'p8iwlw13ksa2hla2yhsdt4j1qr9d','lucas-santos-r-UaSYUqF9o-unsplash.jpg','image/jpeg','{\"identified\":true,\"width\":6000,\"height\":4000,\"analyzed\":true}','local',1961989,'7Ts7PJG9h7N6egD9QOC4rw==','2023-12-09 04:23:03.461245'),(7,'abkwji7vtp5uoea695vajz9svbf4','lucas-santos-r-UaSYUqF9o-unsplash.jpg','image/jpeg','{\"identified\":true,\"width\":200,\"height\":133,\"analyzed\":true}','local',10379,'I+fMwGtWTTVuMjuJWNmb9Q==','2023-12-09 04:23:09.571648');
/*!40000 ALTER TABLE `active_storage_blobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_storage_variant_records`
--

DROP TABLE IF EXISTS `active_storage_variant_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_storage_variant_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blob_id` bigint(20) NOT NULL,
  `variation_digest` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_variant_records_uniqueness` (`blob_id`,`variation_digest`),
  CONSTRAINT `fk_rails_993965df05` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_variant_records`
--

LOCK TABLES `active_storage_variant_records` WRITE;
/*!40000 ALTER TABLE `active_storage_variant_records` DISABLE KEYS */;
INSERT INTO `active_storage_variant_records` VALUES (5,6,'c5V21n0MoEQcdiP7sX4iBoKR00M=');
/*!40000 ALTER TABLE `active_storage_variant_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2023-11-09 12:22:28.302022','2023-11-09 12:22:28.302022');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brake_times`
--

DROP TABLE IF EXISTS `brake_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brake_times` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `min_work_duration` int(11) DEFAULT NULL,
  `max_work_duration` int(11) DEFAULT NULL,
  `break_duration` int(11) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brake_times`
--

LOCK TABLES `brake_times` WRITE;
/*!40000 ALTER TABLE `brake_times` DISABLE KEYS */;
INSERT INTO `brake_times` VALUES (1,0,360,0,'2023-11-26 02:22:38.498399','2023-11-26 02:22:38.498399'),(2,361,480,45,'2023-11-26 02:22:38.508011','2023-11-26 02:22:38.508011'),(3,481,1440,60,'2023-11-26 02:22:38.522885','2023-11-26 02:22:38.522885'),(4,540,1000,30,'2023-12-09 02:49:09.437634','2023-12-09 02:49:09.437634');
/*!40000 ALTER TABLE `brake_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casts`
--

DROP TABLE IF EXISTS `casts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `first_name` varchar(255) NOT NULL,
  `family_name` varchar(255) NOT NULL,
  `company_id` int(11) NOT NULL,
  `health` int(11) NOT NULL DEFAULT '100',
  `sara_shiwake_skill_id` int(11) NOT NULL DEFAULT '1',
  `sara_arai_skill_id` int(11) NOT NULL DEFAULT '1',
  `sara_nagashi_skill_id` int(11) NOT NULL DEFAULT '1',
  `sara_huki_skill_id` int(11) NOT NULL DEFAULT '1',
  `kigu_arai_skill_id` int(11) NOT NULL DEFAULT '1',
  `kigu_nagashi_skill_id` int(11) NOT NULL DEFAULT '1',
  `kigu_huki_skill_id` int(11) NOT NULL DEFAULT '1',
  `silver_migaki_skill_id` int(11) NOT NULL DEFAULT '1',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime(6) DEFAULT NULL,
  `remember_created_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_casts_on_email` (`email`),
  UNIQUE KEY `index_casts_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casts`
--

LOCK TABLES `casts` WRITE;
/*!40000 ALTER TABLE `casts` DISABLE KEYS */;
INSERT INTO `casts` VALUES (1,'bbb@bbb','$2a$12$nPIW5Whh7r.O0cfPfEsK0.doaZZVvs9GgBAvQ1GiVJx6rpHS1F7Na','タロウ','テスト',12345678,100,3,2,4,3,3,3,2,4,NULL,NULL,NULL,'2023-11-11 10:42:46.322901','2023-12-09 06:44:54.258049',1),(2,'ccc@ccc','$2a$12$yhrUG1EBB0Fh8GXrEGWLj.I3YR9Z6ev1gYhXopJqViBzDpn.5aHUW','テスト','ヤマダ',87654321,100,1,2,1,2,3,1,1,4,NULL,NULL,NULL,'2023-11-11 16:42:29.798515','2023-11-11 18:38:00.701572',0),(23,'rosanna_baumbach@runte.example','$2a$12$FcAeOFwpU9oJOse8tqBwpOfNMVR3PwE95dMTw/jKp1kQuUGoakDjm','ヨシハル','オクダ',29496768,100,2,3,3,2,4,2,2,2,NULL,NULL,NULL,'2023-11-19 20:18:10.276730','2023-11-19 20:18:10.276730',0),(24,'ken_schumm@goodwin.test','$2a$12$hGWMi87DmdzU.hr5Mjg.JeUoXM7QCeBpAZ3dxyEyvPv362ocKSUMG','アユキ','アオヤマ',58026830,100,2,2,2,2,3,3,3,4,NULL,NULL,NULL,'2023-11-19 20:18:10.472414','2023-11-19 20:18:10.472414',0),(25,'brigitte_schiller@bednar.example','$2a$12$elmuX6qJ.4B0p5DzZ9GVE.Hm0DggMFZUwt0/LHZGJvac75g.Oovmy','ソウマ','ムライ',87042987,100,4,2,3,2,4,2,4,4,NULL,NULL,NULL,'2023-11-19 20:18:10.672397','2023-11-19 20:18:10.672397',0),(26,'georgene_monahan@towne-schinner.test','$2a$12$Ibav.pYRn4NrmBkK9cbKi.QlWVD7UtTKImNzhhgAlYJFeRbWRoUsy','ミホコ','ミヨシ',70854774,100,2,2,4,2,2,3,4,2,NULL,NULL,NULL,'2023-11-19 20:18:10.862765','2023-11-19 20:18:10.862765',0),(27,'lani@schneider.example','$2a$12$BWa8Yd4hpzkshNUiz02BV.ndo/tzHZZ45M60BWzwivXyIBjTgVRcS','リユ','ヤモト',50283795,100,4,2,4,2,3,3,2,2,NULL,NULL,NULL,'2023-11-19 20:18:11.050541','2023-11-19 20:18:11.050541',0),(28,'shayne@gislason.example','$2a$12$R8aAQ47v8drIL/ftaUwysuNRhjYkTrgfwlE1GFkowa/PoNhNJcUse','トオル','コンドウ',70425449,100,3,3,2,4,2,3,4,4,NULL,NULL,NULL,'2023-11-19 20:18:11.244817','2023-11-19 20:18:11.244817',0),(29,'monte@bergstrom-marvin.test','$2a$12$.mz4FH6oZ8hYEmpziifrJO2JJHU6dgydC4AhbtHHrxwhgmPIxnMD6','ナミエ','コタニ',56080411,100,3,2,2,2,4,2,2,4,NULL,NULL,NULL,'2023-11-19 20:18:11.440254','2023-11-19 20:18:11.440254',0),(30,'doug@orn-baumbach.test','$2a$12$tsQMcPlGXIt3wEXAO9WAwON2c4AOuYdOEiOf5ucpzow07lpyRorVK','イクヨ','イノウエ',41193565,100,2,4,3,3,2,4,2,2,NULL,NULL,NULL,'2023-11-19 20:18:11.633258','2023-11-19 20:18:11.633258',0),(31,'raymon@wintheiser-weber.test','$2a$12$aj8wjfODEHIxXFjEkI9t9.RI.BeSNHeQS9oDBDUFAAN0ou2Mtg96y','マキナ','ハラ',75887711,100,4,4,3,4,4,4,4,2,NULL,NULL,NULL,'2023-11-19 20:18:11.821195','2023-11-19 20:18:11.821195',0),(32,'eladia@murray.test','$2a$12$HVzBc1YzWTImdt4n.bQdy.djP8QVcFIOFdfnUu.XWeHz8zeEX7jLK','タカエ','セキネ',30610094,100,3,3,4,3,4,4,2,4,NULL,NULL,NULL,'2023-11-19 20:18:12.006197','2023-11-19 20:18:12.006197',0),(33,'randal@aufderhar.example','$2a$12$AYihA5Yl4G9GQS/P9jPi3.Hdtnj7.UfkLUjoJH8FpYF.d2USG7Xru','リナ','ミヨシ',41736734,100,3,4,4,2,4,4,2,2,NULL,NULL,NULL,'2023-11-19 20:20:18.073091','2023-11-19 20:20:18.073091',0),(34,'wallace.bosco@murphy.example','$2a$12$tgVH/ZejCD1bySj6Z92USeRCpG4a65KOcngl5Lxp.L3bONSI4Ngim','ヤスシ','ヒラカワ',39397708,100,4,2,2,3,4,4,3,4,NULL,NULL,NULL,'2023-11-19 20:20:18.257518','2023-11-19 20:20:18.257518',0),(35,'aurora_cole@jast.test','$2a$12$ILeLEm8vGXqpADxmPdvKxut/fbKjD8tQkon0G8nr9R9viwg6k9oJu','アキサ','トクナガ',96404263,100,2,2,3,3,4,2,3,2,NULL,NULL,NULL,'2023-11-19 20:20:18.442740','2023-11-19 20:20:18.442740',0),(36,'jimmy@pagac.test','$2a$12$8ARJeKPHLwCrM1mToMnXY.x12xQUmU8X3/MLc.XmtN9JBD0czgzDe','エイト','フジイ',63049643,100,4,4,2,3,3,4,3,2,NULL,NULL,NULL,'2023-11-19 20:20:18.637589','2023-11-19 20:20:18.637589',0),(37,'clair@mayer.example','$2a$12$1auO7.J6cx4MsycMOxzlJeXDnFsud8OxJssou22mcP9Kx2U/TYijS','タテヨシ','ホリ',81027991,100,2,2,4,4,2,2,4,2,NULL,NULL,NULL,'2023-11-19 20:20:18.837736','2023-11-19 20:20:18.837736',0),(38,'omega@robel.example','$2a$12$D05Hklw6ZKWFCIBVRu081.2OZHmIR/25f7DmOmU2L.BBvMNWXopn.','レン','カワハラ',70490770,100,3,2,3,3,2,3,4,4,NULL,NULL,NULL,'2023-11-19 20:20:19.029013','2023-11-19 20:20:19.029013',0),(39,'grace_collins@yundt.example','$2a$12$VEVBiyIMwZzKxOkjUoDvcenrIzXkEKSyIln8yt.3IoV91jM6bAz7i','ヨシマサ','イトウ',78515082,100,3,2,4,3,3,4,3,2,NULL,NULL,NULL,'2023-11-19 20:20:19.217198','2023-11-19 20:20:19.217198',0),(40,'elbert.considine@stanton.example','$2a$12$3MmIn/Rm3PNYtW1WX3V96Ov.BWRJ3BxwKIJU6e9jIiL/cLKMcHfg2','ミキホ','アンドウ',19524619,100,2,2,4,3,4,4,2,3,NULL,NULL,NULL,'2023-11-19 20:20:19.399870','2023-11-19 20:20:19.399870',0),(41,'else@erdman-mertz.test','$2a$12$OWRU1nSOFZ0bvnj8AotqXuKGiwpcDxlObPrwMsWHMYNInHvGNfDPu','エリ','カワグチ',77474239,100,4,4,3,3,4,4,3,2,NULL,NULL,NULL,'2023-11-19 20:20:19.585381','2023-11-19 20:20:19.585381',0),(42,'jerilyn@keebler.example','$2a$12$HmvmTG5yQ.igtZ.ZU/htGeEX6fnS8m0n/Vc/FBqoIvp1WV8328p5W','シエル','イワタ',25465975,100,3,2,3,4,3,2,4,3,NULL,NULL,NULL,'2023-11-19 20:20:19.770132','2023-11-19 20:20:19.770132',0);
/*!40000 ALTER TABLE `casts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `position_name` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  `fatigue_level` int(11) NOT NULL,
  `position_type` int(11) NOT NULL,
  `required_skill_level` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (1,'sara_shiwake',2,40,0,2,'2023-11-13 01:41:15.592776','2023-11-13 01:41:15.592776'),(2,'sara_arai',1,30,0,2,'2023-11-13 01:41:15.603399','2023-11-13 01:41:15.603399'),(3,'sara_nagashi',1,20,0,2,'2023-11-13 01:41:15.619631','2023-11-13 01:41:15.619631'),(4,'sara_huki',2,10,1,2,'2023-11-13 01:41:15.629080','2023-11-13 01:41:15.629080'),(5,'kigu_arai',1,30,0,2,'2023-11-13 01:41:15.638471','2023-11-13 01:41:15.638471'),(6,'kigu_nagashi',1,20,0,2,'2023-11-13 01:41:15.643347','2023-11-13 01:41:15.643347'),(7,'kigu_huki',2,10,1,2,'2023-11-13 01:41:15.652830','2023-11-13 01:41:15.652830'),(8,'silver_migaki',1,10,1,2,'2023-11-13 01:41:15.661419','2023-11-13 01:41:15.661419'),(9,'extra',99,0,2,1,'2023-11-13 01:41:15.669572','2023-11-13 01:41:15.669572'),(10,'brake',0,0,3,0,'2023-12-03 22:20:18.592754','2023-12-03 22:23:59.167334');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cast_id` bigint(20) NOT NULL,
  `position_id` bigint(20) NOT NULL,
  `workday_id` bigint(20) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_schedules_on_cast_id` (`cast_id`),
  KEY `index_schedules_on_position_id` (`position_id`),
  KEY `index_schedules_on_workday_id` (`workday_id`),
  CONSTRAINT `fk_rails_1ca0a8f068` FOREIGN KEY (`cast_id`) REFERENCES `casts` (`id`),
  CONSTRAINT `fk_rails_7f3455fc5f` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  CONSTRAINT `fk_rails_8f5ce96d75` FOREIGN KEY (`workday_id`) REFERENCES `workdays` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (202,1,10,85,'10:00:00','11:00:00','2023-12-04 02:48:27.861610','2023-12-04 02:48:27.861610'),(224,2,10,131,'14:00:00','15:00:00','2023-12-09 04:41:54.388224','2023-12-09 04:41:54.388224'),(227,23,10,133,'13:15:00','14:00:00','2023-12-09 04:55:46.480738','2023-12-09 04:55:46.480738'),(228,2,1,131,'11:00:00','13:00:00','2023-12-09 04:58:25.740732','2023-12-09 04:58:25.740732'),(229,2,2,131,'15:00:00','17:00:00','2023-12-09 04:58:42.501765','2023-12-09 04:58:42.501765'),(230,1,10,134,'17:00:00','18:00:00','2023-12-13 02:07:00.349630','2023-12-13 02:07:00.349630'),(231,1,1,134,'13:00:00','15:00:00','2023-12-13 02:07:10.282234','2023-12-13 02:07:10.282234');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20231109121311'),('20231109142523'),('20231111115652'),('20231111174342'),('20231113002044'),('20231115023116'),('20231115103452'),('20231125104509');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workdays`
--

DROP TABLE IF EXISTS `workdays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workdays` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cast_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_workdays_on_cast_id` (`cast_id`),
  CONSTRAINT `fk_rails_64ca71a02a` FOREIGN KEY (`cast_id`) REFERENCES `casts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workdays`
--

LOCK TABLES `workdays` WRITE;
/*!40000 ALTER TABLE `workdays` DISABLE KEYS */;
INSERT INTO `workdays` VALUES (85,1,'2023-12-04','07:00:00','16:00:00','2023-12-04 02:48:27.834860','2023-12-04 02:48:27.834860'),(131,2,'2023-12-09','09:00:00','18:00:00','2023-12-09 04:41:54.367944','2023-12-09 04:41:54.367944'),(133,23,'2023-12-09','10:00:00','17:00:00','2023-12-09 04:55:46.459652','2023-12-09 04:55:46.459652'),(134,1,'2023-12-13','12:00:00','21:00:00','2023-12-13 02:07:00.326731','2023-12-13 02:07:00.326731');
/*!40000 ALTER TABLE `workdays` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-13 22:03:55
