package bestbank.customer;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class CustomerDAO {

    private Connection conn;

    CustomerDAO() {
        conn = ApplicationDAO.getDBConnection();
    }

    public boolean isValidCustomerSSN(String ssn) {
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM customer WHERE ssn = ?");
            stmt.setString(1, ssn);
            ResultSet customerSet = stmt.executeQuery();
            return customerSet.next();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public void deleteCustomerBySSN(String ssn) throws SQLException {
        PreparedStatement stmt = conn.prepareStatement("DELETE FROM customer WHERE ssn = ?");
        stmt.setString(1, ssn);
        stmt.execute();
    }

    public ArrayList<String> getAllBankBranches() {
        ArrayList<String> allBranches = new ArrayList<>();

        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT name FROM branch");
            ResultSet branchSet = stmt.executeQuery();
            // Iterate over branches
            while (branchSet.next()) {
                allBranches.add(branchSet.getString("name"));
            }
        } catch (SQLException e) {
            System.out.println(e);
            return allBranches;
        }
        return allBranches;
    }


    public void addNewCustomer(Customer customer) throws SQLException {

        // Add Customer (with address)
        String query = "INSERT INTO customer(ssn, first_name, last_name, street_no, city, state, zip_code) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, customer.getSSN());
        stmt.setString(2, customer.getFirstName());
        stmt.setString(3, customer.getLastName());
        stmt.setString(4, customer.getStreet());
        stmt.setString(5, customer.getCity());
        stmt.setString(6, customer.getState());
        stmt.setString(7, customer.getZip());
        stmt.execute();

        // Add the APT No (if needed)
        if(customer.hasAptNo()) {
            PreparedStatement stmt2 = conn.prepareStatement("UPDATE customer SET apt_no = ? WHERE ssn = ?");
            stmt2.setString(1, customer.getApt());
            stmt2.setString(2, customer.getSSN());
            stmt2.execute();
        }

    }


    public String addNewAccount(String[] customerSSNs, String branchName, String accountType, String interestOrOverdraft, double balance) throws SQLException {

        String lastAccessed = LocalDate.now().toString();
        // Insert New Account
        conn.setAutoCommit(false);
        String query = "INSERT INTO account(balance, last_accessed, branch_name) VALUES(?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setDouble(1, balance);
        stmt.setString(2, lastAccessed);
        stmt.setString(3, branchName);
        stmt.execute();

        // query db for account number
        PreparedStatement stmt2 = conn.prepareStatement("SELECT MAX(account_no) AS new_account_no FROM account");
        ResultSet accountSet = stmt2.executeQuery();
        accountSet.next();
        String newAccountNo = accountSet.getString("new_account_no");

        // Batch insert into has_account
        String query2 = "INSERT INTO has_account(account_no, ssn) VALUES(?,?) ";
        PreparedStatement stmt3 = conn.prepareStatement(query2);
        for(String ssn : customerSSNs) {
            stmt3.setString(1, newAccountNo);
            stmt3.setString(2, ssn);
            stmt3.addBatch();
        }
        stmt3.executeBatch();

        // insert new record to DB (assumes that Account No is auto increment)
        if(accountType.equals("savings")) {
            PreparedStatement stmt4 = conn.prepareStatement("INSERT INTO savings_account (account_no, interest_rate) VALUES(?,?)");
            stmt4.setString(1, newAccountNo);
            stmt4.setString(2, interestOrOverdraft);
            stmt4.execute();
        } else {
            PreparedStatement stmt5 = conn.prepareStatement("INSERT INTO checking_account (account_no, overdraft) VALUES(?,?)");
            stmt5.setString(1, newAccountNo);
            stmt5.setString(2, interestOrOverdraft);
            stmt5.execute();
        }

        // Insert Balance Forward Transaction
        PreparedStatement stmt6 = conn.prepareStatement("INSERT INTO transaction (account_no, transaction_code, date, time, amount) VALUES(?,?,?,?,?)");
        stmt6.setString(1, newAccountNo);
        stmt6.setString(2, "BF");
        stmt6.setString(3, lastAccessed);
        stmt6.setString(4, this.getFormattedCurrentTime());
        stmt6.setDouble(5, balance);
        stmt6.execute();


        // Commit everything at once
        conn.commit();

        return newAccountNo;
    }

    public String removeCustomerAccount(String accountNo) throws SQLException {
        PreparedStatement stmt = conn.prepareStatement("DELETE FROM account WHERE account_no = ?");
        stmt.setString(1, accountNo);
        stmt.execute();

        return accountNo;
    }

    public String addCustomerLoan(String[] customerSSNs, String branchName, String amount, String loanDescription) throws SQLException {

        String loanDateTaken = LocalDate.now().toString();
        conn.setAutoCommit(false);

        // Insert into loan
        String query1 = "INSERT INTO loan(loan_amount, date_taken, branch_name) VALUES(?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(query1);
        stmt.setString(1, amount);
        stmt.setString(2, loanDateTaken);
        stmt.setString(3, branchName);
        stmt.execute();

        // Query db for loan number
        PreparedStatement stmt2 = conn.prepareStatement("SELECT MAX(loan_no) AS new_loan_no FROM loan");
        ResultSet accountSet = stmt2.executeQuery();
        accountSet.next();
        String newLoanNo = accountSet.getString("new_loan_no");

        // Add loan description (if needed)
        if (!loanDescription.equals("")) {
            PreparedStatement stmt2b = conn.prepareStatement("UPDATE loan SET description = ? WHERE loan_no = ?");
            stmt2b.setString(1, loanDescription);
            stmt2b.setString(2, newLoanNo);
            stmt2b.execute();
        }

        // Batch insert into has_loan
        String query2 = "INSERT INTO has_loan(loan_no, ssn) VALUES(?,?) ";
        PreparedStatement stmt3 = conn.prepareStatement(query2);
        for(String ssn : customerSSNs) {
            stmt3.setString(1, newLoanNo);
            stmt3.setString(2, ssn);
            stmt3.addBatch();
        }
        stmt3.executeBatch();

        // Commit all changes at once
        conn.commit();

        return newLoanNo;
    }

    public String removeCustomerLoan(String loanNo) throws SQLException {
        PreparedStatement stmt = conn.prepareStatement("DELETE FROM loan WHERE loan_no = ?");
        stmt.setString(1, loanNo);
        stmt.execute();

        return loanNo;
    }

    private String getFormattedCurrentTime() {

        // Returns time in 12:00 AM / 1:00 PM format
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("h:mm a");
        LocalTime localTime = LocalTime.now();
        String currentTime = dtf.format(localTime);

        return currentTime;
    }

    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
