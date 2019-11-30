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

//    public String[] getBalanceFwd(String accountNo) {
//        String[] balanceFwd = new String[6];
//        try {
//            Statement stmt = conn.createStatement();
//            ResultSet balanceSet = stmt.executeQuery("SELECT CURDATE() AS balance_date, balance FROM account WHERE account_no = " + accountNo);
//            // Get Current Balance
//            while (balanceSet.next()) {
//                balanceFwd[0] = balanceSet.getString("balance_date");
//                balanceFwd[1] = "";
//                balanceFwd[2] = "";
//                balanceFwd[3] = "";
//                balanceFwd[4] = "";
//                balanceFwd[5] = balanceSet.getString("balance");
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return balanceFwd;
//    }

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
