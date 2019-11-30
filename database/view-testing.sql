CREATE SCHEMA bestbank_db;
USE bestbank_db;

-- Passbook Testing
CREATE TABLE account(
account_no INTEGER AUTO_INCREMENT PRIMARY KEY,
balance DOUBLE);
ALTER TABLE account AUTO_INCREMENT = 100000000;

INSERT INTO account(balance)
VALUES (5500.00),
(8870.99),
(105702.37);

SELECT * FROM account WHERE accountNo=100000000;


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
(100000001, '2019-09-30', '', 'Balance Forward', 0.00, 500.00);

SELECT CURDATE() AS balance_date, balance FROM account WHERE account_no = 100000000;