use bestbank_db;


drop table passbook;

drop table has_account;


CREATE TABLE account(
account_no INTEGER AUTO_INCREMENT PRIMARY KEY,
balance DOUBLE);
ALTER TABLE account AUTO_INCREMENT = 100000000;


INSERT INTO account(balance)
VALUES (5500.00),
(8870.99),
(105702.37);


SELECT * FROM account WHERE account_No=100000000;

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


