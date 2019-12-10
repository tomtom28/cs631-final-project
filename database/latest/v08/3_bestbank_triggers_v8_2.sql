-- BEST BANK DATABASE TRIGGERS
USE bestbank;


-- Do some clean up:
DROP TRIGGER IF EXISTS `update_account_balance`;


-- Trigger 1
-- Updates the balance field of the given account whose
-- newly inserted transaction has a matching account_no
DELIMITER ;;
CREATE TRIGGER update_account_balance 
AFTER INSERT ON transaction 
FOR EACH ROW
	IF NEW.transaction_code NOT IN ('BF') 
    THEN
		UPDATE account a
		SET balance = (	SELECT sum(credit) - sum(debit)
						FROM account_passbooks ap
						WHERE ap.account_no = NEW.account_no)
		WHERE a.account_no = NEW.account_no;
DELIMITER ;

-- Note that Balance Forward transactions are exempt from this trigger
-- since the account balance is directly inserted by the application        
        
        