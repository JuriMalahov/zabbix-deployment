/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zabbix_proxy
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `message` varchar(2048) NOT NULL DEFAULT '',
  `action` int(11) NOT NULL DEFAULT 0,
  `old_severity` int(11) NOT NULL DEFAULT 0,
  `new_severity` int(11) NOT NULL DEFAULT 0,
  `suppress_until` int(11) NOT NULL DEFAULT 0,
  `taskid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT 0,
  `evaltype` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `esc_period` varchar(255) NOT NULL DEFAULT '1h',
  `formula` varchar(1024) NOT NULL DEFAULT '',
  `pause_suppressed` int(11) NOT NULL DEFAULT 1,
  `notify_if_canceled` int(11) NOT NULL DEFAULT 1,
  `pause_symptoms` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`actionid`),
  UNIQUE KEY `actions_2` (`name`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(1024) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `retries` int(11) NOT NULL DEFAULT 0,
  `error` varchar(2048) NOT NULL DEFAULT '',
  `esc_step` int(11) NOT NULL DEFAULT 0,
  `alerttype` int(11) NOT NULL DEFAULT 0,
  `p_eventid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  `parameters` text NOT NULL,
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  KEY `alerts_7` (`p_eventid`),
  KEY `alerts_8` (`acknowledgeid`),
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_5` FOREIGN KEY (`p_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_6` FOREIGN KEY (`acknowledgeid`) REFERENCES `acknowledges` (`acknowledgeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditlog` (
  `auditid` varchar(25) NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `clock` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(39) NOT NULL DEFAULT '',
  `action` int(11) NOT NULL DEFAULT 0,
  `resourcetype` int(11) NOT NULL DEFAULT 0,
  `resourceid` bigint(20) unsigned DEFAULT NULL,
  `resource_cuid` varchar(25) DEFAULT NULL,
  `resourcename` varchar(255) NOT NULL DEFAULT '',
  `recordsetid` varchar(25) NOT NULL,
  `details` longtext NOT NULL,
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  KEY `auditlog_3` (`resourcetype`,`resourceid`),
  KEY `auditlog_4` (`recordsetid`),
  KEY `auditlog_5` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxyid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT 0,
  `listen_dns` varchar(255) NOT NULL DEFAULT '',
  `host_metadata` text NOT NULL,
  `flags` int(11) NOT NULL DEFAULT 0,
  `tls_accepted` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`host`),
  KEY `autoreg_host_2` (`proxyid`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxyid`) REFERENCES `proxy` (`proxyid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changelog`
--

DROP TABLE IF EXISTS `changelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `changelog` (
  `changelogid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object` int(11) NOT NULL DEFAULT 0,
  `objectid` bigint(20) unsigned NOT NULL,
  `operation` int(11) NOT NULL DEFAULT 0,
  `clock` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`changelogid`),
  KEY `changelog_1` (`clock`)
) ENGINE=InnoDB AUTO_INCREMENT=6454 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changelog`
--

LOCK TABLES `changelog` WRITE;
/*!40000 ALTER TABLE `changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `changelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT 0,
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  `value2` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_autoreg_tls`
--

DROP TABLE IF EXISTS `config_autoreg_tls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_autoreg_tls` (
  `autoreg_tlsid` bigint(20) unsigned NOT NULL,
  `tls_psk_identity` varchar(128) NOT NULL DEFAULT '',
  `tls_psk` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_tlsid`),
  UNIQUE KEY `config_autoreg_tls_1` (`tls_psk_identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_autoreg_tls`
--

LOCK TABLES `config_autoreg_tls` WRITE;
/*!40000 ALTER TABLE `config_autoreg_tls` DISABLE KEYS */;
INSERT INTO `config_autoreg_tls` VALUES
(1,'','');
/*!40000 ALTER TABLE `config_autoreg_tls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connector`
--

DROP TABLE IF EXISTS `connector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `connector` (
  `connectorid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `protocol` int(11) NOT NULL DEFAULT 0,
  `data_type` int(11) NOT NULL DEFAULT 0,
  `url` varchar(2048) NOT NULL DEFAULT '',
  `max_records` int(11) NOT NULL DEFAULT 0,
  `max_senders` int(11) NOT NULL DEFAULT 1,
  `max_attempts` int(11) NOT NULL DEFAULT 1,
  `timeout` varchar(255) NOT NULL DEFAULT '5s',
  `http_proxy` varchar(255) NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT 0,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(128) NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT 1,
  `verify_host` int(11) NOT NULL DEFAULT 1,
  `ssl_cert_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `tags_evaltype` int(11) NOT NULL DEFAULT 0,
  `item_value_type` int(11) NOT NULL DEFAULT 31,
  `attempt_interval` varchar(32) NOT NULL DEFAULT '5s',
  PRIMARY KEY (`connectorid`),
  UNIQUE KEY `connector_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connector`
--

LOCK TABLES `connector` WRITE;
/*!40000 ALTER TABLE `connector` DISABLE KEYS */;
/*!40000 ALTER TABLE `connector` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger connector_insert after insert on connector
for each row
insert into changelog (object,objectid,operation,clock)
values (17,new.connectorid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger connector_update after update on connector
for each row
insert into changelog (object,objectid,operation,clock)
values (17,old.connectorid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger connector_delete before delete on connector
for each row
insert into changelog (object,objectid,operation,clock)
values (17,old.connectorid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `connector_tag`
--

DROP TABLE IF EXISTS `connector_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `connector_tag` (
  `connector_tagid` bigint(20) unsigned NOT NULL,
  `connectorid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`connector_tagid`),
  KEY `connector_tag_1` (`connectorid`),
  CONSTRAINT `c_connector_tag_1` FOREIGN KEY (`connectorid`) REFERENCES `connector` (`connectorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connector_tag`
--

LOCK TABLES `connector_tag` WRITE;
/*!40000 ALTER TABLE `connector_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `connector_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger connector_tag_insert after insert on connector_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (18,new.connector_tagid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger connector_tag_update after update on connector_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (18,old.connector_tagid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger connector_tag_delete before delete on connector_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (18,old.connector_tagid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `corr_condition`
--

DROP TABLE IF EXISTS `corr_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corr_condition` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_1` (`correlationid`),
  CONSTRAINT `c_corr_condition_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition`
--

LOCK TABLES `corr_condition` WRITE;
/*!40000 ALTER TABLE `corr_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_group`
--

DROP TABLE IF EXISTS `corr_condition_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corr_condition_group` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT 0,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_group_1` (`groupid`),
  CONSTRAINT `c_corr_condition_group_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE,
  CONSTRAINT `c_corr_condition_group_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_group`
--

LOCK TABLES `corr_condition_group` WRITE;
/*!40000 ALTER TABLE `corr_condition_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tag`
--

DROP TABLE IF EXISTS `corr_condition_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corr_condition_tag` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tag_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tag`
--

LOCK TABLES `corr_condition_tag` WRITE;
/*!40000 ALTER TABLE `corr_condition_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagpair`
--

DROP TABLE IF EXISTS `corr_condition_tagpair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corr_condition_tagpair` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `oldtag` varchar(255) NOT NULL DEFAULT '',
  `newtag` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagpair_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagpair`
--

LOCK TABLES `corr_condition_tagpair` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagpair` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagpair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagvalue`
--

DROP TABLE IF EXISTS `corr_condition_tagvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corr_condition_tagvalue` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagvalue_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagvalue`
--

LOCK TABLES `corr_condition_tagvalue` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_operation`
--

DROP TABLE IF EXISTS `corr_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corr_operation` (
  `corr_operationid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`corr_operationid`),
  KEY `corr_operation_1` (`correlationid`),
  CONSTRAINT `c_corr_operation_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_operation`
--

LOCK TABLES `corr_operation` WRITE;
/*!40000 ALTER TABLE `corr_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `correlation`
--

DROP TABLE IF EXISTS `correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `correlation` (
  `correlationid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `evaltype` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `formula` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`correlationid`),
  UNIQUE KEY `correlation_2` (`name`),
  KEY `correlation_1` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correlation`
--

LOCK TABLES `correlation` WRITE;
/*!40000 ALTER TABLE `correlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard` (
  `dashboardid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `private` int(11) NOT NULL DEFAULT 1,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `display_period` int(11) NOT NULL DEFAULT 30,
  `auto_start` int(11) NOT NULL DEFAULT 1,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`dashboardid`),
  KEY `dashboard_1` (`userid`),
  KEY `dashboard_2` (`templateid`),
  KEY `dashboard_3` (`uuid`),
  CONSTRAINT `c_dashboard_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `c_dashboard_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_page`
--

DROP TABLE IF EXISTS `dashboard_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_page` (
  `dashboard_pageid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `display_period` int(11) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dashboard_pageid`),
  KEY `dashboard_page_1` (`dashboardid`),
  CONSTRAINT `c_dashboard_page_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_page`
--

LOCK TABLES `dashboard_page` WRITE;
/*!40000 ALTER TABLE `dashboard_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_user`
--

DROP TABLE IF EXISTS `dashboard_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_user` (
  `dashboard_userid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 2,
  PRIMARY KEY (`dashboard_userid`),
  UNIQUE KEY `dashboard_user_1` (`dashboardid`,`userid`),
  KEY `dashboard_user_2` (`userid`),
  CONSTRAINT `c_dashboard_user_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_user`
--

LOCK TABLES `dashboard_user` WRITE;
/*!40000 ALTER TABLE `dashboard_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_usrgrp`
--

DROP TABLE IF EXISTS `dashboard_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_usrgrp` (
  `dashboard_usrgrpid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 2,
  PRIMARY KEY (`dashboard_usrgrpid`),
  UNIQUE KEY `dashboard_usrgrp_1` (`dashboardid`,`usrgrpid`),
  KEY `dashboard_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_dashboard_usrgrp_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_usrgrp`
--

LOCK TABLES `dashboard_usrgrp` WRITE;
/*!40000 ALTER TABLE `dashboard_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbversion`
--

DROP TABLE IF EXISTS `dbversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dbversion` (
  `dbversionid` bigint(20) unsigned NOT NULL,
  `mandatory` int(11) NOT NULL DEFAULT 0,
  `optional` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dbversionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbversion`
--

LOCK TABLES `dbversion` WRITE;
/*!40000 ALTER TABLE `dbversion` DISABLE KEYS */;
INSERT INTO `dbversion` VALUES
(1,7040000,7040000);
/*!40000 ALTER TABLE `dbversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `key_` varchar(2048) NOT NULL DEFAULT '',
  `snmp_community` varchar(255) NOT NULL DEFAULT '',
  `ports` varchar(255) NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT 0,
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT 0,
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT 0,
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT 0,
  `snmpv3_contextname` varchar(255) NOT NULL DEFAULT '',
  `host_source` int(11) NOT NULL DEFAULT 1,
  `name_source` int(11) NOT NULL DEFAULT 0,
  `allow_redirect` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`,`host_source`,`name_source`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger dchecks_insert after insert on dchecks
for each row
insert into changelog (object,objectid,operation,clock)
values (10,new.dcheckid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger dchecks_update after update on dchecks
for each row
insert into changelog (object,objectid,operation,clock)
values (10,old.dcheckid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger dchecks_delete before delete on dchecks
for each row
insert into changelog (object,objectid,operation,clock)
values (10,old.dcheckid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `lastup` int(11) NOT NULL DEFAULT 0,
  `lastdown` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxyid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `iprange` varchar(2048) NOT NULL DEFAULT '',
  `delay` varchar(255) NOT NULL DEFAULT '1h',
  `status` int(11) NOT NULL DEFAULT 0,
  `concurrency_max` int(11) NOT NULL DEFAULT 0,
  `error` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`druleid`),
  UNIQUE KEY `drules_2` (`name`),
  KEY `drules_1` (`proxyid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxyid`) REFERENCES `proxy` (`proxyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger drules_insert after insert on drules
for each row
insert into changelog (object,objectid,operation,clock)
values (9,new.druleid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger drules_update after update on drules
for each row
insert into changelog (object,objectid,operation,clock)
values (9,old.druleid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger drules_delete before delete on drules
for each row
insert into changelog (object,objectid,operation,clock)
values (9,old.druleid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `lastup` int(11) NOT NULL DEFAULT 0,
  `lastdown` int(11) NOT NULL DEFAULT 0,
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) NOT NULL DEFAULT '',
  `dns` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT 0,
  `esc_step` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `itemid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  `servicealarmid` bigint(20) unsigned DEFAULT NULL,
  `serviceid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`escalationid`),
  UNIQUE KEY `escalations_1` (`triggerid`,`itemid`,`serviceid`,`escalationid`),
  KEY `escalations_2` (`eventid`),
  KEY `escalations_3` (`nextcheck`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_recovery`
--

DROP TABLE IF EXISTS `event_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_recovery` (
  `eventid` bigint(20) unsigned NOT NULL,
  `r_eventid` bigint(20) unsigned NOT NULL,
  `c_eventid` bigint(20) unsigned DEFAULT NULL,
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `event_recovery_1` (`r_eventid`),
  KEY `event_recovery_2` (`c_eventid`),
  CONSTRAINT `c_event_recovery_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_3` FOREIGN KEY (`c_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_recovery`
--

LOCK TABLES `event_recovery` WRITE;
/*!40000 ALTER TABLE `event_recovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_recovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_suppress`
--

DROP TABLE IF EXISTS `event_suppress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_suppress` (
  `event_suppressid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `suppress_until` int(11) NOT NULL DEFAULT 0,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_suppressid`),
  UNIQUE KEY `event_suppress_1` (`eventid`,`maintenanceid`),
  KEY `event_suppress_2` (`suppress_until`),
  KEY `event_suppress_3` (`maintenanceid`),
  KEY `event_suppress_4` (`userid`),
  CONSTRAINT `c_event_suppress_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_suppress_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_suppress_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_suppress`
--

LOCK TABLES `event_suppress` WRITE;
/*!40000 ALTER TABLE `event_suppress` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_suppress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_symptom`
--

DROP TABLE IF EXISTS `event_symptom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_symptom` (
  `eventid` bigint(20) unsigned NOT NULL,
  `cause_eventid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`eventid`),
  KEY `event_symptom_1` (`cause_eventid`),
  CONSTRAINT `c_event_symptom_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_symptom_2` FOREIGN KEY (`cause_eventid`) REFERENCES `events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_symptom`
--

LOCK TABLES `event_symptom` WRITE;
/*!40000 ALTER TABLE `event_symptom` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_symptom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_tag`
--

DROP TABLE IF EXISTS `event_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_tag` (
  `eventtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`eventtagid`),
  KEY `event_tag_1` (`eventid`),
  CONSTRAINT `c_event_tag_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_tag`
--

LOCK TABLES `event_tag` WRITE;
/*!40000 ALTER TABLE `event_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT 0,
  `object` int(11) NOT NULL DEFAULT 0,
  `objectid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `clock` int(11) NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0,
  `acknowledged` int(11) NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  `name` varchar(2048) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`source`,`object`,`objectid`,`clock`),
  KEY `events_2` (`source`,`object`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT 0,
  `exp_delimiter` varchar(1) NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES
(1,1,'^(btrfs|ext2|ext3|ext4|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|apfs|refs|ntfs|fat32|zfs)$',3,',',0),
(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),
(5,4,'^(MMCSS|gupdate|SysmonLog|clr_optimization_v2.0.50727_32|clr_optimization_v4.0.30319_32)$',4,',',1),
(6,5,'^(automatic|automatic delayed)$',3,',',1),
(7,2,'^Software Loopback Interface',4,',',1),
(8,2,'^(In)?[Ll]oop[Bb]ack[0-9._]*$',4,',',1),
(9,2,'^NULL[0-9.]*$',4,',',1),
(10,2,'^[Ll]o[0-9.]*$',4,',',1),
(11,2,'^[Ss]ystem$',4,',',1),
(12,2,'^Nu[0-9.]*$',4,',',1),
(13,6,'(?i)error|fail|crash',3,',',0);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `name` varchar(12) NOT NULL DEFAULT '',
  `parameter` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`name`,`parameter`),
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger functions_insert after insert on functions
for each row
insert into changelog (object,objectid,operation,clock)
values (7,new.functionid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger functions_update after update on functions
for each row
insert into changelog (object,objectid,operation,clock)
values (7,old.functionid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger functions_delete before delete on functions
for each row
insert into changelog (object,objectid,operation,clock)
values (7,old.functionid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`globalmacroid`),
  UNIQUE KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES
(2,'{$SNMP_COMMUNITY}','public','',0);
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `globalvars` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `graph_discovery` (
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  `lastcheck` int(11) NOT NULL DEFAULT 0,
  `ts_delete` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`graphid`),
  KEY `graph_discovery_1` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `theme` varchar(64) NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) NOT NULL DEFAULT '',
  `graphcolor` varchar(6) NOT NULL DEFAULT '',
  `gridcolor` varchar(6) NOT NULL DEFAULT '',
  `maingridcolor` varchar(6) NOT NULL DEFAULT '',
  `gridbordercolor` varchar(6) NOT NULL DEFAULT '',
  `textcolor` varchar(6) NOT NULL DEFAULT '',
  `highlightcolor` varchar(6) NOT NULL DEFAULT '',
  `leftpercentilecolor` varchar(6) NOT NULL DEFAULT '',
  `rightpercentilecolor` varchar(6) NOT NULL DEFAULT '',
  `nonworktimecolor` varchar(6) NOT NULL DEFAULT '',
  `colorpalette` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`graphthemeid`),
  UNIQUE KEY `graph_theme_1` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT 900,
  `height` int(11) NOT NULL DEFAULT 200,
  `yaxismin` double NOT NULL DEFAULT 0,
  `yaxismax` double NOT NULL DEFAULT 100,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT 1,
  `show_triggers` int(11) NOT NULL DEFAULT 1,
  `graphtype` int(11) NOT NULL DEFAULT 0,
  `show_legend` int(11) NOT NULL DEFAULT 1,
  `show_3d` int(11) NOT NULL DEFAULT 0,
  `percent_left` double NOT NULL DEFAULT 0,
  `percent_right` double NOT NULL DEFAULT 0,
  `ymin_type` int(11) NOT NULL DEFAULT 0,
  `ymax_type` int(11) NOT NULL DEFAULT 0,
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT 0,
  `discover` int(11) NOT NULL DEFAULT 0,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`graphid`),
  KEY `graphs_1` (`name`),
  KEY `graphs_2` (`templateid`),
  KEY `graphs_3` (`ymin_itemid`),
  KEY `graphs_4` (`ymax_itemid`),
  KEY `graphs_5` (`uuid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT 0,
  `calc_fnc` int(11) NOT NULL DEFAULT 2,
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_discovery`
--

DROP TABLE IF EXISTS `group_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_discovery` (
  `groupdiscoveryid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `parent_group_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT 0,
  `ts_delete` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`groupdiscoveryid`),
  UNIQUE KEY `group_discovery_1` (`groupid`,`parent_group_prototypeid`),
  KEY `group_discovery_2` (`parent_group_prototypeid`),
  CONSTRAINT `c_group_discovery_1` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_discovery_2` FOREIGN KEY (`parent_group_prototypeid`) REFERENCES `group_prototype` (`group_prototypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_discovery`
--

LOCK TABLES `group_discovery` WRITE;
/*!40000 ALTER TABLE `group_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_prototype`
--

DROP TABLE IF EXISTS `group_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_prototype` (
  `group_prototypeid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_prototypeid`),
  KEY `group_prototype_1` (`hostid`),
  KEY `group_prototype_2` (`groupid`),
  KEY `group_prototype_3` (`templateid`),
  CONSTRAINT `c_group_prototype_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_group_prototype_3` FOREIGN KEY (`templateid`) REFERENCES `group_prototype` (`group_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_prototype`
--

LOCK TABLES `group_prototype` WRITE;
/*!40000 ALTER TABLE `group_prototype` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ha_node`
--

DROP TABLE IF EXISTS `ha_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ha_node` (
  `ha_nodeid` varchar(25) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT 10051,
  `lastaccess` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `ha_sessionid` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`ha_nodeid`),
  UNIQUE KEY `ha_node_1` (`name`),
  KEY `ha_node_2` (`status`,`lastaccess`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ha_node`
--

LOCK TABLES `ha_node` WRITE;
/*!40000 ALTER TABLE `ha_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `ha_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hgset`
--

DROP TABLE IF EXISTS `hgset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hgset` (
  `hgsetid` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`hgsetid`),
  KEY `hgset_1` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hgset`
--

LOCK TABLES `hgset` WRITE;
/*!40000 ALTER TABLE `hgset` DISABLE KEYS */;
/*!40000 ALTER TABLE `hgset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hgset_group`
--

DROP TABLE IF EXISTS `hgset_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hgset_group` (
  `hgsetid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hgsetid`,`groupid`),
  KEY `hgset_group_1` (`groupid`),
  CONSTRAINT `c_hgset_group_1` FOREIGN KEY (`hgsetid`) REFERENCES `hgset` (`hgsetid`) ON DELETE CASCADE,
  CONSTRAINT `c_hgset_group_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hgset_group`
--

LOCK TABLES `hgset_group` WRITE;
/*!40000 ALTER TABLE `hgset_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `hgset_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `value` double NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`,`ns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_bin`
--

DROP TABLE IF EXISTS `history_bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_bin` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  `value` longblob NOT NULL,
  PRIMARY KEY (`itemid`,`clock`,`ns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_bin`
--

LOCK TABLES `history_bin` WRITE;
/*!40000 ALTER TABLE `history_bin` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_bin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_log` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT 0,
  `value` text NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`,`ns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`,`ns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_text` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `value` text NOT NULL,
  `ns` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`,`ns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `value` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`,`ns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_discovery`
--

DROP TABLE IF EXISTS `host_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_discovery` (
  `hostid` bigint(20) unsigned NOT NULL,
  `parent_hostid` bigint(20) unsigned DEFAULT NULL,
  `lldruleid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT 0,
  `ts_delete` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `disable_source` int(11) NOT NULL DEFAULT 0,
  `ts_disable` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hostid`),
  KEY `host_discovery_1` (`parent_hostid`),
  KEY `host_discovery_2` (`lldruleid`),
  CONSTRAINT `c_host_discovery_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_discovery_2` FOREIGN KEY (`parent_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_host_discovery_3` FOREIGN KEY (`lldruleid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_discovery`
--

LOCK TABLES `host_discovery` WRITE;
/*!40000 ALTER TABLE `host_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_hgset`
--

DROP TABLE IF EXISTS `host_hgset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_hgset` (
  `hostid` bigint(20) unsigned NOT NULL,
  `hgsetid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostid`),
  KEY `host_hgset_1` (`hgsetid`),
  CONSTRAINT `c_host_hgset_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_hgset_2` FOREIGN KEY (`hgsetid`) REFERENCES `hgset` (`hgsetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_hgset`
--

LOCK TABLES `host_hgset` WRITE;
/*!40000 ALTER TABLE `host_hgset` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_hgset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT 0,
  `type` varchar(64) NOT NULL DEFAULT '',
  `type_full` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  `alias` varchar(128) NOT NULL DEFAULT '',
  `os` varchar(128) NOT NULL DEFAULT '',
  `os_full` varchar(255) NOT NULL DEFAULT '',
  `os_short` varchar(128) NOT NULL DEFAULT '',
  `serialno_a` varchar(64) NOT NULL DEFAULT '',
  `serialno_b` varchar(64) NOT NULL DEFAULT '',
  `tag` varchar(64) NOT NULL DEFAULT '',
  `asset_tag` varchar(64) NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) NOT NULL DEFAULT '',
  `hardware` varchar(255) NOT NULL DEFAULT '',
  `hardware_full` text NOT NULL,
  `software` varchar(255) NOT NULL DEFAULT '',
  `software_full` text NOT NULL,
  `software_app_a` varchar(64) NOT NULL DEFAULT '',
  `software_app_b` varchar(64) NOT NULL DEFAULT '',
  `software_app_c` varchar(64) NOT NULL DEFAULT '',
  `software_app_d` varchar(64) NOT NULL DEFAULT '',
  `software_app_e` varchar(64) NOT NULL DEFAULT '',
  `contact` text NOT NULL,
  `location` text NOT NULL,
  `location_lat` varchar(16) NOT NULL DEFAULT '',
  `location_lon` varchar(16) NOT NULL DEFAULT '',
  `notes` text NOT NULL,
  `chassis` varchar(64) NOT NULL DEFAULT '',
  `model` varchar(64) NOT NULL DEFAULT '',
  `hw_arch` varchar(32) NOT NULL DEFAULT '',
  `vendor` varchar(64) NOT NULL DEFAULT '',
  `contract_number` varchar(64) NOT NULL DEFAULT '',
  `installer_name` varchar(64) NOT NULL DEFAULT '',
  `deployment_status` varchar(64) NOT NULL DEFAULT '',
  `url_a` varchar(2048) NOT NULL DEFAULT '',
  `url_b` varchar(2048) NOT NULL DEFAULT '',
  `url_c` varchar(2048) NOT NULL DEFAULT '',
  `host_networks` text NOT NULL,
  `host_netmask` varchar(39) NOT NULL DEFAULT '',
  `host_router` varchar(39) NOT NULL DEFAULT '',
  `oob_ip` varchar(39) NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) NOT NULL DEFAULT '',
  `oob_router` varchar(39) NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) NOT NULL DEFAULT '',
  `site_address_a` varchar(128) NOT NULL DEFAULT '',
  `site_address_b` varchar(128) NOT NULL DEFAULT '',
  `site_address_c` varchar(128) NOT NULL DEFAULT '',
  `site_city` varchar(128) NOT NULL DEFAULT '',
  `site_state` varchar(64) NOT NULL DEFAULT '',
  `site_country` varchar(64) NOT NULL DEFAULT '',
  `site_zip` varchar(64) NOT NULL DEFAULT '',
  `site_rack` varchar(128) NOT NULL DEFAULT '',
  `site_notes` text NOT NULL,
  `poc_1_name` varchar(128) NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_1_notes` text NOT NULL,
  `poc_2_name` varchar(128) NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_2_notes` text NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_proxy`
--

DROP TABLE IF EXISTS `host_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_proxy` (
  `hostproxyid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) NOT NULL DEFAULT '',
  `proxyid` bigint(20) unsigned DEFAULT NULL,
  `revision` bigint(20) unsigned NOT NULL DEFAULT 0,
  `tls_accept` int(11) NOT NULL DEFAULT 1,
  `tls_issuer` varchar(1024) NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) NOT NULL DEFAULT '',
  `tls_psk` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`hostproxyid`),
  UNIQUE KEY `host_proxy_1` (`hostid`),
  KEY `host_proxy_2` (`proxyid`),
  KEY `host_proxy_3` (`revision`),
  CONSTRAINT `c_host_proxy_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_host_proxy_2` FOREIGN KEY (`proxyid`) REFERENCES `proxy` (`proxyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_proxy`
--

LOCK TABLES `host_proxy` WRITE;
/*!40000 ALTER TABLE `host_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_proxy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger host_proxy_insert after insert on host_proxy
for each row
insert into changelog (object,objectid,operation,clock)
values (21,new.hostproxyid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger host_proxy_update after update on host_proxy
for each row
insert into changelog (object,objectid,operation,clock)
values (21,old.hostproxyid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger host_proxy_delete before delete on host_proxy
for each row
insert into changelog (object,objectid,operation,clock)
values (21,old.hostproxyid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_rtdata`
--

DROP TABLE IF EXISTS `host_rtdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_rtdata` (
  `hostid` bigint(20) unsigned NOT NULL,
  `active_available` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_rtdata_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_rtdata`
--

LOCK TABLES `host_rtdata` WRITE;
/*!40000 ALTER TABLE `host_rtdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_rtdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_tag`
--

DROP TABLE IF EXISTS `host_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_tag` (
  `hosttagid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `automatic` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hosttagid`),
  KEY `host_tag_1` (`hostid`),
  CONSTRAINT `c_host_tag_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_tag`
--

LOCK TABLES `host_tag` WRITE;
/*!40000 ALTER TABLE `host_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger host_tag_insert after insert on host_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (2,new.hosttagid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger host_tag_update after update on host_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (2,old.hosttagid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger host_tag_delete before delete on host_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (2,old.hosttagid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `automatic` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
INSERT INTO `hostmacro` VALUES
(5203,10343,'{$AGENT.NODATA_TIMEOUT}','30m','',0,0),
(5204,10343,'{$CPU.UTIL.CRIT}','90','',0,0),
(5205,10343,'{$IF.ERRORS.WARN}','2','',0,0),
(5206,10343,'{$IFCONTROL}','1','',0,0),
(5207,10343,'{$KERNEL.MAXFILES.MIN}','256','',0,0),
(5208,10343,'{$KERNEL.MAXPROC.MIN}','1024','',0,0),
(5209,10343,'{$LOAD_AVG_PER_CPU.MAX.WARN}','1.5','',0,0),
(5210,10343,'{$MEMORY.AVAILABLE.MIN}','20M','',0,0),
(5211,10343,'{$MEMORY.UTIL.MAX}','90','',0,0),
(5212,10343,'{$NET.IF.IFNAME.MATCHES}','^.*$','',0,0),
(5213,10343,'{$NET.IF.IFNAME.NOT_MATCHES}','(^Software Loopback Interface|^NULL[0-9.]*$|^[Ll]o[0-9.]*$|^[Ss]ystem$|^Nu[0-9.]*$|^veth[0-9A-z]+$|docker[0-9]+|br-[a-z0-9]{12})','',0,0),
(5214,10343,'{$SWAP.PFREE.MIN.WARN}','50','',0,0),
(5216,10343,'{$VFS.DEV.DEVNAME.MATCHES}','.+','',0,0),
(5217,10343,'{$VFS.DEV.DEVNAME.NOT_MATCHES}','^(loop[0-9]*|sd[a-z][0-9]+|nbd[0-9]+|sr[0-9]+|fd[0-9]+|dm-[0-9]+|ram[0-9]+|ploop[a-z0-9]+|md[0-9]*|hcp[0-9]*|zram[0-9]*)','',0,0),
(5218,10343,'{$VFS.DEV.READ.AWAIT.WARN}','20','',0,0),
(5219,10343,'{$VFS.DEV.WRITE.AWAIT.WARN}','20','',0,0),
(5220,10343,'{$VFS.FS.FSNAME.MATCHES}','.+','',0,0),
(5221,10343,'{$VFS.FS.FSNAME.NOT_MATCHES}','^(/dev|/sys|/run|/proc|.+/shm$)','',0,0),
(5222,10343,'{$VFS.FS.FSTYPE.MATCHES}','^(btrfs|ext2|ext3|ext4|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|apfs|refs|ntfs|fat32|zfs)$','',0,0),
(5223,10343,'{$VFS.FS.FSTYPE.NOT_MATCHES}','^\\s$','',0,0),
(5224,10343,'{$VFS.FS.INODE.PFREE.MIN.CRIT}','10','',0,0),
(5225,10343,'{$VFS.FS.INODE.PFREE.MIN.WARN}','20','',0,0),
(5226,10343,'{$VFS.FS.PUSED.MAX.CRIT}','90','',0,0),
(5227,10343,'{$VFS.FS.PUSED.MAX.WARN}','80','',0,0),
(5393,10343,'{$IF.UTIL.MAX}','90','',0,0),
(5539,10343,'{$AGENT.TIMEOUT}','5m','',0,0),
(8066,10772,'{$STUB_STATUS_HOST}','192.168.1.2','',0,0),
(8067,10772,'{$STUB_STATUS_PATH}','server-status?auto','',0,0),
(8068,10772,'{$STUB_STATUS_PORT}','80','',0,0),
(8069,10772,'{$STUB_STATUS_PROT}','http','',0,0);
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro_config`
--

DROP TABLE IF EXISTS `hostmacro_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostmacro_config` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `section_name` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `required` int(11) NOT NULL DEFAULT 0,
  `regex` varchar(255) NOT NULL DEFAULT '',
  `options` text NOT NULL,
  PRIMARY KEY (`hostmacroid`),
  CONSTRAINT `c_hostmacro_config_1` FOREIGN KEY (`hostmacroid`) REFERENCES `hostmacro` (`hostmacroid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro_config`
--

LOCK TABLES `hostmacro_config` WRITE;
/*!40000 ALTER TABLE `hostmacro_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostmacro_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxyid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `ipmi_authtype` int(11) NOT NULL DEFAULT -1,
  `ipmi_privilege` int(11) NOT NULL DEFAULT 2,
  `ipmi_username` varchar(16) NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) NOT NULL DEFAULT '',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT 0,
  `maintenance_type` int(11) NOT NULL DEFAULT 0,
  `maintenance_from` int(11) NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT 0,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `tls_connect` int(11) NOT NULL DEFAULT 1,
  `tls_accept` int(11) NOT NULL DEFAULT 1,
  `tls_issuer` varchar(1024) NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) NOT NULL DEFAULT '',
  `tls_psk` varchar(512) NOT NULL DEFAULT '',
  `discover` int(11) NOT NULL DEFAULT 0,
  `custom_interfaces` int(11) NOT NULL DEFAULT 0,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  `name_upper` varchar(128) NOT NULL DEFAULT '',
  `vendor_name` varchar(64) NOT NULL DEFAULT '',
  `vendor_version` varchar(32) NOT NULL DEFAULT '',
  `proxy_groupid` bigint(20) unsigned DEFAULT NULL,
  `monitored_by` int(11) NOT NULL DEFAULT 0,
  `wizard_ready` int(11) NOT NULL DEFAULT 0,
  `readme` text NOT NULL,
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxyid`),
  KEY `hosts_4` (`name`),
  KEY `hosts_5` (`maintenanceid`),
  KEY `hosts_6` (`name_upper`),
  KEY `hosts_7` (`templateid`),
  KEY `hosts_8` (`proxy_groupid`),
  KEY `hosts_9` (`uuid`),
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxyid`) REFERENCES `proxy` (`proxyid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`),
  CONSTRAINT `c_hosts_3` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_hosts_4` FOREIGN KEY (`proxy_groupid`) REFERENCES `proxy_group` (`proxy_groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES
(10343,NULL,'',3,-1,2,'','',NULL,0,0,0,'',0,NULL,'',1,1,'','','','',0,0,'','','','',NULL,0,0,''),
(10770,NULL,'Zabbix agent 1',0,-1,2,'','',NULL,0,0,0,'Zabbix agent 1',0,NULL,'',1,1,'','','','',0,0,'','ZABBIX AGENT 1','','',NULL,0,0,''),
(10771,NULL,'Zabbix agent 2',0,-1,2,'','',NULL,0,0,0,'Zabbix agent 2',0,NULL,'',1,1,'','','','',0,0,'','ZABBIX AGENT 2','','',NULL,0,0,''),
(10772,NULL,'',3,-1,2,'','',NULL,0,0,0,'',0,NULL,'',1,1,'','','','',0,0,'','','','',NULL,0,0,''),
(10773,NULL,'vESR',0,-1,2,'','',NULL,0,0,0,'vESR',0,NULL,'',1,1,'','','','',0,0,'','VESR','','',NULL,0,0,'');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger hosts_name_upper_insert
before insert on hosts for each row
set new.name_upper=upper(new.name) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger hosts_insert after insert on hosts
for each row
insert into changelog (object,objectid,operation,clock)
values (1,new.hostid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger hosts_name_upper_update
before update on hosts for each row
begin
if new.name<>old.name
then
set new.name_upper=upper(new.name);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger hosts_update after update on hosts
for each row
insert into changelog (object,objectid,operation,clock)
values (1,old.hostid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger hosts_delete before delete on hosts
for each row
insert into changelog (object,objectid,operation,clock)
values (1,old.hostid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  `link_type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES
(557,10770,10772,0),
(572,10771,10343,0),
(574,10770,10343,0);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) NOT NULL DEFAULT '',
  `field` varchar(64) NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hstgrp`
--

DROP TABLE IF EXISTS `hstgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hstgrp` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT 0,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`groupid`),
  UNIQUE KEY `hstgrp_1` (`type`,`name`),
  KEY `hstgrp_2` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hstgrp`
--

LOCK TABLES `hstgrp` WRITE;
/*!40000 ALTER TABLE `hstgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `hstgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT 0,
  `url` varchar(2048) NOT NULL DEFAULT '',
  `timeout` varchar(255) NOT NULL DEFAULT '15s',
  `posts` text NOT NULL,
  `required` varchar(255) NOT NULL DEFAULT '',
  `status_codes` varchar(255) NOT NULL DEFAULT '',
  `follow_redirects` int(11) NOT NULL DEFAULT 1,
  `retrieve_mode` int(11) NOT NULL DEFAULT 0,
  `post_type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstep_insert after insert on httpstep
for each row
insert into changelog (object,objectid,operation,clock)
values (14,new.httpstepid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstep_update after update on httpstep
for each row
insert into changelog (object,objectid,operation,clock)
values (14,old.httpstepid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstep_delete before delete on httpstep
for each row
insert into changelog (object,objectid,operation,clock)
values (14,old.httpstepid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `httpstep_field`
--

DROP TABLE IF EXISTS `httpstep_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httpstep_field` (
  `httpstep_fieldid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`httpstep_fieldid`),
  KEY `httpstep_field_1` (`httpstepid`),
  CONSTRAINT `c_httpstep_field_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep_field`
--

LOCK TABLES `httpstep_field` WRITE;
/*!40000 ALTER TABLE `httpstep_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstep_field_insert after insert on httpstep_field
for each row
insert into changelog (object,objectid,operation,clock)
values (15,new.httpstep_fieldid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstep_field_update after update on httpstep_field
for each row
insert into changelog (object,objectid,operation,clock)
values (15,old.httpstep_fieldid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstep_field_delete before delete on httpstep_field
for each row
insert into changelog (object,objectid,operation,clock)
values (15,old.httpstep_fieldid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`),
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstepitem_insert after insert on httpstepitem
for each row
insert into changelog (object,objectid,operation,clock)
values (16,new.httpstepitemid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstepitem_update after update on httpstepitem
for each row
insert into changelog (object,objectid,operation,clock)
values (16,old.httpstepitemid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httpstepitem_delete before delete on httpstepitem
for each row
insert into changelog (object,objectid,operation,clock)
values (16,old.httpstepitemid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `delay` varchar(255) NOT NULL DEFAULT '1m',
  `status` int(11) NOT NULL DEFAULT 0,
  `agent` varchar(255) NOT NULL DEFAULT 'Zabbix',
  `authentication` int(11) NOT NULL DEFAULT 0,
  `http_user` varchar(255) NOT NULL DEFAULT '',
  `http_password` varchar(255) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `http_proxy` varchar(255) NOT NULL DEFAULT '',
  `retries` int(11) NOT NULL DEFAULT 1,
  `ssl_cert_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT 0,
  `verify_host` int(11) NOT NULL DEFAULT 0,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`httptestid`),
  UNIQUE KEY `httptest_2` (`hostid`,`name`),
  KEY `httptest_3` (`status`),
  KEY `httptest_4` (`templateid`),
  KEY `httptest_5` (`uuid`),
  CONSTRAINT `c_httptest_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_httptest_3` FOREIGN KEY (`templateid`) REFERENCES `httptest` (`httptestid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptest_insert after insert on httptest
for each row
insert into changelog (object,objectid,operation,clock)
values (11,new.httptestid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptest_update after update on httptest
for each row
insert into changelog (object,objectid,operation,clock)
values (11,old.httptestid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptest_delete before delete on httptest
for each row
insert into changelog (object,objectid,operation,clock)
values (11,old.httptestid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `httptest_field`
--

DROP TABLE IF EXISTS `httptest_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httptest_field` (
  `httptest_fieldid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`httptest_fieldid`),
  KEY `httptest_field_1` (`httptestid`),
  CONSTRAINT `c_httptest_field_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest_field`
--

LOCK TABLES `httptest_field` WRITE;
/*!40000 ALTER TABLE `httptest_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptest_field_insert after insert on httptest_field
for each row
insert into changelog (object,objectid,operation,clock)
values (12,new.httptest_fieldid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptest_field_update after update on httptest_field
for each row
insert into changelog (object,objectid,operation,clock)
values (12,old.httptest_fieldid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptest_field_delete before delete on httptest_field
for each row
insert into changelog (object,objectid,operation,clock)
values (12,old.httptest_fieldid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `httptest_tag`
--

DROP TABLE IF EXISTS `httptest_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httptest_tag` (
  `httptesttagid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`httptesttagid`),
  KEY `httptest_tag_1` (`httptestid`),
  CONSTRAINT `c_httptest_tag_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest_tag`
--

LOCK TABLES `httptest_tag` WRITE;
/*!40000 ALTER TABLE `httptest_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_1` (`httptestid`,`itemid`),
  KEY `httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`),
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptestitem_insert after insert on httptestitem
for each row
insert into changelog (object,objectid,operation,clock)
values (13,new.httptestitemid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptestitem_update after update on httptestitem
for each row
insert into changelog (object,objectid,operation,clock)
values (13,old.httptestitemid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger httptestitem_delete before delete on httptestitem
for each row
insert into changelog (object,objectid,operation,clock)
values (13,old.httptestitemid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  UNIQUE KEY `icon_map_1` (`name`),
  KEY `icon_map_2` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT 0,
  `expression` varchar(64) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ids` (
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
INSERT INTO `ids` VALUES
('proxy_autoreg_host','autoreg_host_lastid',238),
('proxy_history','history_lastid',189058),
('task','taskid',2);
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `useip` int(11) NOT NULL DEFAULT 1,
  `ip` varchar(64) NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(255) NOT NULL DEFAULT '',
  `port` varchar(64) NOT NULL DEFAULT '10050',
  `available` int(11) NOT NULL DEFAULT 0,
  `error` varchar(2048) NOT NULL DEFAULT '',
  `errors_from` int(11) NOT NULL DEFAULT 0,
  `disable_until` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  KEY `interface_3` (`available`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES
(82,10771,1,1,1,'192.168.1.3','','10050',0,'',0,0),
(83,10770,1,1,1,'192.168.1.2','','10050',0,'',0,0),
(84,10773,1,2,1,'192.168.1.4','','161',2,'cannot retrieve OID: \'.1.3.6.1.2.1.2.2.1.8.2\' from [[192.168.1.4]:161]: timed out',1764861843,1764862845);
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_discovery`
--

DROP TABLE IF EXISTS `interface_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `interface_discovery` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `parent_interfaceid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`interfaceid`),
  KEY `interface_discovery_1` (`parent_interfaceid`),
  CONSTRAINT `c_interface_discovery_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE,
  CONSTRAINT `c_interface_discovery_2` FOREIGN KEY (`parent_interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_discovery`
--

LOCK TABLES `interface_discovery` WRITE;
/*!40000 ALTER TABLE `interface_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `interface_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_snmp`
--

DROP TABLE IF EXISTS `interface_snmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `interface_snmp` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `version` int(11) NOT NULL DEFAULT 2,
  `bulk` int(11) NOT NULL DEFAULT 1,
  `community` varchar(64) NOT NULL DEFAULT '',
  `securityname` varchar(64) NOT NULL DEFAULT '',
  `securitylevel` int(11) NOT NULL DEFAULT 0,
  `authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `authprotocol` int(11) NOT NULL DEFAULT 0,
  `privprotocol` int(11) NOT NULL DEFAULT 0,
  `contextname` varchar(255) NOT NULL DEFAULT '',
  `max_repetitions` int(11) NOT NULL DEFAULT 10,
  PRIMARY KEY (`interfaceid`),
  CONSTRAINT `c_interface_snmp_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_snmp`
--

LOCK TABLES `interface_snmp` WRITE;
/*!40000 ALTER TABLE `interface_snmp` DISABLE KEYS */;
INSERT INTO `interface_snmp` VALUES
(84,3,1,'','snmp-user',0,'','',0,0,'',10);
/*!40000 ALTER TABLE `interface_snmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_condition`
--

DROP TABLE IF EXISTS `item_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_condition` (
  `item_conditionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT 8,
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`item_conditionid`),
  KEY `item_condition_1` (`itemid`),
  CONSTRAINT `c_item_condition_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_condition`
--

LOCK TABLES `item_condition` WRITE;
/*!40000 ALTER TABLE `item_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned DEFAULT NULL,
  `key_` varchar(2048) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT 0,
  `ts_delete` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `disable_source` int(11) NOT NULL DEFAULT 0,
  `ts_disable` int(11) NOT NULL DEFAULT 0,
  `lldruleid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `item_discovery_2` (`parent_itemid`),
  KEY `item_discovery_3` (`lldruleid`),
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_3` FOREIGN KEY (`lldruleid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_parameter`
--

DROP TABLE IF EXISTS `item_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_parameter` (
  `item_parameterid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`item_parameterid`),
  KEY `item_parameter_1` (`itemid`),
  CONSTRAINT `c_item_parameter_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_parameter`
--

LOCK TABLES `item_parameter` WRITE;
/*!40000 ALTER TABLE `item_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_preproc`
--

DROP TABLE IF EXISTS `item_preproc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_preproc` (
  `item_preprocid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `params` text NOT NULL,
  `error_handler` int(11) NOT NULL DEFAULT 0,
  `error_handler_params` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`item_preprocid`),
  KEY `item_preproc_1` (`itemid`,`step`),
  CONSTRAINT `c_item_preproc_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_preproc`
--

LOCK TABLES `item_preproc` WRITE;
/*!40000 ALTER TABLE `item_preproc` DISABLE KEYS */;
INSERT INTO `item_preproc` VALUES
(133227,70062,1,5,'Total Accesses:\\s+([0-9]+)\n\\1',0,''),
(133228,70063,1,5,'BusyWorkers:\\s+([0-9]+)\n\\1',0,''),
(133229,70064,1,5,'BytesPerReq:\\s+([0-9]+)\n\\1',0,''),
(133230,70065,1,5,'BytesPerSec:\\s+([0-9]+)\n\\1',0,''),
(133231,70066,1,5,'IdleWorkers:\\s+([0-9]+)\n\\1',0,''),
(133232,70067,1,5,'ReqPerSec:\\s+(.*\\.[0-9]+)\n\\1',0,''),
(133233,70068,1,5,'\\bUptime:\\s+([0-9.]+)\n\\1',0,''),
(133234,70069,1,5,'ServerVersion:\\s+(.+)\n\\1',0,''),
(133235,70070,1,5,'Total Accesses:\\s+([0-9]+)\n\\1',0,''),
(133468,70313,1,21,'return value/100',0,''),
(134526,71408,1,20,'1d',0,''),
(134527,71410,1,20,'1d',0,''),
(134528,71411,1,20,'1d',0,''),
(134529,71412,1,20,'1d',0,''),
(134530,71415,1,20,'1h',0,''),
(134531,71416,1,10,'',0,''),
(134532,71420,1,20,'1d',0,''),
(134533,71421,1,10,'',0,''),
(134534,71432,1,20,'12h',0,''),
(134535,71434,1,20,'1d',0,''),
(134536,71435,1,20,'1d',0,''),
(134537,71436,1,12,'$.length()',0,''),
(134538,71436,2,20,'12h',0,''),
(134539,71440,1,20,'12h',0,''),
(134540,71443,1,20,'1h',0,''),
(134541,71449,1,21,'return (100 - value)',0,''),
(134542,71450,1,21,'return (100-value);',0,''),
(134543,71453,1,21,'var filesystems = JSON.parse(value);\n\nresult = filesystems.map(function (filesystem) {\n	return {\n		\'fsname\': filesystem.fsname,\n		\'fstype\': filesystem.fstype\n	};\n});\n\nreturn JSON.stringify(result);',0,''),
(134544,71453,2,20,'1h',0,''),
(134619,71506,1,21,'return JSON.stringify(value.trim().split(/ +/));',0,''),
(134620,71507,1,12,'$[7]',0,''),
(134621,71507,2,10,'',0,''),
(134622,71507,3,1,'0.001',0,''),
(134623,71508,1,12,'$[4]',0,''),
(134624,71508,2,10,'',0,''),
(134625,71509,1,12,'$[9]',0,''),
(134626,71509,2,10,'',0,''),
(134627,71509,3,1,'0.1',0,''),
(134628,71510,1,12,'$[3]',0,''),
(134629,71510,2,10,'',0,''),
(134630,71510,3,1,'0.001',0,''),
(134631,71511,1,12,'$[0]',0,''),
(134632,71511,2,10,'',0,''),
(134633,71512,1,12,'$[10]',0,''),
(134634,71512,2,10,'',0,''),
(134635,71512,3,1,'0.001',0,''),
(134636,71513,1,12,'$.[?(@.fsname==\'/\')].first()',0,''),
(134637,71514,1,12,'$.options',1,''),
(134638,71514,2,5,'(?:^|,)ro\\b\n1',2,'0'),
(134639,71515,1,12,'$.bytes.used',0,''),
(134640,71516,1,12,'$.bytes.total',0,''),
(134641,71517,1,12,'$.bytes.pused',0,''),
(134642,71518,1,12,'$.bytes.free',0,''),
(134643,71519,1,12,'$.inodes.pfree',0,''),
(134644,71520,1,10,'',0,''),
(134645,71521,1,10,'',0,''),
(134646,71522,1,10,'',0,''),
(134647,71522,2,1,'8',0,''),
(134648,71523,1,10,'',0,''),
(134649,71524,1,10,'',0,''),
(134650,71525,1,10,'',0,''),
(134651,71525,2,1,'8',0,''),
(134652,71526,1,21,'var newvalue;\nswitch(value) {\n  case \"unknown\":\n	newvalue = 0;\n	break;\n  case \"notpresent\":\n	newvalue = 1;\n	break;\n  case \"down\":\n	newvalue = 2;\n	break;\n  case \"lowerlayerdown\":\n	newvalue = 3;\n	break;\n  case \"testing\":\n	newvalue = 4;\n	break;\n  case \"dormant\":\n	newvalue = 5;\n	break;\n  case \"up\":\n	newvalue = 6;\n	break;  default:\n	newvalue = \"Problem parsing interface operstate in JS\";\n}\nreturn newvalue;',0,''),
(134653,71527,1,1,'1000000',0,''),
(134654,71527,2,20,'1h',0,''),
(134655,71528,1,20,'1d',0,''),
(134749,71625,1,20,'1d',0,''),
(134750,71627,1,20,'1d',0,''),
(134751,71628,1,20,'1d',0,''),
(134752,71629,1,20,'1d',0,''),
(134753,71632,1,20,'1h',0,''),
(134754,71633,1,10,'',0,''),
(134755,71637,1,20,'1d',0,''),
(134756,71638,1,10,'',0,''),
(134757,71649,1,20,'12h',0,''),
(134758,71651,1,20,'1d',0,''),
(134759,71652,1,20,'1d',0,''),
(134760,71653,1,12,'$.length()',0,''),
(134761,71653,2,20,'12h',0,''),
(134762,71657,1,20,'12h',0,''),
(134763,71660,1,20,'1h',0,''),
(134764,71666,1,21,'return (100 - value)',0,''),
(134765,71667,1,21,'return (100-value);',0,''),
(134766,71670,1,21,'var filesystems = JSON.parse(value);\n\nresult = filesystems.map(function (filesystem) {\n	return {\n		\'fsname\': filesystem.fsname,\n		\'fstype\': filesystem.fstype\n	};\n});\n\nreturn JSON.stringify(result);',0,''),
(134767,71670,2,20,'1h',0,''),
(134805,71696,1,10,'',0,''),
(134806,71697,1,10,'',0,''),
(134807,71698,1,10,'',0,''),
(134808,71698,2,1,'8',0,''),
(134809,71699,1,10,'',0,''),
(134810,71700,1,10,'',0,''),
(134811,71701,1,10,'',0,''),
(134812,71701,2,1,'8',0,''),
(134813,71702,1,21,'var newvalue;\nswitch(value) {\n  case \"unknown\":\n	newvalue = 0;\n	break;\n  case \"notpresent\":\n	newvalue = 1;\n	break;\n  case \"down\":\n	newvalue = 2;\n	break;\n  case \"lowerlayerdown\":\n	newvalue = 3;\n	break;\n  case \"testing\":\n	newvalue = 4;\n	break;\n  case \"dormant\":\n	newvalue = 5;\n	break;\n  case \"up\":\n	newvalue = 6;\n	break;  default:\n	newvalue = \"Problem parsing interface operstate in JS\";\n}\nreturn newvalue;',0,''),
(134814,71703,1,1,'1000000',0,''),
(134815,71703,2,20,'1h',0,''),
(134816,71704,1,20,'1d',0,''),
(134817,71705,1,12,'$.[?(@.fsname==\'/\')].first()',0,''),
(134818,71706,1,12,'$.options',1,''),
(134819,71706,2,5,'(?:^|,)ro\\b\n1',2,'0'),
(134820,71707,1,12,'$.bytes.used',0,''),
(134821,71708,1,12,'$.bytes.total',0,''),
(134822,71709,1,12,'$.bytes.pused',0,''),
(134823,71710,1,12,'$.bytes.free',0,''),
(134824,71711,1,12,'$.inodes.pfree',0,''),
(134825,71714,1,21,'return JSON.stringify(value.trim().split(/ +/));',0,''),
(134826,71715,1,12,'$[7]',0,''),
(134827,71715,2,10,'',0,''),
(134828,71715,3,1,'0.001',0,''),
(134829,71716,1,12,'$[4]',0,''),
(134830,71716,2,10,'',0,''),
(134831,71717,1,12,'$[9]',0,''),
(134832,71717,2,10,'',0,''),
(134833,71717,3,1,'0.1',0,''),
(134834,71718,1,12,'$[3]',0,''),
(134835,71718,2,10,'',0,''),
(134836,71718,3,1,'0.001',0,''),
(134837,71719,1,12,'$[0]',0,''),
(134838,71719,2,10,'',0,''),
(134839,71720,1,12,'$[10]',0,''),
(134840,71720,2,10,'',0,''),
(134841,71720,3,1,'0.001',0,'');
/*!40000 ALTER TABLE `item_preproc` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger item_preproc_insert after insert on item_preproc
for each row
insert into changelog (object,objectid,operation,clock)
values (8,new.item_preprocid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger item_preproc_update after update on item_preproc
for each row
insert into changelog (object,objectid,operation,clock)
values (8,old.item_preprocid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger item_preproc_delete before delete on item_preproc
for each row
insert into changelog (object,objectid,operation,clock)
values (8,old.item_preprocid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `item_rtdata`
--

DROP TABLE IF EXISTS `item_rtdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_rtdata` (
  `itemid` bigint(20) unsigned NOT NULL,
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `mtime` int(11) NOT NULL DEFAULT 0,
  `error` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemid`),
  CONSTRAINT `c_item_rtdata_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_rtdata`
--

LOCK TABLES `item_rtdata` WRITE;
/*!40000 ALTER TABLE `item_rtdata` DISABLE KEYS */;
INSERT INTO `item_rtdata` VALUES
(70061,0,0,0,''),
(70062,0,0,0,''),
(70063,0,0,0,''),
(70064,0,0,0,''),
(70065,0,0,0,''),
(70066,0,0,0,''),
(70067,0,0,0,''),
(70068,0,0,0,''),
(70069,0,0,0,''),
(70070,0,0,0,''),
(70313,0,0,0,''),
(70314,0,0,0,''),
(70315,0,0,0,''),
(71408,0,0,0,''),
(71409,0,0,0,''),
(71410,0,0,0,''),
(71411,0,0,0,''),
(71412,0,0,0,''),
(71413,0,0,0,''),
(71414,0,0,0,''),
(71415,0,0,0,''),
(71416,0,0,0,''),
(71417,0,0,0,''),
(71418,0,0,0,''),
(71419,0,0,0,''),
(71420,0,0,0,''),
(71421,0,0,0,''),
(71422,0,0,0,''),
(71423,0,0,0,''),
(71424,0,0,0,''),
(71425,0,0,0,''),
(71426,0,0,0,''),
(71427,0,0,0,''),
(71428,0,0,0,''),
(71429,0,0,0,''),
(71430,0,0,0,''),
(71431,0,0,0,''),
(71432,0,0,0,''),
(71433,0,0,0,''),
(71434,0,0,0,''),
(71435,0,0,0,''),
(71436,0,0,0,''),
(71437,0,0,0,''),
(71438,0,0,0,''),
(71439,0,0,0,''),
(71440,0,0,0,''),
(71441,0,0,0,''),
(71442,0,0,0,''),
(71443,0,0,0,''),
(71444,0,0,0,''),
(71445,0,0,0,''),
(71446,0,0,0,''),
(71447,0,0,0,''),
(71448,0,0,0,''),
(71449,0,0,0,''),
(71450,0,0,0,''),
(71451,0,0,0,''),
(71452,0,0,0,''),
(71453,0,0,0,''),
(71506,0,0,0,''),
(71507,0,0,0,''),
(71508,0,0,0,''),
(71509,0,0,0,''),
(71510,0,0,0,''),
(71511,0,0,0,''),
(71512,0,0,0,''),
(71513,0,0,0,''),
(71514,0,0,0,''),
(71515,0,0,0,''),
(71516,0,0,0,''),
(71517,0,0,0,''),
(71518,0,0,0,''),
(71519,0,0,0,''),
(71520,0,0,0,''),
(71521,0,0,0,''),
(71522,0,0,0,''),
(71523,0,0,0,''),
(71524,0,0,0,''),
(71525,0,0,0,''),
(71526,0,0,0,''),
(71527,0,0,0,''),
(71528,0,0,0,''),
(71625,0,0,0,''),
(71626,0,0,0,''),
(71627,0,0,0,''),
(71628,0,0,0,''),
(71629,0,0,0,''),
(71630,0,0,0,''),
(71631,0,0,0,''),
(71632,0,0,0,''),
(71633,0,0,0,''),
(71634,0,0,0,''),
(71635,0,0,0,''),
(71636,0,0,0,''),
(71637,0,0,0,''),
(71638,0,0,0,''),
(71639,0,0,0,''),
(71640,0,0,0,''),
(71641,0,0,0,''),
(71642,0,0,0,''),
(71643,0,0,0,''),
(71644,0,0,0,''),
(71645,0,0,0,''),
(71646,0,0,0,''),
(71647,0,0,0,''),
(71648,0,0,0,''),
(71649,0,0,0,''),
(71650,0,0,0,''),
(71651,0,0,0,''),
(71652,0,0,0,''),
(71653,0,0,0,''),
(71654,0,0,0,''),
(71655,0,0,0,''),
(71656,0,0,0,''),
(71657,0,0,0,''),
(71658,0,0,0,''),
(71659,0,0,0,''),
(71660,0,0,0,''),
(71661,0,0,0,''),
(71662,0,0,0,''),
(71663,0,0,0,''),
(71664,0,0,0,''),
(71665,0,0,0,''),
(71666,0,0,0,''),
(71667,0,0,0,''),
(71668,0,0,0,''),
(71669,0,0,0,''),
(71670,0,0,0,''),
(71696,0,0,0,''),
(71697,0,0,0,''),
(71698,0,0,0,''),
(71699,0,0,0,''),
(71700,0,0,0,''),
(71701,0,0,0,''),
(71702,0,0,0,''),
(71703,0,0,0,''),
(71704,0,0,0,''),
(71705,0,0,0,''),
(71706,0,0,0,''),
(71707,0,0,0,''),
(71708,0,0,0,''),
(71709,0,0,0,''),
(71710,0,0,0,''),
(71711,0,0,0,''),
(71714,0,0,0,''),
(71715,0,0,0,''),
(71716,0,0,0,''),
(71717,0,0,0,''),
(71718,0,0,0,''),
(71719,0,0,0,''),
(71720,0,0,0,'');
/*!40000 ALTER TABLE `item_rtdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_rtname`
--

DROP TABLE IF EXISTS `item_rtname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_rtname` (
  `itemid` bigint(20) unsigned NOT NULL,
  `name_resolved` varchar(2048) NOT NULL DEFAULT '',
  `name_resolved_upper` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemid`),
  CONSTRAINT `c_item_rtname_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_rtname`
--

LOCK TABLES `item_rtname` WRITE;
/*!40000 ALTER TABLE `item_rtname` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_rtname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_tag`
--

DROP TABLE IF EXISTS `item_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_tag` (
  `itemtagid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemtagid`),
  KEY `item_tag_1` (`itemid`),
  CONSTRAINT `c_item_tag_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_tag`
--

LOCK TABLES `item_tag` WRITE;
/*!40000 ALTER TABLE `item_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger item_tag_insert after insert on item_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (4,new.itemtagid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger item_tag_update after update on item_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (4,old.itemtagid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger item_tag_delete before delete on item_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (4,old.itemtagid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `snmp_oid` varchar(512) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `key_` varchar(2048) NOT NULL DEFAULT '',
  `delay` varchar(1024) NOT NULL DEFAULT '0',
  `history` varchar(255) NOT NULL DEFAULT '31d',
  `trends` varchar(255) NOT NULL DEFAULT '365d',
  `status` int(11) NOT NULL DEFAULT 0,
  `value_type` int(11) NOT NULL DEFAULT 0,
  `trapper_hosts` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(255) NOT NULL DEFAULT '',
  `formula` varchar(255) NOT NULL DEFAULT '',
  `logtimefmt` varchar(64) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `params` text NOT NULL,
  `ipmi_sensor` varchar(128) NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT 0,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT 0,
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT 0,
  `lifetime` varchar(255) NOT NULL DEFAULT '7d',
  `evaltype` int(11) NOT NULL DEFAULT 0,
  `jmx_endpoint` varchar(255) NOT NULL DEFAULT '',
  `master_itemid` bigint(20) unsigned DEFAULT NULL,
  `timeout` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(2048) NOT NULL DEFAULT '',
  `query_fields` text NOT NULL,
  `posts` text NOT NULL,
  `status_codes` varchar(255) NOT NULL DEFAULT '200',
  `follow_redirects` int(11) NOT NULL DEFAULT 1,
  `post_type` int(11) NOT NULL DEFAULT 0,
  `http_proxy` varchar(255) NOT NULL DEFAULT '',
  `headers` text NOT NULL,
  `retrieve_mode` int(11) NOT NULL DEFAULT 0,
  `request_method` int(11) NOT NULL DEFAULT 0,
  `output_format` int(11) NOT NULL DEFAULT 0,
  `ssl_cert_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT 0,
  `verify_host` int(11) NOT NULL DEFAULT 0,
  `allow_traps` int(11) NOT NULL DEFAULT 0,
  `discover` int(11) NOT NULL DEFAULT 0,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  `lifetime_type` int(11) NOT NULL DEFAULT 0,
  `enabled_lifetime_type` int(11) NOT NULL DEFAULT 2,
  `enabled_lifetime` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`),
  KEY `items_1` (`hostid`,`key_`(764)),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `items_6` (`interfaceid`),
  KEY `items_7` (`master_itemid`),
  KEY `items_8` (`key_`(768)),
  KEY `items_10` (`uuid`),
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemap` (`valuemapid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`),
  CONSTRAINT `c_items_5` FOREIGN KEY (`master_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES
(70061,19,'',10770,'','apache2.get','10s','1h','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',0,83,'',0,'7d',0,'',NULL,'','{$STUB_STATUS_PROT}://{$STUB_STATUS_HOST}:{$STUB_STATUS_PORT}/{$STUB_STATUS_PATH}','','','200',1,0,'','',2,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70062,18,'',10770,'','apache2.Accesses','0','30d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70063,18,'',10770,'','apache2.BusyWorkers','0','30d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70064,18,'',10770,'','apache2.BytesPerReq','0','30d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70065,18,'',10770,'','apache2.BytesPerSec','0','30d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70066,18,'',10770,'','apache2.IdleWorkers','0','30d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70067,18,'',10770,'','apache2.ReqPerSec','0','30d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70068,18,'',10770,'','apache2.ServerUptimeSeconds','0','30d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70069,18,'',10770,'','apache2.Version','0','30d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70070,18,'',10770,'','apache2.kBytes','0','30d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',70061,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70313,20,'get[1.3.6.1.2.1.1.3.0]',10773,'','sysUpTime','1s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,84,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70314,20,'get[1.3.6.1.2.1.2.2.1.8.2]',10773,'','ifOperStatus','1s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,84,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(70315,20,'get[1.3.6.1.2.1.2.2.1.10.1]',10773,'','ifInOctets','1s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,84,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71408,7,'',10771,'','agent.hostname','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71409,7,'',10771,'','agent.ping','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71410,7,'',10771,'','agent.version','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71411,7,'',10771,'','kernel.maxfiles','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71412,7,'',10771,'','kernel.maxproc','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71413,7,'',10771,'','proc.num','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71414,7,'',10771,'','proc.num[,,run]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71415,7,'',10771,'','system.boottime','15m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71416,7,'',10771,'','system.cpu.intr','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71417,7,'',10771,'','system.cpu.load[all,avg15]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71418,7,'',10771,'','system.cpu.load[all,avg1]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71419,7,'',10771,'','system.cpu.load[all,avg5]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71420,7,'',10771,'','system.cpu.num','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71421,7,'',10771,'','system.cpu.switches','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71422,7,'',10771,'','system.cpu.util[,guest]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71423,7,'',10771,'','system.cpu.util[,guest_nice]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71424,7,'',10771,'','system.cpu.util[,idle]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71425,7,'',10771,'','system.cpu.util[,interrupt]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71426,7,'',10771,'','system.cpu.util[,iowait]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71427,7,'',10771,'','system.cpu.util[,nice]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71428,7,'',10771,'','system.cpu.util[,softirq]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71429,7,'',10771,'','system.cpu.util[,steal]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71430,7,'',10771,'','system.cpu.util[,system]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71431,7,'',10771,'','system.cpu.util[,user]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71432,7,'',10771,'','system.hostname','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',3,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71433,7,'',10771,'','system.localtime','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71434,7,'',10771,'','system.sw.arch','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71435,7,'',10771,'','system.sw.os','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',5,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71436,7,'',10771,'','system.sw.packages.get','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71437,7,'',10771,'','system.swap.size[,free]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71438,7,'',10771,'','system.swap.size[,pfree]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71439,7,'',10771,'','system.swap.size[,total]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71440,7,'',10771,'','system.uname','15m','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71441,7,'',10771,'','system.uptime','30s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71442,7,'',10771,'','system.users.num','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71443,7,'',10771,'','vfs.file.cksum[/etc/passwd,sha256]','15m','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71444,7,'',10771,'','vfs.fs.get','1m','0','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71445,7,'',10771,'','vm.memory.size[available]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71446,7,'',10771,'','vm.memory.size[pavailable]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71447,7,'',10771,'','vm.memory.size[total]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71448,5,'',10771,'','zabbix[host,active_agent,available]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71449,18,'',10771,'','system.cpu.util','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',71424,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71450,18,'',10771,'','vm.memory.utilization','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',71446,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71451,7,'',10771,'','net.if.discovery','1h','31d','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',1,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71452,7,'',10771,'','vfs.dev.discovery','1h','31d','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',1,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71453,18,'',10771,'','vfs.fs.dependent.discovery','0','31d','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',1,NULL,'',0,'7d',0,'',71444,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71506,7,'',10771,'','vfs.file.contents[/sys/block/sda/stat]','1m','0','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71507,18,'',10771,'','vfs.dev.write.time.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71506,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71508,18,'',10771,'','vfs.dev.write.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71506,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71509,18,'',10771,'','vfs.dev.util[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71506,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71510,18,'',10771,'','vfs.dev.read.time.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71506,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71511,18,'',10771,'','vfs.dev.read.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71506,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71512,18,'',10771,'','vfs.dev.queue_size[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71506,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71513,18,'',10771,'','vfs.fs.dependent[/,data]','0','1h','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71444,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71514,18,'',10771,'','vfs.fs.dependent[/,readonly]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71513,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71515,18,'',10771,'','vfs.fs.dependent.size[/,used]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71513,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71516,18,'',10771,'','vfs.fs.dependent.size[/,total]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71513,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71517,18,'',10771,'','vfs.fs.dependent.size[/,pused]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71513,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71518,18,'',10771,'','vfs.fs.dependent.size[/,free]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71513,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71519,18,'',10771,'','vfs.fs.dependent.inode[/,pfree]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71513,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71520,7,'',10771,'','net.if.in[\"enp0s3\",dropped]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71521,7,'',10771,'','net.if.in[\"enp0s3\",errors]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71522,7,'',10771,'','net.if.in[\"enp0s3\"]','10s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71523,7,'',10771,'','net.if.out[\"enp0s3\",dropped]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71524,7,'',10771,'','net.if.out[\"enp0s3\",errors]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71525,7,'',10771,'','net.if.out[\"enp0s3\"]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71526,7,'',10771,'','vfs.file.contents[\"/sys/class/net/enp0s3/operstate\"]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71527,7,'',10771,'','vfs.file.contents[\"/sys/class/net/enp0s3/speed\"]','5m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71528,7,'',10771,'','vfs.file.contents[\"/sys/class/net/enp0s3/type\"]','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71625,7,'',10770,'','agent.hostname','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71626,7,'',10770,'','agent.ping','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71627,7,'',10770,'','agent.version','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71628,7,'',10770,'','kernel.maxfiles','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71629,7,'',10770,'','kernel.maxproc','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71630,7,'',10770,'','proc.num','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71631,7,'',10770,'','proc.num[,,run]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71632,7,'',10770,'','system.boottime','15m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71633,7,'',10770,'','system.cpu.intr','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71634,7,'',10770,'','system.cpu.load[all,avg15]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71635,7,'',10770,'','system.cpu.load[all,avg1]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71636,7,'',10770,'','system.cpu.load[all,avg5]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71637,7,'',10770,'','system.cpu.num','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71638,7,'',10770,'','system.cpu.switches','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71639,7,'',10770,'','system.cpu.util[,guest]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71640,7,'',10770,'','system.cpu.util[,guest_nice]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71641,7,'',10770,'','system.cpu.util[,idle]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71642,7,'',10770,'','system.cpu.util[,interrupt]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71643,7,'',10770,'','system.cpu.util[,iowait]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71644,7,'',10770,'','system.cpu.util[,nice]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71645,7,'',10770,'','system.cpu.util[,softirq]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71646,7,'',10770,'','system.cpu.util[,steal]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71647,7,'',10770,'','system.cpu.util[,system]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71648,7,'',10770,'','system.cpu.util[,user]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71649,7,'',10770,'','system.hostname','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',3,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71650,7,'',10770,'','system.localtime','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71651,7,'',10770,'','system.sw.arch','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71652,7,'',10770,'','system.sw.os','1h','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',5,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71653,7,'',10770,'','system.sw.packages.get','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71654,7,'',10770,'','system.swap.size[,free]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71655,7,'',10770,'','system.swap.size[,pfree]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71656,7,'',10770,'','system.swap.size[,total]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71657,7,'',10770,'','system.uname','15m','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71658,7,'',10770,'','system.uptime','30s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71659,7,'',10770,'','system.users.num','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71660,7,'',10770,'','vfs.file.cksum[/etc/passwd,sha256]','15m','31d','365d',0,1,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71661,7,'',10770,'','vfs.fs.get','1m','0','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71662,7,'',10770,'','vm.memory.size[available]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71663,7,'',10770,'','vm.memory.size[pavailable]','1m','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71664,7,'',10770,'','vm.memory.size[total]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71665,5,'',10770,'','zabbix[host,active_agent,available]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71666,18,'',10770,'','system.cpu.util','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',71641,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71667,18,'',10770,'','vm.memory.utilization','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',0,NULL,'',0,'7d',0,'',71663,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71668,7,'',10770,'','net.if.discovery','1h','31d','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',1,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71669,7,'',10770,'','vfs.dev.discovery','1h','31d','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',1,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71670,18,'',10770,'','vfs.fs.dependent.discovery','0','31d','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',1,NULL,'',0,'7d',0,'',71661,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71696,7,'',10770,'','net.if.in[\"enp0s3\",dropped]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71697,7,'',10770,'','net.if.in[\"enp0s3\",errors]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71698,7,'',10770,'','net.if.in[\"enp0s3\"]','10s','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71699,7,'',10770,'','net.if.out[\"enp0s3\",dropped]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71700,7,'',10770,'','net.if.out[\"enp0s3\",errors]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71701,7,'',10770,'','net.if.out[\"enp0s3\"]','3m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71702,7,'',10770,'','vfs.file.contents[\"/sys/class/net/enp0s3/operstate\"]','1m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71703,7,'',10770,'','vfs.file.contents[\"/sys/class/net/enp0s3/speed\"]','5m','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71704,7,'',10770,'','vfs.file.contents[\"/sys/class/net/enp0s3/type\"]','1h','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71705,18,'',10770,'','vfs.fs.dependent[/,data]','0','1h','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71661,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71706,18,'',10770,'','vfs.fs.dependent[/,readonly]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71705,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71707,18,'',10770,'','vfs.fs.dependent.size[/,used]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71705,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71708,18,'',10770,'','vfs.fs.dependent.size[/,total]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71705,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71709,18,'',10770,'','vfs.fs.dependent.size[/,pused]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71705,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71710,18,'',10770,'','vfs.fs.dependent.size[/,free]','0','31d','365d',0,3,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71705,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71711,18,'',10770,'','vfs.fs.dependent.inode[/,pfree]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71705,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71714,7,'',10770,'','vfs.file.contents[/sys/block/sda/stat]','1m','0','365d',0,4,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',NULL,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71715,18,'',10770,'','vfs.dev.write.time.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71714,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71716,18,'',10770,'','vfs.dev.write.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71714,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71717,18,'',10770,'','vfs.dev.util[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71714,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71718,18,'',10770,'','vfs.dev.read.time.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71714,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71719,18,'',10770,'','vfs.dev.read.rate[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71714,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0'),
(71720,18,'',10770,'','vfs.dev.queue_size[sda]','0','31d','365d',0,0,'','','','',NULL,NULL,'','',0,'','','','',4,NULL,'',0,'7d',0,'',71714,'','','','','200',1,0,'','',0,0,0,'','','',0,0,0,0,'',0,2,'0');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger items_insert after insert on items
for each row
insert into changelog (object,objectid,operation,clock)
values (3,new.itemid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger items_update after update on items
for each row
insert into changelog (object,objectid,operation,clock)
values (3,old.itemid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger items_delete before delete on items
for each row
insert into changelog (object,objectid,operation,clock)
values (3,old.itemid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lld_macro_export`
--

DROP TABLE IF EXISTS `lld_macro_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_macro_export` (
  `lld_macro_exportid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `lld_macro` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`lld_macro_exportid`),
  KEY `lld_macro_export_1` (`itemid`),
  CONSTRAINT `c_lld_macro_export_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_macro_export`
--

LOCK TABLES `lld_macro_export` WRITE;
/*!40000 ALTER TABLE `lld_macro_export` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_macro_export` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_macro_path`
--

DROP TABLE IF EXISTS `lld_macro_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_macro_path` (
  `lld_macro_pathid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `lld_macro` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`lld_macro_pathid`),
  UNIQUE KEY `lld_macro_path_1` (`itemid`,`lld_macro`),
  CONSTRAINT `c_lld_macro_path_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_macro_path`
--

LOCK TABLES `lld_macro_path` WRITE;
/*!40000 ALTER TABLE `lld_macro_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_macro_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override`
--

DROP TABLE IF EXISTS `lld_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override` (
  `lld_overrideid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `step` int(11) NOT NULL DEFAULT 0,
  `evaltype` int(11) NOT NULL DEFAULT 0,
  `formula` varchar(255) NOT NULL DEFAULT '',
  `stop` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`lld_overrideid`),
  UNIQUE KEY `lld_override_1` (`itemid`,`name`),
  CONSTRAINT `c_lld_override_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override`
--

LOCK TABLES `lld_override` WRITE;
/*!40000 ALTER TABLE `lld_override` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_condition`
--

DROP TABLE IF EXISTS `lld_override_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_condition` (
  `lld_override_conditionid` bigint(20) unsigned NOT NULL,
  `lld_overrideid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT 8,
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`lld_override_conditionid`),
  KEY `lld_override_condition_1` (`lld_overrideid`),
  CONSTRAINT `c_lld_override_condition_1` FOREIGN KEY (`lld_overrideid`) REFERENCES `lld_override` (`lld_overrideid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_condition`
--

LOCK TABLES `lld_override_condition` WRITE;
/*!40000 ALTER TABLE `lld_override_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_opdiscover`
--

DROP TABLE IF EXISTS `lld_override_opdiscover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_opdiscover` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `discover` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_opdiscover_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_opdiscover`
--

LOCK TABLES `lld_override_opdiscover` WRITE;
/*!40000 ALTER TABLE `lld_override_opdiscover` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_opdiscover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_operation`
--

DROP TABLE IF EXISTS `lld_override_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_operation` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `lld_overrideid` bigint(20) unsigned NOT NULL,
  `operationobject` int(11) NOT NULL DEFAULT 0,
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`lld_override_operationid`),
  KEY `lld_override_operation_1` (`lld_overrideid`),
  CONSTRAINT `c_lld_override_operation_1` FOREIGN KEY (`lld_overrideid`) REFERENCES `lld_override` (`lld_overrideid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_operation`
--

LOCK TABLES `lld_override_operation` WRITE;
/*!40000 ALTER TABLE `lld_override_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_ophistory`
--

DROP TABLE IF EXISTS `lld_override_ophistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_ophistory` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `history` varchar(255) NOT NULL DEFAULT '31d',
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_ophistory_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_ophistory`
--

LOCK TABLES `lld_override_ophistory` WRITE;
/*!40000 ALTER TABLE `lld_override_ophistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_ophistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_opinventory`
--

DROP TABLE IF EXISTS `lld_override_opinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_opinventory` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_opinventory_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_opinventory`
--

LOCK TABLES `lld_override_opinventory` WRITE;
/*!40000 ALTER TABLE `lld_override_opinventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_opinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_opperiod`
--

DROP TABLE IF EXISTS `lld_override_opperiod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_opperiod` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `delay` varchar(1024) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_opperiod_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_opperiod`
--

LOCK TABLES `lld_override_opperiod` WRITE;
/*!40000 ALTER TABLE `lld_override_opperiod` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_opperiod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_opseverity`
--

DROP TABLE IF EXISTS `lld_override_opseverity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_opseverity` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `severity` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_opseverity_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_opseverity`
--

LOCK TABLES `lld_override_opseverity` WRITE;
/*!40000 ALTER TABLE `lld_override_opseverity` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_opseverity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_opstatus`
--

DROP TABLE IF EXISTS `lld_override_opstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_opstatus` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_opstatus_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_opstatus`
--

LOCK TABLES `lld_override_opstatus` WRITE;
/*!40000 ALTER TABLE `lld_override_opstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_opstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_optag`
--

DROP TABLE IF EXISTS `lld_override_optag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_optag` (
  `lld_override_optagid` bigint(20) unsigned NOT NULL,
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`lld_override_optagid`),
  KEY `lld_override_optag_1` (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_optag_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_optag`
--

LOCK TABLES `lld_override_optag` WRITE;
/*!40000 ALTER TABLE `lld_override_optag` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_optag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_optemplate`
--

DROP TABLE IF EXISTS `lld_override_optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_optemplate` (
  `lld_override_optemplateid` bigint(20) unsigned NOT NULL,
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`lld_override_optemplateid`),
  UNIQUE KEY `lld_override_optemplate_1` (`lld_override_operationid`,`templateid`),
  KEY `lld_override_optemplate_2` (`templateid`),
  CONSTRAINT `c_lld_override_optemplate_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_lld_override_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_optemplate`
--

LOCK TABLES `lld_override_optemplate` WRITE;
/*!40000 ALTER TABLE `lld_override_optemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_override_optrends`
--

DROP TABLE IF EXISTS `lld_override_optrends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lld_override_optrends` (
  `lld_override_operationid` bigint(20) unsigned NOT NULL,
  `trends` varchar(255) NOT NULL DEFAULT '365d',
  PRIMARY KEY (`lld_override_operationid`),
  CONSTRAINT `c_lld_override_optrends_1` FOREIGN KEY (`lld_override_operationid`) REFERENCES `lld_override_operation` (`lld_override_operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_override_optrends`
--

LOCK TABLES `lld_override_optrends` WRITE;
/*!40000 ALTER TABLE `lld_override_optrends` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_override_optrends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_tag`
--

DROP TABLE IF EXISTS `maintenance_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_tag` (
  `maintenancetagid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT 2,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`maintenancetagid`),
  KEY `maintenance_tag_1` (`maintenanceid`),
  CONSTRAINT `c_maintenance_tag_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_tag`
--

LOCK TABLES `maintenance_tag` WRITE;
/*!40000 ALTER TABLE `maintenance_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT 0,
  `active_till` int(11) NOT NULL DEFAULT 0,
  `tags_evaltype` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`maintenanceid`),
  UNIQUE KEY `maintenances_2` (`name`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(1024) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT 0,
  `severity` int(11) NOT NULL DEFAULT 63,
  `period` varchar(1024) NOT NULL DEFAULT '1-7,00:00-24:00',
  `userdirectory_mediaid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  KEY `media_3` (`userdirectory_mediaid`),
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_3` FOREIGN KEY (`userdirectory_mediaid`) REFERENCES `userdirectory_media` (`userdirectory_mediaid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '',
  `smtp_server` varchar(255) NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) NOT NULL DEFAULT '',
  `smtp_email` varchar(255) NOT NULL DEFAULT '',
  `exec_path` varchar(255) NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `passwd` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1,
  `smtp_port` int(11) NOT NULL DEFAULT 25,
  `smtp_security` int(11) NOT NULL DEFAULT 0,
  `smtp_verify_peer` int(11) NOT NULL DEFAULT 0,
  `smtp_verify_host` int(11) NOT NULL DEFAULT 0,
  `smtp_authentication` int(11) NOT NULL DEFAULT 0,
  `maxsessions` int(11) NOT NULL DEFAULT 1,
  `maxattempts` int(11) NOT NULL DEFAULT 3,
  `attempt_interval` varchar(32) NOT NULL DEFAULT '10s',
  `message_format` int(11) NOT NULL DEFAULT 1,
  `script` text NOT NULL,
  `timeout` varchar(32) NOT NULL DEFAULT '30s',
  `process_tags` int(11) NOT NULL DEFAULT 0,
  `show_event_menu` int(11) NOT NULL DEFAULT 0,
  `event_menu_url` varchar(2048) NOT NULL DEFAULT '',
  `event_menu_name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `provider` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`mediatypeid`),
  UNIQUE KEY `media_type_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type_message`
--

DROP TABLE IF EXISTS `media_type_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_type_message` (
  `mediatype_messageid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `eventsource` int(11) NOT NULL,
  `recovery` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`mediatype_messageid`),
  UNIQUE KEY `media_type_message_1` (`mediatypeid`,`eventsource`,`recovery`),
  CONSTRAINT `c_media_type_message_1` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type_message`
--

LOCK TABLES `media_type_message` WRITE;
/*!40000 ALTER TABLE `media_type_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_type_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type_oauth`
--

DROP TABLE IF EXISTS `media_type_oauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_type_oauth` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `redirection_url` varchar(2048) NOT NULL DEFAULT '',
  `client_id` varchar(255) NOT NULL DEFAULT '',
  `client_secret` varchar(255) NOT NULL DEFAULT '',
  `authorization_url` varchar(2048) NOT NULL DEFAULT '',
  `tokens_status` int(11) NOT NULL DEFAULT 0,
  `access_token` text NOT NULL,
  `access_token_updated` int(11) NOT NULL DEFAULT 0,
  `access_expires_in` int(11) NOT NULL DEFAULT 0,
  `refresh_token` text NOT NULL,
  `token_url` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`mediatypeid`),
  CONSTRAINT `c_media_type_oauth_1` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type_oauth`
--

LOCK TABLES `media_type_oauth` WRITE;
/*!40000 ALTER TABLE `media_type_oauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_type_oauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type_param`
--

DROP TABLE IF EXISTS `media_type_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_type_param` (
  `mediatype_paramid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`mediatype_paramid`),
  KEY `media_type_param_1` (`mediatypeid`),
  CONSTRAINT `c_media_type_param_1` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type_param`
--

LOCK TABLES `media_type_param` WRITE;
/*!40000 ALTER TABLE `media_type_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_type_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfa`
--

DROP TABLE IF EXISTS `mfa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mfa` (
  `mfaid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `hash_function` int(11) DEFAULT 1,
  `code_length` int(11) DEFAULT 6,
  `api_hostname` varchar(1024) DEFAULT '',
  `clientid` varchar(32) DEFAULT '',
  `client_secret` varchar(64) DEFAULT '',
  PRIMARY KEY (`mfaid`),
  UNIQUE KEY `mfa_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfa`
--

LOCK TABLES `mfa` WRITE;
/*!40000 ALTER TABLE `mfa` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfa_totp_secret`
--

DROP TABLE IF EXISTS `mfa_totp_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mfa_totp_secret` (
  `mfa_totp_secretid` bigint(20) unsigned NOT NULL,
  `mfaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `totp_secret` varchar(32) DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `used_codes` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`mfa_totp_secretid`),
  KEY `mfa_totp_secret_1` (`mfaid`),
  KEY `mfa_totp_secret_2` (`userid`),
  CONSTRAINT `c_mfa_totp_secret_1` FOREIGN KEY (`mfaid`) REFERENCES `mfa` (`mfaid`) ON DELETE CASCADE,
  CONSTRAINT `c_mfa_totp_secret_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfa_totp_secret`
--

LOCK TABLES `mfa_totp_secret` WRITE;
/*!40000 ALTER TABLE `mfa_totp_secret` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfa_totp_secret` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `module` (
  `moduleid` bigint(20) unsigned NOT NULL,
  `id` varchar(255) NOT NULL DEFAULT '',
  `relative_path` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `config` text NOT NULL,
  PRIMARY KEY (`moduleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `scriptid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opcommand_1` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT 0,
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT 0,
  `esc_period` varchar(255) NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT 1,
  `esc_step_to` int(11) NOT NULL DEFAULT 1,
  `evaltype` int(11) NOT NULL DEFAULT 0,
  `recovery` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opinventory`
--

DROP TABLE IF EXISTS `opinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opinventory` (
  `operationid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`operationid`),
  CONSTRAINT `c_opinventory_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opinventory`
--

LOCK TABLES `opinventory` WRITE;
/*!40000 ALTER TABLE `opinventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `opinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT 1,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opmessage_1` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optag`
--

DROP TABLE IF EXISTS `optag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `optag` (
  `optagid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`optagid`),
  KEY `optag_1` (`operationid`),
  CONSTRAINT `c_optag_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optag`
--

LOCK TABLES `optag` WRITE;
/*!40000 ALTER TABLE `optag` DISABLE KEYS */;
/*!40000 ALTER TABLE `optag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `ugsetid` bigint(20) unsigned NOT NULL,
  `hgsetid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 2,
  PRIMARY KEY (`ugsetid`,`hgsetid`),
  KEY `permission_1` (`hgsetid`),
  CONSTRAINT `c_permission_1` FOREIGN KEY (`ugsetid`) REFERENCES `ugset` (`ugsetid`) ON DELETE CASCADE,
  CONSTRAINT `c_permission_2` FOREIGN KEY (`hgsetid`) REFERENCES `hgset` (`hgsetid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `problem` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT 0,
  `object` int(11) NOT NULL DEFAULT 0,
  `objectid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `clock` int(11) NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `r_clock` int(11) NOT NULL DEFAULT 0,
  `r_ns` int(11) NOT NULL DEFAULT 0,
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(2048) NOT NULL DEFAULT '',
  `acknowledged` int(11) NOT NULL DEFAULT 0,
  `severity` int(11) NOT NULL DEFAULT 0,
  `cause_eventid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `problem_1` (`source`,`object`,`objectid`),
  KEY `problem_2` (`r_clock`),
  KEY `problem_3` (`r_eventid`),
  KEY `problem_4` (`cause_eventid`),
  CONSTRAINT `c_problem_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_problem_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_problem_3` FOREIGN KEY (`cause_eventid`) REFERENCES `events` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_tag`
--

DROP TABLE IF EXISTS `problem_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `problem_tag` (
  `problemtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`problemtagid`),
  KEY `problem_tag_1` (`eventid`,`tag`,`value`),
  CONSTRAINT `c_problem_tag_1` FOREIGN KEY (`eventid`) REFERENCES `problem` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_tag`
--

LOCK TABLES `problem_tag` WRITE;
/*!40000 ALTER TABLE `problem_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT 0,
  `value_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `value_int` int(11) NOT NULL DEFAULT 0,
  `value_str` text NOT NULL,
  `source` varchar(96) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy`
--

DROP TABLE IF EXISTS `proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy` (
  `proxyid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `operating_mode` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `tls_connect` int(11) NOT NULL DEFAULT 1,
  `tls_accept` int(11) NOT NULL DEFAULT 1,
  `tls_issuer` varchar(1024) NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) NOT NULL DEFAULT '',
  `tls_psk` varchar(512) NOT NULL DEFAULT '',
  `allowed_addresses` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `port` varchar(64) NOT NULL DEFAULT '10051',
  `custom_timeouts` int(11) NOT NULL DEFAULT 0,
  `timeout_zabbix_agent` varchar(255) NOT NULL DEFAULT '',
  `timeout_simple_check` varchar(255) NOT NULL DEFAULT '',
  `timeout_snmp_agent` varchar(255) NOT NULL DEFAULT '',
  `timeout_external_check` varchar(255) NOT NULL DEFAULT '',
  `timeout_db_monitor` varchar(255) NOT NULL DEFAULT '',
  `timeout_http_agent` varchar(255) NOT NULL DEFAULT '',
  `timeout_ssh_agent` varchar(255) NOT NULL DEFAULT '',
  `timeout_telnet_agent` varchar(255) NOT NULL DEFAULT '',
  `timeout_script` varchar(255) NOT NULL DEFAULT '',
  `local_address` varchar(255) NOT NULL DEFAULT '',
  `local_port` varchar(64) NOT NULL DEFAULT '10051',
  `proxy_groupid` bigint(20) unsigned DEFAULT NULL,
  `timeout_browser` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`proxyid`),
  UNIQUE KEY `proxy_1` (`name`),
  KEY `proxy_2` (`proxy_groupid`),
  CONSTRAINT `c_proxy_1` FOREIGN KEY (`proxy_groupid`) REFERENCES `proxy_group` (`proxy_groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy`
--

LOCK TABLES `proxy` WRITE;
/*!40000 ALTER TABLE `proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger proxy_insert after insert on proxy
for each row
insert into changelog (object,objectid,operation,clock)
values (19,new.proxyid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger proxy_update after update on proxy
for each row
insert into changelog (object,objectid,operation,clock)
values (19,old.proxyid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger proxy_delete before delete on proxy
for each row
insert into changelog (object,objectid,operation,clock)
values (19,old.proxyid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `host` varchar(128) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT 0,
  `listen_dns` varchar(255) NOT NULL DEFAULT '',
  `host_metadata` text NOT NULL,
  `flags` int(11) NOT NULL DEFAULT 0,
  `tls_accepted` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
INSERT INTO `proxy_autoreg_host` VALUES
(230,1764689064,'Zabbix agent 2','192.168.1.3',10050,'mon-host-2','',0,1);
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `druleid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(255) NOT NULL DEFAULT '',
  `error` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_dhistory_1` (`clock`),
  KEY `proxy_dhistory_2` (`druleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_group`
--

DROP TABLE IF EXISTS `proxy_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_group` (
  `proxy_groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `failover_delay` varchar(255) NOT NULL DEFAULT '1m',
  `min_online` varchar(255) NOT NULL DEFAULT '1',
  PRIMARY KEY (`proxy_groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_group`
--

LOCK TABLES `proxy_group` WRITE;
/*!40000 ALTER TABLE `proxy_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_group` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger proxy_group_insert after insert on proxy_group
for each row
insert into changelog (object,objectid,operation,clock)
values (20,new.proxy_groupid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger proxy_group_update after update on proxy_group
for each row
insert into changelog (object,objectid,operation,clock)
values (20,old.proxy_groupid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger proxy_group_delete before delete on proxy_group
for each row
insert into changelog (object,objectid,operation,clock)
values (20,old.proxy_groupid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proxy_group_rtdata`
--

DROP TABLE IF EXISTS `proxy_group_rtdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_group_rtdata` (
  `proxy_groupid` bigint(20) unsigned NOT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`proxy_groupid`),
  CONSTRAINT `c_proxy_group_rtdata_1` FOREIGN KEY (`proxy_groupid`) REFERENCES `proxy_group` (`proxy_groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_group_rtdata`
--

LOCK TABLES `proxy_group_rtdata` WRITE;
/*!40000 ALTER TABLE `proxy_group_rtdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_group_rtdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT 0,
  `value` longtext NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT 0,
  `mtime` int(11) NOT NULL DEFAULT 0,
  `flags` int(11) NOT NULL DEFAULT 0,
  `write_clock` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `proxy_history_2` (`write_clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
INSERT INTO `proxy_history` VALUES
(142300,71448,1764689148,0,'',0,'1',0,442096324,0,0,0,0,1764689148),
(142301,70313,1764698329,0,'',0,'6096.68',0,362826238,0,0,0,0,1764698329),
(142302,70315,1764698329,0,'',0,'4727841',0,362795247,0,0,0,0,1764698329),
(142303,70314,1764698329,0,'',0,'1',0,362815386,0,0,0,0,1764698329),
(187230,71448,1764698328,0,'',0,'1',0,828842953,0,0,0,0,1764698329),
(187231,70313,1764699185,0,'',0,'6953.21',0,896709341,0,0,0,0,1764699185),
(187232,70315,1764699185,0,'',0,'5311285',0,896807017,0,0,0,0,1764699185),
(189059,70061,1764862751,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:39:11 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 453\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:39:11 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 2962\nServerUptime: 49 minutes 22 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 92\nTotal kBytes: 68\nTotal Duration: 20\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00506415\nUptime: 2962\nReqPerSec: .0310601\nBytesPerSec: 23.5084\nBytesPerReq: 756.87\nDurationPerReq: .217391\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: ..................................................__________________________________________W_______..................................................\n',0,39846244,0,0,0,0,1764862751),
(189060,70067,1764862751,0,'',0,'.0310601',0,39846244,0,0,0,0,1764862751),
(189061,70062,1764862751,0,'',0,'92',0,39846244,0,0,0,0,1764862751),
(189062,70069,1764862751,0,'',0,'Apache/2.4.65 (Debian)',0,39846244,0,0,0,0,1764862751),
(189063,70068,1764862751,0,'',0,'2962',0,39846244,0,0,0,0,1764862751),
(189064,70064,1764862751,0,'',0,'756',0,39846244,0,0,0,0,1764862751),
(189065,70070,1764862751,0,'',0,'92',0,39846244,0,0,0,0,1764862751),
(189066,70066,1764862751,0,'',0,'49',0,39846244,0,0,0,0,1764862751),
(189067,70063,1764862751,0,'',0,'1',0,39846244,0,0,0,0,1764862751),
(189068,70065,1764862751,0,'',0,'23',0,39846244,0,0,0,0,1764862751),
(189069,71646,1764862746,0,'',0,'0.000000',0,145537421,0,0,0,0,1764862751),
(189070,71647,1764862747,0,'',0,'0.000000',0,145966626,0,0,0,0,1764862751),
(189071,71648,1764862748,0,'',0,'0.000000',0,146138640,0,0,0,0,1764862751),
(189072,71698,1764862748,0,'',0,'1864',0,146192194,0,0,0,0,1764862751),
(189073,71650,1764862750,0,'',0,'1764862750',0,148035513,0,0,0,0,1764862751),
(189074,71654,1764862754,0,'',0,'1022357504',0,152120804,0,0,0,0,1764862756),
(189075,71715,1764862754,0,'',0,'0.00018314334656091316',0,152154797,0,0,0,0,1764862756),
(189076,71719,1764862754,0,'',0,'0',0,152154797,0,0,0,0,1764862756),
(189077,71718,1764862754,0,'',0,'0',0,152154797,0,0,0,0,1764862756),
(189078,71720,1764862754,0,'',0,'0.00026639032227041915',0,152154797,0,0,0,0,1764862756),
(189079,71717,1764862754,0,'',0,'0',0,152154797,0,0,0,0,1764862756),
(189080,71716,1764862754,0,'',0,'0.58272882996654185',0,152154797,0,0,0,0,1764862756),
(189081,71714,1764862754,0,'',0,'',0,152154797,0,0,0,2,1764862756),
(189082,71655,1764862755,0,'',0,'100.000000',0,152662557,0,0,0,0,1764862756),
(189083,70061,1764862761,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:39:21 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 455\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:39:21 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 2972\nServerUptime: 49 minutes 32 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 93\nTotal kBytes: 69\nTotal Duration: 21\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00504711\nUptime: 2972\nReqPerSec: .0312921\nBytesPerSec: 23.7739\nBytesPerReq: 759.742\nDurationPerReq: .225806\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: .................................................._____________________W____________________________..................................................\n',0,39576987,0,0,0,0,1764862761),
(189084,70067,1764862761,0,'',0,'.0312921',0,39576987,0,0,0,0,1764862761),
(189085,70062,1764862761,0,'',0,'93',0,39576987,0,0,0,0,1764862761),
(189086,70069,1764862761,0,'',0,'Apache/2.4.65 (Debian)',0,39576987,0,0,0,0,1764862761),
(189087,70068,1764862761,0,'',0,'2972',0,39576987,0,0,0,0,1764862761),
(189088,70064,1764862761,0,'',0,'759',0,39576987,0,0,0,0,1764862761),
(189089,70070,1764862761,0,'',0,'93',0,39576987,0,0,0,0,1764862761),
(189090,70066,1764862761,0,'',0,'49',0,39576987,0,0,0,0,1764862761),
(189091,70063,1764862761,0,'',0,'1',0,39576987,0,0,0,0,1764862761),
(189092,70065,1764862761,0,'',0,'23',0,39576987,0,0,0,0,1764862761),
(189093,71656,1764862756,0,'',0,'1022357504',0,154069944,0,0,0,0,1764862761),
(189094,71657,1764862757,0,'',0,'',0,154208573,0,0,0,2,1764862761),
(189095,71658,1764862758,0,'',0,'2972',0,154826176,0,0,0,0,1764862761),
(189096,71698,1764862758,0,'',0,'1864',0,154997286,0,0,0,0,1764862761),
(189097,71659,1764862759,0,'',0,'1',0,158862905,0,0,0,0,1764862761),
(189098,71660,1764862760,0,'',0,'',0,159721652,0,0,0,2,1764862761),
(189099,71665,1764862765,0,'',0,'1',0,851338087,0,0,0,0,1764862766),
(189100,71661,1764862761,0,'',0,'',0,163341540,0,0,0,2,1764862766),
(189101,71710,1764862761,0,'',0,'35426344960',0,163341540,0,0,0,0,1764862766),
(189102,71705,1764862761,0,'',0,'{\"fsname\":\"/\",\"options\":\"rw,relatime,errors=remount-ro\",\"bytes\":{\"used\":3408084992,\"free\":35426344960,\"total\":40947412992,\"pused\":8.775937,\"pfree\":91.224063},\"fstype\":\"ext4\",\"inodes\":{\"used\":47483,\"free\":2511605,\"total\":2559088,\"pused\":1.855466,\"pfree\":98.144534}}',0,163341540,0,0,0,0,1764862766),
(189103,71709,1764862761,0,'',0,'8.775937',0,163341540,0,0,0,0,1764862766),
(189104,71670,1764862761,0,'',0,'',0,163341540,0,0,0,2,1764862766),
(189105,71707,1764862761,0,'',0,'3408084992',0,163341540,0,0,0,0,1764862766),
(189106,71708,1764862761,0,'',0,'40947412992',0,163341540,0,0,0,0,1764862766),
(189107,71706,1764862761,0,'',0,'0',0,163341540,0,0,0,0,1764862766),
(189108,71711,1764862761,0,'',0,'98.144534',0,163341540,0,0,0,0,1764862766),
(189109,71662,1764862762,0,'',0,'747106304',0,163770203,0,0,0,0,1764862766),
(189110,71663,1764862763,0,'',0,'74.158898',0,164819887,0,0,0,0,1764862766),
(189111,71667,1764862763,0,'',0,'25.841102000000006',0,164819887,0,0,0,0,1764862766),
(189112,71664,1764862764,0,'',0,'1007439872',0,165927624,0,0,0,0,1764862766),
(189113,70061,1764862771,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:39:31 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 453\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:39:31 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 2982\nServerUptime: 49 minutes 42 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 94\nTotal kBytes: 69\nTotal Duration: 21\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00503018\nUptime: 2982\nReqPerSec: .0315225\nBytesPerSec: 23.6942\nBytesPerReq: 751.66\nDurationPerReq: .223404\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: ..................................................____________________________W_____________________..................................................\n',0,39219429,0,0,0,0,1764862771),
(189114,70067,1764862771,0,'',0,'.0315225',0,39219429,0,0,0,0,1764862771),
(189115,70062,1764862771,0,'',0,'94',0,39219429,0,0,0,0,1764862771),
(189116,70069,1764862771,0,'',0,'Apache/2.4.65 (Debian)',0,39219429,0,0,0,0,1764862771),
(189117,70068,1764862771,0,'',0,'2982',0,39219429,0,0,0,0,1764862771),
(189118,70064,1764862771,0,'',0,'751',0,39219429,0,0,0,0,1764862771),
(189119,70070,1764862771,0,'',0,'94',0,39219429,0,0,0,0,1764862771),
(189120,70066,1764862771,0,'',0,'49',0,39219429,0,0,0,0,1764862771),
(189121,70063,1764862771,0,'',0,'1',0,39219429,0,0,0,0,1764862771),
(189122,70065,1764862771,0,'',0,'23',0,39219429,0,0,0,0,1764862771),
(189123,71698,1764862768,0,'',0,'2248',0,168659509,0,0,0,0,1764862771),
(189124,71698,1764862778,0,'',0,'1800',0,176333071,0,0,0,0,1764862778),
(189125,70061,1764862781,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:39:41 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 453\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:39:41 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 2992\nServerUptime: 49 minutes 52 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 95\nTotal kBytes: 70\nTotal Duration: 21\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00501337\nUptime: 2992\nReqPerSec: .0317513\nBytesPerSec: 23.9572\nBytesPerReq: 754.526\nDurationPerReq: .221053\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: .................................................._______________________W__________________________..................................................\n',0,39843965,0,0,0,0,1764862781),
(189126,70067,1764862781,0,'',0,'.0317513',0,39843965,0,0,0,0,1764862781),
(189127,70062,1764862781,0,'',0,'95',0,39843965,0,0,0,0,1764862781),
(189128,70069,1764862781,0,'',0,'Apache/2.4.65 (Debian)',0,39843965,0,0,0,0,1764862781),
(189129,70068,1764862781,0,'',0,'2992',0,39843965,0,0,0,0,1764862781),
(189130,70064,1764862781,0,'',0,'754',0,39843965,0,0,0,0,1764862781),
(189131,70070,1764862781,0,'',0,'95',0,39843965,0,0,0,0,1764862781),
(189132,70066,1764862781,0,'',0,'49',0,39843965,0,0,0,0,1764862781),
(189133,70063,1764862781,0,'',0,'1',0,39843965,0,0,0,0,1764862781),
(189134,70065,1764862781,0,'',0,'23',0,39843965,0,0,0,0,1764862781),
(189135,71626,1764862786,0,'',0,'1',0,181611694,0,0,0,0,1764862787),
(189136,71448,1764862788,0,'',0,'0',0,877905872,0,0,0,0,1764862789),
(189137,70061,1764862791,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:39:51 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 452\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:39:51 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 3002\nServerUptime: 50 minutes 2 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 96\nTotal kBytes: 71\nTotal Duration: 21\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00499667\nUptime: 3002\nReqPerSec: .0319787\nBytesPerSec: 24.2185\nBytesPerReq: 757.333\nDurationPerReq: .21875\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: .................................................._____________________________________________W____..................................................\n',0,39473260,0,0,0,0,1764862791),
(189138,70067,1764862791,0,'',0,'.0319787',0,39473260,0,0,0,0,1764862791),
(189139,70062,1764862791,0,'',0,'96',0,39473260,0,0,0,0,1764862791),
(189140,70069,1764862791,0,'',0,'Apache/2.4.65 (Debian)',0,39473260,0,0,0,0,1764862791),
(189141,70068,1764862791,0,'',0,'3002',0,39473260,0,0,0,0,1764862791),
(189142,70064,1764862791,0,'',0,'757',0,39473260,0,0,0,0,1764862791),
(189143,70070,1764862791,0,'',0,'96',0,39473260,0,0,0,0,1764862791),
(189144,70066,1764862791,0,'',0,'49',0,39473260,0,0,0,0,1764862791),
(189145,70063,1764862791,0,'',0,'1',0,39473260,0,0,0,0,1764862791),
(189146,70065,1764862791,0,'',0,'24',0,39473260,0,0,0,0,1764862791),
(189147,71658,1764862788,0,'',0,'3002',0,183806494,0,0,0,0,1764862791),
(189148,71698,1764862788,0,'',0,'2008',0,183853144,0,0,0,0,1764862791),
(189149,71630,1764862790,0,'',0,'84',0,186794991,0,0,0,0,1764862791),
(189150,71631,1764862791,0,'',0,'1',0,189923423,0,0,0,0,1764862796),
(189151,71633,1764862793,0,'',0,'475.51818325344391',0,191579498,0,0,0,0,1764862796),
(189152,71634,1764862794,0,'',0,'0.000000',0,192971244,0,0,0,0,1764862796),
(189153,71635,1764862795,0,'',0,'0.000000',0,194046292,0,0,0,0,1764862796),
(189154,70061,1764862801,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:40:01 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 449\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:40:01 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 3012\nServerUptime: 50 minutes 12 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 97\nTotal kBytes: 72\nTotal Duration: 21\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00498008\nUptime: 3012\nReqPerSec: .0322045\nBytesPerSec: 24.4781\nBytesPerReq: 760.082\nDurationPerReq: .216495\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: ..................................................W_________________________________________________..................................................\n',0,39156545,0,0,0,0,1764862801),
(189155,70067,1764862801,0,'',0,'.0322045',0,39156545,0,0,0,0,1764862801),
(189156,70062,1764862801,0,'',0,'97',0,39156545,0,0,0,0,1764862801),
(189157,70069,1764862801,0,'',0,'Apache/2.4.65 (Debian)',0,39156545,0,0,0,0,1764862801),
(189158,70068,1764862801,0,'',0,'3012',0,39156545,0,0,0,0,1764862801),
(189159,70064,1764862801,0,'',0,'760',0,39156545,0,0,0,0,1764862801),
(189160,70070,1764862801,0,'',0,'97',0,39156545,0,0,0,0,1764862801),
(189161,70066,1764862801,0,'',0,'49',0,39156545,0,0,0,0,1764862801),
(189162,70063,1764862801,0,'',0,'1',0,39156545,0,0,0,0,1764862801),
(189163,70065,1764862801,0,'',0,'24',0,39156545,0,0,0,0,1764862801),
(189164,71696,1764862796,0,'',0,'0',0,196094281,0,0,0,0,1764862801),
(189165,71636,1764862796,0,'',0,'0.000000',0,196103539,0,0,0,0,1764862801),
(189166,71637,1764862797,0,'',0,'',0,196988105,0,0,0,2,1764862801),
(189167,71697,1764862797,0,'',0,'0',0,197023459,0,0,0,0,1764862801),
(189168,71638,1764862798,0,'',0,'69.83028563264152',0,197455017,0,0,0,0,1764862801),
(189169,71698,1764862798,0,'',0,'2032',0,197488139,0,0,0,0,1764862801),
(189170,71699,1764862799,0,'',0,'0',0,198506184,0,0,0,0,1764862801),
(189171,71639,1764862799,0,'',0,'0.000000',0,198512312,0,0,0,0,1764862801),
(189172,71640,1764862800,0,'',0,'0.000000',0,199164197,0,0,0,0,1764862801),
(189173,71700,1764862800,0,'',0,'0',0,199210439,0,0,0,0,1764862801),
(189174,71641,1764862801,0,'',0,'99.932660',0,201256878,0,0,0,0,1764862806),
(189175,71666,1764862801,0,'',0,'0.06734000000000151',0,201256878,0,0,0,0,1764862806),
(189176,71701,1764862801,0,'',0,'4192',0,201297954,0,0,0,0,1764862806),
(189177,71642,1764862802,0,'',0,'0.000000',0,201827939,0,0,0,0,1764862806),
(189178,71702,1764862802,0,'',0,'6',0,201864541,0,0,0,0,1764862806),
(189179,71703,1764862803,0,'',0,'',0,202057624,0,0,0,2,1764862806),
(189180,71643,1764862803,0,'',0,'0.016832',0,202066320,0,0,0,0,1764862806),
(189181,71644,1764862804,0,'',0,'0.000000',0,203352830,0,0,0,0,1764862806),
(189182,71645,1764862805,0,'',0,'0.033659',0,204317728,0,0,0,0,1764862806),
(189183,70061,1764862811,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:40:11 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 450\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:40:11 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 3022\nServerUptime: 50 minutes 22 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 98\nTotal kBytes: 72\nTotal Duration: 22\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .0049636\nUptime: 3022\nReqPerSec: .0324289\nBytesPerSec: 24.3971\nBytesPerReq: 752.327\nDurationPerReq: .22449\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: ..................................................___________________________W______________________..................................................\n',0,40067561,0,0,0,0,1764862811),
(189184,70067,1764862811,0,'',0,'.0324289',0,40067561,0,0,0,0,1764862811),
(189185,70062,1764862811,0,'',0,'98',0,40067561,0,0,0,0,1764862811),
(189186,70069,1764862811,0,'',0,'Apache/2.4.65 (Debian)',0,40067561,0,0,0,0,1764862811),
(189187,70068,1764862811,0,'',0,'3022',0,40067561,0,0,0,0,1764862811),
(189188,70064,1764862811,0,'',0,'752',0,40067561,0,0,0,0,1764862811),
(189189,70070,1764862811,0,'',0,'98',0,40067561,0,0,0,0,1764862811),
(189190,70066,1764862811,0,'',0,'49',0,40067561,0,0,0,0,1764862811),
(189191,70063,1764862811,0,'',0,'1',0,40067561,0,0,0,0,1764862811),
(189192,70065,1764862811,0,'',0,'24',0,40067561,0,0,0,0,1764862811),
(189193,71646,1764862806,0,'',0,'0.000000',0,205851290,0,0,0,0,1764862811),
(189194,71647,1764862807,0,'',0,'0.016829',0,206660190,0,0,0,0,1764862811),
(189195,71648,1764862808,0,'',0,'0.016832',0,207487709,0,0,0,0,1764862811),
(189196,71698,1764862808,0,'',0,'1816',0,207535809,0,0,0,0,1764862811),
(189197,71650,1764862810,0,'',0,'1764862810',0,210387420,0,0,0,0,1764862811),
(189198,71654,1764862814,0,'',0,'1022357504',0,213404808,0,0,0,0,1764862816),
(189199,71715,1764862814,0,'',0,'0.00016649659724946123',0,213442326,0,0,0,0,1764862816),
(189200,71719,1764862814,0,'',0,'0',0,213442326,0,0,0,0,1764862816),
(189201,71718,1764862814,0,'',0,'0',0,213442326,0,0,0,0,1764862816),
(189202,71720,1764862814,0,'',0,'0.00029969387504903016',0,213442326,0,0,0,0,1764862816),
(189203,71717,1764862814,0,'',0,'0',0,213442326,0,0,0,0,1764862816),
(189204,71716,1764862814,0,'',0,'0.51613945147332974',0,213442326,0,0,0,0,1764862816),
(189205,71714,1764862814,0,'',0,'',0,213442326,0,0,0,2,1764862816),
(189206,71655,1764862815,0,'',0,'100.000000',0,214133502,0,0,0,0,1764862816),
(189207,70061,1764862821,0,'',0,'HTTP/1.1 200 OK\r\nDate: Thu, 04 Dec 2025 15:40:21 GMT\r\nServer: Apache/2.4.65 (Debian)\r\nVary: Accept-Encoding\r\nContent-Encoding: gzip\r\nContent-Length: 450\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n192.168.1.2\nServerVersion: Apache/2.4.65 (Debian)\nServerMPM: event\nServer Built: 2025-07-29T20:18:46\nCurrentTime: Thursday, 04-Dec-2025 18:40:21 MSK\nRestartTime: Thursday, 04-Dec-2025 17:49:48 MSK\nParentServerConfigGeneration: 2\nParentServerMPMGeneration: 1\nServerUptimeSeconds: 3032\nServerUptime: 50 minutes 32 seconds\nLoad1: 0.00\nLoad5: 0.00\nLoad15: 0.00\nTotal Accesses: 99\nTotal kBytes: 73\nTotal Duration: 22\nCPUUser: .02\nCPUSystem: .13\nCPUChildrenUser: 0\nCPUChildrenSystem: 0\nCPULoad: .00494723\nUptime: 3032\nReqPerSec: .0326517\nBytesPerSec: 24.6544\nBytesPerReq: 755.071\nDurationPerReq: .222222\nBusyWorkers: 1\nGracefulWorkers: 0\nIdleWorkers: 49\nProcesses: 2\nStopping: 0\nConnsTotal: 0\nConnsAsyncWaitIO: 0\nConnsAsyncWriting: 0\nConnsAsyncKeepAlive: 0\nConnsAsyncClosing: 0\nScoreboard: ..................................................__W_______________________________________________..................................................\n',0,38891747,0,0,0,0,1764862821),
(189208,70067,1764862821,0,'',0,'.0326517',0,38891747,0,0,0,0,1764862821),
(189209,70062,1764862821,0,'',0,'99',0,38891747,0,0,0,0,1764862821),
(189210,70069,1764862821,0,'',0,'Apache/2.4.65 (Debian)',0,38891747,0,0,0,0,1764862821),
(189211,70068,1764862821,0,'',0,'3032',0,38891747,0,0,0,0,1764862821),
(189212,70064,1764862821,0,'',0,'755',0,38891747,0,0,0,0,1764862821),
(189213,70070,1764862821,0,'',0,'99',0,38891747,0,0,0,0,1764862821),
(189214,70066,1764862821,0,'',0,'49',0,38891747,0,0,0,0,1764862821),
(189215,70063,1764862821,0,'',0,'1',0,38891747,0,0,0,0,1764862821),
(189216,70065,1764862821,0,'',0,'24',0,38891747,0,0,0,0,1764862821),
(189217,71656,1764862816,0,'',0,'1022357504',0,215934418,0,0,0,0,1764862821),
(189218,71658,1764862818,0,'',0,'3032',0,216617522,0,0,0,0,1764862821),
(189219,71698,1764862818,0,'',0,'1864',0,216667058,0,0,0,0,1764862821),
(189220,71659,1764862819,0,'',0,'1',0,219767921,0,0,0,0,1764862821),
(189221,71661,1764862821,0,'',0,'',0,222812740,0,0,0,2,1764862826),
(189222,71706,1764862821,0,'',0,'0',0,222812740,0,0,0,0,1764862826),
(189223,71711,1764862821,0,'',0,'98.144534',0,222812740,0,0,0,0,1764862826),
(189224,71670,1764862821,0,'',0,'',0,222812740,0,0,0,2,1764862826),
(189225,71707,1764862821,0,'',0,'3408084992',0,222812740,0,0,0,0,1764862826),
(189226,71708,1764862821,0,'',0,'40947412992',0,222812740,0,0,0,0,1764862826),
(189227,71705,1764862821,0,'',0,'{\"fsname\":\"/\",\"options\":\"rw,relatime,errors=remount-ro\",\"bytes\":{\"used\":3408084992,\"free\":35426344960,\"total\":40947412992,\"pused\":8.775937,\"pfree\":91.224063},\"fstype\":\"ext4\",\"inodes\":{\"used\":47483,\"free\":2511605,\"total\":2559088,\"pused\":1.855466,\"pfree\":98.144534}}',0,222812740,0,0,0,0,1764862826),
(189228,71709,1764862821,0,'',0,'8.775937',0,222812740,0,0,0,0,1764862826),
(189229,71710,1764862821,0,'',0,'35426344960',0,222812740,0,0,0,0,1764862826),
(189230,71662,1764862822,0,'',0,'747155456',0,223021089,0,0,0,0,1764862826),
(189231,71663,1764862823,0,'',0,'74.164183',0,224111049,0,0,0,0,1764862826),
(189232,71667,1764862823,0,'',0,'25.835817000000006',0,224111049,0,0,0,0,1764862826),
(189233,71664,1764862824,0,'',0,'1007439872',0,226201259,0,0,0,0,1764862826),
(189234,71665,1764862825,0,'',0,'1',0,910710629,0,0,0,0,1764862826);
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_rtdata`
--

DROP TABLE IF EXISTS `proxy_rtdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_rtdata` (
  `proxyid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT 0,
  `version` int(11) NOT NULL DEFAULT 0,
  `compatibility` int(11) NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`proxyid`),
  CONSTRAINT `c_proxy_rtdata_1` FOREIGN KEY (`proxyid`) REFERENCES `proxy` (`proxyid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_rtdata`
--

LOCK TABLES `proxy_rtdata` WRITE;
/*!40000 ALTER TABLE `proxy_rtdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_rtdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `test_string` text NOT NULL,
  PRIMARY KEY (`regexpid`),
  UNIQUE KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES
(1,'File systems for discovery',''),
(2,'Network interfaces for discovery',''),
(3,'Storage devices for SNMP discovery',''),
(4,'Windows service names for discovery',''),
(5,'Windows service startup states for discovery',''),
(6,'GetErrorLog','');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `reportid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(2048) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `period` int(11) NOT NULL DEFAULT 0,
  `cycle` int(11) NOT NULL DEFAULT 0,
  `weekdays` int(11) NOT NULL DEFAULT 0,
  `start_time` int(11) NOT NULL DEFAULT 0,
  `active_since` int(11) NOT NULL DEFAULT 0,
  `active_till` int(11) NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `lastsent` int(11) NOT NULL DEFAULT 0,
  `info` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`reportid`),
  UNIQUE KEY `report_1` (`name`),
  KEY `report_2` (`userid`),
  KEY `report_3` (`dashboardid`),
  CONSTRAINT `c_report_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_report_2` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_param`
--

DROP TABLE IF EXISTS `report_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_param` (
  `reportparamid` bigint(20) unsigned NOT NULL,
  `reportid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`reportparamid`),
  KEY `report_param_1` (`reportid`),
  CONSTRAINT `c_report_param_1` FOREIGN KEY (`reportid`) REFERENCES `report` (`reportid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_param`
--

LOCK TABLES `report_param` WRITE;
/*!40000 ALTER TABLE `report_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_user`
--

DROP TABLE IF EXISTS `report_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_user` (
  `reportuserid` bigint(20) unsigned NOT NULL,
  `reportid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `exclude` int(11) NOT NULL DEFAULT 0,
  `access_userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`reportuserid`),
  KEY `report_user_1` (`reportid`),
  KEY `report_user_2` (`userid`),
  KEY `report_user_3` (`access_userid`),
  CONSTRAINT `c_report_user_1` FOREIGN KEY (`reportid`) REFERENCES `report` (`reportid`) ON DELETE CASCADE,
  CONSTRAINT `c_report_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_report_user_3` FOREIGN KEY (`access_userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_user`
--

LOCK TABLES `report_user` WRITE;
/*!40000 ALTER TABLE `report_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_usrgrp`
--

DROP TABLE IF EXISTS `report_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_usrgrp` (
  `reportusrgrpid` bigint(20) unsigned NOT NULL,
  `reportid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `access_userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`reportusrgrpid`),
  KEY `report_usrgrp_1` (`reportid`),
  KEY `report_usrgrp_2` (`usrgrpid`),
  KEY `report_usrgrp_3` (`access_userid`),
  CONSTRAINT `c_report_usrgrp_1` FOREIGN KEY (`reportid`) REFERENCES `report` (`reportid`) ON DELETE CASCADE,
  CONSTRAINT `c_report_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_report_usrgrp_3` FOREIGN KEY (`access_userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_usrgrp`
--

LOCK TABLES `report_usrgrp` WRITE;
/*!40000 ALTER TABLE `report_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 0,
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 0,
  `readonly` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`roleid`),
  UNIQUE KEY `role_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_rule`
--

DROP TABLE IF EXISTS `role_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_rule` (
  `role_ruleid` bigint(20) unsigned NOT NULL,
  `roleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value_int` int(11) NOT NULL DEFAULT 0,
  `value_str` varchar(255) NOT NULL DEFAULT '',
  `value_moduleid` bigint(20) unsigned DEFAULT NULL,
  `value_serviceid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`role_ruleid`),
  KEY `role_rule_1` (`roleid`),
  KEY `role_rule_2` (`value_moduleid`),
  KEY `role_rule_3` (`value_serviceid`),
  CONSTRAINT `c_role_rule_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON DELETE CASCADE,
  CONSTRAINT `c_role_rule_2` FOREIGN KEY (`value_moduleid`) REFERENCES `module` (`moduleid`) ON DELETE CASCADE,
  CONSTRAINT `c_role_rule_3` FOREIGN KEY (`value_serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_rule`
--

LOCK TABLES `role_rule` WRITE;
/*!40000 ALTER TABLE `role_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scim_group`
--

DROP TABLE IF EXISTS `scim_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scim_group` (
  `scim_groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`scim_groupid`),
  UNIQUE KEY `scim_group_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scim_group`
--

LOCK TABLES `scim_group` WRITE;
/*!40000 ALTER TABLE `scim_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `scim_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script_param`
--

DROP TABLE IF EXISTS `script_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `script_param` (
  `script_paramid` bigint(20) unsigned NOT NULL,
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`script_paramid`),
  UNIQUE KEY `script_param_1` (`scriptid`,`name`),
  CONSTRAINT `c_script_param_1` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `script_param`
--

LOCK TABLES `script_param` WRITE;
/*!40000 ALTER TABLE `script_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `script_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `command` text NOT NULL,
  `host_access` int(11) NOT NULL DEFAULT 2,
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `confirmation` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 5,
  `execute_on` int(11) NOT NULL DEFAULT 2,
  `timeout` varchar(32) NOT NULL DEFAULT '30s',
  `scope` int(11) NOT NULL DEFAULT 1,
  `port` varchar(64) NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT 0,
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `menu_path` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(2048) NOT NULL DEFAULT '',
  `new_window` int(11) NOT NULL DEFAULT 1,
  `manualinput` int(11) NOT NULL DEFAULT 0,
  `manualinput_prompt` varchar(255) NOT NULL DEFAULT '',
  `manualinput_validator` varchar(2048) NOT NULL DEFAULT '',
  `manualinput_validator_type` int(11) NOT NULL DEFAULT 0,
  `manualinput_default_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`scriptid`),
  UNIQUE KEY `scripts_3` (`name`,`menu_path`),
  KEY `scripts_1` (`usrgrpid`),
  KEY `scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_problem`
--

DROP TABLE IF EXISTS `service_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_problem` (
  `service_problemid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `severity` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`service_problemid`),
  KEY `service_problem_1` (`eventid`),
  KEY `service_problem_2` (`serviceid`),
  CONSTRAINT `c_service_problem_1` FOREIGN KEY (`eventid`) REFERENCES `problem` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_service_problem_2` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_problem`
--

LOCK TABLES `service_problem` WRITE;
/*!40000 ALTER TABLE `service_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_problem_tag`
--

DROP TABLE IF EXISTS `service_problem_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_problem_tag` (
  `service_problem_tagid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`service_problem_tagid`),
  KEY `service_problem_tag_1` (`serviceid`),
  CONSTRAINT `c_service_problem_tag_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_problem_tag`
--

LOCK TABLES `service_problem_tag` WRITE;
/*!40000 ALTER TABLE `service_problem_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_problem_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_status_rule`
--

DROP TABLE IF EXISTS `service_status_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_status_rule` (
  `service_status_ruleid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `limit_value` int(11) NOT NULL DEFAULT 0,
  `limit_status` int(11) NOT NULL DEFAULT 0,
  `new_status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`service_status_ruleid`),
  KEY `service_status_rule_1` (`serviceid`),
  CONSTRAINT `c_service_status_rule_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_status_rule`
--

LOCK TABLES `service_status_rule` WRITE;
/*!40000 ALTER TABLE `service_status_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_status_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_tag`
--

DROP TABLE IF EXISTS `service_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_tag` (
  `servicetagid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`servicetagid`),
  KEY `service_tag_1` (`serviceid`),
  CONSTRAINT `c_service_tag_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_tag`
--

LOCK TABLES `service_tag` WRITE;
/*!40000 ALTER TABLE `service_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT -1,
  `algorithm` int(11) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  `weight` int(11) NOT NULL DEFAULT 0,
  `propagation_rule` int(11) NOT NULL DEFAULT 0,
  `propagation_value` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `uuid` varchar(32) NOT NULL DEFAULT '',
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `secret` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`,`lastaccess`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `name` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `value_str` text NOT NULL,
  `value_int` int(11) NOT NULL DEFAULT 0,
  `value_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `value_hostgroupid` bigint(20) unsigned DEFAULT NULL,
  `value_userdirectoryid` bigint(20) unsigned DEFAULT NULL,
  `value_mfaid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `settings_2` (`value_usrgrpid`),
  KEY `settings_3` (`value_hostgroupid`),
  KEY `settings_4` (`value_userdirectoryid`),
  KEY `settings_5` (`value_mfaid`),
  CONSTRAINT `c_settings_2` FOREIGN KEY (`value_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_settings_3` FOREIGN KEY (`value_hostgroupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_settings_4` FOREIGN KEY (`value_userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`),
  CONSTRAINT `c_settings_5` FOREIGN KEY (`value_mfaid`) REFERENCES `mfa` (`mfaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
('autoreg_tls_accept',2,'',1,NULL,NULL,NULL,NULL),
('hk_history',1,'31d',0,NULL,NULL,NULL,NULL),
('hk_history_global',2,'',0,NULL,NULL,NULL,NULL),
('proxy_secrets_provider',2,'',0,NULL,NULL,NULL,NULL),
('snmptrap_logging',2,'',1,NULL,NULL,NULL,NULL),
('timeout_browser',1,'60s',0,NULL,NULL,NULL,NULL),
('timeout_db_monitor',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_external_check',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_http_agent',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_script',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_simple_check',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_snmp_agent',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_ssh_agent',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_telnet_agent',1,'3s',0,NULL,NULL,NULL,NULL),
('timeout_zabbix_agent',1,'3s',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sla`
--

DROP TABLE IF EXISTS `sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sla` (
  `slaid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `period` int(11) NOT NULL DEFAULT 0,
  `slo` double NOT NULL DEFAULT 99.9,
  `effective_date` int(11) NOT NULL DEFAULT 0,
  `timezone` varchar(50) NOT NULL DEFAULT 'UTC',
  `status` int(11) NOT NULL DEFAULT 1,
  `description` text NOT NULL,
  PRIMARY KEY (`slaid`),
  UNIQUE KEY `sla_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sla`
--

LOCK TABLES `sla` WRITE;
/*!40000 ALTER TABLE `sla` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sla_excluded_downtime`
--

DROP TABLE IF EXISTS `sla_excluded_downtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sla_excluded_downtime` (
  `sla_excluded_downtimeid` bigint(20) unsigned NOT NULL,
  `slaid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `period_from` int(11) NOT NULL DEFAULT 0,
  `period_to` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sla_excluded_downtimeid`),
  KEY `sla_excluded_downtime_1` (`slaid`),
  CONSTRAINT `c_sla_excluded_downtime_1` FOREIGN KEY (`slaid`) REFERENCES `sla` (`slaid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sla_excluded_downtime`
--

LOCK TABLES `sla_excluded_downtime` WRITE;
/*!40000 ALTER TABLE `sla_excluded_downtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla_excluded_downtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sla_schedule`
--

DROP TABLE IF EXISTS `sla_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sla_schedule` (
  `sla_scheduleid` bigint(20) unsigned NOT NULL,
  `slaid` bigint(20) unsigned NOT NULL,
  `period_from` int(11) NOT NULL DEFAULT 0,
  `period_to` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sla_scheduleid`),
  KEY `sla_schedule_1` (`slaid`),
  CONSTRAINT `c_sla_schedule_1` FOREIGN KEY (`slaid`) REFERENCES `sla` (`slaid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sla_schedule`
--

LOCK TABLES `sla_schedule` WRITE;
/*!40000 ALTER TABLE `sla_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sla_service_tag`
--

DROP TABLE IF EXISTS `sla_service_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sla_service_tag` (
  `sla_service_tagid` bigint(20) unsigned NOT NULL,
  `slaid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sla_service_tagid`),
  KEY `sla_service_tag_1` (`slaid`),
  CONSTRAINT `c_sla_service_tag_1` FOREIGN KEY (`slaid`) REFERENCES `sla` (`slaid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sla_service_tag`
--

LOCK TABLES `sla_service_tag` WRITE;
/*!40000 ALTER TABLE `sla_service_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `sla_service_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_trigger`
--

DROP TABLE IF EXISTS `sysmap_element_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_element_trigger` (
  `selement_triggerid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`selement_triggerid`),
  UNIQUE KEY `sysmap_element_trigger_1` (`selementid`,`triggerid`),
  KEY `sysmap_element_trigger_2` (`triggerid`),
  CONSTRAINT `c_sysmap_element_trigger_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_element_trigger_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_trigger`
--

LOCK TABLES `sysmap_element_trigger` WRITE;
/*!40000 ALTER TABLE `sysmap_element_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_link_threshold`
--

DROP TABLE IF EXISTS `sysmap_link_threshold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_link_threshold` (
  `linkthresholdid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `type` int(11) NOT NULL DEFAULT 0,
  `threshold` varchar(255) NOT NULL DEFAULT '',
  `pattern` varchar(255) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`linkthresholdid`),
  KEY `sysmap_link_threshold_1` (`linkid`),
  CONSTRAINT `c_sysmap_link_threshold_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_link_threshold`
--

LOCK TABLES `sysmap_link_threshold` WRITE;
/*!40000 ALTER TABLE `sysmap_link_threshold` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_link_threshold` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_shape`
--

DROP TABLE IF EXISTS `sysmap_shape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_shape` (
  `sysmap_shapeid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `width` int(11) NOT NULL DEFAULT 200,
  `height` int(11) NOT NULL DEFAULT 200,
  `text` text NOT NULL,
  `font` int(11) NOT NULL DEFAULT 9,
  `font_size` int(11) NOT NULL DEFAULT 11,
  `font_color` varchar(6) NOT NULL DEFAULT '000000',
  `text_halign` int(11) NOT NULL DEFAULT 0,
  `text_valign` int(11) NOT NULL DEFAULT 0,
  `border_type` int(11) NOT NULL DEFAULT 0,
  `border_width` int(11) NOT NULL DEFAULT 1,
  `border_color` varchar(6) NOT NULL DEFAULT '000000',
  `background_color` varchar(6) NOT NULL DEFAULT '',
  `zindex` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sysmap_shapeid`),
  KEY `sysmap_shape_1` (`sysmapid`),
  CONSTRAINT `c_sysmap_shape_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_shape`
--

LOCK TABLES `sysmap_shape` WRITE;
/*!40000 ALTER TABLE `sysmap_shape` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_shape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(2048) NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_user`
--

DROP TABLE IF EXISTS `sysmap_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_user` (
  `sysmapuserid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 2,
  PRIMARY KEY (`sysmapuserid`),
  UNIQUE KEY `sysmap_user_1` (`sysmapid`,`userid`),
  KEY `sysmap_user_2` (`userid`),
  CONSTRAINT `c_sysmap_user_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_user`
--

LOCK TABLES `sysmap_user` WRITE;
/*!40000 ALTER TABLE `sysmap_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_usrgrp`
--

DROP TABLE IF EXISTS `sysmap_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmap_usrgrp` (
  `sysmapusrgrpid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT 2,
  PRIMARY KEY (`sysmapusrgrpid`),
  UNIQUE KEY `sysmap_usrgrp_1` (`sysmapid`,`usrgrpid`),
  KEY `sysmap_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_sysmap_usrgrp_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_usrgrp`
--

LOCK TABLES `sysmap_usrgrp` WRITE;
/*!40000 ALTER TABLE `sysmap_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT 600,
  `height` int(11) NOT NULL DEFAULT 400,
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT 2,
  `label_location` int(11) NOT NULL DEFAULT 0,
  `highlight` int(11) NOT NULL DEFAULT 1,
  `expandproblem` int(11) NOT NULL DEFAULT 1,
  `markelements` int(11) NOT NULL DEFAULT 0,
  `show_unack` int(11) NOT NULL DEFAULT 0,
  `grid_size` int(11) NOT NULL DEFAULT 50,
  `grid_show` int(11) NOT NULL DEFAULT 1,
  `grid_align` int(11) NOT NULL DEFAULT 1,
  `label_format` int(11) NOT NULL DEFAULT 0,
  `label_type_host` int(11) NOT NULL DEFAULT 2,
  `label_type_hostgroup` int(11) NOT NULL DEFAULT 2,
  `label_type_trigger` int(11) NOT NULL DEFAULT 2,
  `label_type_map` int(11) NOT NULL DEFAULT 2,
  `label_type_image` int(11) NOT NULL DEFAULT 2,
  `label_string_host` varchar(255) NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) NOT NULL DEFAULT '',
  `label_string_map` varchar(255) NOT NULL DEFAULT '',
  `label_string_image` varchar(255) NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT 0,
  `severity_min` int(11) NOT NULL DEFAULT 0,
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT 1,
  `show_suppressed` int(11) NOT NULL DEFAULT 0,
  `background_scale` int(11) NOT NULL DEFAULT 1,
  `show_element_label` int(11) NOT NULL DEFAULT 1,
  `show_link_label` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`sysmapid`),
  UNIQUE KEY `sysmaps_1` (`name`),
  KEY `sysmaps_2` (`backgroundid`),
  KEY `sysmaps_3` (`iconmapid`),
  KEY `sysmaps_4` (`userid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`),
  CONSTRAINT `c_sysmaps_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_element_tag`
--

DROP TABLE IF EXISTS `sysmaps_element_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmaps_element_tag` (
  `selementtagid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`selementtagid`),
  KEY `sysmaps_element_tag_1` (`selementid`),
  CONSTRAINT `c_sysmaps_element_tag_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_element_tag`
--

LOCK TABLES `sysmaps_element_tag` WRITE;
/*!40000 ALTER TABLE `sysmaps_element_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_element_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `elementtype` int(11) NOT NULL DEFAULT 0,
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(2048) NOT NULL DEFAULT '',
  `label_location` int(11) NOT NULL DEFAULT -1,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT 0,
  `areatype` int(11) NOT NULL DEFAULT 0,
  `width` int(11) NOT NULL DEFAULT 200,
  `height` int(11) NOT NULL DEFAULT 200,
  `viewtype` int(11) NOT NULL DEFAULT 0,
  `use_iconmap` int(11) NOT NULL DEFAULT 1,
  `evaltype` int(11) NOT NULL DEFAULT 0,
  `show_label` int(11) NOT NULL DEFAULT -1,
  `zindex` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`selementid`),
  KEY `sysmaps_elements_1` (`sysmapid`),
  KEY `sysmaps_elements_2` (`iconid_off`),
  KEY `sysmaps_elements_3` (`iconid_on`),
  KEY `sysmaps_elements_4` (`iconid_disabled`),
  KEY `sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `label` varchar(2048) NOT NULL DEFAULT '',
  `show_label` int(11) NOT NULL DEFAULT -1,
  `indicator_type` int(11) NOT NULL DEFAULT 0,
  `itemid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`linkid`),
  KEY `sysmaps_links_1` (`sysmapid`),
  KEY `sysmaps_links_2` (`selementid1`),
  KEY `sysmaps_links_3` (`selementid2`),
  KEY `sysmaps_links_4` (`itemid`),
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_4` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_filter`
--

DROP TABLE IF EXISTS `tag_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_filter` (
  `tag_filterid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`tag_filterid`),
  KEY `tag_filter_1` (`usrgrpid`),
  KEY `tag_filter_2` (`groupid`),
  CONSTRAINT `c_tag_filter_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_tag_filter_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_filter`
--

LOCK TABLES `tag_filter` WRITE;
/*!40000 ALTER TABLE `tag_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `taskid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `clock` int(11) NOT NULL DEFAULT 0,
  `ttl` int(11) NOT NULL DEFAULT 0,
  `proxyid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`taskid`),
  KEY `task_1` (`status`,`proxyid`),
  KEY `task_2` (`proxyid`),
  CONSTRAINT `c_task_1` FOREIGN KEY (`proxyid`) REFERENCES `proxy` (`proxyid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_acknowledge`
--

DROP TABLE IF EXISTS `task_acknowledge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_acknowledge` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_acknowledge_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_acknowledge`
--

LOCK TABLES `task_acknowledge` WRITE;
/*!40000 ALTER TABLE `task_acknowledge` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_acknowledge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_check_now`
--

DROP TABLE IF EXISTS `task_check_now`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_check_now` (
  `taskid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_check_now_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_check_now`
--

LOCK TABLES `task_check_now` WRITE;
/*!40000 ALTER TABLE `task_check_now` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_check_now` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_close_problem`
--

DROP TABLE IF EXISTS `task_close_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_close_problem` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_close_problem_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_close_problem`
--

LOCK TABLES `task_close_problem` WRITE;
/*!40000 ALTER TABLE `task_close_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_close_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_data`
--

DROP TABLE IF EXISTS `task_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_data` (
  `taskid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `data` text NOT NULL,
  `parent_taskid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_data_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_data`
--

LOCK TABLES `task_data` WRITE;
/*!40000 ALTER TABLE `task_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command`
--

DROP TABLE IF EXISTS `task_remote_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_remote_command` (
  `taskid` bigint(20) unsigned NOT NULL,
  `command_type` int(11) NOT NULL DEFAULT 0,
  `execute_on` int(11) NOT NULL DEFAULT 0,
  `port` int(11) NOT NULL DEFAULT 0,
  `authtype` int(11) NOT NULL DEFAULT 0,
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `command` text NOT NULL,
  `alertid` bigint(20) unsigned DEFAULT NULL,
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command`
--

LOCK TABLES `task_remote_command` WRITE;
/*!40000 ALTER TABLE `task_remote_command` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command_result`
--

DROP TABLE IF EXISTS `task_remote_command_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_remote_command_result` (
  `taskid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `info` longtext NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_result_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command_result`
--

LOCK TABLES `task_remote_command_result` WRITE;
/*!40000 ALTER TABLE `task_remote_command_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_result`
--

DROP TABLE IF EXISTS `task_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_result` (
  `taskid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `info` longtext NOT NULL,
  PRIMARY KEY (`taskid`),
  KEY `task_result_1` (`parent_taskid`),
  CONSTRAINT `c_task_result_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_result`
--

LOCK TABLES `task_result` WRITE;
/*!40000 ALTER TABLE `task_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT 0,
  `every` int(11) NOT NULL DEFAULT 1,
  `month` int(11) NOT NULL DEFAULT 0,
  `dayofweek` int(11) NOT NULL DEFAULT 0,
  `day` int(11) NOT NULL DEFAULT 0,
  `start_time` int(11) NOT NULL DEFAULT 0,
  `period` int(11) NOT NULL DEFAULT 0,
  `start_date` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `tokenid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `token` varchar(128) DEFAULT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `expires_at` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0,
  `creator_userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`tokenid`),
  UNIQUE KEY `token_2` (`userid`,`name`),
  UNIQUE KEY `token_3` (`token`),
  KEY `token_1` (`name`),
  KEY `token_4` (`creator_userid`),
  CONSTRAINT `c_token_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_token_2` FOREIGN KEY (`creator_userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  `value_min` double NOT NULL DEFAULT 0,
  `value_avg` double NOT NULL DEFAULT 0,
  `value_max` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  `value_min` bigint(20) unsigned NOT NULL DEFAULT 0,
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT 0,
  `value_max` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trigger_discovery` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  `lastcheck` int(11) NOT NULL DEFAULT 0,
  `ts_delete` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `disable_source` int(11) NOT NULL DEFAULT 0,
  `ts_disable` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`triggerid`),
  KEY `trigger_discovery_1` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_queue`
--

DROP TABLE IF EXISTS `trigger_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trigger_queue` (
  `trigger_queueid` bigint(20) unsigned NOT NULL,
  `objectid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `clock` int(11) NOT NULL DEFAULT 0,
  `ns` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`trigger_queueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_queue`
--

LOCK TABLES `trigger_queue` WRITE;
/*!40000 ALTER TABLE `trigger_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_tag`
--

DROP TABLE IF EXISTS `trigger_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trigger_tag` (
  `triggertagid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`triggertagid`),
  KEY `trigger_tag_1` (`triggerid`),
  CONSTRAINT `c_trigger_tag_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_tag`
--

LOCK TABLES `trigger_tag` WRITE;
/*!40000 ALTER TABLE `trigger_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger trigger_tag_insert after insert on trigger_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (6,new.triggertagid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger trigger_tag_update after update on trigger_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (6,old.triggertagid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger trigger_tag_delete before delete on trigger_tag
for each row
insert into changelog (object,objectid,operation,clock)
values (6,old.triggertagid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(2048) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(2048) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `lastchange` int(11) NOT NULL DEFAULT 0,
  `comments` text NOT NULL,
  `error` varchar(2048) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `flags` int(11) NOT NULL DEFAULT 0,
  `recovery_mode` int(11) NOT NULL DEFAULT 0,
  `recovery_expression` varchar(2048) NOT NULL DEFAULT '',
  `correlation_mode` int(11) NOT NULL DEFAULT 0,
  `correlation_tag` varchar(255) NOT NULL DEFAULT '',
  `manual_close` int(11) NOT NULL DEFAULT 0,
  `opdata` varchar(255) NOT NULL DEFAULT '',
  `discover` int(11) NOT NULL DEFAULT 0,
  `event_name` varchar(2048) NOT NULL DEFAULT '',
  `uuid` varchar(32) NOT NULL DEFAULT '',
  `url_name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`,`lastchange`),
  KEY `triggers_3` (`templateid`),
  KEY `triggers_4` (`uuid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger triggers_insert after insert on triggers
for each row
insert into changelog (object,objectid,operation,clock)
values (5,new.triggerid,1,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger triggers_update after update on triggers
for each row
insert into changelog (object,objectid,operation,clock)
values (5,old.triggerid,2,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`zabbix`@`localhost`*/ /*!50003 trigger triggers_delete before delete on triggers
for each row
insert into changelog (object,objectid,operation,clock)
values (5,old.triggerid,3,unix_timestamp()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ugset`
--

DROP TABLE IF EXISTS `ugset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ugset` (
  `ugsetid` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`ugsetid`),
  KEY `ugset_1` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ugset`
--

LOCK TABLES `ugset` WRITE;
/*!40000 ALTER TABLE `ugset` DISABLE KEYS */;
/*!40000 ALTER TABLE `ugset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ugset_group`
--

DROP TABLE IF EXISTS `ugset_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ugset_group` (
  `ugsetid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`ugsetid`,`usrgrpid`),
  KEY `ugset_group_1` (`usrgrpid`),
  CONSTRAINT `c_ugset_group_1` FOREIGN KEY (`ugsetid`) REFERENCES `ugset` (`ugsetid`) ON DELETE CASCADE,
  CONSTRAINT `c_ugset_group_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ugset_group`
--

LOCK TABLES `ugset_group` WRITE;
/*!40000 ALTER TABLE `ugset_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ugset_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_scim_group`
--

DROP TABLE IF EXISTS `user_scim_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_scim_group` (
  `user_scim_groupid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `scim_groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_scim_groupid`),
  KEY `user_scim_group_1` (`userid`),
  KEY `user_scim_group_2` (`scim_groupid`),
  CONSTRAINT `c_user_scim_group_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_user_scim_group_2` FOREIGN KEY (`scim_groupid`) REFERENCES `scim_group` (`scim_groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_scim_group`
--

LOCK TABLES `user_scim_group` WRITE;
/*!40000 ALTER TABLE `user_scim_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_scim_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ugset`
--

DROP TABLE IF EXISTS `user_ugset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_ugset` (
  `userid` bigint(20) unsigned NOT NULL,
  `ugsetid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `user_ugset_1` (`ugsetid`),
  CONSTRAINT `c_user_ugset_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_user_ugset_2` FOREIGN KEY (`ugsetid`) REFERENCES `ugset` (`ugsetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ugset`
--

LOCK TABLES `user_ugset` WRITE;
/*!40000 ALTER TABLE `user_ugset` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ugset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdirectory`
--

DROP TABLE IF EXISTS `userdirectory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdirectory` (
  `userdirectoryid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `idp_type` int(11) NOT NULL DEFAULT 1,
  `provision_status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userdirectoryid`),
  KEY `userdirectory_1` (`idp_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdirectory`
--

LOCK TABLES `userdirectory` WRITE;
/*!40000 ALTER TABLE `userdirectory` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdirectory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdirectory_idpgroup`
--

DROP TABLE IF EXISTS `userdirectory_idpgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdirectory_idpgroup` (
  `userdirectory_idpgroupid` bigint(20) unsigned NOT NULL,
  `userdirectoryid` bigint(20) unsigned NOT NULL,
  `roleid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`userdirectory_idpgroupid`),
  KEY `userdirectory_idpgroup_1` (`userdirectoryid`),
  KEY `userdirectory_idpgroup_2` (`roleid`),
  CONSTRAINT `c_userdirectory_idpgroup_1` FOREIGN KEY (`userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`) ON DELETE CASCADE,
  CONSTRAINT `c_userdirectory_idpgroup_2` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdirectory_idpgroup`
--

LOCK TABLES `userdirectory_idpgroup` WRITE;
/*!40000 ALTER TABLE `userdirectory_idpgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdirectory_idpgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdirectory_ldap`
--

DROP TABLE IF EXISTS `userdirectory_ldap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdirectory_ldap` (
  `userdirectoryid` bigint(20) unsigned NOT NULL,
  `host` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT 389,
  `base_dn` varchar(255) NOT NULL DEFAULT '',
  `search_attribute` varchar(128) NOT NULL DEFAULT '',
  `bind_dn` varchar(255) NOT NULL DEFAULT '',
  `bind_password` varchar(128) NOT NULL DEFAULT '',
  `start_tls` int(11) NOT NULL DEFAULT 0,
  `search_filter` varchar(255) NOT NULL DEFAULT '',
  `group_basedn` varchar(255) NOT NULL DEFAULT '',
  `group_name` varchar(255) NOT NULL DEFAULT '',
  `group_member` varchar(255) NOT NULL DEFAULT '',
  `user_ref_attr` varchar(255) NOT NULL DEFAULT '',
  `group_filter` varchar(255) NOT NULL DEFAULT '',
  `group_membership` varchar(255) NOT NULL DEFAULT '',
  `user_username` varchar(255) NOT NULL DEFAULT '',
  `user_lastname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`userdirectoryid`),
  CONSTRAINT `c_userdirectory_ldap_1` FOREIGN KEY (`userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdirectory_ldap`
--

LOCK TABLES `userdirectory_ldap` WRITE;
/*!40000 ALTER TABLE `userdirectory_ldap` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdirectory_ldap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdirectory_media`
--

DROP TABLE IF EXISTS `userdirectory_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdirectory_media` (
  `userdirectory_mediaid` bigint(20) unsigned NOT NULL,
  `userdirectoryid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(255) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT 0,
  `severity` int(11) NOT NULL DEFAULT 63,
  `period` varchar(1024) NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`userdirectory_mediaid`),
  KEY `userdirectory_media_1` (`userdirectoryid`),
  KEY `userdirectory_media_2` (`mediatypeid`),
  CONSTRAINT `c_userdirectory_media_1` FOREIGN KEY (`userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`) ON DELETE CASCADE,
  CONSTRAINT `c_userdirectory_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdirectory_media`
--

LOCK TABLES `userdirectory_media` WRITE;
/*!40000 ALTER TABLE `userdirectory_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdirectory_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdirectory_saml`
--

DROP TABLE IF EXISTS `userdirectory_saml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdirectory_saml` (
  `userdirectoryid` bigint(20) unsigned NOT NULL,
  `idp_entityid` varchar(1024) NOT NULL DEFAULT '',
  `sso_url` varchar(2048) NOT NULL DEFAULT '',
  `slo_url` varchar(2048) NOT NULL DEFAULT '',
  `username_attribute` varchar(128) NOT NULL DEFAULT '',
  `sp_entityid` varchar(1024) NOT NULL DEFAULT '',
  `nameid_format` varchar(2048) NOT NULL DEFAULT '',
  `sign_messages` int(11) NOT NULL DEFAULT 0,
  `sign_assertions` int(11) NOT NULL DEFAULT 0,
  `sign_authn_requests` int(11) NOT NULL DEFAULT 0,
  `sign_logout_requests` int(11) NOT NULL DEFAULT 0,
  `sign_logout_responses` int(11) NOT NULL DEFAULT 0,
  `encrypt_nameid` int(11) NOT NULL DEFAULT 0,
  `encrypt_assertions` int(11) NOT NULL DEFAULT 0,
  `group_name` varchar(255) NOT NULL DEFAULT '',
  `user_username` varchar(255) NOT NULL DEFAULT '',
  `user_lastname` varchar(255) NOT NULL DEFAULT '',
  `scim_status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userdirectoryid`),
  CONSTRAINT `c_userdirectory_saml_1` FOREIGN KEY (`userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdirectory_saml`
--

LOCK TABLES `userdirectory_saml` WRITE;
/*!40000 ALTER TABLE `userdirectory_saml` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdirectory_saml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdirectory_usrgrp`
--

DROP TABLE IF EXISTS `userdirectory_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdirectory_usrgrp` (
  `userdirectory_usrgrpid` bigint(20) unsigned NOT NULL,
  `userdirectory_idpgroupid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`userdirectory_usrgrpid`),
  UNIQUE KEY `userdirectory_usrgrp_1` (`userdirectory_idpgroupid`,`usrgrpid`),
  KEY `userdirectory_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_userdirectory_usrgrp_1` FOREIGN KEY (`userdirectory_idpgroupid`) REFERENCES `userdirectory_idpgroup` (`userdirectory_idpgroupid`) ON DELETE CASCADE,
  CONSTRAINT `c_userdirectory_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdirectory_usrgrp`
--

LOCK TABLES `userdirectory_usrgrp` WRITE;
/*!40000 ALTER TABLE `userdirectory_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdirectory_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `surname` varchar(100) NOT NULL DEFAULT '',
  `passwd` varchar(60) NOT NULL DEFAULT '',
  `url` varchar(2048) NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT 0,
  `autologout` varchar(32) NOT NULL DEFAULT '15m',
  `lang` varchar(7) NOT NULL DEFAULT 'default',
  `refresh` varchar(32) NOT NULL DEFAULT '30s',
  `theme` varchar(128) NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT 0,
  `attempt_ip` varchar(39) NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT 0,
  `rows_per_page` int(11) NOT NULL DEFAULT 50,
  `timezone` varchar(50) NOT NULL DEFAULT 'default',
  `roleid` bigint(20) unsigned DEFAULT NULL,
  `userdirectoryid` bigint(20) unsigned DEFAULT NULL,
  `ts_provisioned` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `users_1` (`username`),
  KEY `users_2` (`userdirectoryid`),
  KEY `users_3` (`roleid`),
  CONSTRAINT `c_users_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_2` FOREIGN KEY (`userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT 0,
  `users_status` int(11) NOT NULL DEFAULT 0,
  `debug_mode` int(11) NOT NULL DEFAULT 0,
  `userdirectoryid` bigint(20) unsigned DEFAULT NULL,
  `mfa_status` int(11) NOT NULL DEFAULT 0,
  `mfaid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`usrgrpid`),
  UNIQUE KEY `usrgrp_1` (`name`),
  KEY `usrgrp_2` (`userdirectoryid`),
  KEY `usrgrp_3` (`mfaid`),
  CONSTRAINT `c_usrgrp_2` FOREIGN KEY (`userdirectoryid`) REFERENCES `userdirectory` (`userdirectoryid`),
  CONSTRAINT `c_usrgrp_3` FOREIGN KEY (`mfaid`) REFERENCES `mfa` (`mfaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemap`
--

DROP TABLE IF EXISTS `valuemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `valuemap` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `uuid` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  UNIQUE KEY `valuemap_1` (`hostid`,`name`),
  KEY `valuemap_2` (`uuid`),
  CONSTRAINT `c_valuemap_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemap`
--

LOCK TABLES `valuemap` WRITE;
/*!40000 ALTER TABLE `valuemap` DISABLE KEYS */;
/*!40000 ALTER TABLE `valuemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemap_mapping`
--

DROP TABLE IF EXISTS `valuemap_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `valuemap_mapping` (
  `valuemap_mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) NOT NULL DEFAULT '',
  `newvalue` varchar(64) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 0,
  `sortorder` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`valuemap_mappingid`),
  UNIQUE KEY `valuemap_mapping_1` (`valuemapid`,`value`,`type`),
  CONSTRAINT `c_valuemap_mapping_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemap` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemap_mapping`
--

LOCK TABLES `valuemap_mapping` WRITE;
/*!40000 ALTER TABLE `valuemap_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `valuemap_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget`
--

DROP TABLE IF EXISTS `widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `widget` (
  `widgetid` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `width` int(11) NOT NULL DEFAULT 1,
  `height` int(11) NOT NULL DEFAULT 2,
  `view_mode` int(11) NOT NULL DEFAULT 0,
  `dashboard_pageid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`widgetid`),
  KEY `widget_1` (`dashboard_pageid`),
  CONSTRAINT `c_widget_1` FOREIGN KEY (`dashboard_pageid`) REFERENCES `dashboard_page` (`dashboard_pageid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget_field`
--

DROP TABLE IF EXISTS `widget_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `widget_field` (
  `widget_fieldid` bigint(20) unsigned NOT NULL,
  `widgetid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value_int` int(11) NOT NULL DEFAULT 0,
  `value_str` varchar(2048) NOT NULL DEFAULT '',
  `value_groupid` bigint(20) unsigned DEFAULT NULL,
  `value_hostid` bigint(20) unsigned DEFAULT NULL,
  `value_itemid` bigint(20) unsigned DEFAULT NULL,
  `value_graphid` bigint(20) unsigned DEFAULT NULL,
  `value_sysmapid` bigint(20) unsigned DEFAULT NULL,
  `value_serviceid` bigint(20) unsigned DEFAULT NULL,
  `value_slaid` bigint(20) unsigned DEFAULT NULL,
  `value_userid` bigint(20) unsigned DEFAULT NULL,
  `value_actionid` bigint(20) unsigned DEFAULT NULL,
  `value_mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`widget_fieldid`),
  KEY `widget_field_1` (`widgetid`),
  KEY `widget_field_2` (`value_groupid`),
  KEY `widget_field_3` (`value_hostid`),
  KEY `widget_field_4` (`value_itemid`),
  KEY `widget_field_5` (`value_graphid`),
  KEY `widget_field_6` (`value_sysmapid`),
  KEY `widget_field_7` (`value_serviceid`),
  KEY `widget_field_8` (`value_slaid`),
  KEY `widget_field_9` (`value_userid`),
  KEY `widget_field_10` (`value_actionid`),
  KEY `widget_field_11` (`value_mediatypeid`),
  CONSTRAINT `c_widget_field_1` FOREIGN KEY (`widgetid`) REFERENCES `widget` (`widgetid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_10` FOREIGN KEY (`value_actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_11` FOREIGN KEY (`value_mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_2` FOREIGN KEY (`value_groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_3` FOREIGN KEY (`value_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_4` FOREIGN KEY (`value_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_5` FOREIGN KEY (`value_graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_6` FOREIGN KEY (`value_sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_7` FOREIGN KEY (`value_serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_8` FOREIGN KEY (`value_slaid`) REFERENCES `sla` (`slaid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_9` FOREIGN KEY (`value_userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget_field`
--

LOCK TABLES `widget_field` WRITE;
/*!40000 ALTER TABLE `widget_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `widget_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-04 18:54:12
