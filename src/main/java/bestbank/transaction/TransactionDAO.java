package bestbank.transaction;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class TransactionDAO {

    private Connection conn;

    TransactionDAO() {
        conn = ApplicationDAO.getDBConnection();
    }


    public double getAccountBalance(String accountNo) throws SQLException {

        // Query account balance, a derived attribute on the account table
        PreparedStatement stmt = conn.prepareStatement("SELECT balance FROM account WHERE account_no = ?");
        stmt.setString(1, accountNo);
        ResultSet rSet = stmt.executeQuery();
        rSet.next();

        double balance = rSet.getDouble("balance");
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


    public void payLoan(String loanNo, String accountNo, double amount) throws Exception {

        //Checks if the user has enough to make the payment specified
        double accountBalance = this.getAccountBalance(accountNo);
        double overdraftAllowed = this.getOverDraftAllowed(accountNo);
        if ( ((accountBalance - amount) < 0) && (Math.abs(accountBalance - amount) > overdraftAllowed) ) {
            throw new Exception("Unable to process loan payment. AccountNo: " + accountNo + " has insufficient funds!");
        }

        conn.setAutoCommit(false);

        // Insert loan_payment for given loanNo
        String query = "INSERT INTO loan_payment(loan_no, payment_amount, payment_date) VALUES(?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, loanNo);
        stmt.setDouble(2, amount);
        stmt.setString(3, this.getFormattedCurrentDate());
        stmt.execute();

        // Insert "LP" transaction for the given accountNo
        String query2 = "INSERT INTO transaction(account_no, transaction_code, date, time, amount) VALUES(?,?,?,?,?) ";
        PreparedStatement stmt2 = conn.prepareStatement(query2);
        stmt2.setString(1, accountNo);
        stmt2.setString(2, "LP");
        stmt2.setString(3, this.getFormattedCurrentDate());
        stmt2.setString(4, this.getFormattedCurrentTime());
        stmt2.setDouble(5, amount);
        stmt2.execute();


        // Update the last_accessed field on the account that paid the loan
        String query3 = "UPDATE account SET last_accessed = ? WHERE account_no = ? ";
        PreparedStatement stmt3 = conn.prepareStatement(query3);
        stmt3.setString(1, this.getFormattedCurrentDate());
        stmt3.setString(2, accountNo);
        stmt3.execute();

        conn.commit();
    }

    public void makeCashDeposit(String accountNo, double amount) throws SQLException {
        double currentBalance = this.getAccountBalance(accountNo);

        // TODO process request (do NOT use a try-catch here)
        String query = "INSERT INTO transaction(account_no, transaction_code, date, time, amount) VALUES(?,?,?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, accountNo);
        stmt.setString(2, "CD");
        stmt.setString(3, this.getFormattedCurrentDate());
        stmt.setString(4, this.getFormattedCurrentTime());
        stmt.setDouble(5, amount);
        stmt.execute();
//
//        // Also need to update the last_modified field on the account
        String query2 = "UPDATE account SET last_accessed = ? WHERE account_no = ? ";
        PreparedStatement stmt2 = conn.prepareStatement(query2);
        stmt2.setString(1, this.getFormattedCurrentDate());
        stmt2.setString(2, accountNo);
        stmt2.execute();


    }


    public void makeCashWithdrawal(String accountNo, double amount) throws Exception {

        // Check for savings / checking overdraft (checking account is allowed to go into overdraft)
        double accountBalance = this.getAccountBalance(accountNo);
        double overdraftAllowed = this.getOverDraftAllowed(accountNo);
        if ( ((accountBalance - amount) < 0) && (Math.abs(accountBalance - amount) > overdraftAllowed) ) {
            throw new Exception("Unable to process withdrawal. AccountNo: " + accountNo + " has insufficient funds!");
        }

        // Prevent auto-commit, all transactions must be valid to be processed
        conn.setAutoCommit(false);

        // Withdraw from account
        String query = "INSERT INTO transaction(account_no, transaction_code, date, time, amount) VALUES(?,?,?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, accountNo);
        stmt.setString(2, "WD");
        stmt.setString(3, this.getFormattedCurrentDate());
        stmt.setString(4, this.getFormattedCurrentTime());
        stmt.setDouble(5, amount);
        stmt.execute();

        // Update Last Accessed date of the account
        String query2 = "UPDATE account SET last_accessed = ? WHERE account_no = ? ";
        PreparedStatement stmt2 = conn.prepareStatement(query2);
        stmt2.setString(1, this.getFormattedCurrentDate());
        stmt2.setString(2, accountNo);
        stmt2.execute();

        // Commit all the changes at once
        conn.commit();
    }


    public void depositCheque(String fromAccountNo, String toAccountNo, double amount) throws Exception {

        // Check is cheque bounces (checking account is allowed to go into overdraft)
        double fromAccountBalance = this.getAccountBalance(fromAccountNo);
        double overdraftAllowed = this.getOverDraftAllowed(fromAccountNo);
        if ( ((fromAccountBalance - amount) < 0) && (Math.abs(fromAccountBalance - amount) > overdraftAllowed) ) {
            throw new Exception("Check Bounced. AccountNo: " + fromAccountNo + " has insufficient funds to process the cheque!");
        }

        // Prevent auto-commit, all transactions must be valid to be processed
        conn.setAutoCommit(false);

        // Withdraw from "from" account
        String query = "INSERT INTO transaction(account_no, transaction_code, date, time, amount) VALUES(?,?,?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, fromAccountNo);
        stmt.setString(2, "QW");
        stmt.setString(3, this.getFormattedCurrentDate());
        stmt.setString(4, this.getFormattedCurrentTime());
        stmt.setDouble(5, amount);
        stmt.execute();

        // Update Last Modified date of "from" account
        String query2 = "UPDATE account SET last_accessed = ? WHERE account_no = ? ";
        PreparedStatement stmt2 = conn.prepareStatement(query2);
        stmt2.setString(1, this.getFormattedCurrentDate());
        stmt2.setString(2, fromAccountNo);
        stmt2.execute();

        // Deposit into "to" account
        String query3 = "INSERT INTO transaction(account_no, transaction_code, date, time, amount) VALUES(?,?,?,?,?) ";
        PreparedStatement stmt3 = conn.prepareStatement(query3);
        stmt3.setString(1, toAccountNo);
        stmt3.setString(2, "QD");
        stmt3.setString(3, this.getFormattedCurrentDate());
        stmt3.setString(4, this.getFormattedCurrentTime());
        stmt3.setDouble(5, amount);
        stmt3.execute();

        // Update Last Modified date of "to" account
        String query4 = "UPDATE account SET last_accessed = ? WHERE account_no = ? ";
        PreparedStatement stmt4 = conn.prepareStatement(query4);
        stmt4.setString(1, this.getFormattedCurrentDate());
        stmt4.setString(2, toAccountNo);
        stmt4.execute();

        // Commit all the changes at once
        conn.commit();

    }


    private String getFormattedCurrentTime() {

        // Returns time in 12:00 AM / 1:00 PM format
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("h:mm a");
        LocalTime localTime = LocalTime.now();
        String currentTime = dtf.format(localTime);

        return currentTime;
    }


    private String getFormattedCurrentDate() {
        String currentDate = LocalDate.now().toString();
        return currentDate;
    }



    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
