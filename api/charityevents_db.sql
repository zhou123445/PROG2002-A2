-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Fun Run'),(2,'Gala Dinner'),(3,'Silent Auction'),(4,'Charity Concert');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charity_organisations`
--

DROP TABLE IF EXISTS `charity_organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charity_organisations` (
  `organisation_id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(100) NOT NULL,
  `mission` text,
  `contact_email` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`organisation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charity_organisations`
--

LOCK TABLES `charity_organisations` WRITE;
/*!40000 ALTER TABLE `charity_organisations` DISABLE KEYS */;
INSERT INTO `charity_organisations` VALUES (1,'City Hope Charity','Support local vulnerable communities','info@cityhope.org','0400111222');
/*!40000 ALTER TABLE `charity_organisations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(150) NOT NULL,
  `event_description` text,
  `event_date` date DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `ticket_price` decimal(10,2) DEFAULT '0.00',
  `charity_goal` decimal(12,2) DEFAULT NULL,
  `current_progress` decimal(12,2) DEFAULT '0.00',
  `is_suspended` tinyint(1) DEFAULT '0',
  `category_id` int DEFAULT NULL,
  `organisation_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `category_id` (`category_id`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`organisation_id`) REFERENCES `charity_organisations` (`organisation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Spring Fun Run','5km community run for homeless support','2026-10-05','City Park',0.00,5000.00,2200.00,0,1,1),(2,'Winter Gala Dinner','Formal dinner fundraising night','2026-11-12','Grand Hotel',120.00,15000.00,8500.00,0,2,1),(3,'Art Silent Auction','Bid for local artworks','2026-10-20','Community Hall',25.00,8000.00,3100.00,0,3,1),(4,'Autumn Charity Concert','Live music charity show','2026-09-30','Town Hall',45.00,10000.00,6700.00,0,4,1),(5,'Kids Fun Run','Family‑friendly running event','2026-12-02','Riverside Park',15.00,3000.00,1200.00,0,1,1),(6,'Christmas Gala','End‑of‑year charity formal dinner','2026-12-15','Skyview Ballroom',150.00,20000.00,4000.00,0,2,1),(7,'Vintage Auction','Antique silent auction','2026-11-28','Heritage Centre',30.00,6000.00,2800.00,0,3,1),(8,'Summer Charity Music Night','Outdoor live performance','2026-10-18','Beach Amphitheatre',35.00,7500.00,5100.00,1,4,1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-24 11:21:33
