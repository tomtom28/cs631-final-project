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


    public String addNewAccount(String ssn, String branchName, String accountType, String interest, String balance) throws SQLException {

        // Insert New Account
        // TODO

        // Get Latest (i.e. biggest #) Account No
        String newAccountNo = "99999999";
        // TODO

        return newAccountNo;
    }


    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
