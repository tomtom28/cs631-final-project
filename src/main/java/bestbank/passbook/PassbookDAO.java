package bestbank.passbook;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

    public ArrayList<String[]> getTransactions(String accountNo) {
        ArrayList<String[]> transactions = new ArrayList<>(0);
        try {
            Statement transactionStmt = conn.createStatement();
            ResultSet transactionSet = transactionStmt.executeQuery("SELECT * FROM passbook WHERE account_no = " + accountNo + " ORDER BY transaction_date ASC");

            // Iterate over transactions
            while (transactionSet.next()) {
                String[] transaction = {
                    transactionSet.getString("transaction_date"),
                    transactionSet.getString("transaction_code"),
                    transactionSet.getString("transaction_name"),
                    transactionSet.getString("debit"),
                    transactionSet.getString("credit")
                };

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
