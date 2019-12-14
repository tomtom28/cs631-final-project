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
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (100000000,1243785.35,'2019-12-07','Rockerfeller Bank'),(100000001,46695.5,'2019-12-06','Oakmont Bank'),(100000002,35846,'2019-12-05','Sun Bank'),(100000003,-105.99,'2019-12-07','Oakmont Bank'),(100000004,8996,'2019-10-04','Rockerfeller Bank');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('Oakmont Bank','Edison','-108796.44'),('Rockerfeller Bank','Newark','1250389.35'),('Sun Bank','Trenton','25850');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `charge_account`
--

LOCK TABLES `charge_account` WRITE;
/*!40000 ALTER TABLE `charge_account` DISABLE KEYS */;
INSERT INTO `charge_account` VALUES ('Oakmont Bank',8),('Rockerfeller Bank',8),('Sun Bank',4);
/*!40000 ALTER TABLE `charge_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `checking_account`
--

LOCK TABLES `checking_account` WRITE;
/*!40000 ALTER TABLE `checking_account` DISABLE KEYS */;
INSERT INTO `checking_account` VALUES (100000000,0),(100000001,0),(100000002,0),(100000003,500);
/*!40000 ALTER TABLE `checking_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('111-22-3456','Larry','Ellison',NULL,'1010 Oracle Lane','Palo Alto','90511','California'),('246-00-8888','Thomas','Thompson',NULL,'3 Grove PL','El Dorado','95721','California'),('468-34-2156','Vincent','Oria',NULL,'1600 Pennsylvania Ave','Washington','48632','Washington, DC'),('672-74-3690','Spencer','Escalante',NULL,'23 Gold Rd','Princeton','75315','New Jersey');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customers_banker`
--

LOCK TABLES `customers_banker` WRITE;
/*!40000 ALTER TABLE `customers_banker` DISABLE KEYS */;
INSERT INTO `customers_banker` VALUES ('246-00-8888','229-64-2379','Loan Officer'),('246-00-8888','568-25-9825','Personal Banker'),('468-34-2156','678-95-1374','Personal Banker'),('672-74-3690','112-98-1507','Loan Officer'),('672-74-3690','568-25-9825','Personal Banker');
/*!40000 ALTER TABLE `customers_banker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('Young','Michael','112-98-1507'),('Richman','Jenny','999-88-7777'),('Richman','Johnny','999-88-7777');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`ssn`, `first_name`, `last_name`, `position`, `phone_no`, `start_date`, `branch_name`, `manager_ssn`) VALUES ('112-98-1507','Michelle','Young','Customer Rep','846-234-5891','2017-02-15','Oakmont Bank','227-65-3915'),('227-65-3915','John','Johnson','Manager','222-867-5309','2006-10-11','Oakmont Bank','999-88-7777'),('229-64-2379','Claire','Stevens','Customer Rep','202-467-9273','2012-01-05','Rockerfeller Bank','321-68-9764'),('321-68-9764','Jen','Williams','Manager','343-500-1264','2002-12-17','Rockerfeller Bank','999-88-7777'),('568-25-9875','Roy','Smith','Customer Rep','732-555-9845','2010-08-05','Sun Bank','659-98-7533'),('659-98-7533','Leroy','Jones','Manager','647-569-3486','2005-04-13','Sun Bank','999-88-7777'),('678-95-1374','Arnold','Miller','Customer Rep','846-234-6671','2018-06-07','Oakmont Bank','227-65-3915'),('999-88-7777','Richard','Richman','CEO','647-318-2264','2000-01-01','Rockerfeller Bank','999-88-7777');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `has_account`
--

LOCK TABLES `has_account` WRITE;
/*!40000 ALTER TABLE `has_account` DISABLE KEYS */;
INSERT INTO `has_account` VALUES (100000002,'246-00-8888'),(100000004,'246-00-8888'),(100000000,'468-34-2156'),(100000001,'672-74-3690'),(100000003,'672-74-3690'),(100000004,'672-74-3690');
/*!40000 ALTER TABLE `has_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `has_loan`
--

LOCK TABLES `has_loan` WRITE;
/*!40000 ALTER TABLE `has_loan` DISABLE KEYS */;
INSERT INTO `has_loan` VALUES (200000001,'246-00-8888'),(200000002,'246-00-8888'),(200000003,'246-00-8888'),(200000000,'672-74-3690'),(200000003,'672-74-3690');
/*!40000 ALTER TABLE `has_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (200000000,150000,'2019-10-09','Spencer Tuition','Oakmont Bank'),(200000001,20000,'2019-04-20','Thomas Tuition','Sun Bank'),(200000002,12000,'2019-07-04','Thomas Car Loan','Rockerfeller Bank'),(200000003,7000,'2019-12-01','Spencer & Thomas Vegas','Oakmont Bank');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan_payment`
--

LOCK TABLES `loan_payment` WRITE;
/*!40000 ALTER TABLE `loan_payment` DISABLE KEYS */;
INSERT INTO `loan_payment` VALUES (1,200000000,1500,'2019-12-01'),(2,200000001,10000,'2019-12-01'),(3,200000002,1000,'2019-12-02'),(4,200000002,1100,'2019-12-03'),(5,200000002,7500,'2019-12-05'),(6,200000000,55.55,'2019-12-06'),(7,200000003,50.5,'2019-12-06');
/*!40000 ALTER TABLE `loan_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `savings_account`
--

LOCK TABLES `savings_account` WRITE;
/*!40000 ALTER TABLE `savings_account` DISABLE KEYS */;
INSERT INTO `savings_account` VALUES (100000004,2.1);
/*!40000 ALTER TABLE `savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,100000000,'BF',1000000,'2019-10-01','10:10 AM'),(2,100000001,'BF',50000,'2019-10-02','11:11 AM'),(3,100000002,'BF',55000,'2019-10-03','12:12 PM'),(4,100000003,'BF',500,'2019-10-04','10:55 AM'),(5,100000004,'BF',9000,'2019-10-04','4:20 PM'),(6,100000000,'CD',250000,'2019-10-05','6:00 PM'),(7,100000003,'WD',777.49,'2019-10-21','11:00 AM'),(8,100000001,'WD',250,'2019-10-21','1:30 PM'),(9,100000000,'SC',2,'2019-11-01','6:00 AM'),(10,100000001,'SC',2,'2019-11-01','6:00 AM'),(11,100000002,'SC',2,'2019-11-01','6:00 AM'),(12,100000003,'SC',2,'2019-11-01','6:00 AM'),(13,100000004,'SC',2,'2019-11-01','6:00 AM'),(14,100000002,'CD',450,'2019-11-02','10:01 AM'),(15,100000000,'WD',5500.55,'2019-11-11','11:11 AM'),(16,100000003,'CD',45.5,'2019-11-28','11:15 AM'),(17,100000003,'CD',30,'2019-11-30','12:37 PM'),(18,100000000,'SC',2,'2019-12-01','6:00 AM'),(19,100000001,'SC',2,'2019-12-01','6:00 AM'),(20,100000002,'SC',2,'2019-12-01','6:00 AM'),(21,100000003,'SC',2,'2019-12-01','6:00 AM'),(22,100000004,'SC',2,'2019-12-01','6:00 AM'),(23,100000000,'WD',610.1,'2019-12-01','7:55 PM'),(24,100000001,'LP',1500,'2019-12-01','9:01 AM'),(25,100000002,'LP',10000,'2019-12-01','10:10 AM'),(26,100000002,'LP',1000,'2019-12-02','11:59 AM'),(27,100000002,'LP',1100,'2019-12-03','3:32 PM'),(28,100000002,'LP',7500,'2019-12-05','09:55 AM'),(29,100000001,'LP',1500,'2019-12-06','11:11 AM'),(30,100000001,'LP',50.5,'2019-12-06','12:12 PM'),(31,100000000,'QW',100,'2019-12-07','1:35 PM'),(32,100000003,'QD',100,'2019-12-07','1:35 PM');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transaction_type`
--

LOCK TABLES `transaction_type` WRITE;
/*!40000 ALTER TABLE `transaction_type` DISABLE KEYS */;
INSERT INTO `transaction_type` VALUES ('BF','Balance Forward',0,'credit'),('CD','Customer Deposit',0,'credit'),('LP','Loan Payment',0,'debit'),('QD','Cheque Deposit',0,'credit'),('QW','Cheque Withdrawal',0,'debit'),('SC','Service Charge',2,'debit'),('WD','Withdrawal',0,'debit');
/*!40000 ALTER TABLE `transaction_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-14  0:19:50
