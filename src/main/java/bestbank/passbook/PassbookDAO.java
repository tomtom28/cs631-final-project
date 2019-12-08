package bestbank.passbook;

import bestbank.application.ApplicationDAO;

import java.sql.*;
import java.util.ArrayList;

public class PassbookDAO {

    private Connection conn;

    PassbookDAO() {
        conn = ApplicationDAO.getDBConnection();
    }

    public boolean isValidAccountNo(String accountNo) {
        try {
            Statement pbStmt = conn.createStatement();
            ResultSet passbookSet = pbStmt.executeQuery("SELECT * FROM account WHERE account_no = " + accountNo);
            return passbookSet.next();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean isValidCustomerName(String firstName, String lastName) {
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM customer WHERE first_name = ?  AND last_name = ?");
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            ResultSet custNameSet = stmt.executeQuery();
            return custNameSet.next();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public ArrayList<String[]> getCustomerAccounts(String firstName, String lastName) {
        // Create List of Accounts for the given name
        ArrayList<String[]> listOfAccounts = new ArrayList<>(0);
        try {
            String query = "SELECT c.last_name, c.first_name, c.ssn, a.account_no " +
                "FROM customer c, has_account a " +
                "WHERE first_name = ? AND last_name = ? " +
                "AND c.ssn=a.ssn";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            ResultSet custAccountSet = stmt.executeQuery();

            while (custAccountSet.next()) {
                String[] account = {
                    custAccountSet.getString("last_name"),
                    custAccountSet.getString("first_name"),
                    custAccountSet.getString("ssn"),
                    custAccountSet.getString("account_no")
                };
                listOfAccounts.add(account);
            }
            return listOfAccounts;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listOfAccounts;
    }

    public ArrayList<String[]> getTransactions(String accountNo) {
        ArrayList<String[]> transactions = new ArrayList<>(0);
        try {
            Statement transactionStmt = conn.createStatement();
            ResultSet transactionSet = transactionStmt.executeQuery("SELECT * FROM account_passbooks WHERE account_no = " + accountNo + " ORDER BY date ASC");

            // Iterate over transactions
            while (transactionSet.next()) {

                String[] transaction = {
                    transactionSet.getString("date"),
                    transactionSet.getString("transaction_code"),
                    transactionSet.getString("transaction_name"),
                    transactionSet.getString("debit"),
                    transactionSet.getString("credit")
                };

                // Remove BF (Balance Forward)
                if (transactionSet.getString("transaction_code").equals("BF")) transaction[1] = "";

                // Clean up NULL values
                if (transactionSet.getString("debit") == null) transaction[3] = "0.0";
                if (transactionSet.getString("credit") == null) transaction[4] = "0.0";

                // Append to list
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return transactions;
    }
    
    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
