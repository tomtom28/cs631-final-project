use bestbank;

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

