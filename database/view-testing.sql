use bestbank;

SET GLOBAL time_zone = '-5:00';

CREATE TABLE account(
account_no INTEGER AUTO_INCREMENT PRIMARY KEY,
balance DOUBLE);
ALTER TABLE account AUTO_INCREMENT = 100000000;
INSERT INTO account(balance)
VALUES (5500.00),
(8870.99),
(105702.37);
CREATE TABLE passbook(
account_no INTEGER,
transaction_date DATE,
transaction_code VARCHAR(5),
transaction_name VARCHAR(50),
debit DOUBLE,
credit DOUBLE
);
INSERT INTO passbook(account_no, transaction_date, transaction_code, transaction_name, debit, credit)
VALUES (100000000, '2019-10-01', 'WD', 'Withdrawal', 800.00, 0.00),
(100000000, '2019-10-02', 'SC', 'Service Charge', 2.00, 0.00),
(100000000, '2019-10-03', 'CD', 'Customer Deposit', 0.00, 200.00),
(100000001, '2019-10-31', 'CD', 'Customer Deposit', 0.00, 80.91),
(100000000, '2019-08-31', '', 'Balance Forward', 0.00, 5000.00),
(100000001, '2019-09-30', '', 'Balance Forward', 0.00, 500.00),
(100000002, '2019-09-30', '', 'Balance Forward', 0.00, 888.00);
-- SELECT CURDATE() AS balance_date, balance FROM account WHERE account_no = 100000000;
CREATE TABLE customer(
ssn INTEGER,
first_name VARCHAR(50),
last_name VARCHAR(50)
);
INSERT INTO customer(ssn, first_name, last_name) 
VALUES (135008888,'Thomas', 'Thompson'),
(135007777,'Spencer', 'Escalante'),
(231008888,'Jenny', 'Thompson');
CREATE TABLE has_account(
ssn INTEGER,
account_no INTEGER
);
INSERT INTO has_account(ssn, account_no)
VALUES (135008888,100000000),
(135007777,100000001),
(231008888,100000000),
(135008888,100000002);
SELECT c.last_name, c.first_name, c.ssn, a.account_no
FROM customer c, has_account a
WHERE first_name = 'Thomas' AND last_name = 'Thompson'
AND c.ssn=a.ssn;


-- **************************************
-- ***************************************
-- ***************************************

-- Changes to spencer's schema
alter TABLE account change account_number account_no INT; -- account
ALTER TABLE account MODIFY COLUMN account_no INT NOT NULL AUTO_INCREMENT; -- account
alter TABLE account change balance balance DOUBLE; -- account
ALTER TABLE account AUTO_INCREMENT = 100000000; -- account

alter TABLE customer change `name` first_name VARCHAR(80); -- customer
alter TABLE customer add column last_name VARCHAR(80) after first_name; -- customer
alter TABLE customer change ssn ssn VARCHAR(11); -- customer
alter TABLE customer change `apt#` apt_no VARCHAR(80); -- customer
alter TABLE customer change `street#` street_no VARCHAR(80); -- customer

alter TABLE loan change `loan#` loan_no INT; -- LOAN
ALTER TABLE loan AUTO_INCREMENT = 100000000; -- LOAN
alter TABLE loan change loan_amnt loan_amount DOUBLE; -- LOAN
alter TABLE loan change `name` branch_name VARCHAR(45); -- LOAN
alter TABLE loan add column date_taken DATE after branch_name; -- LOAN



CREATE TABLE has_loan(loan_no INT, customer_ssn VARCHAR(11));
INSERT INTO has_loan VALUES (100000000,'135-00-8888'); 
INSERT INTO has_loan VALUES (100000001,'135-00-8888'); 


CREATE TABLE payment(payment_no INT primary key auto_increment, loan_no INT, payment_amount DOUBLE, payment_date DATE);
drop table payment;
INSERT INTO payment(loan_no, payment_amount, payment_date) VALUES
(100000000, 100.00, '2019-12-02'),
(100000001, 100.00, '2019-05-10'),
(100000001, 300.00, '2019-06-16'),
(100000001, 200.00, '2019-07-11'),
(100000001, 500.00, '2019-08-08');

-- ***************************************

-- Insert values to spencer tables (NOTE: I NULLED OUT A BUNCH OF STUFF FOR ADDRESS)
INSERT INTO customer(ssn, first_name, last_name) 
VALUES ('135-00-8888','Thomas', 'Thompson'),
('135-00-7777','Spencer', 'Escalante'),
('231-00-8888','Jenny', 'Thompson');
INSERT INTO account(balance,last_accessed,overdraft,intrest_rate)
VALUES (4398.00, '2019-11-30', 0, 0),
(580.91, '2019-10-30', 0, 0),
(888.0, '2019-11-11', 0, 0);
INSERT INTO branch(name, city, assets)
VALUES ('Branch A', 'Newark', 100000),
('Branch B', 'New York', 100000),
('Branch C', 'Jersey City', 100000);

-- ***************************************

-- Make up VIEWS
CREATE TABLE passbook(
account_no INTEGER,
transaction_date DATE,
transaction_code VARCHAR(5),
transaction_name VARCHAR(50),
debit DOUBLE,
credit DOUBLE
);
INSERT INTO passbook(account_no, transaction_date, transaction_code, transaction_name, debit, credit)
VALUES (100000000, '2019-10-01', 'WD', 'Withdrawal', 800.00, 0.00),
(100000000, '2019-10-02', 'SC', 'Service Charge', 2.00, 0.00),
(100000000, '2019-10-03', 'CD', 'Customer Deposit', 0.00, 200.00),
(100000001, '2019-10-31', 'CD', 'Customer Deposit', 0.00, 80.91),
(100000000, '2019-08-31', '', 'Balance Forward', 0.00, 5000.00),
(100000001, '2019-09-30', '', 'Balance Forward', 0.00, 500.00),
(100000002, '2019-09-30', '', 'Balance Forward', 0.00, 888.00);

CREATE TABLE has_account(
ssn VARCHAR(11),
account_no INTEGER
);
INSERT INTO has_account(ssn, account_no)
VALUES ('135-00-8888',100000000),
('135-00-7777',100000001),
('231-00-8888',100000000),
('135-00-8888',100000002);




-- PASSBOOK BOOK VIEW TESTING
-- passbook(account_no, transaction_date, transaction_code, transaction_name, debit, credit)

SELECT t.record_no, t.account_no, t.date, t.transaction_code, tt.transaction_name
FROM `transaction` t, `transaction_type` tt
WHERE t.transaction_code = tt.transaction_code;

-- Credits
SELECT tc.record_no, tc.account_no, tc.amount AS 'credit'
FROM `transaction` tc, `transaction_type` ttc
WHERE tc.transaction_code = ttc.transaction_code AND ttc.classification='credit';

-- Debits
SELECT td.record_no, td.account_no, td.amount AS 'debit'
FROM `transaction` td, `transaction_type` ttd
WHERE td.transaction_code = ttd.transaction_code AND ttd.classification='debit';



-- MAKE VIEWS...
CREATE VIEW account_credits AS -- CREDITS
SELECT tc.record_no, tc.account_no, tc.amount AS 'credit'
FROM `transaction` tc, `transaction_type` ttc
WHERE tc.transaction_code = ttc.transaction_code AND ttc.classification='credit';


CREATE VIEW account_debits AS -- DEBITS
SELECT td.record_no, td.account_no, td.amount AS 'debit'
FROM `transaction` td, `transaction_type` ttd
WHERE td.transaction_code = ttd.transaction_code AND ttd.classification='debit';

CREATE VIEW account_passbooks AS -- PASSBOOK
SELECT t.record_no, t.account_no, t.date, t.transaction_code, tt.transaction_name, ad.debit, ac.credit
FROM `transaction` t
LEFT JOIN account_debits ad
ON t.account_no = ad.account_no AND t.record_no = ad.record_no
LEFT JOIN account_credits ac
ON t.account_no = ac.account_no AND t.record_no = ac.record_no
JOIN transaction_type tt
ON t.transaction_code = tt.transaction_code;

SELECT * FROM account_passbooks;

-- ***** 
-- Total $ in customer accounts
SELECT SUM(balance)
FROM `account`;
-- Total $ of loans
SELECT SUM(loan_amount)
FROM loan;
-- Total $ paid for loans
SELECT SUM(payment_amount)
FROM loan_payment;









-- MAKE TRIGGERS !!!!!!!!!
-- determine balance
SELECT sum(credit) - sum(debit) as balance
FROM account_passbooks
WHERE account_no = 100000003;

-- (0) FIX set current balances in DB (with seeded data) (*****)
UPDATE account
SET balance = (SELECT sum(credit) - sum(debit)
	FROM account_passbooks
	WHERE account_no = 100000004)
WHERE account_no = 100000004; -- REPEATED FOR EACH account 100000000 thru 100000004


-- GETS LAST TRANSACTION DATE
SELECT MAX(date)
FROM transaction
WHERE account_no = 100000002 AND transaction_code NOT IN ('SC');

-- (00) FIX LAST_ACCESSED FOR EACH ACCOUNT (*****)
UPDATE account
SET last_accessed = (SELECT MAX(date)
					FROM transaction
					WHERE account_no = 100000004 AND transaction_code NOT IN ('SC'))
WHERE account_no = 100000004; -- REPEATED FOR EACH account 100000000 thru 100000004



-- (1) TRIGGER TO UPDATE ACCOUNT BALANCE (*** THIS ***)
CREATE TRIGGER update_account_balance 
AFTER INSERT ON transaction 
FOR EACH ROW
	UPDATE account a
	SET balance = (	SELECT sum(credit) - sum(debit)
					FROM account_passbooks ap
					WHERE ap.account_no = NEW.account_no)
	WHERE a.account_no = NEW.account_no;
    
    
DROP TRIGGER IF EXISTS update_account_balance;
    
-- (2) TRIGGER TO UPDATE ACCOUNT LAST ACCESSSED (*** THIS ***) ... might not need this...
CREATE TRIGGER update_account_last_access
AFTER INSERT ON transaction
FOR EACH ROW
	UPDATE account a
	SET last_accessed = (SELECT MAX(date)
						FROM transaction
						WHERE a.account_no = NEW.account_no AND NEW.transaction_code NOT IN ('SC', 'BF'))
	WHERE a.account_no = NEW.account_no;

DROP TRIGGER update_account_last_access;
    
-- Test account balance trigger
INSERT INTO transaction(account_no, transaction_code, date, time, amount) 
VALUES (100000000, 'WD', '2019-12-03', '5:55 PM', '610.10');




-- create charge accounts (***********)
CREATE VIEW branch_charge_account AS 
SELECT a.branch_name, SUM(amount) AS charge_account_balance
FROM transaction t, `account` a
WHERE a.account_no = t.account_no AND t.transaction_code='SC'
GROUP BY a.branch_name;

SELECT * FROM charge_account;


-- determine bank assets.... 

-- BRANCH OVERVIEW
SELECT ca.branch_name, ca.charge_account_balance
FROM charge_account ca;


SELECT l.branch_name, sum(loan_amount) AS total_loan_principal
FROM loan l
GROUP BY l.branch_name;

SELECT l.loan_no, lp.payment_amount, l.branch_name
FROM loan_payment lp, loan l
WHERE lp.loan_no = l.loan_no
GROUP BY lp.loan_no;

SELECT *
FROM loan l, loan_payment lp
WHERE l.loan_no = lp.loan_no;


SELECT lp.loan_no, sum(payment_amount)
FROM loan_payment lp
GROUP BY lp.loan_no;


-- SELECT lp2.branch_name, sum(lp2.payment_amount) AS total_loan_payments
-- FROM (SELECT lp.loan_no, lp.payment_amount, l.branch_name
-- 	FROM loan l, loan_payment lp
-- 	WHERE l.loan_no = lp.loan_no) AS lp2
-- GROUP BY lp2.loan_no;
-- 

SELECT l.branch_name, sum(lpt.loan_payment_total)
FROM loan l, 
	(SELECT lp.loan_no, sum(payment_amount) AS loan_payment_total
	FROM loan_payment lp
	GROUP BY lp.loan_no) AS lpt
WHERE l.loan_no = lpt.loan_no;


-- TOTAL LOAN PAYMENTS PER LOAN (***********)
CREATE VIEW total_payments_by_loan AS
SELECT lp.loan_no, sum(payment_amount) AS loan_payment_total
FROM loan_payment lp
GROUP BY lp.loan_no;

CREATE VIEW total_loan_payments_by_branch AS
SELECT branch_name, sum(tpl.loan_payment_total) AS total_of_loan_payments
FROM total_payments_by_loan tpl, loan l
WHERE l.loan_no = tpl.loan_no
GROUP BY branch_name;

-- TOTAL LOAN PRINCIPAL
CREATE VIEW total_loan_amounts_by_branch AS
SELECT branch_name, sum(loan_amount) AS total_of_loan_principals
FROM loan
GROUP BY branch_name;


-- BRANCH TOTAL CUSTOMER ACCOUNTS
CREATE VIEW total_balance_of_customer_accounts_by_branch AS
SELECT branch_name, SUM(balance) AS total_balance_of_customer_accounts
FROM `account` a
GROUP BY branch_name;



-- OVERVIEW OF ALL ASSETS
CREATE VIEW branch_asset_overview AS
SELECT *
FROM branch_charge_account
NATURAL JOIN
total_balance_of_customer_accounts_by_branch
NATURAL JOIN
total_loan_amounts_by_branch
NATURAL JOIN
total_loan_payments_by_branch;


SELECT * FROM branch_asset_overview;

-- GET BRANCH ASSETS
CREATE VIEW branch_asset_total AS
SELECT bao.branch_name, ((charge_account_balance + total_balance_of_customer_accounts + total_of_loan_payments) - total_of_loan_principals) AS total_assets
FROM branch_asset_overview bao; 
    

SELECT * 
FROM branch_asset_total;
-- ###############################
-- Make Database Events:

SET GLOBAL event_scheduler = ON;

-- (1) Update years_employed for each Employee on Jan 1st of every year
-- (1a) Create procedure to update employee years_employed
DELIMITER ;;
CREATE PROCEDURE update_employee_years_employed()
BEGIN
	ALTER TABLE employee
	CHANGE COLUMN years_employed years_employed INT(3) GENERATED ALWAYS AS ((YEAR(CURDATE()) - year(`start_date`))) VIRTUAL;
END;;
DELIMITER ;

-- (1b) Call procedure on Jan 1st every year
CREATE EVENT update_employment_length
ON SCHEDULE
    EVERY 1 YEAR
    STARTS '2020-01-01 00:00:00'
    ON COMPLETION PRESERVE
DO
	CALL update_employee_years_employed();


-- (2) Perform a Service Charge on every account on the 1st of every month
-- (2a) Create procedure to apply service charges to all (customer) accounts
DELIMITER ;;
CREATE PROCEDURE apply_service_charge_to_all_accounts()
BEGIN

	DECLARE n INT DEFAULT 0; -- total # of accounts
    DECLARE i INT DEFAULT 0; -- iterator value
    DECLARE service_charge DOUBLE DEFAULT 0.0; -- current service charge amount
    DECLARE todays_date DATE DEFAULT NULL; -- current date
    DECLARE current_account_no INT DEFAULT 0; -- account_no (determined during iterations)
    
    SET i = 0;
    SELECT COUNT(*) FROM `account` INTO n;
    SELECT charge FROM transaction_type WHERE transaction_code = 'SC' INTO service_charge;
	SELECT CURDATE() INTO todays_date;
    
    -- iterate over all account tuples and insert service charge into transaction table
    WHILE i < n DO
		SELECT account_no FROM `account` ORDER BY account_no LIMIT i,1 INTO current_account_no;
		INSERT INTO transaction(account_no, transaction_code, `date`, `time`, `amount`) 
        VALUES (current_account_no, 'SC', todays_date, '6:00 AM', service_charge);
        SET i = i + 1;
	END WHILE;
	
END;;
DELIMITER ;

-- (2b) Call procedure on the 1st of every month (at 6:00 AM)
CREATE EVENT apply_monthly_service_charge
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2020-01-01 00:06:00'
    ON COMPLETION PRESERVE
DO
	CALL apply_service_charge_to_all_accounts();






-- (3) UPDATE BANK ASSETS AT END OF EACH DAY
-- CREATE EVENT update_branch_assets
-- ON SCHEDULE
--     EVERY 1 DAY
--     STARTS '2020-01-01 23:59:59'
--     ON COMPLETION PRESERVE
-- DO
-- 	TODO: UPDATE EACH ROW OF BRANCH WITH NEW ASSETS
--     ;




