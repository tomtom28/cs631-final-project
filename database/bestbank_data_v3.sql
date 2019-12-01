-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bestbank
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('100000000',100000000,'2019-11-27',NULL,NULL),('100000001',500000,'2019-09-02',NULL,NULL),('100000002',500000,'2019-11-28',NULL,NULL);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('Frank\'s Bank','Edison',500000),('Joe\'s Bank','Newark',700000),('John\'s Bank','Trenton',400000);
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('468-34-2156','Vincent','Oria',NULL,'1600 Pennsylvania Ave','Washington','48632','DC'),('672-74-3690','Spencer','Escalante',NULL,'23 Gold Rd','Princeton','75315','NJ'),('682-51-3593','Thomas','Thompson',NULL,'3 Grove PL','Edison','95761','NJ');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customers banker`
--

LOCK TABLES `customers banker` WRITE;
/*!40000 ALTER TABLE `customers banker` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers banker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('Thompson','Jenny','658-93-004');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('112-98-1507','227-65-3915','2017-02-17','2 Years','846-234-5891','Frank\'s Bank'),('229-64-2379','321-68-9764','2012-01-05','7 Years','202-467-9273','Joe\'s Bank'),('568-25-9875','659-98-7533','2000-08-05','19 Years','732-555-9845','John\'s Bank'),('678-95-1374','227-65-3915','2018-06-07','1 Year','846-234-6671','Frank\'s Bank');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `has_account`
--

LOCK TABLES `has_account` WRITE;
/*!40000 ALTER TABLE `has_account` DISABLE KEYS */;
INSERT INTO `has_account` VALUES ('468-34-2156','100000000'),('672-74-3690','100000001'),('682-51-3593','100000002');
/*!40000 ALTER TABLE `has_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `has_loan`
--

LOCK TABLES `has_loan` WRITE;
/*!40000 ALTER TABLE `has_loan` DISABLE KEYS */;
INSERT INTO `has_loan` VALUES (226548329,'672-74-3690'),(345783651,'682-51-3593');
/*!40000 ALTER TABLE `has_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (226548329,150000,'Spencer Tuition'),(345783651,20000,'Thomas Tuition');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan_payment`
--

LOCK TABLES `loan_payment` WRITE;
/*!40000 ALTER TABLE `loan_payment` DISABLE KEYS */;
INSERT INTO `loan_payment` VALUES ('10000000000','226548329','1500','2019-11-26'),('10000000001','345783651','10000','2019-11-01');
/*!40000 ALTER TABLE `loan_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES ('DE','Deposit',100000000);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-01  3:43:53
