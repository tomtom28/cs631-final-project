package bestbank.customer;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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


    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
