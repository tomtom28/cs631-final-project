-- BEST BANK DATABASE EVENTS & PROCEDURES
USE bestbank;


-- Do some clean up:
DROP EVENT IF EXISTS `update_employment_length`;
DROP EVENT IF EXISTS `apply_monthly_service_charge`;
DROP EVENT IF EXISTS `update_branch_charge_accounts`;
DROP EVENT IF EXISTS `update_branch_assets`;
DROP PROCEDURE IF EXISTS `update_employee_years_employed`;
DROP PROCEDURE IF EXISTS `apply_service_charge_to_all_accounts`;
DROP PROCEDURE IF EXISTS `update_branch_charge_account_balance`;
DROP PROCEDURE IF EXISTS `update_branch_total_assets`;



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
DELIMITER ;;
CREATE EVENT apply_monthly_service_charge
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2020-01-01 06:00:00'
    ON COMPLETION PRESERVE
DO
	CALL apply_service_charge_to_all_accounts();
    




-- Event & Procedure (Part 3)
-- Updates Charge Account balance each day at 6:00 PM

-- (3a) Create procedure to query the branch_charge_account view & add its info to the Charge Account table
DELIMITER ;;
CREATE PROCEDURE update_branch_charge_account_balance()
BEGIN
	-- Turn off Safe Mode
    SET SQL_SAFE_UPDATES = 0;
	-- Delete all data in the Charge Account table
    DELETE FROM charge_account;
    -- Insert all new data from the Branch Charge Account view into the Charge Account table
    INSERT INTO charge_account
	SELECT * FROM branch_charge_account;
    -- Turn Safe Mode back on
    SET SQL_SAFE_UPDATES = 1;
    
END;;
DELIMITER ;
    
 -- (3b) Calls the procedure at the end of each day (at 6:00 PM)
DELIMITER ;;
CREATE EVENT update_branch_charge_accounts
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2020-01-01 18:00:00'
    ON COMPLETION PRESERVE
DO
	CALL update_branch_charge_account_balance();   
    
    
    
    
-- Event & Procedure (Part 4)
-- Updates Branch assets each day at 6:15 PM

-- (4a) Create procedure to query the branch_asset_total view & add its asset totals to the Branch table
DELIMITER ;;
CREATE PROCEDURE update_branch_total_assets()
BEGIN
	UPDATE branch, branch_asset_total
	SET branch.assets = branch_asset_total.total_assets
	WHERE branch.`name` = branch_asset_total.`branch_name`;
END;;
DELIMITER ;


 -- (4b) Calls the procedure at the end of each day (at 6:15 PM)
 -- Always be sure that this event is schedule to run after the 
 -- update_branch_charge_accounts event (currently set to 6:00 PM)
DELIMITER ;;
CREATE EVENT update_branch_assets
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2020-01-01 18:15:00'
    ON COMPLETION PRESERVE
DO
	CALL update_branch_total_assets();   
