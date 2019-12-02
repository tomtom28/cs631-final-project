package bestbank.loan;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.SQLException;

public class LoanDAO {
    private Connection conn;

    LoanDAO() {
        conn = ApplicationDAO.getDBConnection();
    }


    // TODO add DAO queries



    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
