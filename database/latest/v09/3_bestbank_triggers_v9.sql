-- BEST BANK DATABASE TRIGGERS
USE bestbank;

-- Do some clean up:
DROP TRIGGER IF EXISTS `update_account_balance_after_transaction_insert`;
DROP TRIGGER IF EXISTS `update_account_balance_after_transaction_update`;
DROP TRIGGER IF EXISTS `update_account_balance_after_transaction_deletion`;



-- Trigger 1
-- Updates the balance field of the given account whose
-- newly inserted transaction has a matching account_no
DELIMITER ;;
CREATE TRIGGER update_account_balance_after_transaction_insert 
AFTER INSERT ON transaction 
FOR EACH ROW
	IF NEW.transaction_code NOT IN ('BF') 
    THEN
		UPDATE account a
		SET balance = (	SELECT sum(credit) - sum(debit)
						FROM account_passbooks ap
						WHERE ap.account_no = NEW.account_no)
		WHERE a.account_no = NEW.account_no;
	END IF;;
DELIMITER ;



-- Trigger 2
-- Updates the balance field of the given account whose
-- updated transaction has a matching account_no
DELIMITER ;;
CREATE TRIGGER update_account_balance_after_transaction_update
AFTER UPDATE ON transaction 
FOR EACH ROW
	IF NEW.transaction_code NOT IN ('BF') 
    THEN
		UPDATE account a
		SET balance = (	SELECT sum(credit) - sum(debit)
						FROM account_passbooks ap
						WHERE ap.account_no = NEW.account_no)
		WHERE a.account_no = NEW.account_no;
	END IF;;
DELIMITER ;



-- Trigger 3
-- Updates the balance field of the given account whose
-- deleted transaction has a matching account_no
DELIMITER ;;
CREATE TRIGGER update_account_balance_after_transaction_deletion 
AFTER DELETE ON transaction 
FOR EACH ROW
	IF OLD.transaction_code NOT IN ('BF') 
    THEN
		UPDATE account a
		SET balance = (	SELECT sum(credit) - sum(debit)
						FROM account_passbooks ap
						WHERE ap.account_no = OLD.account_no)
		WHERE a.account_no = OLD.account_no;
	END IF;;
DELIMITER ;


-- Note that Balance Forward transactions are exempt from these triggers
-- since the account balance is directly inserted by the application        
        
        