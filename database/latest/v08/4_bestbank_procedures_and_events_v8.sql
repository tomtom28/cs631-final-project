-- BEST BANK DATABASE EVENTS & PROCEDURES
USE bestbank;


-- Do some clean up:
DROP EVENT IF EXISTS `update_employment_length`;
DROP EVENT IF EXISTS `apply_monthly_service_charge`;
DROP PROCEDURE IF EXISTS `update_employee_years_employed`;
DROP PROCEDURE IF EXISTS `apply_service_charge_to_all_accounts`;



-- Enable the event scheduler
SET GLOBAL event_scheduler = ON;


-- Event & Procedure (Part 1)
-- Updates the years_employed for each Employee on Jan 1st of every year.

-- (1a) Creates procedure to update employee years_employed
DELIMITER ;;
CREATE PROCEDURE update_employee_years_employed()
BEGIN
	ALTER TABLE employee
	CHANGE COLUMN years_employed years_employed INT(3) GENERATED ALWAYS AS ((YEAR(CURDATE()) - year(`start_date`))) VIRTUAL;
END;;
DELIMITER ;

-- (1b) Calls the procedure on Jan 1st every year
CREATE EVENT update_employment_length
ON SCHEDULE
    EVERY 1 YEAR
    STARTS '2020-01-01 00:00:00'
    ON COMPLETION PRESERVE
DO
	CALL update_employee_years_employed();
    



-- Event & Procedure (Part 2)
-- Applies a service charge to every account, at the 1st of each month.

-- (2a) Create procedure to apply service charges to all (customer) accounts
DELIMITER ;;
CREATE PROCEDURE apply_service_charge_to_all_accounts()
BEGIN
	DECLARE n INT DEFAULT 0; -- total # of accounts
    DECLARE i INT DEFAULT 0; -- initial iterator value
    DECLARE service_charge DOUBLE DEFAULT 0.0; -- current service charge amount
    DECLARE todays_date DATE DEFAULT NULL; -- current date
    DECLARE current_account_no INT DEFAULT 0; -- account_no (determined during iterations)
    
    SET i = 0;
    SELECT COUNT(*) FROM `account` INTO n;
    SELECT charge FROM transaction_type WHERE transaction_code = 'SC' INTO service_charge;
	SELECT CURDATE() INTO todays_date;
    
    -- Iterate over all account tuples and insert service charge into transaction table
    WHILE i < n DO
		SELECT account_no FROM `account` ORDER BY account_no LIMIT i,1 INTO current_account_no;
		INSERT INTO transaction(account_no, transaction_code, `date`, `time`, `amount`) 
        VALUES (current_account_no, 'SC', todays_date, '6:00 AM', service_charge);
        SET i = i + 1;
	END WHILE;
END;;
DELIMITER ;

-- (2b) Calls the procedure on the 1st of every month (at 6:00 AM)
CREATE EVENT apply_monthly_service_charge
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2020-01-01 00:06:00'
    ON COMPLETION PRESERVE
DO
	CALL apply_service_charge_to_all_accounts();
