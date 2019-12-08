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
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (100000000,1244497.45,'2019-11-27','Rockerfeller Bank'),(100000001,49748,'2019-09-02','Oakmont Bank'),(100000002,55448,'2019-11-28','Sun Bank'),(100000003,-203.99,'2019-10-21','Oakmont Bank'),(100000004,8998,'2019-12-02','Rockerfeller Bank');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('Oakmont Bank','Edison',500000),('Rockerfeller Bank','Newark',700000),('Sun Bank','Trenton',400000);
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `checking_account`
--

LOCK TABLES `checking_account` WRITE;
/*!40000 ALTER TABLE `checking_account` DISABLE KEYS */;
INSERT INTO `checking_account` VALUES (100000000,0),(100000001,0),(100000002,0),(100000003,500);
/*!40000 ALTER TABLE `checking_account` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('111-22-3456','Larry','Ellison',NULL,'1010 Oracle Lane','Palo Alto','90511','California'),('246-00-8888','Thomas','Thompson',NULL,'3 Grove PL','El Dorado','95721','California'),('468-34-2156','Vincent','Oria',NULL,'1600 Pennsylvania Ave','Washington','48632','Washington, DC'),('672-74-3690','Spencer','Escalante',NULL,'23 Gold Rd','Princeton','75315','New Jersey');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `customers_banker`
--

LOCK TABLES `customers_banker` WRITE;
/*!40000 ALTER TABLE `customers_banker` DISABLE KEYS */;
INSERT INTO `customers_banker` VALUES ('246-00-8888','229-64-2379','Loan Officer'),('246-00-8888','568-25-9825','Personal Banker'),('468-34-2156','678-95-1374','Personal Banker'),('672-74-3690','112-98-1507','Loan Officer'),('672-74-3690','568-25-9825','Personal Banker');
/*!40000 ALTER TABLE `customers_banker` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('Young','Michael','112-98-1507'),('Richman','Jenny','999-88-7777'),('Richman','Johnny','999-88-7777');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

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
  `phone_no` varchar(45) NOT NULL,
  `branch_name` varchar(45) NOT NULL,
  `position` varchar(45) NOT NULL,
  `years_employed` int(3) GENERATED ALWAYS AS ((2019 - year(`start_date`))) VIRTUAL,
  PRIMARY KEY (`ssn`),
  KEY `employee_branch_name_idx` (`branch_name`),
  CONSTRAINT `employee_branch_name` FOREIGN KEY (`branch_name`) REFERENCES `branch` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`ssn`, `manager_ssn`, `start_date`, `phone_no`, `branch_name`, `position`) VALUES ('112-98-1507','227-65-3915','2017-02-15','846-234-5891','Oakmont Bank','Customer Rep'),('227-65-3915','999-88-7777','2006-10-11','222-867-5309','Oakmont Bank','Manager'),('229-64-2379','321-68-9764','2012-01-05','202-467-9273','Rockerfeller Bank','Customer Rep'),('321-68-9764','999-88-7777','2002-12-17','343-500-1264','Rockerfeller Bank','Manager'),('568-25-9875','659-98-7533','2010-08-05','732-555-9845','Sun Bank','Customer Rep'),('659-98-7533','999-88-7777','2005-04-13','647-569-3486','Sun Bank','Manager'),('678-95-1374','227-65-3915','2018-06-07','846-234-6671','Oakmont Bank','Customer Rep'),('999-88-7777','999-88-7777','2000-01-01','647-318-2264','Rockerfeller Bank','CEO');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `has_account`
--

LOCK TABLES `has_account` WRITE;
/*!40000 ALTER TABLE `has_account` DISABLE KEYS */;
INSERT INTO `has_account` VALUES (100000002,'246-00-8888'),(100000004,'246-00-8888'),(100000000,'468-34-2156'),(100000001,'672-74-3690'),(100000003,'672-74-3690'),(100000004,'672-74-3690');
/*!40000 ALTER TABLE `has_account` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `has_loan`
--

LOCK TABLES `has_loan` WRITE;
/*!40000 ALTER TABLE `has_loan` DISABLE KEYS */;
INSERT INTO `has_loan` VALUES (200000001,'246-00-8888'),(200000002,'246-00-8888'),(200000003,'246-00-8888'),(200000000,'672-74-3690'),(200000003,'672-74-3690');
/*!40000 ALTER TABLE `has_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan` (
  `loan_no` int(11) NOT NULL AUTO_INCREMENT,
  `loan_amount` double NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `date_taken` date NOT NULL,
  PRIMARY KEY (`loan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=200000004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (200000000,150000,'Spencer Tuition','2019-10-09'),(200000001,20000,'Thomas Tuition','2019-04-20'),(200000002,12000,'Thomas Car Loan','2019-07-04'),(200000003,7000,'Spencer & Thomas Vegas','2019-12-01');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `loan_payment`
--

LOCK TABLES `loan_payment` WRITE;
/*!40000 ALTER TABLE `loan_payment` DISABLE KEYS */;
INSERT INTO `loan_payment` VALUES (1,200000000,1500,'2019-11-01'),(2,200000001,10000,'2019-11-05'),(3,200000002,1000,'2019-11-15'),(4,200000002,1100,'2019-11-29'),(5,200000002,7500,'2019-12-02'),(6,200000001,55.55,'2019-12-05');
/*!40000 ALTER TABLE `loan_payment` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `savings_account`
--

LOCK TABLES `savings_account` WRITE;
/*!40000 ALTER TABLE `savings_account` DISABLE KEYS */;
INSERT INTO `savings_account` VALUES (100000004,2.1);
/*!40000 ALTER TABLE `savings_account` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,100000000,'BF','2019-10-01','10:10 AM',1000000),(2,100000001,'BF','2019-10-02','11:11 AM',50000),(3,100000002,'BF','2019-10-03','12:12 PM',55000),(4,100000003,'BF','2019-10-04','10:55 AM',500),(5,100000004,'BF','2019-10-04','04:20 PM',9000),(6,100000000,'CD','2019-10-05','6:00 PM',250000),(7,100000003,'WD','2019-10-21','11:00 AM',777.49),(8,100000001,'WD','2019-10-21','1:30 PM',250),(9,100000000,'SC','2019-11-01','6:00 AM',2),(10,100000001,'SC','2019-11-01','6:00 AM',2),(11,100000002,'SC','2019-11-01','6:00 AM',2),(12,100000003,'SC','2019-11-01','6:00 AM',2),(13,100000004,'SC','2019-11-01','6:00 AM',2),(14,100000002,'CD','2019-11-02','10:01 AM',450),(15,100000000,'WD','2019-11-11','11:11 AM',5500.55),(16,100000003,'CD','2019-12-01','11:15 AM',45.5),(17,100000003,'CD','2019-12-02','12:15 PM',30);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_account_balance 
AFTER INSERT ON transaction 
FOR EACH ROW
	UPDATE account a
	SET balance = (	SELECT sum(credit) - sum(debit)
					FROM account_passbooks ap
					WHERE ap.account_no = NEW.account_no)
	WHERE a.account_no = NEW.account_no */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transaction_type`
--

DROP TABLE IF EXISTS `transaction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_type` (
  `transaction_code` varchar(2) NOT NULL,
  `transaction_name` varchar(45) NOT NULL,
  `charge` double NOT NULL,
  `classification` varchar(15) NOT NULL,
  PRIMARY KEY (`transaction_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_type`
--

LOCK TABLES `transaction_type` WRITE;
/*!40000 ALTER TABLE `transaction_type` DISABLE KEYS */;
INSERT INTO `transaction_type` VALUES ('BF','Balance Forward',0,'credit'),('CD','Customer Deposit',0,'credit'),('LP','Loan Payment',0,'debit'),('SC','Service Charge',2,'debit'),('WD','Withdrawal',0,'debit');
/*!40000 ALTER TABLE `transaction_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bestbank'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `update_length_employment` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = '-05:00' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `update_length_employment` ON SCHEDULE EVERY 1 YEAR STARTS '2018-01-01 00:00:00' ON COMPLETION PRESERVE ENABLE DO ALTER TABLE employee
	CHANGE COLUMN years_employed years_employed INT(3) GENERATED ALWAYS AS ((YEAR(CURDATE()) - year(`start_date`))) VIRTUAL */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-07 16:41:44
