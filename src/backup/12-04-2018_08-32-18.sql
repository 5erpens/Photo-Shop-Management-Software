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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,'1234567890123456','Jen Marshel','2018-04-25','789',1),(2,'1234567890123457','Mr.Elton John','2022-08-01','777',5),(3,'7892567892673546','Mr. Elton John','2023-08-01','345',5),(4,'3234354545544545','Mr. Alphachino','2022-09-01','234',2);
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
INSERT INTO `customer_account` VALUES (1,'Organisation','City, University of London (City)',NULL,'Northampton Square',NULL,'London','London','EC1V 0HB','United Kingdom','Valued',02070408000,'David.Rhind@city.ac.uk','False'),(2,'Organisation','InfoPharma Ltd',NULL,'25 Bond Street',NULL,'London','London','WC1V 8LS','United Kingdom','Valued',02073218001,'Alex.Wright@infopharma.com','False'),(3,'Organisation','Hello Magazine',NULL,'12 Bond Street','','London','London','WC1V 8NS','United Kingdom','Valued',02034567808,'Sarah.Brocklehurst@hello.com','False'),(4,'Individual','Eva','Bauyer','1 Liverpool street','','London','London','EC2V 8NS','United Kingdom','Valued',02085558989,'eva.bauyer@gmail.com','False'),(5,'Individual','Elton','John','24 Bond Street',NULL,'London','London','WC1V 8LG','United Kingdom','Default',02085558984,'elton.john@eltonjhon.com','False');
/*!40000 ALTER TABLE `customer_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount` (
  `customer_id` int(11) NOT NULL,
  `type` enum('Fixed','Flexible','Variable') NOT NULL,
  `percentage` float DEFAULT NULL,
  UNIQUE KEY `Discount_id_uindex` (`customer_id`),
  CONSTRAINT `discount_customer_account_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer_account` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
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
  `deadline` date NOT NULL,
  `priority` enum('Standard','Urgent') NOT NULL DEFAULT 'Standard',
  `status` enum('Pending','In-Progress','Finished') NOT NULL DEFAULT 'Pending',
  `start_time` datetime DEFAULT NULL,
  `special_instruction` varchar(255) DEFAULT NULL,
  `staff_Assigned` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`prime_id`),
  UNIQUE KEY `job_prime_id_uindex` (`prime_id`),
  KEY `job_customer_account_customer_id_fk` (`customer_id`),
  KEY `job_staff_account_staff_id_fk` (`staff_id`),
  KEY `job_task_task_id_fk_idx` (`task_id`),
  CONSTRAINT `job_customer_account_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer_account` (`customer_id`),
  CONSTRAINT `job_staff_account_staff_id_fk` FOREIGN KEY (`staff_id`) REFERENCES `staff_account` (`staff_id`),
  CONSTRAINT `job_task_task_id_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (8,'20180408151803',3,NULL,1,'2018-04-08 15:18:03','2018-04-10','Standard','Pending',NULL,'Easter Egg',0),(9,'20180408151803',3,NULL,2,'2018-04-08 15:18:03','2018-04-08','Urgent','Pending',NULL,'',0),(10,'20180408151803',3,NULL,3,'2018-04-08 15:18:03','2018-04-11','Standard','Pending',NULL,'',0),(11,'20180408151949',4,NULL,7,'2018-04-08 15:19:49','2018-04-13','Urgent','Pending',NULL,'',0),(12,'20180408151949',4,NULL,6,'2018-04-08 15:19:50','2018-04-14','Standard','Pending',NULL,'',0),(13,'20180408151949',4,NULL,4,'2018-04-08 15:19:50','2018-04-20','Standard','Pending',NULL,'',0),(14,'20180408210959',3,NULL,7,'2018-04-08 21:09:59','2018-04-25','Urgent','Pending',NULL,'',0),(15,'20180408210959',3,NULL,6,'2018-04-08 21:09:59','2018-04-08','Standard','Pending',NULL,'',0),(16,'20180408212807',4,NULL,1,'2018-04-08 21:28:07','2018-04-08','Standard','Pending',NULL,'',0),(17,'20180408212807',4,NULL,7,'2018-04-08 21:28:07','2018-04-11','Urgent','Pending',NULL,'',0),(18,'20180408232712',2,NULL,5,'2018-04-08 23:27:12','2018-04-08','Urgent','Pending',NULL,'',0),(19,'20180408232712',2,NULL,3,'2018-04-08 23:27:12','2018-04-10','Standard','Pending',NULL,'',0),(20,'20180408232843',1,NULL,4,'2018-04-08 23:28:43','2018-04-08','Standard','Pending',NULL,'',0),(21,'20180408232843',1,NULL,4,'2018-04-08 23:28:43','2018-04-09','Urgent','Pending',NULL,'',0),(22,'20180408232930',1,NULL,6,'2018-04-08 23:29:30','2018-04-08','Urgent','Pending',NULL,'',0),(23,'20180408232930',1,NULL,7,'2018-04-08 23:29:30','2018-04-18','Standard','Pending',NULL,'',0),(24,'20180409022710',4,NULL,5,'2018-04-09 02:27:10','2018-04-09','Standard','Pending',NULL,'',0),(25,'20180409022710',4,NULL,2,'2018-04-09 02:27:10','2018-04-09','Standard','Pending',NULL,'',0),(26,'20180409022710',4,NULL,4,'2018-04-09 02:27:10','2018-04-11','Standard','Pending',NULL,'',0),(27,'20180409151949',4,NULL,4,'2018-04-09 15:19:49','2018-04-01','Urgent','Pending',NULL,'',0),(28,'20180409151949',4,NULL,4,'2018-04-09 15:19:49','2018-04-19','Standard','Pending',NULL,'',0),(29,'20180409215455',5,NULL,1,'2018-04-09 21:54:55','2018-04-09','Standard','Pending',NULL,'',0),(30,'20180409215455',5,NULL,1,'2018-04-09 21:54:55','2018-04-09','Standard','Pending',NULL,'',0),(35,'20180410004208',5,NULL,3,'2018-04-10 00:42:08','2018-04-10','Standard','Pending',NULL,'',0),(36,'20180410004208',5,NULL,4,'2018-04-10 00:42:08','2018-04-11','Standard','Pending',NULL,'',0),(37,'20180412062625',5,NULL,3,'2018-04-12 06:26:25','2018-04-12','Urgent','Pending',NULL,'',0),(38,'20180412062625',5,NULL,4,'2018-04-12 06:26:25','2018-04-13','Standard','Pending',NULL,'',0),(39,'20180412082810',5,NULL,1,'2018-04-12 08:28:10','2018-04-12','Standard','Pending',NULL,'',0),(40,'20180412082810',5,NULL,1,'2018-04-12 08:28:10','2018-04-12','Standard','Pending',NULL,'',0);
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
INSERT INTO `log` VALUES ('2018-04-12 06:19:06: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-12 06:25:09: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-12 06:25:43: Opened customer account : 5'),('2018-04-12 06:26:25: New task added: customer id: 5 task : Bag up'),('2018-04-12 06:26:25: New task added: customer id: 5 task : Colour film processing'),('2018-04-12 06:26:25: Payment Completed for job-task id: 37'),('38'),('2018-04-12 06:26:25: Payment Completed for job-task id: 38'),('2018-04-12 06:27:39: Account access attempt: Staff Account ID: 5: Authentication status: Failed'),('2018-04-12 06:27:44: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-12 06:27:46: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-12 06:31:21: Account access attempt: Staff Account ID: 5: Authentication status: Failed'),('2018-04-12 06:31:27: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-12 06:34:20: Account access attempt: Staff Account ID: 5: Authentication status: Successful'),('2018-04-12 06:34:45: Account access attempt: Staff Account ID: 2: Authentication status: Successful'),('2018-04-12 06:35:01: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-12 08:22:53: file: Data restoring successfull: Data restore successfull'),('2018-04-12 08:23:29: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-12 08:27:55: Account access attempt: Staff Account ID: 1: Authentication status: Successful'),('2018-04-12 08:28:02: Opened customer account : 5'),('2018-04-12 08:28:10: New task added: customer id: 5 task : Use of large copy camera'),('2018-04-12 08:28:10: New task added: customer id: 5 task : Use of large copy camera'),('2018-04-12 08:28:10: Payment Completed for job-task id: 39'),('40'),('2018-04-12 08:28:11: Payment Completed for job-task id: 40'),('2018-04-12 08:29:10: Opened customer account : 5'),('2018-04-12 08:32:13: Account access attempt: Staff Account ID: 1: Authentication status: Successful');
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
INSERT INTO `notification` VALUES ('OS','G','2018-04-12 08:28:10: New Job added: customer id: 5 Jobid: 20180412082810');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (1,'Cash',NULL,'2018-04-09',10,NULL),(2,'Card',1,'2018-04-09',22,'1234567890123456'),(3,'Card',2,'2018-04-09',29,'1234567890123457'),(4,'Card',2,'2018-04-09',30,'1234567890123457'),(5,'Card',3,'2018-04-10',35,'7892567892673546'),(6,'Card',3,'2018-04-10',36,'7892567892673546'),(7,'Card',4,'2018-04-10',18,'3234354545544545'),(8,'Cash',NULL,'2018-04-10',19,NULL),(9,'Card',2,'2018-04-12',37,'1234567890123457'),(10,'Cash',NULL,'2018-04-12',39,NULL);
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
  `department` enum('Development Area','Copy Room','Packing Room','Finishing Room') DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT 'Qwerty',
  `contact_no` bigint(11) unsigned zerofill NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_account_email_uindex` (`email`),
  UNIQUE KEY `staff_account_contact_no_uindex` (`contact_no`),
  UNIQUE KEY `staff_account_staff_id_uindex` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_account`
--

LOCK TABLES `staff_account` WRITE;
/*!40000 ALTER TABLE `staff_account` DISABLE KEYS */;
INSERT INTO `staff_account` VALUES (1,'John','Oliver','33 Marlborough Rd','West Ford St','Ruislip','Leeds','HA4 7SS','United Kingdom','Office Manager',NULL,'john.oliver@bapers.com','JOQwerty',01895157242),(2,'Ricky','Gervais','143D Queens Dr',NULL,'Bedford','Bournemouth','BH4 8DF','United Kingdom','Shift Manager',NULL,'ricky.gervais@bapers.com','RGQwerty',01202363715),(3,'Jon','Stewart','2A Filmer Rd','Alfriston','London','London','ML5 1HF','United Kingdom','Shift Manager',NULL,'jon.stewart@bapers.co.uk','JSQwerty',01236735421),(4,'Stephen','Colbert','3 Firestation Corner','Finsberry ','Norwich','Bournemouth','SW6 7BT','United States','Receptionist',NULL,'stephen.colbert@bapers.com','SCQwerty',02013877213),(5,'Karl','Pilkington','18 Chapel Ct','East Morden','Wembly','London','NR6 5NU','United Kingdom','Technician','Development Area','karl.pilkington@bapers.com','KPQwerty',01929444345),(6,'Stephen','Merchant','5 Penk Dr N','West Cards','Tinkerr','Wareham','WS15 2XY','United Kingdom','Technician','Copy Room','stephen.merchant@bapers.com','SMQwerty',01889671843),(7,'Perl','Winston','24 Clandon Road','Clandon Gardens','London','Greater London','N4 4CD','United States','Technician','Packing Room','perl.winston@outlook.com','PWQwerty',01889671345),(8,'Jo','Peterson','34 Golden Ln',NULL,'London','London','NW2 3SK','United Kingdom','Technician','Finishing Room','jo.peterson@bapers.com','Qwerty',01204938476);
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
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `task_int_uindex` (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Use of large copy camera','Copy Room','CR25',19,'02:00:00'),(2,'Black and white film processing','Development area','DR12',49.5,'01:00:00'),(3,'Bag up','Packing Departments','PR10',6,'00:30:00'),(4,'Colour film processing','Development Area','DR25',80,'01:30:00'),(5,'Colour Transparency processing','Development Area','DR100',110.3,'03:00:00'),(6,'Use of small copy camera','Copy Room','CR16',8.3,'01:15:00'),(7,'Mount Transparencies','Finishing Room','FR5',55.5,'00:45:00');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable_discount`
--

DROP TABLE IF EXISTS `variable_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_discount` (
  `prime_id` int(11) NOT NULL,
  `discount_percentage` float NOT NULL,
  UNIQUE KEY `variable_discount_prime_id_uindex` (`prime_id`),
  CONSTRAINT `variable_discount_job_prime_id_fk` FOREIGN KEY (`prime_id`) REFERENCES `job` (`prime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable_discount`
--

LOCK TABLES `variable_discount` WRITE;
/*!40000 ALTER TABLE `variable_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `variable_discount` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-12  8:32:18
