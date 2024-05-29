-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: ajms_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.19-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_list`
--

DROP TABLE IF EXISTS `account_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `user_id` int(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_list_users_FK` (`user_id`),
  CONSTRAINT `account_list_users_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_list`
--

LOCK TABLES `account_list` WRITE;
/*!40000 ALTER TABLE `account_list` DISABLE KEYS */;
INSERT INTO `account_list` VALUES (51,'ICICI bank','',1,0,'2024-05-26 13:54:06',NULL,NULL),(52,'JOSHNA ENTERPRISES','',1,0,'2024-05-26 13:55:10',NULL,NULL),(53,'KALYAN AQUA','',1,0,'2024-05-26 18:44:12',NULL,NULL),(54,'Mannem Bhadraiah','',1,0,'2024-05-26 19:17:30',NULL,NULL),(55,'K Navya','',1,0,'2024-05-26 19:19:38',NULL,NULL),(56,'Bank Charges','',1,0,'2024-05-26 19:21:30',NULL,NULL);
/*!40000 ALTER TABLE `account_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_list`
--

DROP TABLE IF EXISTS `group_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_list` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1= Active',
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = No, 1 = Yes ',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `user_id` int(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_list_users_FK` (`user_id`),
  CONSTRAINT `group_list_users_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_list`
--

LOCK TABLES `group_list` WRITE;
/*!40000 ALTER TABLE `group_list` DISABLE KEYS */;
INSERT INTO `group_list` VALUES (8,'BANKS','',1,0,'2024-05-26 13:51:20','2024-05-26 17:40:13',NULL),(9,'Sundary Debtors','',1,0,'2024-05-26 13:54:31','2024-05-26 13:58:12',NULL),(10,'Sundary Creditors','',1,0,'2024-05-26 19:17:48',NULL,NULL),(11,'Indirect Expenses','',1,0,'2024-05-26 19:21:15',NULL,NULL);
/*!40000 ALTER TABLE `group_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_entries`
--

DROP TABLE IF EXISTS `journal_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal_entries` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `journal_date` date NOT NULL,
  `description` text NOT NULL,
  `user_id` int(30) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `journal_entries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_entries`
--

LOCK TABLES `journal_entries` WRITE;
/*!40000 ALTER TABLE `journal_entries` DISABLE KEYS */;
INSERT INTO `journal_entries` VALUES (14,'202405-00001','2024-04-06','',6,'2024-05-26 18:36:17',NULL),(15,'202405-00002','2024-04-06','',6,'2024-05-26 18:40:25',NULL),(16,'202405-00003','2024-04-12','',6,'2024-05-26 19:10:44',NULL),(17,'202405-00004','2024-04-15','',6,'2024-05-26 19:12:11',NULL),(18,'202405-00005','2024-04-18','',6,'2024-05-26 19:13:50',NULL),(19,'202405-00006','2024-04-18','',6,'2024-05-26 19:16:26',NULL),(20,'202405-00007','2024-04-18','',6,'2024-05-26 19:19:02',NULL),(21,'202405-00008','2024-04-20','',6,'2024-05-26 19:20:25',NULL),(22,'202405-00009','2024-04-30','',6,'2024-05-26 19:22:14',NULL);
/*!40000 ALTER TABLE `journal_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_items`
--

DROP TABLE IF EXISTS `journal_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal_items` (
  `journal_id` int(30) NOT NULL,
  `account_id` int(30) NOT NULL,
  `group_id` int(30) NOT NULL,
  `amount` float NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = Debit, 2= Credit',
  KEY `journal_id` (`journal_id`),
  KEY `account_id` (`account_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `journal_items_ibfk_1` FOREIGN KEY (`journal_id`) REFERENCES `journal_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `journal_items_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account_list` (`id`) ON DELETE CASCADE,
  CONSTRAINT `journal_items_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `group_list` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_items`
--

LOCK TABLES `journal_items` WRITE;
/*!40000 ALTER TABLE `journal_items` DISABLE KEYS */;
INSERT INTO `journal_items` VALUES (14,51,8,30000,'2024-05-26 18:36:17',1),(14,52,9,30000,'2024-05-26 18:36:17',2),(15,51,8,30000,'2024-05-26 18:40:25',2),(15,52,9,30000,'2024-05-26 18:40:25',1),(16,53,9,699193,'2024-05-26 19:10:44',2),(16,51,8,699193,'2024-05-26 19:10:44',1),(17,51,8,699500,'2024-05-26 19:12:11',2),(17,52,9,699500,'2024-05-26 19:12:11',1),(18,52,9,85000,'2024-05-26 19:13:50',2),(18,51,8,85000,'2024-05-26 19:13:50',1),(19,52,9,85000,'2024-05-26 19:16:26',1),(19,51,8,85000,'2024-05-26 19:16:26',2),(19,52,9,515000,'2024-05-26 19:16:26',2),(19,51,8,515000,'2024-05-26 19:16:26',1),(20,54,10,500000,'2024-05-26 19:19:02',1),(20,51,8,500000,'2024-05-26 19:19:02',2),(21,55,10,15000,'2024-05-26 19:20:25',1),(21,51,8,15000,'2024-05-26 19:20:25',2),(22,56,11,45.42,'2024-05-26 19:22:14',1),(22,51,8,45.42,'2024-05-26 19:22:14',2);
/*!40000 ALTER TABLE `journal_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_info`
--

DROP TABLE IF EXISTS `system_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_info` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_info`
--

LOCK TABLES `system_info` WRITE;
/*!40000 ALTER TABLE `system_info` DISABLE KEYS */;
INSERT INTO `system_info` VALUES (1,'name','Accounting Journal Management System'),(6,'short_name','AJMS - PHP'),(11,'logo','uploads/logo-1643680475.png'),(13,'user_avatar','uploads/user_avatar.jpg'),(14,'cover','uploads/cover-1643680511.png'),(15,'content','Array'),(16,'email','info@xyzcompany.com'),(17,'contact','09854698789 / 78945632'),(18,'from_time','11:00'),(19,'to_time','21:30'),(20,'address','XYZ Street, There City, Here, 2306');
/*!40000 ALTER TABLE `system_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(250) NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=not verified, 1 = verified',
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Adminstrator',NULL,'Admin','admin','0192023a7bbd73250516f069df18b500','uploads/avatar-1.png?v=1643703899',NULL,1,1,'2021-01-20 14:02:37','2022-02-01 16:24:59'),(5,'Claire',NULL,'Blake','cblake','4744ddea876b11dcb1d169fadf494418','uploads/avatar-5.png?v=1643704129',NULL,2,1,'2022-02-01 16:28:49','2022-02-01 16:28:49'),(6,'sri manikanta aqua traders',NULL,'bhargavi','bhargavi','92d43b8d661f4cd96f0190c6a3933618',NULL,NULL,1,1,'2024-05-26 13:47:49','2024-05-26 21:59:55');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ajms_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-28 22:05:11
