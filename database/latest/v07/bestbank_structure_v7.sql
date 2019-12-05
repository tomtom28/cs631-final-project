CREATE DATABASE  IF NOT EXISTS `bestbank` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bestbank`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: bestbank
-- ------------------------------------------------------
-- Server version	5.7.16

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `balance` double NOT NULL,
  `last_accessed` date NOT NULL,
  `branch_name` varchar(45) NOT NULL,
  PRIMARY KEY (`account_no`),
  KEY `account_branch_name_idx` (`branch_name`),
  CONSTRAINT `account_branch_name` FOREIGN KEY (`branch_name`) REFERENCES `branch` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100000005 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checking_account` (
  `account_no` int(11) NOT NULL,
  `overdraft` double NOT NULL,
  PRIMARY KEY (`account_no`),
  CONSTRAINT `checking_account_no` FOREIGN KEY (`account_no`) REFERENCES `account` (`account_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `customers_banker`
--

DROP TABLE IF EXISTS `customers_banker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_banker` (
  `customer_ssn` varchar(11) NOT NULL,
  `employee_ssn` varchar(11) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_ssn`,`employee_ssn`),
  CONSTRAINT `cb_customer_ssn` FOREIGN KEY (`customer_ssn`) REFERENCES `customer` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependent` (
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `employee_ssn` varchar(11) NOT NULL,
  PRIMARY KEY (`last_name`,`first_name`),
  KEY `dependent_employee_ssn_idx` (`employee_ssn`),
  CONSTRAINT `dependent_employee_ssn` FOREIGN KEY (`employee_ssn`) REFERENCES `employee` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `ssn` varchar(11) NOT NULL,
  `manager_ssn` varchar(11) NOT NULL,
  `start_date` date NOT NULL,
  `employment_length_years` int(11) GENERATED ALWAYS AS ((2019 - year(`start_date`))) VIRTUAL,
  `phone_no` varchar(45) NOT NULL,
  `branch_name` varchar(45) NOT NULL,
  `position` varchar(45) NOT NULL,
  PRIMARY KEY (`ssn`),
  KEY `employee_branch_name_idx` (`branch_name`),
  CONSTRAINT `employee_branch_name` FOREIGN KEY (`branch_name`) REFERENCES `branch` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `has_account`
--

DROP TABLE IF EXISTS `has_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `has_account` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `ssn` varchar(11) NOT NULL,
  PRIMARY KEY (`account_no`,`ssn`),
  KEY `has_account_customer_ssn_idx` (`ssn`),
  CONSTRAINT `has_account_account_no` FOREIGN KEY (`account_no`) REFERENCES `account` (`account_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `has_account_customer_ssn` FOREIGN KEY (`ssn`) REFERENCES `customer` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100000005 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `has_loan`
--

DROP TABLE IF EXISTS `has_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `has_loan` (
  `loan_no` int(11) NOT NULL,
  `ssn` varchar(11) NOT NULL,
  PRIMARY KEY (`loan_no`,`ssn`),
  KEY `ssn_idx` (`ssn`),
  CONSTRAINT `has_loan_loan_no` FOREIGN KEY (`loan_no`) REFERENCES `loan` (`loan_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `has_loan_ssn` FOREIGN KEY (`ssn`) REFERENCES `customer` (`ssn`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan` (
  `loan_no` int(11) NOT NULL AUTO_INCREMENT,
  `loan_amount` double NOT NULL,
  `description` varchar(45) NOT NULL,
  `date_taken` date NOT NULL,
  PRIMARY KEY (`loan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=200000004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan_payment`
--

DROP TABLE IF EXISTS `loan_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan_payment` (
  `payment_no` int(11) NOT NULL AUTO_INCREMENT,
  `loan_no` int(11) NOT NULL,
  `payment_amount` double NOT NULL,
  `payment_date` date NOT NULL,
  PRIMARY KEY (`payment_no`,`loan_no`),
  KEY `payment_loan_no_idx` (`loan_no`),
  CONSTRAINT `payment_loan_no` FOREIGN KEY (`loan_no`) REFERENCES `loan` (`loan_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `savings_account`
--

DROP TABLE IF EXISTS `savings_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savings_account` (
  `account_no` int(11) NOT NULL,
  `interest_rate` double NOT NULL,
  PRIMARY KEY (`account_no`),
  CONSTRAINT `savings_account_no` FOREIGN KEY (`account_no`) REFERENCES `account` (`account_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `record_no` int(11) NOT NULL AUTO_INCREMENT,
  `account_no` int(11) NOT NULL,
  `transaction_code` varchar(2) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`record_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_type`
--

DROP TABLE IF EXISTS `transaction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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

-- Dump completed on 2019-12-04 23:20:10
