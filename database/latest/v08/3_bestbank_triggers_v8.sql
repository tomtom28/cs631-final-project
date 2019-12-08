-- BEST BANK DATABASE TRIGGERS
USE bestbank;


-- Do some clean up:
DROP TRIGGER IF EXISTS `update_account_balance`;


-- Trigger 1
-- Updates the balance field of the given account whose
-- newly inserted transaction has a matching account_no
CREATE TRIGGER update_account_balance 
AFTER INSERT ON transaction 
FOR EACH ROW
	UPDATE account a
	SET balance = (	SELECT sum(credit) - sum(debit)
					FROM account_passbooks ap
					WHERE ap.account_no = NEW.account_no)
	WHERE a.account_no = NEW.account_no;