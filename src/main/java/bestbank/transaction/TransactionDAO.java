package bestbank.transaction;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.SQLException;

public class TransactionDAO {

    private Connection conn;

    TransactionDAO() {
        conn = ApplicationDAO.getDBConnection();
    }


    public double getAccountBalance(String accountNo) throws SQLException {

        // TODO determine balance based on transactions
        double balance = 100.00;
        return balance;
    }


    // TODO more DAO methods to support front end


    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
