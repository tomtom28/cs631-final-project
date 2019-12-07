package bestbank.transaction;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TransactionDAO {

    private Connection conn;

    TransactionDAO() {
        conn = ApplicationDAO.getDBConnection();
    }


    public double getAccountBalance(String accountNo) throws SQLException {

        // TODO determine balance ... likely a derived attribute on the account table
        double balance = 100.00;

        return balance;
    }


    public double getOverDraftAllowed(String accountNo) {

        try {
            // Returns the amount of allowed overdraft (if any)
            PreparedStatement stmt = conn.prepareStatement("SELECT overdraft FROM checking_account WHERE account_no = ?");
            stmt.setString(1, accountNo);
            ResultSet rSet = stmt.executeQuery();
            rSet.next();
            return  rSet.getDouble("overdraft");
        } catch(SQLException e) {
            // Note: if the account doesn't exist in the checking, then we are just assuming it's a savings account, i.e. no overdraft
            return 0.00;
        }

    }


    public void payLoan(String loanNo, String accountNo, String amount) throws SQLException {

        // TODO process request (do NOT use a try-catch here)

    }

    public void makeCashDeposit(String accountNo, double amount) throws SQLException {

        // TODO process request (do NOT use a try-catch here)

    }


    public void makeCashWithdrawal(String accountNo, double amount) throws SQLException {
        // TODO process request (do NOT use a try-catch here)

    }


    public void depositCheque(String fromAccountNo, String toAccountNo, double amount) throws Exception {

        // Check is cheque bounces (checking account is allowed to go into overdraft)
        double fromAccountBalance = this.getAccountBalance(fromAccountNo);
        double overdraftAllowed = this.getOverDraftAllowed(fromAccountNo);
        if ( ((fromAccountBalance - amount) < 0) && (Math.abs(fromAccountBalance - amount) > overdraftAllowed) ) {
            throw new Exception("Check Bounced. AccountNo: " + fromAccountNo + " has insufficient funds to process the cheque!");
        }

        // TODO: If cheque is good then Withdraw Transaction goes to fromAccount
        // todo AND THEN Deposit Transaction goes to toAccount (maybe we can make a new "Cheque Deposit" transaction_type)?

    }


    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
