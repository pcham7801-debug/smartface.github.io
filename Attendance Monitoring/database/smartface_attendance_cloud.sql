-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: smartface_attendance
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1,'System Administrator','admin@smartface.edu','admin','$2y$12$jnnofBJLEib3p1vtOacTX.9hCohsMyYwxpwp5mqKudV0cEK.x4aea','active','2026-09-09 10:34:11');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `attendance_date` date NOT NULL,
  `time_in` time NOT NULL,
  `time_out` time DEFAULT NULL,
  `signout_status` enum('none','pending','approved','rejected') NOT NULL DEFAULT 'none',
  `signout_reason` varchar(255) DEFAULT NULL,
  `status` enum('Present','Late','Absent','Excused','Incomplete') NOT NULL DEFAULT 'Present',
  `verification_method` varchar(50) DEFAULT 'Face Recognition',
  `remarks` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_subject_date` (`student_id`,`subject_id`,`attendance_date`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (5,5,5,'2026-09-14','11:07:02','11:47:05','approved',NULL,'Present','Face Recognition',NULL,'2026-09-14 11:07:02','2026-09-14 19:42:35');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,1,'System Initialization','Database schema imported with seed data successfully','127.0.0.1','2026-09-09 10:34:11'),(2,1,'User Logout','User admin logged out.','::1','2026-09-09 10:52:25'),(3,NULL,'Student Registered','New student registered: Sherwin Baylen (24-104174)','::1','2026-09-09 10:56:40'),(4,4,'User Login','User ewwin09 logged in successfully as student.','::1','2026-09-09 10:57:01'),(5,4,'User Login','User ewwin09 logged in successfully as student.','::1','2026-09-09 22:40:38'),(6,4,'Face Registered','Biometric face descriptor registered for Student ID internal #3','::1','2026-09-09 22:41:09'),(7,4,'User Logout','User ewwin09 logged out.','::1','2026-09-09 22:41:28'),(8,4,'User Login','User ewwin09 logged in successfully as student.','::1','2026-09-10 09:07:37'),(9,4,'User Face Login','User ewwin09 logged in via facial recognition (Distance: 0).','::1','2026-09-10 09:13:17'),(10,4,'User Face Login','User ewwin09 logged in via facial recognition (Distance: 0).','::1','2026-09-10 09:13:33'),(11,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:15:03'),(12,4,'User Face Login','User ewwin09 logged in via facial recognition (Distance: 0.4112).','::1','2026-09-10 09:15:31'),(13,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:17:27'),(14,4,'User Face Login','User ewwin09 logged in via facial recognition (Distance: 0.3811).','::1','2026-09-10 09:17:47'),(15,4,'User Face Login','User ewwin09 logged in via facial recognition (Distance: 0.3839).','::1','2026-09-10 09:17:47'),(16,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:17:51'),(17,NULL,'Failed Face Login','Face verification failed. Best distance: 999 (Threshold: 0.55)','::1','2026-09-10 09:18:07'),(18,4,'User Face Login','User ewwin09 logged in via facial recognition (Distance: 0.5017).','::1','2026-09-10 09:18:08'),(19,4,'Face Registered','Biometric face descriptor registered for Student ID internal #3','::1','2026-09-10 09:18:40'),(20,4,'User Face Login','User ewwin09 verified successfully via biometric face scan (Distance: 0).','::1','2026-09-10 09:21:17'),(21,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin09. Live distance: 1.6971 > Threshold: 0.48','::1','2026-09-10 09:21:17'),(22,NULL,'Failed Face Login','No face biometric registered for user: student','::1','2026-09-10 09:21:17'),(23,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:22:00'),(24,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin09. Live distance: 0.7481 > Threshold: 0.48','::1','2026-09-10 09:22:22'),(25,4,'User Face Login','User ewwin09 verified successfully via biometric face scan (Distance: 0.3888).','::1','2026-09-10 09:22:25'),(26,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:22:32'),(27,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin09. Live distance: 0.7566 > Threshold: 0.48','::1','2026-09-10 09:22:49'),(28,4,'User Face Login','User ewwin09 verified successfully via biometric face scan (Distance: 0.4648).','::1','2026-09-10 09:22:52'),(29,4,'User Face Login','User ewwin09 verified successfully via biometric face scan (Distance: 0).','::1','2026-09-10 09:25:31'),(30,4,'User Face Login','User ewwin09 verified successfully via biometric face scan (Distance: 0.2289).','::1','2026-09-10 09:25:31'),(31,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:26:24'),(32,4,'User Face Login','User ewwin09 verified successfully via biometric face scan (Distance: 0.3709).','::1','2026-09-10 09:26:42'),(33,4,'User Logout','User ewwin09 logged out.','::1','2026-09-10 09:30:21'),(34,1,'Admin Login','Administrator admin signed in via Admin Portal.','::1','2026-09-10 09:30:49'),(35,1,'Admin Delete Student','Admin deleted student user ID #3','::1','2026-09-10 09:31:39'),(36,1,'Admin Delete Student','Admin deleted student user ID #2','::1','2026-09-10 09:31:42'),(37,1,'Face Registered','Biometric face descriptor registered for Student ID internal #3','::1','2026-09-10 09:32:02'),(38,NULL,'Failed Face Login','Account not found for input: ewwin','::1','2026-09-10 09:33:16'),(39,NULL,'Failed Face Login','Account not found for input: ewwin','::1','2026-09-10 09:33:19'),(40,NULL,'Failed Face Login','Account not found for input: ewwin','::1','2026-09-10 09:33:22'),(41,NULL,'Failed Face Login','Account not found for input: ewwin','::1','2026-09-10 09:33:25'),(42,1,'Admin Delete Student','Admin deleted student user ID #4','::1','2026-09-10 09:33:43'),(43,1,'Delete Subject','Deleted subject ID #2','::1','2026-09-10 09:33:50'),(44,1,'Delete Subject','Deleted subject ID #1','::1','2026-09-10 09:33:53'),(45,1,'Delete Subject','Deleted subject ID #4','::1','2026-09-10 09:33:57'),(46,1,'Delete Subject','Deleted subject ID #3','::1','2026-09-10 09:34:00'),(47,1,'Add Subject','Created new subject: IT16 - System Administration and Maintenace','::1','2026-09-10 09:37:10'),(48,NULL,'Student Registered','New student registered: Sherwin Baylen (24-104174)','::1','2026-09-10 09:38:47'),(49,5,'User Face Login','User ewwin verified successfully via biometric face scan (Distance: 0.1001).','::1','2026-09-10 09:39:03'),(50,5,'User Logout','User ewwin logged out.','::1','2026-09-10 09:39:07'),(51,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin. Live distance: 0.5553 > Threshold: 0.41','::1','2026-09-10 09:39:25'),(52,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin. Live distance: 0.4314 > Threshold: 0.41','::1','2026-09-10 09:39:29'),(53,5,'User Face Login','User ewwin verified successfully via biometric face scan (Distance: 0.3596).','::1','2026-09-10 09:39:32'),(54,5,'User Logout','User ewwin logged out.','::1','2026-09-10 09:39:37'),(55,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin. Live distance: 0.5196 > Threshold: 0.41','::1','2026-09-10 09:39:56'),(56,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin. Live distance: 0.4866 > Threshold: 0.41','::1','2026-09-10 09:39:59'),(57,5,'User Face Login','User ewwin verified successfully via biometric face scan (Distance: 0.1313).','::1','2026-09-10 09:40:06'),(58,5,'User Face Login','User ewwin verified successfully via biometric face scan (Distance: 0.1272).','::1','2026-09-10 09:40:06'),(59,1,'Edit Subject','Updated subject #5: IT16','::1','2026-09-10 09:41:55'),(60,5,'User Logout','User ewwin logged out.','::1','2026-09-10 10:00:43'),(61,5,'User Face Login','User ewwin verified successfully via biometric face scan (Distance: 0.3313).','::1','2026-09-10 10:01:02'),(62,1,'Admin Assign Subjects','Updated enrolled subjects for student ID #4 (1 subjects)','::1','2026-09-10 10:05:27'),(63,5,'User Logout','User ewwin logged out.','::1','2026-09-10 10:05:46'),(64,5,'User Face Login','User ewwin verified successfully via biometric face scan (Distance: 0.3024).','::1','2026-09-10 10:06:04'),(65,5,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully via recorded biometric face scan (Distance: 0).','::1','2026-09-10 10:10:13'),(66,NULL,'Failed Face Login','Unrecognized face attempted login. Best distance: 999 (Threshold: 0.38)','::1','2026-09-10 10:10:13'),(67,NULL,'Failed Face Login Mismatch','Face mismatch for ewwin. Distance: 0.7791 > Threshold: 0.38','::1','2026-09-10 10:10:13'),(68,5,'User Logout','User ewwin logged out.','::1','2026-09-10 10:11:08'),(69,5,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully via recorded biometric face scan (Distance: 0.3423).','::1','2026-09-10 10:11:24'),(70,5,'User Logout','User ewwin logged out.','::1','2026-09-10 10:11:29'),(71,5,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully via recorded biometric face scan (Distance: 0.3767).','::1','2026-09-10 10:11:44'),(72,5,'User Logout','User ewwin logged out.','::1','2026-09-10 10:11:50'),(73,5,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully via recorded biometric face scan (Distance: 0.111).','::1','2026-09-10 10:12:04'),(74,1,'Admin Delete Student','Admin deleted student user ID #5','::1','2026-09-10 10:12:13'),(75,5,'User Logout','User ewwin logged out.','::1','2026-09-10 10:12:21'),(76,NULL,'Student Registered','New student registered: Sherwin Baylen (24-104174)','::1','2026-09-10 10:13:14'),(77,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully via recorded biometric face scan (Distance: 0.3104).','::1','2026-09-10 10:13:28'),(78,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0).','::1','2026-09-10 10:16:35'),(79,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.7764 > Threshold: 0.4. Access denied.','::1','2026-09-10 10:16:35'),(80,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:17:27'),(81,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.371).','::1','2026-09-10 10:17:45'),(82,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:18:02'),(83,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.3475).','::1','2026-09-10 10:20:49'),(84,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:21:16'),(85,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2367).','::1','2026-09-10 10:21:30'),(86,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:24:07'),(87,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.1254).','::1','2026-09-10 10:24:21'),(88,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:24:28'),(89,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.3237).','::1','2026-09-10 10:24:43'),(90,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.3227).','::1','2026-09-10 10:24:43'),(91,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:30:37'),(92,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.2988 > Threshold: 0.28. Access denied.','::1','2026-09-10 10:30:51'),(93,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.1433).','::1','2026-09-10 10:31:00'),(94,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:31:07'),(95,NULL,'Student Registered','New student registered: Christian jay Malana (24-104083)','::1','2026-09-10 10:34:15'),(96,7,'User Face Login','Student jay (Christian jay Malana) verified successfully as account owner via face scan (Distance: 0.1377).','::1','2026-09-10 10:34:34'),(97,7,'User Face Login','Student jay (Christian jay Malana) verified successfully as account owner via face scan (Distance: 0.1337).','::1','2026-09-10 10:34:34'),(98,7,'User Logout','User jay logged out.','::1','2026-09-10 10:34:40'),(99,NULL,'Failed Face Login Mismatch','Face mismatch for account jay. Live distance: 0.308 > Threshold: 0.28. Access denied.','::1','2026-09-10 10:34:55'),(100,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.13).','::1','2026-09-10 10:38:35'),(101,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.1359).','::1','2026-09-10 10:38:35'),(102,6,'User Logout','User ewwin logged out.','::1','2026-09-10 10:38:39'),(103,7,'User Face Login','Student jay (Christian jay Malana) verified successfully as account owner via face scan (Distance: 0.2774).','::1','2026-09-10 10:38:52'),(104,7,'User Logout','User jay logged out.','::1','2026-09-10 10:38:57'),(105,NULL,'Failed Face Login Mismatch','Face mismatch for account jay. Live distance: 0.311 > Threshold: 0.28. Access denied.','::1','2026-09-10 10:39:10'),(106,NULL,'Student Registered','New student registered: Jerrecson Oligo (24-104205)','::1','2026-09-10 11:32:13'),(107,8,'User Face Login','Student Jeric (Jerrecson Oligo) verified successfully as account owner via face scan (Distance: 0.1736).','::1','2026-09-10 11:32:30'),(108,1,'Admin Assign Subjects','Updated enrolled subjects for student ID #7 (0 subjects)','::1','2026-09-10 11:33:10'),(109,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2239).','::1','2026-09-14 11:06:18'),(110,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2212).','::1','2026-09-14 11:06:18'),(111,6,'Sign In Recorded','Attendance Sign In recorded for Student #5 in IT16 - Status: Present','::1','2026-09-14 11:07:02'),(112,1,'Admin Login','Administrator admin signed in via Admin Portal.','::1','2026-09-14 11:14:56'),(113,6,'Sign Out Recorded','Attendance Sign Out recorded for Student #5 in IT16','::1','2026-09-14 11:47:05'),(114,1,'Admin Assign Subjects','Updated enrolled subjects for student ID #6 (0 subjects)','::1','2026-09-14 15:36:18'),(115,1,'Admin Assign Subjects','Updated enrolled subjects for student ID #7 (0 subjects)','::1','2026-09-14 15:36:22'),(116,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2233).','::1','2026-09-14 17:39:43'),(117,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.2993 > Threshold: 0.28. Access denied.','::1','2026-09-14 17:59:59'),(118,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2475).','::1','2026-09-14 18:00:04'),(119,6,'Face Registered','Biometric face descriptor registered for Student ID internal #5','::1','2026-09-14 18:01:42'),(120,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4293 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:26:42'),(121,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.386 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:26:50'),(122,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4262 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:26:53'),(123,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4003 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:01'),(124,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4236 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:04'),(125,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.433 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:06'),(126,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.3972 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:18'),(127,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.3902 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:22'),(128,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.3928 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:23'),(129,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.3926 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:25'),(130,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.3973 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:28'),(131,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.3863 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:30'),(132,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4095 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:32'),(133,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4014 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:32'),(134,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4161 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:33'),(135,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.418 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:48'),(136,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4151 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:27:58'),(137,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4241 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:00'),(138,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4168 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:02'),(139,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4179 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:02'),(140,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4101 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:04'),(141,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4055 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:06'),(142,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4108 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:12'),(143,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4173 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:14'),(144,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4224 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:15'),(145,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4248 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:15'),(146,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4208 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:17'),(147,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4176 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:19'),(148,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4191 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:19'),(149,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.416 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:20'),(150,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4198 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:21'),(151,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4123 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:22'),(152,NULL,'Failed Face Login Mismatch','Face mismatch for account ewwin. Live distance: 0.4173 > Threshold: 0.28. Access denied.','::1','2026-09-14 19:28:23'),(153,1,'Admin Login','Administrator admin signed in via Admin Portal.','::1','2026-09-14 19:29:09'),(154,1,'Face Registered','Biometric face descriptor registered for Student ID internal #5','::1','2026-09-14 19:29:40'),(155,1,'Face Registered','Biometric face descriptor registered for Student ID internal #5','::1','2026-09-14 19:29:45'),(156,1,'User Logout','User admin logged out.','::1','2026-09-14 19:29:49'),(157,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2291).','::1','2026-09-14 19:29:58'),(158,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2671).','::1','2026-09-14 19:37:03'),(159,6,'User Face Login','Student ewwin (Sherwin Baylen) verified successfully as account owner via face scan (Distance: 0.2644).','::1','2026-09-14 19:37:04'),(160,1,'Sign Out Approved','Admin approved sign out for Sherwin Baylen in IT16.','127.0.0.1','2026-09-14 19:42:35');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `face_records`
--

DROP TABLE IF EXISTS `face_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `face_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `face_encoding` longtext NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`),
  CONSTRAINT `face_records_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `face_records`
--

LOCK TABLES `face_records` WRITE;
/*!40000 ALTER TABLE `face_records` DISABLE KEYS */;
INSERT INTO `face_records` VALUES (3,5,'[-0.15674825012683868,0.14488516747951508,0.11753222346305847,-0.025470688939094543,-0.08033350110054016,-0.08517623692750931,0.025342745706439018,-0.11277975142002106,0.10258625447750092,-0.041595879942178726,0.32970091700553894,-0.11669586598873138,-0.18233826756477356,-0.11374423652887344,0.011471257545053959,0.20340688526630402,-0.1891142725944519,-0.1032804623246193,-0.08384954184293747,-0.03162586688995361,0.05685748532414436,0.008777138777077198,-0.01264474168419838,0.015016322955489159,-0.047533150762319565,-0.3336440324783325,-0.06261955946683884,-0.07011252641677856,0.0163438618183136,-0.06936733424663544,-0.01219133473932743,0.0335322804749012,-0.262305349111557,-0.07334999740123749,-0.019049767404794693,0.03454553708434105,-0.014867199584841728,-0.05183170735836029,0.16461415588855743,-0.02695382945239544,-0.16271546483039856,-0.002487084362655878,0.01898534595966339,0.234438955783844,0.15058331191539764,0.030867602676153183,-0.013965019956231117,-0.08779525011777878,-0.004999475087970495,-0.11713718622922897,0.015772858634591103,0.12395361810922623,0.1231086477637291,0.023452259600162506,-0.0415404848754406,-0.12155992537736893,-0.01350313425064087,0.013589199632406235,-0.1191677674651146,-0.07689978927373886,0.08679009974002838,-0.09026939421892166,-0.0718906968832016,-0.09950894862413406,0.2617773413658142,0.030134128406643867,-0.07606221735477448,-0.11864548921585083,0.11875228583812714,-0.03013032302260399,-0.056532666087150574,0.005993887782096863,-0.15588976442813873,-0.13687622547149658,-0.32587045431137085,0.09280181676149368,0.3689211308956146,0.011778215877711773,-0.24461841583251953,0.015978854149580002,-0.12617884576320648,0.0065680621191859245,0.05826960504055023,0.06665407866239548,-0.04958264157176018,0.037505269050598145,-0.12852506339550018,0.05590901896357536,0.14835746586322784,-0.1209830716252327,-0.011089643463492393,0.1866496056318283,-0.027377668768167496,-0.016613908112049103,-0.012853537686169147,-0.05934794619679451,-0.0008431305177509785,0.0477059930562973,-0.09915537387132645,-0.03088030405342579,0.10262200981378555,-0.03081471100449562,-0.025725681334733963,0.14364764094352722,-0.2112395465373993,0.04615772143006325,0.05345989763736725,-0.018281973898410797,0.02030455507338047,-0.01024534273892641,-0.10888060182332993,-0.12475418299436569,0.11264951527118683,-0.1802351027727127,0.17355552315711975,0.17646798491477966,-0.0055031077936291695,0.12929989397525787,0.09568465501070023,0.11531737446784973,-0.042010821402072906,0.018001725897192955,-0.16610772907733917,0.002365103689953685,0.15469001233577728,0.055736396461725235,0.07795115560293198,0.04351755976676941]','2026-09-10 10:13:14','2026-09-14 19:29:45'),(4,6,'[-0.05702077969908714,0.12338212877511978,0.01039072871208191,-0.10716617852449417,-0.05790751799941063,0.0009067314094863832,-0.02817930094897747,-0.12488045543432236,0.21256087720394135,-0.14471301436424255,0.24891214072704315,-0.0548662431538105,-0.22691656649112701,-0.15345342457294464,-0.05638492479920387,0.20430465042591095,-0.12946195900440216,-0.1880415827035904,-0.05514660105109215,-0.04978056997060776,0.0406770296394825,-0.0074147325940430164,-0.02010679431259632,0.06687074899673462,-0.09223107993602753,-0.3371260166168213,-0.08460317552089691,-0.07761719077825546,-0.035724688321352005,-0.11517801880836487,-0.04757990688085556,0.04176640883088112,-0.21371759474277496,-0.059774287045001984,-0.027508476749062538,0.05087217316031456,-0.012097751721739769,-0.03374364599585533,0.2073793262243271,0.03909642621874809,-0.170353963971138,-0.047137901186943054,-0.011391309089958668,0.2894742488861084,0.17784756422042847,-0.002876515965908766,0.02383357658982277,-0.11315352469682693,0.08469918370246887,-0.12855522334575653,0.04813709482550621,0.1543005257844925,0.08835053443908691,0.058620888739824295,-0.011171190068125725,-0.10156463086605072,0.011065743863582611,0.08258187770843506,-0.12982968986034393,-0.04030430689454079,0.07491344213485718,-0.09080459922552109,-0.10399254411458969,-0.07280176877975464,0.28851377964019775,0.05093285068869591,-0.09126269072294235,-0.19596605002880096,0.18873731791973114,-0.08748669922351837,-0.08413423597812653,0.0001314410474151373,-0.18515124917030334,-0.1380368322134018,-0.32386890053749084,0.0833786204457283,0.3525375425815582,0.10840814560651779,-0.19769296050071716,0.08412106335163116,-0.08296912163496017,0.014966889284551144,0.11547371745109558,0.10379888862371445,-0.02322724461555481,0.06027744337916374,-0.0682249441742897,0.07409486174583435,0.15300379693508148,-0.0627078264951706,-0.06380747258663177,0.1669052094221115,-0.04705122113227844,0.058138418942689896,0.02371586672961712,-0.016026778146624565,-0.032301127910614014,0.1065593808889389,-0.12851408123970032,0.03266611322760582,0.10624714940786362,0.026950541883707047,0.03453933075070381,0.14394192397594452,-0.12904873490333557,0.1081543117761612,0.014689524658024311,0.023483730852603912,0.009002866223454475,0.01011862512677908,-0.14184139668941498,-0.11973253637552261,0.1353735327720642,-0.20790128409862518,0.18438582122325897,0.1347605288028717,0.04872119799256325,0.09988512843847275,0.12625034153461456,0.10158726572990417,0.012160200625658035,-0.023672763258218765,-0.23639695346355438,0.02008027769625187,0.1437205970287323,0.010098547674715519,0.11008986830711365,0.028911923989653587]','2026-09-10 10:34:15','2026-09-10 10:34:15'),(5,7,'[-0.13593363761901855,0.07778944820165634,0.026515144854784012,-0.05770858749747276,0.014414538629353046,-0.13828803598880768,-0.02501467801630497,-0.1648983210325241,0.1277725249528885,-0.04695498198270798,0.3004470765590668,-0.06961280107498169,-0.15261514484882355,-0.1790631264448166,-0.012267835438251495,0.17364300787448883,-0.2117922455072403,-0.10523475706577301,-0.08717882633209229,-0.045582450926303864,0.07398489117622375,-0.05963621661067009,-0.023677442222833633,0.10776183754205704,-0.10830941796302795,-0.2673666775226593,-0.08883842825889587,-0.0629098042845726,0.11312966793775558,-0.05870429426431656,-0.07895972579717636,-0.0170382522046566,-0.24443019926548004,-0.0952085554599762,0.02322433330118656,0.07150596380233765,-0.0059258705005049706,-0.08293525129556656,0.19194312393665314,-0.04750446230173111,-0.19309774041175842,-0.02944951131939888,0.06126829981803894,0.23373402655124664,0.2315807342529297,-0.019171694293618202,0.03689824044704437,-0.11984357982873917,0.1187777891755104,-0.11377549916505814,-0.007548768073320389,0.16962595283985138,0.14123909175395966,0.10192640125751495,-0.0600101463496685,-0.13763244450092316,-0.01624760776758194,0.1539018750190735,-0.12510089576244354,0.022993016988039017,0.08528247475624084,-0.10067947208881378,-0.05058646947145462,-0.07504608482122421,0.23964916169643402,0.03950582072138786,-0.18439124524593353,-0.16649982333183289,0.1388292908668518,-0.11551554501056671,-0.022893710061907768,0.04199037700891495,-0.15948201715946198,-0.20746354758739471,-0.3304603695869446,0.057975884526968,0.34069937467575073,0.10191388428211212,-0.23350398242473602,0.05831334367394447,-0.13607440888881683,0.0038543627597391605,0.1090087741613388,0.1496792584657669,0.0029649671632796526,0.07739932090044022,-0.08707355707883835,0.02606477588415146,0.20588697493076324,-0.046113915741443634,0.01716279238462448,0.19934947788715363,-0.03388691693544388,0.04918147251009941,-0.03064032271504402,0.020313860848546028,-0.08072587102651596,0.03792101517319679,-0.09027399867773056,0.011715268716216087,0.036667052656412125,0.004305901937186718,0.06355120986700058,0.10823556780815125,-0.10861624777317047,0.14286085963249207,0.08071194589138031,0.07653898000717163,0.007380821742117405,-0.01907329075038433,-0.061408545821905136,-0.1182752251625061,0.09062260389328003,-0.19236813485622406,0.2428048700094223,0.17446500062942505,0.1081070601940155,0.1150127649307251,0.10635145008563995,0.09900590032339096,0.008823894895613194,-0.0017689935630187392,-0.13067935407161713,0.04934580251574516,0.07387091964483261,-0.04651143401861191,0.1336851418018341,-0.020776066929101944]','2026-09-10 11:32:13','2026-09-10 11:32:13');
/*!40000 ALTER TABLE `face_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'school_name','SmartFace Institute of Technology','2026-09-09 10:34:11','2026-09-09 10:34:11'),(2,'grace_period_minutes','15','2026-09-09 10:34:11','2026-09-09 10:34:11'),(3,'school_year','2026-2027','2026-09-09 10:34:11','2026-09-09 10:34:11'),(4,'semester','1st Semester','2026-09-09 10:34:11','2026-09-09 10:34:11'),(5,'late_after_minutes','10','2026-09-14 15:31:11','2026-09-14 15:31:11'),(6,'absent_after_minutes','30','2026-09-14 15:31:11','2026-09-14 15:31:11');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_subjects`
--

DROP TABLE IF EXISTS `student_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `enrollment_status` enum('enrolled','dropped') DEFAULT 'enrolled',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_subject` (`student_id`,`subject_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `student_subjects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_subjects`
--

LOCK TABLES `student_subjects` WRITE;
/*!40000 ALTER TABLE `student_subjects` DISABLE KEYS */;
INSERT INTO `student_subjects` VALUES (10,5,5,'enrolled','2026-09-10 10:16:18');
/*!40000 ALTER TABLE `student_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `course` varchar(100) NOT NULL,
  `year_level` varchar(20) NOT NULL,
  `section` varchar(50) NOT NULL,
  `face_registered` tinyint(1) DEFAULT 0,
  `face_data` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `student_id` (`student_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (5,6,'24-104174','BSIT','3rd Year','A',1,'[-0.15674825012683868,0.14488516747951508,0.11753222346305847,-0.025470688939094543,-0.08033350110054016,-0.08517623692750931,0.025342745706439018,-0.11277975142002106,0.10258625447750092,-0.041595879942178726,0.32970091700553894,-0.11669586598873138,-0.18233826756477356,-0.11374423652887344,0.011471257545053959,0.20340688526630402,-0.1891142725944519,-0.1032804623246193,-0.08384954184293747,-0.03162586688995361,0.05685748532414436,0.008777138777077198,-0.01264474168419838,0.015016322955489159,-0.047533150762319565,-0.3336440324783325,-0.06261955946683884,-0.07011252641677856,0.0163438618183136,-0.06936733424663544,-0.01219133473932743,0.0335322804749012,-0.262305349111557,-0.07334999740123749,-0.019049767404794693,0.03454553708434105,-0.014867199584841728,-0.05183170735836029,0.16461415588855743,-0.02695382945239544,-0.16271546483039856,-0.002487084362655878,0.01898534595966339,0.234438955783844,0.15058331191539764,0.030867602676153183,-0.013965019956231117,-0.08779525011777878,-0.004999475087970495,-0.11713718622922897,0.015772858634591103,0.12395361810922623,0.1231086477637291,0.023452259600162506,-0.0415404848754406,-0.12155992537736893,-0.01350313425064087,0.013589199632406235,-0.1191677674651146,-0.07689978927373886,0.08679009974002838,-0.09026939421892166,-0.0718906968832016,-0.09950894862413406,0.2617773413658142,0.030134128406643867,-0.07606221735477448,-0.11864548921585083,0.11875228583812714,-0.03013032302260399,-0.056532666087150574,0.005993887782096863,-0.15588976442813873,-0.13687622547149658,-0.32587045431137085,0.09280181676149368,0.3689211308956146,0.011778215877711773,-0.24461841583251953,0.015978854149580002,-0.12617884576320648,0.0065680621191859245,0.05826960504055023,0.06665407866239548,-0.04958264157176018,0.037505269050598145,-0.12852506339550018,0.05590901896357536,0.14835746586322784,-0.1209830716252327,-0.011089643463492393,0.1866496056318283,-0.027377668768167496,-0.016613908112049103,-0.012853537686169147,-0.05934794619679451,-0.0008431305177509785,0.0477059930562973,-0.09915537387132645,-0.03088030405342579,0.10262200981378555,-0.03081471100449562,-0.025725681334733963,0.14364764094352722,-0.2112395465373993,0.04615772143006325,0.05345989763736725,-0.018281973898410797,0.02030455507338047,-0.01024534273892641,-0.10888060182332993,-0.12475418299436569,0.11264951527118683,-0.1802351027727127,0.17355552315711975,0.17646798491477966,-0.0055031077936291695,0.12929989397525787,0.09568465501070023,0.11531737446784973,-0.042010821402072906,0.018001725897192955,-0.16610772907733917,0.002365103689953685,0.15469001233577728,0.055736396461725235,0.07795115560293198,0.04351755976676941]','2026-09-10 10:13:14','2026-09-14 19:29:45'),(6,7,'24-104083','BSIT','3rd Year','A',1,'[-0.05702077969908714,0.12338212877511978,0.01039072871208191,-0.10716617852449417,-0.05790751799941063,0.0009067314094863832,-0.02817930094897747,-0.12488045543432236,0.21256087720394135,-0.14471301436424255,0.24891214072704315,-0.0548662431538105,-0.22691656649112701,-0.15345342457294464,-0.05638492479920387,0.20430465042591095,-0.12946195900440216,-0.1880415827035904,-0.05514660105109215,-0.04978056997060776,0.0406770296394825,-0.0074147325940430164,-0.02010679431259632,0.06687074899673462,-0.09223107993602753,-0.3371260166168213,-0.08460317552089691,-0.07761719077825546,-0.035724688321352005,-0.11517801880836487,-0.04757990688085556,0.04176640883088112,-0.21371759474277496,-0.059774287045001984,-0.027508476749062538,0.05087217316031456,-0.012097751721739769,-0.03374364599585533,0.2073793262243271,0.03909642621874809,-0.170353963971138,-0.047137901186943054,-0.011391309089958668,0.2894742488861084,0.17784756422042847,-0.002876515965908766,0.02383357658982277,-0.11315352469682693,0.08469918370246887,-0.12855522334575653,0.04813709482550621,0.1543005257844925,0.08835053443908691,0.058620888739824295,-0.011171190068125725,-0.10156463086605072,0.011065743863582611,0.08258187770843506,-0.12982968986034393,-0.04030430689454079,0.07491344213485718,-0.09080459922552109,-0.10399254411458969,-0.07280176877975464,0.28851377964019775,0.05093285068869591,-0.09126269072294235,-0.19596605002880096,0.18873731791973114,-0.08748669922351837,-0.08413423597812653,0.0001314410474151373,-0.18515124917030334,-0.1380368322134018,-0.32386890053749084,0.0833786204457283,0.3525375425815582,0.10840814560651779,-0.19769296050071716,0.08412106335163116,-0.08296912163496017,0.014966889284551144,0.11547371745109558,0.10379888862371445,-0.02322724461555481,0.06027744337916374,-0.0682249441742897,0.07409486174583435,0.15300379693508148,-0.0627078264951706,-0.06380747258663177,0.1669052094221115,-0.04705122113227844,0.058138418942689896,0.02371586672961712,-0.016026778146624565,-0.032301127910614014,0.1065593808889389,-0.12851408123970032,0.03266611322760582,0.10624714940786362,0.026950541883707047,0.03453933075070381,0.14394192397594452,-0.12904873490333557,0.1081543117761612,0.014689524658024311,0.023483730852603912,0.009002866223454475,0.01011862512677908,-0.14184139668941498,-0.11973253637552261,0.1353735327720642,-0.20790128409862518,0.18438582122325897,0.1347605288028717,0.04872119799256325,0.09988512843847275,0.12625034153461456,0.10158726572990417,0.012160200625658035,-0.023672763258218765,-0.23639695346355438,0.02008027769625187,0.1437205970287323,0.010098547674715519,0.11008986830711365,0.028911923989653587]','2026-09-10 10:34:15','2026-09-10 10:34:15'),(7,8,'24-104205','BSIT','3rd Year','A',1,'[-0.13593363761901855,0.07778944820165634,0.026515144854784012,-0.05770858749747276,0.014414538629353046,-0.13828803598880768,-0.02501467801630497,-0.1648983210325241,0.1277725249528885,-0.04695498198270798,0.3004470765590668,-0.06961280107498169,-0.15261514484882355,-0.1790631264448166,-0.012267835438251495,0.17364300787448883,-0.2117922455072403,-0.10523475706577301,-0.08717882633209229,-0.045582450926303864,0.07398489117622375,-0.05963621661067009,-0.023677442222833633,0.10776183754205704,-0.10830941796302795,-0.2673666775226593,-0.08883842825889587,-0.0629098042845726,0.11312966793775558,-0.05870429426431656,-0.07895972579717636,-0.0170382522046566,-0.24443019926548004,-0.0952085554599762,0.02322433330118656,0.07150596380233765,-0.0059258705005049706,-0.08293525129556656,0.19194312393665314,-0.04750446230173111,-0.19309774041175842,-0.02944951131939888,0.06126829981803894,0.23373402655124664,0.2315807342529297,-0.019171694293618202,0.03689824044704437,-0.11984357982873917,0.1187777891755104,-0.11377549916505814,-0.007548768073320389,0.16962595283985138,0.14123909175395966,0.10192640125751495,-0.0600101463496685,-0.13763244450092316,-0.01624760776758194,0.1539018750190735,-0.12510089576244354,0.022993016988039017,0.08528247475624084,-0.10067947208881378,-0.05058646947145462,-0.07504608482122421,0.23964916169643402,0.03950582072138786,-0.18439124524593353,-0.16649982333183289,0.1388292908668518,-0.11551554501056671,-0.022893710061907768,0.04199037700891495,-0.15948201715946198,-0.20746354758739471,-0.3304603695869446,0.057975884526968,0.34069937467575073,0.10191388428211212,-0.23350398242473602,0.05831334367394447,-0.13607440888881683,0.0038543627597391605,0.1090087741613388,0.1496792584657669,0.0029649671632796526,0.07739932090044022,-0.08707355707883835,0.02606477588415146,0.20588697493076324,-0.046113915741443634,0.01716279238462448,0.19934947788715363,-0.03388691693544388,0.04918147251009941,-0.03064032271504402,0.020313860848546028,-0.08072587102651596,0.03792101517319679,-0.09027399867773056,0.011715268716216087,0.036667052656412125,0.004305901937186718,0.06355120986700058,0.10823556780815125,-0.10861624777317047,0.14286085963249207,0.08071194589138031,0.07653898000717163,0.007380821742117405,-0.01907329075038433,-0.061408545821905136,-0.1182752251625061,0.09062260389328003,-0.19236813485622406,0.2428048700094223,0.17446500062942505,0.1081070601940155,0.1150127649307251,0.10635145008563995,0.09900590032339096,0.008823894895613194,-0.0017689935630187392,-0.13067935407161713,0.04934580251574516,0.07387091964483261,-0.04651143401861191,0.1336851418018341,-0.020776066929101944]','2026-09-10 11:32:13','2026-09-10 11:32:13');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(30) NOT NULL,
  `subject_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `instructor` varchar(150) NOT NULL,
  `room` varchar(50) NOT NULL,
  `day` varchar(50) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `semester` varchar(20) NOT NULL DEFAULT '1st Semester',
  `school_year` varchar(30) NOT NULL DEFAULT '2026-2027',
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_code` (`subject_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (5,'IT16','System Administration and Maintenace','System Creation','Jennifer','301','Tuesday','10:00:00','11:30:00','1st Semester','2026-2027','active','2026-09-10 09:37:10');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','student') NOT NULL DEFAULT 'student',
  `course` varchar(100) DEFAULT NULL,
  `year_level` varchar(20) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT 'default_avatar.png',
  `face_registered` tinyint(1) DEFAULT 0,
  `must_change_password` tinyint(1) DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'System','Super','Administrator','admin@smartface.edu','admin','$2y$12$jnnofBJLEib3p1vtOacTX.9hCohsMyYwxpwp5mqKudV0cEK.x4aea','admin',NULL,NULL,NULL,NULL,'default_avatar.png',0,1,'active','2026-09-09 10:34:11','2026-09-09 10:34:11'),(6,'24-104174','Sherwin','Geronimo','Baylen','ewwinbaylen@gamail.com','ewwin','$2y$10$5fDczzulX7WcAKERA64f7un8nEXT3VLlgdBaKOWP24juxNLh1eHpC','student','BSIT','3rd Year','A','09614716691','default_avatar.png',1,0,'active','2026-09-10 10:13:14','2026-09-10 10:13:14'),(7,'24-104083','Christian jay','Balagasay','Malana','jaymalana@gmail.com','jay','$2y$10$ai5SBKNcjxblAi2IZyCyzexewOTT9aeOVGVnLlmxQFkpSV5FzImB6','student','BSIT','3rd Year','A','09614716691','default_avatar.png',1,0,'active','2026-09-10 10:34:15','2026-09-10 10:34:15'),(8,'24-104205','Jerrecson','Besin','Oligo','jerrecsonoligo25@gmail.com','Jeric','$2y$10$GVTf.8hYCDkWa6ie87hbL.DVudqN8JI5J4B.jLONr.n2JZOcyrpIG','student','BSIT','3rd Year','A','09683942273','default_avatar.png',1,0,'active','2026-09-10 11:32:13','2026-09-10 11:32:13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-14 19:43:12
