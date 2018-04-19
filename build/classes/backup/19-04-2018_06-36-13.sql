-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: bapers
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Current Database: `bapers`
--

/*!40000 DROP DATABASE IF EXISTS `bapers`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bapers` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bapers`;

--
-- Table structure for table `band`
--

DROP TABLE IF EXISTS `band`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `band` (
  `volume` varchar(20) NOT NULL,
  `discount_rate` float DEFAULT NULL,
  PRIMARY KEY (`volume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `band`
--

LOCK TABLES `band` WRITE;
/*!40000 ALTER TABLE `band` DISABLE KEYS */;
INSERT INTO `band` VALUES ('1',0),('2',1),('3',2);
/*!40000 ALTER TABLE `band` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card` (
  `card_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `expire_date` date NOT NULL,
  `ccv` varchar(3) NOT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `card_id_uindex` (`card_id`),
  KEY `card_customer_account_customer_id_fk` (`customer_id`),
  CONSTRAINT `card_customer_account_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer_account` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (7,'7826423745287352','Mr. Brown','2018-12-01','237',1);
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_account`
--

DROP TABLE IF EXISTS `customer_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_account` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_type` enum('Individual','Organisation') NOT NULL DEFAULT 'Individual',
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `address_1` varchar(30) NOT NULL,
  `address_2` varchar(30) DEFAULT NULL,
  `town_city` varchar(20) NOT NULL,
  `county` varchar(20) DEFAULT NULL,
  `postcode` char(9) NOT NULL,
  `country` varchar(20) NOT NULL DEFAULT 'United Kingdom',
  `type` enum('Default','Valued') DEFAULT 'Default',
  `contact_no` bigint(11) unsigned zerofill NOT NULL,
  `email` varchar(30) NOT NULL,
  `Suspended` enum('True','False') NOT NULL DEFAULT 'False',
  `discount_type` enum('Fixed','Flexible','Variable','Null') NOT NULL DEFAULT 'Null',
  `percentage` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_account_id_uindex` (`customer_id`),
  UNIQUE KEY `customer_account_email_uindex` (`email`),
  UNIQUE KEY `customer_account_contact_no_uindex` (`contact_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_account`
--

LOCK TABLES `customer_account` WRITE;
/*!40000 ALTER TABLE `customer_account` DISABLE KEYS */;
INSERT INTO `customer_account` VALUES (1,'Organisation','City, University of London (City)',NULL,'Northampton Square','','London','London','EC1V 0HB','United Kingdom','Valued',02070408000,'David.Rhind@city.ac.uk','False','Fixed',3),(2,'Organisation','InfoPharma Ltd',NULL,'25 Bond Street','','London','London','WC1V 8LS','United Kingdom','Valued',02073218001,'Alex.Wright@infopharma.com','False','Flexible',0),(3,'Organisation','Hello Magazine',NULL,'12 Bond Street','','London','London','WC1V 8NS','United Kingdom','Valued',02034567808,'Sarah.Brocklehurst@hello.com','False','Flexible',0),(4,'Individual','Eva','Bauyer','1 Liverpool street','','London','London','EC2V 8NS','United Kingdom','Valued',02085558989,'eva.bauyer@gmail.com','False','Fixed',3),(6,'Organisation','HarryCo-op',NULL,'Prince Street','King\'s Ln','London','Edgeware','N5 3HE','United Kingdom','Valued',07829347568,'admin@harry.coop.com','False','Variable',0);
/*!40000 ALTER TABLE `customer_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `prime_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` varchar(14) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `deadline` datetime NOT NULL,
  `priority` enum('Standard','6 Hour','3 Hour','1 Hour') NOT NULL DEFAULT 'Standard',
  `status` enum('Pending','In-Progress','Finished','On-Hold','Customer-Removed') NOT NULL DEFAULT 'Pending',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `special_instruction` varchar(255) DEFAULT NULL,
  `staff_instruction` varchar(255) DEFAULT NULL,
  `discount` float NOT NULL DEFAULT '0',
  `price` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`prime_id`),
  UNIQUE KEY `job_prime_id_uindex` (`prime_id`),
  KEY `job_customer_account_customer_id_fk` (`customer_id`),
  KEY `job_staff_account_staff_id_fk` (`staff_id`),
  KEY `job_task_task_id_fk_idx` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (119,'20180416175041',6,5,8,'2018-04-16 17:50:41','2018-04-16 18:50:34','1 Hour','Finished','2018-04-19 06:24:20','2018-04-19 06:24:26',NULL,'',2,295.225),(120,'20180416175149',6,5,5,'2018-04-16 17:51:49','2018-04-16 20:51:47','3 Hour','Finished','2018-04-19 06:20:59','2018-04-19 06:24:20','','',1,218.394),(121,'20180416204918',6,5,4,'2018-04-16 20:49:18','2018-04-16 21:49:12','1 Hour','Finished','2018-04-19 06:24:26','2018-04-19 06:24:31','','',4,192),(122,'20180416205629',1,NULL,3,'2018-04-16 20:56:29','2018-04-16 21:55:55','1 Hour','Pending',NULL,NULL,'','',3,14.55),(123,'20180416205629',1,8,7,'2018-04-16 20:56:29','2018-04-17 20:56:12','Standard','Finished','2018-04-18 14:18:54','2018-04-18 14:18:59','','',3,53.835),(124,'20180416205629',1,6,1,'2018-04-16 20:56:29','2018-04-17 02:56:19','6 Hour','Finished','2018-04-18 14:18:16','2018-04-18 14:18:19','','',3,27.645),(125,'20180417023834',6,5,2,'2018-04-17 02:38:34','2018-04-17 08:38:13','6 Hour','Finished','2018-04-19 06:28:30','2018-04-19 06:30:08','','',4,71.28),(126,'20180417023834',6,5,5,'2018-04-17 02:38:34','2018-04-17 05:38:18','3 Hour','In-Progress','2018-04-19 06:30:08',NULL,'','Missing\nfound',1,218.394),(127,'20180417024121',8,NULL,5,'2018-04-17 02:41:21','0022-10-09 00:00:00','6 Hour','Customer-Removed',NULL,NULL,'',NULL,0,165.45),(128,'20180417024121',8,NULL,4,'2018-04-17 02:41:21','0022-10-09 00:00:00','3 Hour','Customer-Removed',NULL,NULL,'',NULL,0,160),(129,'20180417173110',2,6,1,'2018-04-17 17:31:10','2018-04-18 17:31:09','Standard','Finished','2018-04-18 14:18:39','2018-04-19 01:17:12','','',0,19),(130,'20180417184711',1,9,5,'2018-04-17 18:47:11','2018-04-17 21:46:47','3 Hour','Finished','2018-04-18 14:14:00','2018-04-18 14:14:05','','',3,213.982),(131,'20180417184711',1,9,8,'2018-04-17 18:47:11','2018-04-18 00:47:05','6 Hour','In-Progress','2018-04-18 14:17:02',NULL,'',NULL,3,175.327),(132,'20180417193628',2,NULL,3,'2018-04-17 19:36:28','2018-04-17 20:35:17','1 Hour','Pending',NULL,NULL,'','',0,15),(133,'20180417193628',2,6,6,'2018-04-17 19:36:28','2018-04-18 01:35:25','6 Hour','Finished','2018-04-18 14:18:20','2018-04-18 14:18:23','','',0,12.45),(134,'20180417193628',2,9,8,'2018-04-17 19:36:28','2018-04-17 20:35:34','1 Hour','Finished','2018-04-18 14:13:55','2018-04-18 14:14:00','','',0,301.25),(135,'20180417193628',2,NULL,4,'2018-04-17 19:36:29','2018-04-18 19:36:12','Standard','Pending',NULL,NULL,'',NULL,0,80),(136,'20180417223431',3,NULL,4,'2018-04-17 22:34:31','2018-04-18 01:34:15','3 Hour','Pending',NULL,NULL,'',NULL,0,160),(137,'20180417223431',3,6,6,'2018-04-17 22:34:31','2018-04-18 22:34:19','Standard','Finished','2018-04-19 01:17:12','2018-04-19 01:17:19','','',0,8.3),(138,'20180417223431',3,NULL,3,'2018-04-17 22:34:31','2018-04-18 04:34:25','6 Hour','Pending',NULL,NULL,'','',0,9),(139,'20180417223431',3,8,7,'2018-04-17 22:34:31','2018-04-18 22:34:30','Standard','Finished','2018-04-18 14:19:08','2018-04-18 14:19:12','','',0,55.5),(140,'20180417223630',4,NULL,4,'2018-04-17 22:36:30','2018-04-18 01:36:18','3 Hour','Pending',NULL,NULL,'',NULL,3,155.2),(141,'20180417223630',4,8,7,'2018-04-17 22:36:30','2018-04-18 04:36:23','6 Hour','Finished','2018-04-18 14:18:59','2018-04-18 14:19:03','','',3,80.7525),(142,'20180417223630',4,6,9,'2018-04-17 22:36:30','2018-04-18 22:36:29','Standard','Finished','2018-04-19 01:17:19','2018-04-19 01:17:26','','',3,73.235),(143,'20180417223832',1,6,6,'2018-04-17 22:38:32','2018-04-18 01:38:19','3 Hour','Finished','2018-04-18 14:18:23','2018-04-18 14:18:29','','',3,16.102),(144,'20180417223832',1,6,6,'2018-04-17 22:38:32','2018-04-18 04:38:24','6 Hour','Finished','2018-04-18 14:18:29','2018-04-18 14:18:35','','',3,12.0765),(145,'20180417223832',1,8,7,'2018-04-17 22:38:32','2018-04-18 22:38:29','Standard','Finished','2018-04-18 14:19:12','2018-04-18 14:19:15','','',3,53.835),(146,'20180417224020',1,9,4,'2018-04-17 22:40:20','2018-04-17 23:40:10','1 Hour','Finished','2018-04-18 14:14:05','2018-04-18 14:14:10','','',3,194),(147,'20180417224020',1,NULL,4,'2018-04-17 22:40:20','2018-04-17 23:40:15','1 Hour','Pending',NULL,NULL,'','',3,194),(148,'20180417224020',1,NULL,3,'2018-04-17 22:40:20','2018-04-18 22:40:19','Standard','Pending',NULL,NULL,'',NULL,3,5.82),(149,'20180417224227',4,6,1,'2018-04-17 22:42:27','2018-04-18 22:42:14','Standard','Finished','2018-04-19 01:17:26','2018-04-19 01:17:31','','',3,18.43),(150,'20180417224227',4,NULL,2,'2018-04-17 22:42:27','2018-04-18 01:42:20','3 Hour','Pending',NULL,NULL,'',NULL,3,96.03),(151,'20180417224227',4,8,7,'2018-04-17 22:42:27','2018-04-18 04:42:25','6 Hour','Finished','2018-04-18 14:19:03','2018-04-18 14:19:08','','',3,80.7525),(152,'20180417225315',3,6,6,'2018-04-17 22:53:15','2018-04-18 22:52:54','Standard','Finished','2018-04-19 01:17:31','2018-04-19 01:17:35','','',0,8.3),(153,'20180417225315',3,NULL,8,'2018-04-17 22:53:15','2018-04-18 04:53:00','6 Hour','Pending',NULL,NULL,'',NULL,0,180.75),(154,'20180417225315',3,8,7,'2018-04-17 22:53:15','2018-04-18 22:53:03','Standard','In-Progress','2018-04-18 14:19:15',NULL,'',NULL,0,55.5),(155,'20180417225315',3,NULL,3,'2018-04-17 22:53:15','2018-04-17 23:53:08','1 Hour','Pending',NULL,NULL,'','',0,15),(156,'20180418013427',4,6,1,'2018-04-18 01:34:27','2018-04-19 01:34:16','Standard','Finished','2018-04-19 01:17:35','2018-04-19 01:17:41','','',3,18.43),(157,'20180418013427',4,NULL,2,'2018-04-18 01:34:27','2018-04-18 07:34:21','6 Hour','Pending',NULL,NULL,'',NULL,3,72.0225),(158,'20180418013427',4,NULL,8,'2018-04-18 01:34:27','2018-04-18 04:34:26','3 Hour','Pending',NULL,NULL,'',NULL,3,233.77),(159,'20180418022739',3,NULL,3,'2018-04-18 02:27:39','2018-04-18 05:27:16','3 Hour','Pending',NULL,NULL,'','',0,12),(160,'20180418022739',3,NULL,8,'2018-04-18 02:27:39','2018-04-18 05:27:21','3 Hour','Pending',NULL,NULL,'',NULL,0,241),(161,'20180418022739',3,NULL,3,'2018-04-18 02:27:39','2018-04-18 05:27:27','3 Hour','Pending',NULL,NULL,'',NULL,0,12),(162,'20180418022739',3,6,9,'2018-04-18 02:27:39','2018-04-18 05:27:33','3 Hour','Finished','2018-04-18 14:18:35','2018-04-18 14:18:39','','',0,151),(163,'20180418022739',3,NULL,4,'2018-04-18 02:27:39','2018-04-18 05:27:38','3 Hour','Pending',NULL,NULL,'',NULL,0,160),(164,'20180418091051',4,NULL,4,'2018-04-18 09:10:51','2018-04-18 12:10:26','3 Hour','Pending',NULL,NULL,'',NULL,3,155.2),(165,'20180418091051',4,NULL,8,'2018-02-18 09:10:51','2018-04-18 15:10:36','6 Hour','Pending',NULL,NULL,'',NULL,3,175.327),(166,'20180418091051',4,NULL,3,'2018-04-18 09:10:51','2018-04-19 09:10:44','Standard','Pending',NULL,NULL,'',NULL,3,5.82),(167,'20180418091051',4,NULL,4,'2018-04-18 09:10:51','2018-04-19 09:10:50','Standard','Pending',NULL,NULL,'',NULL,3,77.6),(168,'20180418094255',3,6,1,'2018-04-18 09:42:55','2018-04-19 09:42:47','Standard','In-Progress','2018-04-19 01:17:47',NULL,'',NULL,1,18.81),(169,'20180418094255',3,NULL,7,'2018-04-18 09:42:55','2018-04-19 09:42:50','Standard','Pending',NULL,NULL,'',NULL,1,54.945),(170,'20180418094255',3,NULL,3,'2018-04-18 09:42:55','2018-04-18 15:42:54','6 Hour','Pending',NULL,NULL,'',NULL,1,8.91),(171,'20180418134915',2,NULL,4,'2018-04-18 13:49:15','2018-04-19 13:48:47','Standard','Pending',NULL,NULL,'',NULL,0,80),(172,'20180418134915',2,NULL,4,'2018-04-18 13:49:15','2018-04-18 16:48:52','3 Hour','Pending',NULL,NULL,'',NULL,0,160),(173,'20180418134915',2,NULL,9,'2018-04-18 13:49:16','2018-04-19 13:48:57','Standard','Pending',NULL,NULL,'',NULL,0,75.5),(174,'20180418134915',2,NULL,6,'2018-04-18 13:49:16','2018-04-19 13:49:05','Standard','Pending',NULL,NULL,'',NULL,0,8.3),(175,'20180418134915',2,NULL,3,'2018-04-18 13:49:16','2018-04-18 16:49:14','3 Hour','Pending',NULL,NULL,'',NULL,0,12),(176,'20180419011501',6,6,1,'2018-04-19 01:15:01','2018-04-20 01:14:26','Standard','Finished','2018-04-19 01:17:42','2018-04-19 01:17:47','',NULL,2,18.62),(177,'20180419011501',6,6,1,'2018-04-19 01:15:01','2018-04-19 02:14:54','1 Hour','Finished','2018-04-19 01:17:42','2018-04-19 01:17:47','','',2,46.55);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `logger` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES ('2018-04-16 06:54:48: Staff Account ID: 1: Logged Out'),('2018-04-16 06:54:59: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-16 17:48:45: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 17:48:57: Opened customer account : 6'),('2018-04-16 17:50:41: New task added: customer id: 6 task : Image Processing Job-id: 20180416175041'),('2018-04-16 17:50:41: Opened customer account : 6'),('2018-04-16 17:51:49: New task added: customer id: 6 task : Colour Transparency processing Job-id: 20180416175149'),('2018-04-16 17:51:50: Opened customer account : 6'),('2018-04-16 17:57:42: Opened customer account : 6'),('2018-04-16 17:58:25: Staff Account ID: 1: Logged Out'),('2018-04-16 17:59:05: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('Job-Task id: 119 : assigned to the staff_id: 5'),('2018-04-16 17:59:27: Job-Task: 119: status updated: Finished: by Staff id: 5'),('Job-Task id: 120 : assigned to the staff_id: 5'),('2018-04-16 17:59:52: Staff Account ID: 5: Logged Out'),('2018-04-16 17:59:59: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-16 18:00:23: Job-Task: 120: status updated: Finished: by Staff id: 5'),('2018-04-16 18:00:47: Staff Account ID: 5: Logged Out'),('2018-04-16 18:00:57: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-16 18:01:34: Staff Account ID: 5: Logged Out'),('2018-04-16 18:04:23: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-16 18:05:52: Staff Account ID: 4: Logged Out'),('2018-04-16 18:55:29: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-16 18:55:38: Staff Account ID: 5: Logged Out'),('2018-04-16 18:56:06: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('Job-Task id: 119 : assigned to the staff_id: 5'),('2018-04-16 18:56:28: Job-Task: 119: status updated: Finished: by Staff id: 5'),('Job-Task id: 120 : assigned to the staff_id: 5'),('2018-04-16 18:56:55: Staff Account ID: 5: Logged Out'),('2018-04-16 19:15:55: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 19:16:36: Opened customer account : 6'),('2018-04-16 19:17:29: Data backup successfull'),('2018-04-16 19:19:50: Opened customer account : 6'),('2018-04-16 19:20:01: Opened customer account : 6'),('2018-04-16 19:20:32: Opened customer account : 6'),('2018-04-16 19:20:37: Opened customer account : 6'),('2018-04-16 19:23:09: Opened customer account : 6'),('2018-04-16 19:23:16: Staff Account ID: 1: Logged Out'),('2018-04-16 20:25:13: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 20:27:06: Staff Account ID: 1: Logged Out'),('2018-04-16 20:48:38: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 20:48:51: Opened customer account : 6'),('2018-04-16 20:48:57: Opened customer account : 6'),('2018-04-16 20:49:18: New task added: customer id: 6 task : Colour film processing Job-id: 20180416204918'),('2018-04-16 20:49:18: Opened customer account : 6'),('2018-04-16 20:49:34: Opened customer account : 6'),('2018-04-16 20:51:07: Staff Account ID: 1: Logged Out'),('2018-04-16 20:52:01: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-16 20:52:10: Job-Task: 120: status updated: Finished: by Staff id: 5'),('Job-Task id: 121 : assigned to the staff_id: 5'),('2018-04-16 20:53:01: Staff Account ID: 5: Logged Out'),('2018-04-16 20:55:37: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 20:55:44: Opened customer account : 1'),('2018-04-16 20:56:29: New task added: customer id: 1 task : Bag up Job-id: 20180416205629'),('2018-04-16 20:56:29: New task added: customer id: 1 task : Mount Transparencies Job-id: 20180416205629'),('2018-04-16 20:56:29: New task added: customer id: 1 task : Use of large copy camera Job-id: 20180416205629'),('2018-04-16 20:56:29: Opened customer account : 1'),('2018-04-16 20:56:53: Staff Account ID: 1: Logged Out'),('2018-04-16 21:05:04: Account access attempt: Staff Account ID: 6: Authentication status: Successful'),('Job-Task id: 124 : assigned to the staff_id: 6'),('2018-04-16 21:05:09: Job-Task: 124: status updated: Finished: by Staff id: 6'),('2018-04-16 21:05:14: Staff Account ID: 6: Logged Out'),('2018-04-16 21:05:26: Account access attempt: Staff Account ID: 6: Authentication status: Successful'),('2018-04-16 21:07:16: Staff Account ID: 6: Logged Out'),('2018-04-16 21:07:32: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-17 01:44:45: Staff Account ID: 5: Logged Out'),('2018-04-17 01:53:40: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-17 01:54:38: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-17 01:54:43: Opened customer account : 2'),('2018-04-17 01:54:44: Opened customer account : 2'),('2018-04-17 01:54:44: Opened customer account : 3'),('2018-04-17 01:54:45: Opened customer account : 1'),('2018-04-17 01:54:46: Opened customer account : 2'),('2018-04-17 01:54:47: Opened customer account : 3'),('2018-04-17 01:54:47: Opened customer account : 3'),('2018-04-17 01:54:51: Opened customer account : 6'),('2018-04-17 02:36:05: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-17 02:36:11: Opened customer account : 2'),('2018-04-17 02:36:12: Opened customer account : 2'),('2018-04-17 02:36:12: Opened customer account : 4'),('2018-04-17 02:36:13: Opened customer account : 3'),('2018-04-17 02:37:40: Account access attempt: Staff Account ID: 4: Authentication status: Failed'),('2018-04-17 02:37:46: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-17 02:37:52: Opened customer account : 6'),('2018-04-17 02:38:34: New task added: customer id: 6 task : Black and white film processing Job-id: 20180417023834'),('2018-04-17 02:38:34: New task added: customer id: 6 task : Colour Transparency processing Job-id: 20180417023834'),('2018-04-17 02:38:34: Opened customer account : 6'),('2018-04-17 02:39:00: Opened customer account : 6'),('2018-04-17 02:39:17: Payment Completed for job-task id: 119'),('2018-04-17 02:39:17: Payment Completed for job-task id: 121'),('2018-04-17 02:39:17: Payment Completed for job-task id: 126'),('2018-04-17 02:39:39: Opened customer account : 4'),('2018-04-17 02:40:31: New customer account creation successful: customer Last Name: ccx customer email: dscsc@ssd'),('2018-04-17 02:40:31: Opened customer account : 8'),('2018-04-17 02:40:47: Opened customer account : 8'),('2018-04-17 02:40:52: Staff Account ID: 4: Logged Out'),('2018-04-17 02:40:58: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 02:41:03: Opened customer account : 8'),('2018-04-17 02:41:21: New task added: customer id: 8 task : Colour Transparency processing Job-id: 20180417024121'),('2018-04-17 02:41:22: New task added: customer id: 8 task : Colour film processing Job-id: 20180417024121'),('2018-04-17 02:41:22: Payment Completed for job-task id: 127'),('2018-04-17 02:41:22: Payment Completed for job-task id: 128'),('2018-04-17 02:41:56: Staff Account ID: 1: Logged Out'),('2018-04-17 02:42:06: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 02:42:47: Opened customer account : 8'),('2018-04-17 02:42:54: Customer account: 8 Deactivated'),('2018-04-17 02:42:54: Opened customer account : 8'),('2018-04-17 02:42:56: Customer account: 8 Activated'),('2018-04-17 02:42:56: Opened customer account : 8'),('2018-04-17 02:42:57: Customer account: 8 Deactivated'),('2018-04-17 02:42:57: Opened customer account : 8'),('2018-04-17 02:42:59: Customer account: 8 Activated'),('2018-04-17 02:42:59: Opened customer account : 8'),('2018-04-17 02:43:10: Customer account: 8 profile update successfull'),('2018-04-17 02:43:10: Opened customer account : 8'),('2018-04-17 02:43:28: Customer account: 8 profile update successfull'),('2018-04-17 02:43:29: Opened customer account : 8'),('2018-04-17 02:43:37 :Customer account 8 deleted'),('2018-04-17 02:44:07: Staff Account ID: 1: Logged Out'),('2018-04-17 02:44:13: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 02:45:16: Staff Account ID: 1: Logged Out'),('2018-04-17 03:57:27: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-17 04:01:05: Staff Account ID: 2: Logged Out'),('2018-04-17 17:26:15: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 17:30:58: Opened customer account : 4'),('2018-04-17 17:31:02: Opened customer account : 2'),('2018-04-17 17:31:11: New task added: customer id: 2 task : Use of large copy camera Job-id: 20180417173110'),('2018-04-17 17:31:11: Opened customer account : 2'),('2018-04-17 17:31:19: Payment Completed for job-task id: 129'),('2018-04-17 17:33:04: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 17:34:41: Staff Account ID: 1: Logged Out'),('2018-04-17 18:01:35: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 18:01:53: Staff Account ID: 1: Logged Out'),('2018-04-17 18:02:00: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 18:02:15: Staff Account ID: 1: Logged Out'),('2018-04-17 18:20:51: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 18:20:59: Opened customer account : 6'),('2018-04-17 18:21:05: Payment Completed for job-task id: 120'),('2018-04-17 18:21:05: Payment Completed for job-task id: 125'),('2018-04-17 18:45:23: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 18:46:28: Opened customer account : 1'),('2018-04-17 18:47:11: New task added: customer id: 1 task : Colour Transparency processing Job-id: 20180417184711'),('2018-04-17 18:47:11: New task added: customer id: 1 task : Image Processing Job-id: 20180417184711'),('2018-04-17 18:47:11: Opened customer account : 1'),('2018-04-17 18:48:58: New card added: customer id: 1 card number : 7826423745287352'),('2018-04-17 18:49:17: Staff Account ID: 1: Logged Out'),('2018-04-17 19:27:23: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 19:27:42: Staff Account ID: 1: Logged Out'),('2018-04-17 19:27:55: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 19:28:05: Staff Account ID: 1: Logged Out'),('2018-04-17 19:28:29: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 19:28:51: Data backup successfull'),('2018-04-17 19:28:59: Staff Account ID: 1: Logged Out'),('2018-04-17 19:33:57: Account access attempt: Staff Account ID: 1: Authentication status: Failed'),('2018-04-17 19:34:03: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 19:34:17: Opened customer account : 2'),('2018-04-17 19:34:34: Opened customer account : 2'),('2018-04-17 19:36:28: New task added: customer id: 2 task : Bag up Job-id: 20180417193628'),('2018-04-17 19:36:28: New task added: customer id: 2 task : Use of small copy camera Job-id: 20180417193628'),('2018-04-17 19:36:28: New task added: customer id: 2 task : Image Processing Job-id: 20180417193628'),('2018-04-17 19:36:29: New task added: customer id: 2 task : Colour film processing Job-id: 20180417193628'),('2018-04-17 19:36:29: Opened customer account : 2'),('2018-04-17 19:41:21: Staff Account ID: 1: Logged Out'),('2018-04-17 22:34:01: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 22:34:06: Opened customer account : 3'),('2018-04-17 22:34:31: New task added: customer id: 3 task : Colour film processing Job-id: 20180417223431'),('2018-04-17 22:34:31: New task added: customer id: 3 task : Use of small copy camera Job-id: 20180417223431'),('2018-04-17 22:34:31: New task added: customer id: 3 task : Bag up Job-id: 20180417223431'),('2018-04-17 22:34:31: New task added: customer id: 3 task : Mount Transparencies Job-id: 20180417223431'),('2018-04-17 22:34:31: Opened customer account : 3'),('2018-04-17 22:36:04: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 22:36:10: Opened customer account : 4'),('2018-04-17 22:36:30: New task added: customer id: 4 task : Colour film processing Job-id: 20180417223630'),('2018-04-17 22:36:30: New task added: customer id: 4 task : Mount Transparencies Job-id: 20180417223630'),('2018-04-17 22:36:30: New task added: customer id: 4 task : Pixcel Enhancement Job-id: 20180417223630'),('2018-04-17 22:36:30: Opened customer account : 4'),('2018-04-17 22:38:00: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 22:38:05: Opened customer account : 6'),('2018-04-17 22:38:08: Opened customer account : 6'),('2018-04-17 22:38:12: Opened customer account : 1'),('2018-04-17 22:38:32: New task added: customer id: 1 task : Use of small copy camera Job-id: 20180417223832'),('2018-04-17 22:38:32: New task added: customer id: 1 task : Use of small copy camera Job-id: 20180417223832'),('2018-04-17 22:38:32: New task added: customer id: 1 task : Mount Transparencies Job-id: 20180417223832'),('2018-04-17 22:38:33: Opened customer account : 1'),('2018-04-17 22:39:55: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 22:40:03: Opened customer account : 1'),('2018-04-17 22:40:20: New task added: customer id: 1 task : Colour film processing Job-id: 20180417224020'),('2018-04-17 22:40:20: New task added: customer id: 1 task : Colour film processing Job-id: 20180417224020'),('2018-04-17 22:40:20: New task added: customer id: 1 task : Bag up Job-id: 20180417224020'),('2018-04-17 22:40:21: Opened customer account : 1'),('2018-04-17 22:42:06: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 22:42:10: Opened customer account : 4'),('2018-04-17 22:42:27: New task added: customer id: 4 task : Use of large copy camera Job-id: 20180417224227'),('2018-04-17 22:42:27: New task added: customer id: 4 task : Black and white film processing Job-id: 20180417224227'),('2018-04-17 22:42:27: New task added: customer id: 4 task : Mount Transparencies Job-id: 20180417224227'),('2018-04-17 22:42:31: Opened customer account : 4'),('2018-04-17 22:52:44: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-17 22:52:49: Opened customer account : 3'),('2018-04-17 22:53:15: New task added: customer id: 3 task : Use of small copy camera Job-id: 20180417225315'),('2018-04-17 22:53:15: New task added: customer id: 3 task : Image Processing Job-id: 20180417225315'),('2018-04-17 22:53:15: New task added: customer id: 3 task : Mount Transparencies Job-id: 20180417225315'),('2018-04-17 22:53:15: New task added: customer id: 3 task : Bag up Job-id: 20180417225315'),('2018-04-17 22:53:17: Opened customer account : 3'),('2018-04-18 01:34:06: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 01:34:11: Opened customer account : 4'),('2018-04-18 01:34:27: New task added: customer id: 4 task : Use of large copy camera Job-id: 20180418013427'),('2018-04-18 01:34:27: New task added: customer id: 4 task : Black and white film processing Job-id: 20180418013427'),('2018-04-18 01:34:27: New task added: customer id: 4 task : Image Processing Job-id: 20180418013427'),('2018-04-18 01:34:32: Opened customer account : 4'),('2018-04-18 02:27:00: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 02:27:05: Opened customer account : 6'),('2018-04-18 02:27:09: Opened customer account : 3'),('2018-04-18 02:27:39: New task added: customer id: 3 task : Bag up Job-id: 20180418022739'),('2018-04-18 02:27:39: New task added: customer id: 3 task : Image Processing Job-id: 20180418022739'),('2018-04-18 02:27:39: New task added: customer id: 3 task : Bag up Job-id: 20180418022739'),('2018-04-18 02:27:39: New task added: customer id: 3 task : Pixcel Enhancement Job-id: 20180418022739'),('2018-04-18 02:27:39: New task added: customer id: 3 task : Colour film processing Job-id: 20180418022739'),('2018-04-18 02:27:40: Opened customer account : 3'),('2018-04-18 09:10:12: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 09:10:15: Opened customer account : 4'),('2018-04-18 09:10:51: New task added: customer id: 4 task : Colour film processing Job-id: 20180418091051'),('2018-04-18 09:10:51: New task added: customer id: 4 task : Image Processing Job-id: 20180418091051'),('2018-04-18 09:10:51: New task added: customer id: 4 task : Bag up Job-id: 20180418091051'),('2018-04-18 09:10:51: New task added: customer id: 4 task : Colour film processing Job-id: 20180418091051'),('2018-04-18 09:10:52: Opened customer account : 4'),('2018-04-18 09:42:38: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 09:42:43: Opened customer account : 3'),('2018-04-18 09:42:55: New task added: customer id: 3 task : Use of large copy camera Job-id: 20180418094255'),('2018-04-18 09:42:55: New task added: customer id: 3 task : Mount Transparencies Job-id: 20180418094255'),('2018-04-18 09:42:55: New task added: customer id: 3 task : Bag up Job-id: 20180418094255'),('2018-04-18 09:42:56: Opened customer account : 3'),('2018-04-18 09:43:16: Staff Account ID: 1: Logged Out'),('2018-04-18 13:48:37: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 13:48:41: Opened customer account : 2'),('2018-04-18 13:49:15: New task added: customer id: 2 task : Colour film processing Job-id: 20180418134915'),('2018-04-18 13:49:15: New task added: customer id: 2 task : Colour film processing Job-id: 20180418134915'),('2018-04-18 13:49:16: New task added: customer id: 2 task : Pixcel Enhancement Job-id: 20180418134915'),('2018-04-18 13:49:16: New task added: customer id: 2 task : Use of small copy camera Job-id: 20180418134915'),('2018-04-18 13:49:16: New task added: customer id: 2 task : Bag up Job-id: 20180418134915'),('2018-04-18 13:49:17: Opened customer account : 2'),('2018-04-18 13:50:02: Staff Account ID: 1: Logged Out'),('2018-04-18 14:12:25: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 14:12:27: Staff Account ID: 1: Logged Out'),('2018-04-18 14:12:35: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('Job-Task id: 119 : assigned to the staff_id: 5'),('2018-04-18 14:12:44: Job-Task: 119: status updated: Finished: by Staff id: 5'),('Job-Task id: 120 : assigned to the staff_id: 5'),('2018-04-18 14:12:50: Job-Task: 120: status updated: Finished: by Staff id: 5'),('Job-Task id: 121 : assigned to the staff_id: 5'),('2018-04-18 14:12:55: Job-Task: 121: status updated: Finished: by Staff id: 5'),('Job-Task id: 126 : assigned to the staff_id: 5'),('2018-04-18 14:12:59: Job-Task: 126: status updated: Finished: by Staff id: 5'),('Job-Task id: 125 : assigned to the staff_id: 5'),('2018-04-18 14:13:04: Staff Account ID: 5: Logged Out'),('2018-04-18 14:13:49: Account access attempt: Staff Account ID: 6: Authentication status: Failed'),('2018-04-18 14:13:49: Account access attempt: Staff Account ID: 6: Authentication status: Failed'),('2018-04-18 14:13:52: Account access attempt: Staff Account ID: 6: Authentication status: Failed'),('2018-04-18 14:13:55: Account access attempt: Staff Account ID: 9: Authentication status: Successful'),('Job-Task id: 134 : assigned to the staff_id: 9'),('2018-04-18 14:14:00: Job-Task: 134: status updated: Finished: by Staff id: 9'),('Job-Task id: 130 : assigned to the staff_id: 9'),('2018-04-18 14:14:05: Job-Task: 130: status updated: Finished: by Staff id: 9'),('Job-Task id: 146 : assigned to the staff_id: 9'),('2018-04-18 14:14:10: Job-Task: 146: status updated: Finished: by Staff id: 9'),('Job-Task id: 147 : assigned to the staff_id: 9'),('2018-04-18 14:17:02: Job-Task: 147: status updated: Finished: by Staff id: 9'),('Job-Task id: 131 : assigned to the staff_id: 9'),('2018-04-18 14:17:05: Staff Account ID: 9: Logged Out'),('2018-04-18 14:17:23: Account access attempt: Staff Account ID: 7: Authentication status: Successful'),('Job-Task id: 122 : assigned to the staff_id: 7'),('2018-04-18 14:17:27: Job-Task: 122: status updated: Finished: by Staff id: 7'),('Job-Task id: 132 : assigned to the staff_id: 7'),('2018-04-18 14:17:31: Job-Task: 132: status updated: Finished: by Staff id: 7'),('Job-Task id: 155 : assigned to the staff_id: 7'),('2018-04-18 14:17:49: Job-Task: 155: status updated: Finished: by Staff id: 7'),('Job-Task id: 138 : assigned to the staff_id: 7'),('2018-04-18 14:17:53: Job-Task: 138: status updated: Finished: by Staff id: 7'),('Job-Task id: 159 : assigned to the staff_id: 7'),('2018-04-18 14:17:58: Job-Task: 159: status updated: Finished: by Staff id: 7'),('Job-Task id: 161 : assigned to the staff_id: 7'),('2018-04-18 14:18:11: Staff Account ID: 7: Logged Out'),('2018-04-18 14:18:16: Account access attempt: Staff Account ID: 6: Authentication status: Successful'),('Job-Task id: 124 : assigned to the staff_id: 6'),('2018-04-18 14:18:20: Job-Task: 124: status updated: Finished: by Staff id: 6'),('Job-Task id: 133 : assigned to the staff_id: 6'),('2018-04-18 14:18:23: Job-Task: 133: status updated: Finished: by Staff id: 6'),('Job-Task id: 143 : assigned to the staff_id: 6'),('2018-04-18 14:18:29: Job-Task: 143: status updated: Finished: by Staff id: 6'),('Job-Task id: 144 : assigned to the staff_id: 6'),('2018-04-18 14:18:35: Job-Task: 144: status updated: Finished: by Staff id: 6'),('Job-Task id: 162 : assigned to the staff_id: 6'),('2018-04-18 14:18:39: Job-Task: 162: status updated: Finished: by Staff id: 6'),('Job-Task id: 129 : assigned to the staff_id: 6'),('2018-04-18 14:18:41: Staff Account ID: 6: Logged Out'),('2018-04-18 14:18:54: Account access attempt: Staff Account ID: 8: Authentication status: Successful'),('Job-Task id: 123 : assigned to the staff_id: 8'),('2018-04-18 14:18:59: Job-Task: 123: status updated: Finished: by Staff id: 8'),('Job-Task id: 141 : assigned to the staff_id: 8'),('2018-04-18 14:19:03: Job-Task: 141: status updated: Finished: by Staff id: 8'),('Job-Task id: 151 : assigned to the staff_id: 8'),('2018-04-18 14:19:08: Job-Task: 151: status updated: Finished: by Staff id: 8'),('Job-Task id: 139 : assigned to the staff_id: 8'),('2018-04-18 14:19:12: Job-Task: 139: status updated: Finished: by Staff id: 8'),('Job-Task id: 145 : assigned to the staff_id: 8'),('2018-04-18 14:19:15: Job-Task: 145: status updated: Finished: by Staff id: 8'),('Job-Task id: 154 : assigned to the staff_id: 8'),('2018-04-18 14:19:18: Staff Account ID: 8: Logged Out'),('2018-04-18 19:46:56: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 19:48:09: Staff Account ID: 1: Logged Out'),('2018-04-18 19:52:44: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 19:54:13: Staff Account ID: 1: Logged Out'),('2018-04-18 20:09:29: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-18 20:09:32: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-18 20:09:33: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-18 20:11:38: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-18 20:12:27: Staff Account ID: 2: Logged Out'),('2018-04-18 20:14:32: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:34:19: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:36:01: Staff Account ID: 1: Logged Out'),('2018-04-18 20:38:56: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:39:16: Staff Account ID: 1: Logged Out'),('2018-04-18 20:39:51: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:39:54: Staff Account ID: 1: Logged Out'),('2018-04-18 20:40:32: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:40:37: Staff Account ID: 1: Logged Out'),('2018-04-18 20:41:21: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:41:32: Staff Account ID: 1: Logged Out'),('2018-04-18 20:48:41: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:48:53: Staff Account ID: 1: Logged Out'),('2018-04-18 20:50:35: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:51:00: Staff Account ID: 1: Logged Out'),('2018-04-18 20:51:56: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:52:17: Staff Account ID: 1: Logged Out'),('2018-04-18 20:53:29: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:53:53: Staff Account ID: 1: Logged Out'),('2018-04-18 20:54:57: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:55:03: Staff Account ID: 1: Logged Out'),('2018-04-18 20:55:25: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 20:56:03: Staff Account ID: 1: Logged Out'),('2018-04-18 23:12:20: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-18 23:12:57: Staff Account ID: 1: Logged Out'),('2018-04-19 01:13:54: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 01:14:00: Opened customer account : 2'),('2018-04-19 01:14:07: Opened customer account : 4'),('2018-04-19 01:14:11: Opened customer account : 6'),('2018-04-19 01:14:15: Opened customer account : 3'),('2018-04-19 01:14:20: Opened customer account : 6'),('2018-04-19 01:15:01: New task added: customer id: 6 task : Use of large copy camera Job-id: 20180419011501'),('2018-04-19 01:15:01: New task added: customer id: 6 task : Use of large copy camera Job-id: 20180419011501'),('2018-04-19 01:15:02: Opened customer account : 6'),('2018-04-19 01:16:32: Staff Account ID: 1: Logged Out'),('2018-04-19 01:17:06: Account access attempt: Staff Account ID: 6: Authentication status: Successful'),('2018-04-19 01:17:12: Job-Task: 129: status updated: Finished: by Staff id: 6'),('Job-Task id: 137 : assigned to the staff_id: 6'),('2018-04-19 01:17:19: Job-Task: 137: status updated: Finished: by Staff id: 6'),('Job-Task id: 142 : assigned to the staff_id: 6'),('2018-04-19 01:17:26: Job-Task: 142: status updated: Finished: by Staff id: 6'),('Job-Task id: 149 : assigned to the staff_id: 6'),('2018-04-19 01:17:31: Job-Task: 149: status updated: Finished: by Staff id: 6'),('Job-Task id: 152 : assigned to the staff_id: 6'),('2018-04-19 01:17:35: Job-Task: 152: status updated: Finished: by Staff id: 6'),('Job-Task id: 156 : assigned to the staff_id: 6'),('2018-04-19 01:17:42: Job-Task: 156: status updated: Finished: by Staff id: 6'),('Job-Task id: 177 : assigned to the staff_id: 6'),('2018-04-19 01:17:47: Job-Task: 177: status updated: Finished: by Staff id: 6'),('Job-Task id: 168 : assigned to the staff_id: 6'),('2018-04-19 01:17:50: Staff Account ID: 6: Logged Out'),('2018-04-19 01:19:05: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 01:19:15: Opened customer account : 4'),('2018-04-19 01:20:10: Opened customer account : 1'),('2018-04-19 01:20:16: Opened customer account : 2'),('2018-04-19 01:20:22: Opened customer account : 3'),('2018-04-19 01:20:28: Opened customer account : 6'),('2018-04-19 02:26:39: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 02:26:44: Opened customer account : 4'),('2018-04-19 03:14:40: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 03:14:44: Opened customer account : 6'),('2018-04-19 03:16:14: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 03:16:19: Opened customer account : 6'),('2018-04-19 03:18:23: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 03:18:27: Opened customer account : 6'),('2018-04-19 03:20:50: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 03:20:54: Opened customer account : 4'),('2018-04-19 03:21:34: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 03:21:39: Opened customer account : 6'),('2018-04-19 03:21:55: Staff Account ID: 1: Logged Out'),('2018-04-19 03:38:42: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-19 03:38:48: Opened customer account : 6'),('2018-04-19 03:39:45: Staff Account ID: 2: Logged Out'),('2018-04-19 05:17:22: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 05:19:04: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 05:20:14: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 05:21:15: Opened customer account : 4'),('2018-04-19 05:21:17: Customer account: 4 Deactivated'),('2018-04-19 05:21:17: Opened customer account : 4'),('2018-04-19 05:21:18: Customer account: 4 Activated'),('2018-04-19 05:21:18: Opened customer account : 4'),('2018-04-19 05:21:48: Opened customer account : 6'),('2018-04-19 05:23:45: Staff Account ID: 1: Logged Out'),('2018-04-19 06:20:38: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('Job-Task id: 119 : assigned to the staff_id: 5'),('2018-04-19 06:20:59: Job-Task: 119: status updated: On-Hold: by Staff id: 5'),('Job-Task id: 120 : assigned to the staff_id: 5'),('2018-04-19 06:21:02: Staff Account ID: 5: Logged Out'),('2018-04-19 06:21:09: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 06:21:53: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 06:22:20: Staff Account ID: 1: Logged Out'),('2018-04-19 06:22:58: Account access attempt: Staff Account ID: s: Authentication status: Failed'),('2018-04-19 06:23:02: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 06:23:41: Job-Task: 119: status updated: Pending: by Staff id: null'),('2018-04-19 06:24:04: Staff Account ID: 1: Logged Out'),('2018-04-19 06:24:14: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-19 06:24:20: Job-Task: 120: status updated: Finished: by Staff id: 5'),('Job-Task id: 119 : assigned to the staff_id: 5'),('2018-04-19 06:24:26: Job-Task: 119: status updated: Finished: by Staff id: 5'),('Job-Task id: 121 : assigned to the staff_id: 5'),('2018-04-19 06:24:31: Job-Task: 121: status updated: Finished: by Staff id: 5'),('Job-Task id: 126 : assigned to the staff_id: 5'),('2018-04-19 06:28:16: Account access attempt: Staff Account ID: 5: Authentication status: Failed'),('2018-04-19 06:28:22: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-19 06:28:30: Job-Task: 126: status updated: On-Hold: by Staff id: 5'),('Job-Task id: 125 : assigned to the staff_id: 5'),('2018-04-19 06:28:48: Staff Account ID: 5: Logged Out'),('2018-04-19 06:29:03: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 06:29:24: Job-Task: 126: status updated: Pending: by Staff id: null'),('2018-04-19 06:29:49: Staff Account ID: 1: Logged Out'),('2018-04-19 06:30:02: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-19 06:30:08: Job-Task: 125: status updated: Finished: by Staff id: 5'),('Job-Task id: 126 : assigned to the staff_id: 5'),('2018-04-19 06:31:24: Staff Account ID: 5: Logged Out'),('2018-04-19 06:34:26: Account access attempt: Staff Account ID: 1: Authentication status: Failed'),('2018-04-19 06:34:31: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-19 06:36:05: Account access attempt: Staff Account ID: 1: Authentication status: Successful');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `access` enum('O','S','OS') NOT NULL DEFAULT 'OS',
  `code` enum('R','G') NOT NULL DEFAULT 'G',
  `message` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES ('OS','R','2018-04-19 06:20:39: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:21:09: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:21:53: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:23:02: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:24:15: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:28:22: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:29:03: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:30:02: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:34:32: 1 due payment left: Please check due list'),('OS','R','2018-04-19 06:36:05: 1 due payment left: Please check due list');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receipt` (
  `receipt_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Card','Cash') NOT NULL DEFAULT 'Cash',
  `card_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `prime_id` int(11) NOT NULL,
  `card_number` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`receipt_id`),
  UNIQUE KEY `reciept_id_uindex` (`receipt_id`),
  KEY `reciept_card_id_fk` (`card_id`),
  KEY `receipt_job_prime_id_fk` (`prime_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (30,'Cash',NULL,'2018-04-17',119,NULL),(31,'Cash',NULL,'2018-04-17',121,NULL),(32,'Cash',NULL,'2018-04-17',126,NULL),(33,'Cash',NULL,'2018-04-17',127,NULL),(34,'Cash',NULL,'2018-04-17',128,NULL),(35,'Cash',NULL,'2018-04-17',129,NULL),(36,'Cash',NULL,'2018-04-17',120,NULL),(37,'Cash',NULL,'2018-04-17',125,NULL);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_account`
--

DROP TABLE IF EXISTS `staff_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_account` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `address_1` varchar(30) NOT NULL,
  `address_2` varchar(30) DEFAULT NULL,
  `town_city` varchar(20) NOT NULL,
  `county` varchar(50) DEFAULT 'United Kingdom',
  `postcode` char(9) NOT NULL,
  `country` varchar(30) NOT NULL,
  `role` enum('Office Manager','Shift Manager','Receptionist','Technician') NOT NULL,
  `department` enum('Development Area','Copy Room','Packing Department','Finishing Room') DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT 'Qwerty',
  `contact_no` bigint(11) unsigned zerofill NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_account_email_uindex` (`email`),
  UNIQUE KEY `staff_account_contact_no_uindex` (`contact_no`),
  UNIQUE KEY `staff_account_staff_id_uindex` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_account`
--

LOCK TABLES `staff_account` WRITE;
/*!40000 ALTER TABLE `staff_account` DISABLE KEYS */;
INSERT INTO `staff_account` VALUES (1,'John','Oliver','33 Marlborough Rd','West Ford St','Ruislip','Leeds','HA4 7SS','United Kingdom','Office Manager',NULL,'john.oliver@bapers.com','JOQwerty',01895157242),(2,'Ricky','Gervais','143D Queens Dr',NULL,'Bedford','Bournemouth','BH4 8DF','United Kingdom','Shift Manager',NULL,'ricky.gervais@bapers.com','RGQwerty',01202363715),(3,'Jon','Stewart','2A Filmer Rd','Alfriston','London','London','ML5 1HF','United Kingdom','Shift Manager',NULL,'jon.stewart@bapers.co.uk','JSQwerty',01236735421),(4,'Stephen','Colbert','3 Firestation Corner','Finsberry ','Norwich','Bournemouth','SW6 7BT','United States','Receptionist',NULL,'stephen.colbert@bapers.com','SCQwerty',02013877213),(5,'Karl','Pilkington','18 Chapel Ct','East Morden','Wembly','London','NR6 5NU','United Kingdom','Technician','Development Area','karl.pilkington@bapers.com','KPQwerty',01929444345),(6,'Stephen','Merchant','5 Penk Dr N','West Cards','Tinkerr','Wareham','WS15 2XY','United Kingdom','Technician','Copy Room','stephen.merchant@bapers.com','SMQwerty',01889671843),(7,'Perl','Winston','24 Clandon Road','Clandon Gardens','London','Greater London','N4 4CD','United States','Technician','Packing Department','perl.winston@outlook.com','PWQwerty',01889671345),(8,'Jo','Peterson','34 Golden Ln',NULL,'London','London','NW2 3SK','United Kingdom','Technician','Finishing Room','jo.peterson@bapers.com','Qwerty',01204938476),(9,'Richerd ','Faymen','King\'s Road','','London','','EC 1 3HS','United Kingdom','Technician','Development Area','Richerd.Faymen@gmail.com','Qwerty',09837261536);
/*!40000 ALTER TABLE `staff_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `Department` varchar(255) NOT NULL,
  `Shelf slot` varchar(8) NOT NULL,
  `price` float NOT NULL,
  `duration` time NOT NULL,
  `percentage` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `task_int_uindex` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Use of large copy camera','Copy Room','CR25',19,'02:00:00',2),(2,'Black and white film processing','Development area','DR12',49.5,'01:00:00',4),(3,'Bag up','Packing Department','PR10',6,'00:30:00',5),(4,'Colour film processing','Development Area','DR25',80,'01:30:00',4),(5,'Colour Transparency processing','Development Area','DR100',110.3,'03:00:00',1),(6,'Use of small copy camera','Copy Room','CR16',8.3,'01:15:00',5),(7,'Mount Transparencies','Finishing Room','FR5',55.5,'00:45:00',7),(8,'Image Processing','Development Area','SA08',120.5,'03:00:00',2),(9,'Pixcel Enhancement','Copy Room','PXL36',75.5,'01:15:00',1);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-19  6:36:14
