CREATE DATABASE  IF NOT EXISTS `restaurant_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `restaurant_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurant_db
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `mese`
--

DROP TABLE IF EXISTS `mese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mese` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numar` int NOT NULL,
  `capacitate` int NOT NULL,
  `locatie` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `este_activa` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `numar` (`numar`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mese`
--

LOCK TABLES `mese` WRITE;
/*!40000 ALTER TABLE `mese` DISABLE KEYS */;
INSERT INTO `mese` VALUES (1,1,2,'Interior',1),(2,2,4,'Interior',1),(3,3,4,'Interior',1),(4,4,6,'Terasa',1),(5,5,8,'Terasa',1),(6,6,10,'Sala privata',1);
/*!40000 ALTER TABLE `mese` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preparate_meniu`
--

DROP TABLE IF EXISTS `preparate_meniu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preparate_meniu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denumire` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descriere` text COLLATE utf8mb4_unicode_ci,
  `pret` decimal(8,2) NOT NULL,
  `categorie` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `este_disponibil` tinyint(1) NOT NULL DEFAULT '1',
  `imagine` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT '5.0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preparate_meniu`
--

LOCK TABLES `preparate_meniu` WRITE;
/*!40000 ALTER TABLE `preparate_meniu` DISABLE KEYS */;
INSERT INTO `preparate_meniu` VALUES (1,'Bruschette cu rosii','Paine crocanta cu rosii cherry si busuioc',45.00,'Aperitive',1,'https://images.unsplash.com/photo-1572656631137-7935297eff55?q=80&w=500',4.7),(2,'Supa crema de ciuperci','Supa de ciuperci cu smantana si crutoane',75.00,'Supe',1,'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=500',5.0),(3,'File de somon la gratar','Somon cu legume la abur si sos de lamaie',195.00,'Fel principal',1,'https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=500',5.0),(4,'Pasta Carbonara','Paste cu bacon, ou si parmezan',120.00,'Fel principal',1,'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=500',5.0),(5,'Pizza Margherita','Pizza clasica cu sos de rosii si mozzarela',150.00,'Fel principal',1,'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?q=80&w=600',5.0),(6,'Tort de ciocolata','Tort cu crema ganache si fructe de padure',95.00,'Desert',1,'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=500',5.0),(7,'Inghetata artizanala','3 bile la alegere din 12 arome',65.00,'Desert',1,'https://images.unsplash.com/photo-1501443762994-82bd5dace89a?q=80&w=500',5.0),(8,'Limonada de casa','Lamaie, menta si sirop natural',35.00,'Bauturi',1,'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?q=80&w=500',5.0),(9,'Vin rosu (pahar)','Cabernet Sauvignon, sec, 150ml',60.00,'Bauturi',1,'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?q=80&w=500',5.0);
/*!40000 ALTER TABLE `preparate_meniu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recenzii`
--

DROP TABLE IF EXISTS `recenzii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recenzii` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilizator_id` int NOT NULL,
  `preparat_id` int NOT NULL,
  `calificativ` int NOT NULL,
  `comentariu` text COLLATE utf8mb4_unicode_ci,
  `creat_la` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_utilizator_preparat` (`utilizator_id`,`preparat_id`),
  KEY `preparat_id` (`preparat_id`),
  CONSTRAINT `recenzii_ibfk_1` FOREIGN KEY (`utilizator_id`) REFERENCES `utilizatori` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recenzii_ibfk_2` FOREIGN KEY (`preparat_id`) REFERENCES `preparate_meniu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recenzii_chk_1` CHECK ((`calificativ` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recenzii`
--

LOCK TABLES `recenzii` WRITE;
/*!40000 ALTER TABLE `recenzii` DISABLE KEYS */;
INSERT INTO `recenzii` VALUES (1,2,3,5,'Somonul a fost perfect, recomand cu caldura!','2026-05-04 15:07:51'),(2,3,4,4,'Carbonara buna, dar portia cam mica.','2026-05-04 15:07:51'),(3,4,6,5,'Cel mai bun tort de ciocolata pe care l-am mancat.','2026-05-04 15:07:51');
/*!40000 ALTER TABLE `recenzii` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rezervari`
--

DROP TABLE IF EXISTS `rezervari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rezervari` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilizator_id` int NOT NULL,
  `masa_id` int NOT NULL,
  `data` date NOT NULL,
  `ora` time NOT NULL,
  `nr_persoane` int NOT NULL,
  `status` enum('in_asteptare','confirmata','anulata') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_asteptare',
  `observatii` text COLLATE utf8mb4_unicode_ci,
  `creat_la` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `utilizator_id` (`utilizator_id`),
  KEY `masa_id` (`masa_id`),
  CONSTRAINT `rezervari_ibfk_1` FOREIGN KEY (`utilizator_id`) REFERENCES `utilizatori` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rezervari_ibfk_2` FOREIGN KEY (`masa_id`) REFERENCES `mese` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rezervari`
--

LOCK TABLES `rezervari` WRITE;
/*!40000 ALTER TABLE `rezervari` DISABLE KEYS */;
INSERT INTO `rezervari` VALUES (1,2,2,'2025-06-10','19:00:00',3,'confirmata','Aniversare — rugam un desert surpriza','2026-05-04 15:07:45'),(2,3,4,'2025-06-11','20:00:00',4,'confirmata',NULL,'2026-05-04 15:07:45'),(3,4,1,'2025-06-12','13:00:00',2,'anulata','Alergic la gluten','2026-05-04 15:07:45'),(4,10,6,'2026-02-06','16:00:00',3,'anulata',NULL,'2026-05-06 22:37:17'),(5,9,4,'2026-02-10','16:00:00',3,'confirmata',NULL,'2026-05-11 14:52:05');
/*!40000 ALTER TABLE `rezervari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilizatori`
--

DROP TABLE IF EXISTS `utilizatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizatori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parola` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('client','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `creat_la` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizatori`
--

LOCK TABLES `utilizatori` WRITE;
/*!40000 ALTER TABLE `utilizatori` DISABLE KEYS */;
INSERT INTO `utilizatori` VALUES (1,'Admin Restaurant','admin@restaurant.md','$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx','admin','2026-05-04 15:07:06'),(2,'Ion Popescu','ion@mail.com','$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx','client','2026-05-04 15:07:06'),(3,'Maria Ionescu','maria@mail.com','$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx','client','2026-05-04 15:07:06'),(4,'Alex Rusu','alex@mail.com','$2b$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx','client','2026-05-04 15:07:06'),(9,'Admin','admin@rest.md','$2a$12$QCMHn3od9JM2k.FuoQNcduFygYWtLZKM8EEU2yWzrb8V1GLxtjlOi','admin','2026-05-06 22:08:39'),(10,'Pisla Maxim','pislamaxim@gmail.com','$2a$10$9O6lk2Kyc8RHVScYuXHp6OmfXYfHRyn.dTJMaYd7SglyGeyeYmGiC','client','2026-05-06 22:15:48');
/*!40000 ALTER TABLE `utilizatori` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-12 19:15:19
