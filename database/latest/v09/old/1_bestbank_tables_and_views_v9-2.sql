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
-- Temporary view structure for view `account_credits`
--

DROP TABLE IF EXISTS `account_credits`;
/*!50001 DROP VIEW IF EXISTS `account_credits`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `account_credits` AS SELECT 
 1 AS `record_no`,
 1 AS `account_no`,
 1 AS `credit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `account_debits`
--

DROP TABLE IF EXISTS `account_debits`;
/*!50001 DROP VIEW IF EXISTS `account_debits`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `account_debits` AS SELECT 
 1 AS `record_no`,
 1 AS `account_no`,
 1 AS `debit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `account_passbooks`
--

DROP TABLE IF EXISTS `account_passbooks`;
/*!50001 DROP VIEW IF EXISTS `account_passbooks`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `account_passbooks` AS SELECT 
 1 AS `record_no`,
 1 AS `account_no`,
 1 AS `date`,
 1 AS `transaction_code`,
 1 AS `transaction_name`,
 1 AS `debit`,
 1 AS `credit`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `Assets` varchar(45) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `branch_asset_overview`
--

DROP TABLE IF EXISTS `branch_asset_overview`;
/*!50001 DROP VIEW IF EXISTS `branch_asset_overview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `branch_asset_overview` AS SELECT 
 1 AS `branch_name`,
 1 AS `charge_account_balance`,
 1 AS `total_balance_of_customer_accounts`,
 1 AS `total_of_loan_principals`,
 1 AS `total_of_loan_payments`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `branch_asset_total`
--

DROP TABLE IF EXISTS `branch_asset_total`;
/*!50001 DROP VIEW IF EXISTS `branch_asset_total`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `branch_asset_total` AS SELECT 
 1 AS `branch_name`,
 1 AS `total_assets`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `branch_charge_account`
--

DROP TABLE IF EXISTS `branch_charge_account`;
/*!50001 DROP VIEW IF EXISTS `branch_charge_account`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `branch_charge_account` AS SELECT 
 1 AS `branch_name`,
 1 AS `charge_account_balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `charge_account`
--

DROP TABLE IF EXISTS `charge_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_account` (
  `branch_name` varchar(45) NOT NULL,
  `balance` double NOT NULL,
  PRIMARY KEY (`branch_name`)
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
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `position` varchar(45) NOT NULL,
  `phone_no` varchar(45) NOT NULL,
  `start_date` date NOT NULL,
  `years_employed` int(3) GENERATED ALWAYS AS ((2019 - year(`start_date`))) VIRTUAL,
  `branch_name` varchar(45) NOT NULL,
  `manager_ssn` varchar(11) NOT NULL,
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
  `date_taken` date NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `branch_name` varchar(45) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
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
-- Temporary view structure for view `total_balance_of_customer_accounts_by_branch`
--

DROP TABLE IF EXISTS `total_balance_of_customer_accounts_by_branch`;
/*!50001 DROP VIEW IF EXISTS `total_balance_of_customer_accounts_by_branch`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `total_balance_of_customer_accounts_by_branch` AS SELECT 
 1 AS `branch_name`,
 1 AS `total_balance_of_customer_accounts`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_loan_amounts_by_branch`
--

DROP TABLE IF EXISTS `total_loan_amounts_by_branch`;
/*!50001 DROP VIEW IF EXISTS `total_loan_amounts_by_branch`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `total_loan_amounts_by_branch` AS SELECT 
 1 AS `branch_name`,
 1 AS `total_of_loan_principals`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_loan_payments_by_branch`
--

DROP TABLE IF EXISTS `total_loan_payments_by_branch`;
/*!50001 DROP VIEW IF EXISTS `total_loan_payments_by_branch`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `total_loan_payments_by_branch` AS SELECT 
 1 AS `branch_name`,
 1 AS `total_of_loan_payments`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_payments_by_loan`
--

DROP TABLE IF EXISTS `total_payments_by_loan`;
/*!50001 DROP VIEW IF EXISTS `total_payments_by_loan`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `total_payments_by_loan` AS SELECT 
 1 AS `loan_no`,
 1 AS `loan_payment_total`*/;
SET character_set_client = @saved_cs_client;

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
  `amount` double NOT NULL,
  `date` date NOT NULL,
  `time` varchar(45) NOT NULL,
  PRIMARY KEY (`record_no`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Final view structure for view `account_credits`
--

/*!50001 DROP VIEW IF EXISTS `account_credits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `account_credits` AS select `tc`.`record_no` AS `record_no`,`tc`.`account_no` AS `account_no`,`tc`.`amount` AS `credit` from (`transaction` `tc` join `transaction_type` `ttc`) where ((`tc`.`transaction_code` = `ttc`.`transaction_code`) and (`ttc`.`classification` = 'credit')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `account_debits`
--

/*!50001 DROP VIEW IF EXISTS `account_debits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `account_debits` AS select `td`.`record_no` AS `record_no`,`td`.`account_no` AS `account_no`,`td`.`amount` AS `debit` from (`transaction` `td` join `transaction_type` `ttd`) where ((`td`.`transaction_code` = `ttd`.`transaction_code`) and (`ttd`.`classification` = 'debit')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `account_passbooks`
--

/*!50001 DROP VIEW IF EXISTS `account_passbooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `account_passbooks` AS select `t`.`record_no` AS `record_no`,`t`.`account_no` AS `account_no`,`t`.`date` AS `date`,`t`.`transaction_code` AS `transaction_code`,`tt`.`transaction_name` AS `transaction_name`,`ad`.`debit` AS `debit`,`ac`.`credit` AS `credit` from (((`transaction` `t` left join `account_debits` `ad` on(((`t`.`account_no` = `ad`.`account_no`) and (`t`.`record_no` = `ad`.`record_no`)))) left join `account_credits` `ac` on(((`t`.`account_no` = `ac`.`account_no`) and (`t`.`record_no` = `ac`.`record_no`)))) join `transaction_type` `tt` on((`t`.`transaction_code` = `tt`.`transaction_code`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `branch_asset_overview`
--

/*!50001 DROP VIEW IF EXISTS `branch_asset_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `branch_asset_overview` AS select `branch_charge_account`.`branch_name` AS `branch_name`,`branch_charge_account`.`charge_account_balance` AS `charge_account_balance`,`total_balance_of_customer_accounts_by_branch`.`total_balance_of_customer_accounts` AS `total_balance_of_customer_accounts`,`total_loan_amounts_by_branch`.`total_of_loan_principals` AS `total_of_loan_principals`,`total_loan_payments_by_branch`.`total_of_loan_payments` AS `total_of_loan_payments` from (((`branch_charge_account` join `total_balance_of_customer_accounts_by_branch` on((`branch_charge_account`.`branch_name` = `total_balance_of_customer_accounts_by_branch`.`branch_name`))) join `total_loan_amounts_by_branch` on((`branch_charge_account`.`branch_name` = `total_loan_amounts_by_branch`.`branch_name`))) join `total_loan_payments_by_branch` on((`branch_charge_account`.`branch_name` = `total_loan_payments_by_branch`.`branch_name`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `branch_asset_total`
--

/*!50001 DROP VIEW IF EXISTS `branch_asset_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `branch_asset_total` AS select `bao`.`branch_name` AS `branch_name`,(((`bao`.`charge_account_balance` + `bao`.`total_balance_of_customer_accounts`) + `bao`.`total_of_loan_payments`) - `bao`.`total_of_loan_principals`) AS `total_assets` from `branch_asset_overview` `bao` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `branch_charge_account`
--

/*!50001 DROP VIEW IF EXISTS `branch_charge_account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `branch_charge_account` AS select `a`.`branch_name` AS `branch_name`,sum(`t`.`amount`) AS `charge_account_balance` from (`transaction` `t` join `account` `a`) where ((`a`.`account_no` = `t`.`account_no`) and (`t`.`transaction_code` = 'SC')) group by `a`.`branch_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_balance_of_customer_accounts_by_branch`
--

/*!50001 DROP VIEW IF EXISTS `total_balance_of_customer_accounts_by_branch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_balance_of_customer_accounts_by_branch` AS select `a`.`branch_name` AS `branch_name`,sum(`a`.`balance`) AS `total_balance_of_customer_accounts` from `account` `a` group by `a`.`branch_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_loan_amounts_by_branch`
--

/*!50001 DROP VIEW IF EXISTS `total_loan_amounts_by_branch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_loan_amounts_by_branch` AS select `loan`.`branch_name` AS `branch_name`,sum(`loan`.`loan_amount`) AS `total_of_loan_principals` from `loan` group by `loan`.`branch_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_loan_payments_by_branch`
--

/*!50001 DROP VIEW IF EXISTS `total_loan_payments_by_branch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_loan_payments_by_branch` AS select `l`.`branch_name` AS `branch_name`,sum(`tpl`.`loan_payment_total`) AS `total_of_loan_payments` from (`total_payments_by_loan` `tpl` join `loan` `l`) where (`l`.`loan_no` = `tpl`.`loan_no`) group by `l`.`branch_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_payments_by_loan`
--

/*!50001 DROP VIEW IF EXISTS `total_payments_by_loan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_payments_by_loan` AS select `lp`.`loan_no` AS `loan_no`,sum(`lp`.`payment_amount`) AS `loan_payment_total` from `loan_payment` `lp` group by `lp`.`loan_no` */;
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

-- Dump completed on 2019-12-11 23:30:01
