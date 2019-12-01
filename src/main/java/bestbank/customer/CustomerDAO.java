package bestbank.customer;

import bestbank.application.ApplicationDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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


    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
