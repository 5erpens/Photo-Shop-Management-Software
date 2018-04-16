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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,'1234567890123456','Mr. Jen Marshel','2018-04-25','789',1),(2,'1234567890123457','Mr. Elton John','2022-08-01','777',5),(3,'7892567892673546','Mr. Elton John','2023-08-01','345',5),(4,'3234354545544545','Mr. Alphachino','2022-09-01','234',2),(5,'5768908765456789','Mr. Jen Marshel','2018-04-25','873',1);
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
INSERT INTO `customer_account` VALUES (1,'Organisation','City, University of London (City)',NULL,'Northampton Square','','London','London','EC1V 0HB','United Kingdom','Valued',02070408000,'David.Rhind@city.ac.uk','False','Fixed',3),(2,'Organisation','InfoPharma Ltd',NULL,'25 Bond Street','','London','London','WC1V 8LS','United Kingdom','Valued',02073218001,'Alex.Wright@infopharma.com','False','Flexible',0),(3,'Organisation','Hello Magazine',NULL,'12 Bond Street','','London','London','WC1V 8NS','United Kingdom','Valued',02034567808,'Sarah.Brocklehurst@hello.com','False','Flexible',0),(4,'Individual','Eva','Bauyer','1 Liverpool street','','London','London','EC2V 8NS','United Kingdom','Valued',02085558989,'eva.bauyer@gmail.com','False','Fixed',3),(5,'Individual','Elton','John','24 Bond Street',NULL,'London','London','WC1V 8LG','United Kingdom','Default',02085558984,'elton.john@eltonjhon.com','False','Null',0),(6,'Organisation','HarryCo-op',NULL,'Prince Street','King\'s Ln','London','Edgeware','N5 3HE','United Kingdom','Valued',07829347568,'admin@harry.coop.com','False','Variable',0);
/*!40000 ALTER TABLE `customer_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexible_discount`
--

DROP TABLE IF EXISTS `flexible_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flexible_discount` (
  `prime_id` int(11) NOT NULL,
  `discount_percentage` float NOT NULL,
  UNIQUE KEY `variable_discount_prime_id_uindex` (`prime_id`),
  CONSTRAINT `variable_discount_job_prime_id_fk` FOREIGN KEY (`prime_id`) REFERENCES `job` (`prime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexible_discount`
--

LOCK TABLES `flexible_discount` WRITE;
/*!40000 ALTER TABLE `flexible_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexible_discount` ENABLE KEYS */;
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
  `status` enum('Pending','In-Progress','Finished','On-Hold') NOT NULL DEFAULT 'Pending',
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
  KEY `job_task_task_id_fk_idx` (`task_id`),
  CONSTRAINT `job_customer_account_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer_account` (`customer_id`),
  CONSTRAINT `job_staff_account_staff_id_fk` FOREIGN KEY (`staff_id`) REFERENCES `staff_account` (`staff_id`),
  CONSTRAINT `job_task_task_id_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (102,'20180415233917',6,NULL,5,'2018-04-15 23:39:17','2018-04-16 23:39:07','Standard','Pending',NULL,NULL,'',NULL,1,109.197),(103,'20180415233917',6,5,5,'2018-04-15 23:39:17','2018-04-16 05:39:16','6 Hour','In-Progress','2018-04-16 00:04:55',NULL,'',NULL,1,163.796),(104,'20180416000214',1,9,2,'2018-04-16 00:02:14','2018-04-16 06:02:00','6 Hour','In-Progress','2018-04-16 00:08:58',NULL,'',NULL,1,73.5075),(105,'20180416000214',1,NULL,5,'2018-04-16 00:02:14','2018-04-17 00:02:05','Standard','Pending',NULL,NULL,'',NULL,1,109.197),(106,'20180416000214',1,7,3,'2018-04-16 00:02:14','2018-04-17 00:02:09','Standard','In-Progress','2018-04-16 00:19:56',NULL,'',NULL,1,5.94),(107,'20180416000307',1,NULL,8,'2018-04-16 00:03:07','2018-04-17 00:03:05','Standard','Pending',NULL,NULL,'',NULL,3,116.885),(108,'20180416002155',6,6,9,'2018-04-16 00:21:55','2018-04-16 01:21:40','1 Hour','In-Progress','2018-04-16 00:23:51',NULL,'',NULL,1,186.863),(109,'20180416002155',6,NULL,1,'2018-04-16 00:21:55','2018-04-17 00:21:51','Standard','Pending',NULL,NULL,'',NULL,2,18.62),(110,'20180416002215',6,8,7,'2018-04-16 00:22:15','2018-04-16 06:22:14','6 Hour','In-Progress','2018-04-16 00:25:02',NULL,'',NULL,7,77.4225);
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
INSERT INTO `log` VALUES ('2018-04-15 23:33:48: Staff Account ID: 1: Logged Out'),('2018-04-15 23:38:46: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-15 23:38:52: Opened customer account : 2'),('2018-04-15 23:38:56: Opened customer account : 6'),('2018-04-15 23:39:17: New task added: customer id: 6 task : Colour Transparency processing Job-id: 20180415233917'),('2018-04-15 23:39:17: New task added: customer id: 6 task : Colour Transparency processing Job-id: 20180415233917'),('2018-04-15 23:39:17: Opened customer account : 6'),('2018-04-15 23:39:59: Staff Account ID: 1: Logged Out'),('2018-04-15 23:40:46: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-15 23:40:51: Opened customer account : 2'),('2018-04-15 23:40:57: Opened customer account : 6'),('2018-04-15 23:57:22: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-15 23:57:27: Opened customer account : 6'),('2018-04-15 23:59:09: Opened customer account : 5'),('2018-04-15 23:59:54: Opened customer account : 5'),('2018-04-16 00:01:51: Opened customer account : 1'),('2018-04-16 00:02:14: New task added: customer id: 1 task : Black and white film processing Job-id: 20180416000214'),('2018-04-16 00:02:14: New task added: customer id: 1 task : Colour Transparency processing Job-id: 20180416000214'),('2018-04-16 00:02:15: New task added: customer id: 1 task : Bag up Job-id: 20180416000214'),('2018-04-16 00:02:15: Opened customer account : 1'),('2018-04-16 00:02:56: Customer account: 1 profile update successfull'),('2018-04-16 00:02:56: Opened customer account : 1'),('2018-04-16 00:03:07: New task added: customer id: 1 task : Image Processing Job-id: 20180416000307'),('2018-04-16 00:03:07: Opened customer account : 1'),('2018-04-16 00:04:09: Opened customer account : 1'),('2018-04-16 00:04:33: Staff Account ID: 1: Logged Out'),('2018-04-16 00:04:55: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('Job-Task id: 103 : assigned to the staff_id: 5'),('2018-04-16 00:06:22: Staff Account ID: 5: Logged Out'),('2018-04-16 00:06:33: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-16 00:06:36: Staff Account ID: 5: Logged Out'),('2018-04-16 00:06:44: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 00:08:23: New staff account creation successful: Staff Last Name: Faymen Staff Role: Technician'),('2018-04-16 00:08:23: Opened staff account : 9'),('2018-04-16 00:08:49: Staff Account ID: 1: Logged Out'),('2018-04-16 00:08:58: Account access attempt: Staff Account ID: 9: Authentication status: Successful'),('Job-Task id: 104 : assigned to the staff_id: 9'),('2018-04-16 00:09:33: Staff Account ID: 9: Logged Out'),('2018-04-16 00:10:41: Account access attempt: Staff Account ID: 8: Authentication status: Successful'),('2018-04-16 00:10:53: Staff Account ID: 8: Logged Out'),('2018-04-16 00:11:21: Account access attempt: Staff Account ID: 7: Authentication status: Successful'),('2018-04-16 00:12:25: Staff Account ID: 7: Logged Out'),('2018-04-16 00:17:35: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 00:17:51: Staff Account ID: 1: Logged Out'),('2018-04-16 00:19:56: Account access attempt: Staff Account ID: 7: Authentication status: Successful'),('Job-Task id: 106 : assigned to the staff_id: 7'),('2018-04-16 00:20:47: Staff Account ID: 7: Logged Out'),('2018-04-16 00:21:08: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 00:21:18: Opened customer account : 6'),('2018-04-16 00:21:55: New task added: customer id: 6 task : Pixcel Enhancement Job-id: 20180416002155'),('2018-04-16 00:21:55: New task added: customer id: 6 task : Use of large copy camera Job-id: 20180416002155'),('2018-04-16 00:21:56: Opened customer account : 6'),('2018-04-16 00:22:15: New task added: customer id: 6 task : Mount Transparencies Job-id: 20180416002215'),('2018-04-16 00:22:15: Opened customer account : 6'),('2018-04-16 00:22:45: Staff Account ID: 1: Logged Out'),('2018-04-16 00:23:37: Account access attempt: Staff Account ID: 5: Authentication status: Failed'),('2018-04-16 00:23:46: Account access attempt: Staff Account ID: 5: Authentication status: Failed'),('2018-04-16 00:23:47: Account access attempt: Staff Account ID: 5: Authentication status: Failed'),('2018-04-16 00:23:51: Account access attempt: Staff Account ID: 6: Authentication status: Successful'),('Job-Task id: 108 : assigned to the staff_id: 6'),('2018-04-16 00:24:56: Staff Account ID: 6: Logged Out'),('2018-04-16 00:25:01: Account access attempt: Staff Account ID: 8: Authentication status: Successful'),('Job-Task id: 110 : assigned to the staff_id: 8'),('2018-04-16 00:25:42: Staff Account ID: 8: Logged Out'),('2018-04-16 00:33:47: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-16 00:34:15: Staff Account ID: 4: Logged Out'),('2018-04-16 00:37:24: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-16 00:37:52: Staff Account ID: 4: Logged Out'),('2018-04-16 00:38:22: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-16 00:38:49: Staff Account ID: 4: Logged Out'),('2018-04-16 00:46:48: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-16 00:48:32: Staff Account ID: 5: Logged Out'),('2018-04-16 00:48:42: Account access attempt: Staff Account ID: 4: Authentication status: Successful'),('2018-04-16 00:50:29: Staff Account ID: 4: Logged Out'),('2018-04-16 03:35:44: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:36:33: Staff Account ID: 1: Logged Out'),('2018-04-16 03:44:17: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:45:17: Staff Account ID: 1: Logged Out'),('2018-04-16 03:50:16: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:51:13: Staff Account ID: 1: Logged Out'),('2018-04-16 03:51:52: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:53:46: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:54:12: Staff Account ID: 1: Logged Out'),('2018-04-16 03:55:26: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:55:45: Staff Account ID: 1: Logged Out'),('2018-04-16 03:57:28: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 03:58:33: Staff Account ID: 1: Logged Out'),('2018-04-16 04:09:38: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 04:09:50: Staff Account ID: 1: Logged Out'),('2018-04-16 04:43:54: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 04:46:11: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 04:48:14: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 04:52:30: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 04:53:16: Staff Account ID: 1: Logged Out'),('2018-04-16 05:00:46: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:00:55: Opened staff account : 2'),('2018-04-16 05:01:40: Staff Account ID: 1: Logged Out'),('2018-04-16 05:05:16: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:07:09: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:07:39: New Task: asdasd : Added to task list'),('2018-04-16 05:12:45: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:18:53: Account access attempt: Staff Account ID: 1: Authentication status: Failed'),('2018-04-16 05:18:58: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:20:28: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:21:39: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-16 05:22:27: Staff Account ID: 1: Logged Out'),('2018-04-16 05:30:59: Account access attempt: Staff Account ID: 1: Authentication status: Successful');
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
INSERT INTO `notification` VALUES ('OS','G','2018-04-15 23:39:17: New Job added: customer id: 6 Job-id: 20180415233917'),('OS','G','2018-04-16 00:02:15: New Job added: customer id: 1 Job-id: 20180416000214'),('OS','G','2018-04-16 00:03:07: New Job added: customer id: 1 Job-id: 20180416000307'),('OS','G','2018-04-16 00:21:55: New Job added: customer id: 6 Job-id: 20180416002155'),('OS','G','2018-04-16 00:22:15: New Job added: customer id: 6 Job-id: 20180416002215');
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
  KEY `receipt_job_prime_id_fk` (`prime_id`),
  CONSTRAINT `receipt_job_prime_id_fk` FOREIGN KEY (`prime_id`) REFERENCES `job` (`prime_id`),
  CONSTRAINT `reciept_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `card` (`card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
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

-- Dump completed on 2018-04-16  5:31:07
