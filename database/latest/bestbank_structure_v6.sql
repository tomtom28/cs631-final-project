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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `balance` double NOT NULL,
  `last_accessed` date NOT NULL,
  `branch_name` varchar(45) NOT NULL,
  PRIMARY KEY (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100000004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `assets` double NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checking_account`
--

DROP TABLE IF EXISTS `checking_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checking_account` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `overdraft` double NOT NULL,
  PRIMARY KEY (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100000003 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `ssn` varchar(11) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `apt_no` int(11) DEFAULT NULL,
  `street_no` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `zip_code` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers banker`
--

DROP TABLE IF EXISTS `customers banker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers banker` (
  `customer_ssn` varchar(11) NOT NULL,
  `employee_ssn` varchar(11) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_ssn`,`employee_ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependent` (
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `ssn` varchar(11) NOT NULL,
  PRIMARY KEY (`last_name`,`first_name`),
  UNIQUE KEY `ssn_UNIQUE` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `ssn` varchar(11) NOT NULL,
  `manager_ssn` varchar(11) NOT NULL,
  `start_date` date NOT NULL,
  `employment_length` int(11) GENERATED ALWAYS AS ((2019 - year(`start_date`))) VIRTUAL,
  `phone_no` varchar(45) NOT NULL,
  `branch_name` varchar(45) NOT NULL,
  `position` varchar(45) NOT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `has_account`
--

DROP TABLE IF EXISTS `has_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_account` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `ssn` varchar(11) NOT NULL,
  PRIMARY KEY (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100000004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `has_loan`
--

DROP TABLE IF EXISTS `has_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_loan` (
  `loan_no` int(11) NOT NULL,
  `ssn` varchar(45) NOT NULL,
  PRIMARY KEY (`loan_no`,`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_no` int(11) NOT NULL AUTO_INCREMENT,
  `loan_amnt` double NOT NULL,
  `name` varchar(45) NOT NULL,
  `date_taken` date NOT NULL,
  PRIMARY KEY (`loan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=345783652 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan_payment`
--

DROP TABLE IF EXISTS `loan_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_payment` (
  `payment_no` int(11) NOT NULL AUTO_INCREMENT,
  `loan_no` int(11) NOT NULL,
  `amount` double NOT NULL,
  `payment_date` date NOT NULL,
  PRIMARY KEY (`payment_no`,`loan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100000002 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saving_account`
--

DROP TABLE IF EXISTS `saving_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saving_account` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `intrest_rate` double NOT NULL,
  PRIMARY KEY (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100000004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `record_no` int(11) NOT NULL AUTO_INCREMENT,
  `account_no` int(11) NOT NULL,
  `transaction_code` varchar(2) NOT NULL,
  `date` date NOT NULL,
  `transaction_time` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`record_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100000007 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_type`
--

DROP TABLE IF EXISTS `transaction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_type` (
  `transaction_code` varchar(2) NOT NULL,
  `transaction_type` varchar(45) NOT NULL,
  `charge` double NOT NULL,
  PRIMARY KEY (`transaction_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-03 22:59:14
