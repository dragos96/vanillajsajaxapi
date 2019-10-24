-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: localhost    Database: cinema
-- ------------------------------------------------------
-- Server version	5.7.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actors`
--

DROP TABLE IF EXISTS `actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `actors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(200) NOT NULL,
  `lastname` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actors`
--

LOCK TABLES `actors` WRITE;
/*!40000 ALTER TABLE `actors` DISABLE KEYS */;
INSERT INTO `actors` VALUES (1,'tom','cruise'),(2,'will','smith'),(3,'judd','law'),(4,'bradd','pitt'),(5,'angelina','jolie'),(6,'tom','hanks'),(7,'russell','crowe'),(8,'jackie','chan'),(9,'christian','bale');
/*!40000 ALTER TABLE `actors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actors_movies`
--

DROP TABLE IF EXISTS `actors_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `actors_movies` (
  `id_actor` int(11) NOT NULL,
  `id_movie` int(11) NOT NULL,
  PRIMARY KEY (`id_actor`,`id_movie`),
  KEY `id_movie` (`id_movie`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actors_movies`
--

LOCK TABLES `actors_movies` WRITE;
/*!40000 ALTER TABLE `actors_movies` DISABLE KEYS */;
INSERT INTO `actors_movies` VALUES (2,2);
/*!40000 ALTER TABLE `actors_movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clicks`
--

DROP TABLE IF EXISTS `clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_clicked` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `page_name` varchar(200) DEFAULT NULL,
  `button_name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clicks`
--

LOCK TABLES `clicks` WRITE;
/*!40000 ALTER TABLE `clicks` DISABLE KEYS */;
INSERT INTO `clicks` VALUES (1,'2019-05-06 15:17:00',1,'cinema',NULL);
/*!40000 ALTER TABLE `clicks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `clicks_stats`
--

DROP TABLE IF EXISTS `clicks_stats`;
/*!50001 DROP VIEW IF EXISTS `clicks_stats`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `clicks_stats` AS SELECT 
 1 AS `id`,
 1 AS `date_clicked`,
 1 AS `user_id`,
 1 AS `page_name`,
 1 AS `button_name`,
 1 AS `CLICKS_BUTTON`,
 1 AS `BNAME`,
 1 AS `PERCENTAGE`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `heatmaps`
--

DROP TABLE IF EXISTS `heatmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `heatmaps` (
  `user_id` int(11) NOT NULL,
  `page_name` varchar(300) NOT NULL,
  `the_heatmap` longtext,
  PRIMARY KEY (`user_id`,`page_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heatmaps`
--

LOCK TABLES `heatmaps` WRITE;
/*!40000 ALTER TABLE `heatmaps` DISABLE KEYS */;

/*!40000 ALTER TABLE `heatmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(300) DEFAULT NULL,
  `releaseYear` int(11) DEFAULT NULL,
  `ytId` varchar(500) DEFAULT NULL,
  `thumbnailUrl` text,
  `filmingLocation` text,
  `synopsis` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Dark City X',1991,'gt9HkO-cGGo','http://icons.iconarchive.com/icons/firstline1/movie-mega-pack-1/256/Dark-City-icon.png','{ \"lat\": 44.4268, \"lng\": 26.1025 }','John Murdoch awakens alone in a strange hotel to find that he has lost his memory and is wanted for a series of brutal and bizarre murders. While trying to piece together his past, he stumbles upon a fiendish underworld controlled by a group of beings known as The Strangers who possess the ability to put people to sleep and alter the city and its inhabitants. Now Murdoch must find a way to stop them before they take control of his mind and destroy him.'),(2,'Independence Day X',1994,'kA2WzBi2grE','http://icons.iconarchive.com/icons/firstline1/movie-mega-pack-2/256/Independence-Day-icon.png','{ \"lat\": -25.363, \"lng\": 131.044 }','On July 2, 1996, an enormous mothership UFO, that has one fourth the mass of the Moon, enters orbit around Earth, deploying assault fortress saucers, each fifteen miles wide, that take positions over some of Earth\'s major cities. David Levinson, an MIT-trained satellite technician, decodes a signal embedded within global satellite transmissions that he determines is the aliens\' countdown timer for a coordinated attack. With help from his former wife, White House Communications Director Constance Spano, David, and his father Julius, gain access to the Oval Office and warn President Thomas J. Whitmore the aliens are hostile. Whitmore immediately orders large-scale evacuations of New York City, Los Angeles, and Washington, D.C., but it is too late; the timer reaches zero and the saucers activate devastating directed-energy weapons, killing millions. Whitmore, the Levinsons, and a few others narrowly escape aboard Air Force One as the capital is destroyed, along with the other locations over which the saucers are positioned.');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_ro`
--

DROP TABLE IF EXISTS `movies_ro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `movies_ro` (
  `id` int(11) NOT NULL,
  `title` varchar(300) DEFAULT NULL,
  `releaseYear` int(11) DEFAULT NULL,
  `ytId` varchar(500) DEFAULT NULL,
  `thumbnailUrl` text,
  `filmingLocation` text,
  `synopsis` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_ro`
--

LOCK TABLES `movies_ro` WRITE;
/*!40000 ALTER TABLE `movies_ro` DISABLE KEYS */;
INSERT INTO `movies_ro` VALUES (1,'Orasul Intunecat X',1991,'gt9HkO-cGGo','http://icons.iconarchive.com/icons/firstline1/movie-mega-pack-1/256/Dark-City-icon.png','{ \"lat\": 44.4268, \"lng\": 26.1025 }','John Murdoch se trezeste intr-un oras'),(2,'Ziua Independentei X',1994,'kA2WzBi2grE','http://icons.iconarchive.com/icons/firstline1/movie-mega-pack-2/256/Independence-Day-icon.png','{ \"lat\": -25.363, \"lng\": 131.044 }','Invazia extraterestrilor');
/*!40000 ALTER TABLE `movies_ro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_times`
--

DROP TABLE IF EXISTS `page_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `page_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_name` varchar(200) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `total_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_times`
--

LOCK TABLES `page_times` WRITE;
/*!40000 ALTER TABLE `page_times` DISABLE KEYS */;

/*!40000 ALTER TABLE `page_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(300) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` enum('ADMIN','USER') DEFAULT NULL,
  `is_online` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ion@gmail.com','1234','ADMIN',1),(2,'test@test.ro','1234','USER',0),(3,'john@gmail.com','1234','USER',1),(4,'sorin@yahoo.com','1234','USER',1),(5,'tom@yahoo.com','1234','USER',0),(6,'andy@gmail.com','1234','USER',1),(7,'test2@gmail.com','1234','USER',0),(8,'rrr@rrr.ro','rrrr','USER',0),(9,'gelu@gmail.com','9999','USER',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `clicks_stats`
--

/*!50001 DROP VIEW IF EXISTS `clicks_stats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clicks_stats` AS select `c`.`id` AS `id`,`c`.`date_clicked` AS `date_clicked`,`c`.`user_id` AS `user_id`,`c`.`page_name` AS `page_name`,`c`.`button_name` AS `button_name`,`x`.`CLICKS_BUTTON` AS `CLICKS_BUTTON`,`x`.`BNAME` AS `BNAME`,(`x`.`CLICKS_BUTTON` / (select count(0) from `cinema`.`clicks`)) AS `PERCENTAGE` from (`cinema`.`clicks` `c` join (select count(0) AS `CLICKS_BUTTON`,`cinema`.`clicks`.`button_name` AS `BNAME` from `cinema`.`clicks` group by `cinema`.`clicks`.`button_name`) `x` on((`c`.`button_name` = `x`.`BNAME`))) */;
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

-- Dump completed on 2019-05-14 12:01:04
