package bestbank.loan;

import bestbank.application.ApplicationDAO;

import java.sql.*;
import java.util.ArrayList;

public class LoanDAO {
    private Connection conn;

    LoanDAO() {
        conn = ApplicationDAO.getDBConnection();
    }

    public boolean isValidLoanNo(String loanNo) {
        try {
            Statement pbStmt = conn.createStatement();
            ResultSet loanSet = pbStmt.executeQuery("SELECT * FROM loan WHERE loan_no = " + loanNo);
            return loanSet.next();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public String getLoanDateTaken(String loanNo) {
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT date_taken FROM loan WHERE loan_no = ?");
            stmt.setString(1, loanNo);
            ResultSet loanSet = stmt.executeQuery();
            loanSet.next();
            return  loanSet.getString("date_taken");
        } catch (SQLException e) {
            System.out.println(e);
            return "1900-01-01";
        }
    }

    public double getLoanPrincipal(String loanNo) {
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT loan_amount FROM loan WHERE loan_no = ?");
            stmt.setString(1, loanNo);
            ResultSet loanSet = stmt.executeQuery();
            loanSet.next();
            return  loanSet.getDouble("loan_amount");
        } catch (SQLException e) {
            System.out.println(e);
            return 0.0;
        }
    }

    public String getLoanCustomerSSNs(String loanNo) {

        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT ssn FROM has_loan WHERE loan_no = ?");
            stmt.setString(1, loanNo);
            ResultSet ssnSet = stmt.executeQuery();

            // Gets list of customer SSNs (ex. 111-22-3333, 222-66-8888, ...)
            String customerSSNs = "";
            while (ssnSet.next()) {
                customerSSNs = customerSSNs + ssnSet.getNString(1) + ", ";
            }

            // Trim end (if needed)
            if (customerSSNs.length() > 3) customerSSNs = customerSSNs.substring(0,customerSSNs.length()-2);

            return customerSSNs;

        } catch (SQLException e) {
            System.out.println(e);
            return "";
        }

    }

    public String getLoanDescription(String loanNo) {

        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT description FROM loan WHERE loan_no = ?");
            stmt.setString(1, loanNo);
            ResultSet loanSet = stmt.executeQuery();

            loanSet.next();
            String description = loanSet.getNString(1);
            return description;

        } catch (SQLException e) {
            System.out.println(e);
            return "N/A";
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

    public ArrayList<String[]> getCustomerLoans(String firstName, String lastName) {
        // Create List of Accounts for the given name
        ArrayList<String[]> listOfLoans = new ArrayList<>(0);
        try {
            String query = "SELECT c.last_name, c.first_name, c.ssn, l.loan_no " +
                    "FROM customer c, has_loan l " +
                    "WHERE first_name = ? AND last_name = ? " +
                    "AND c.ssn=l.ssn";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            ResultSet custLoanSet = stmt.executeQuery();

            while (custLoanSet.next()) {
                String[] loan = {
                        custLoanSet.getString("last_name"),
                        custLoanSet.getString("first_name"),
                        custLoanSet.getString("ssn"),
                        custLoanSet.getString("loan_no")
                };
                listOfLoans.add(loan);
            }
            return listOfLoans;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listOfLoans;
    }

    public ArrayList<String[]> getPayments(String loanNo) {
        ArrayList<String[]> payments = new ArrayList<>(0);
        try {
            Statement stmt = conn.createStatement();
            ResultSet paymentSet = stmt.executeQuery("SELECT payment_date, payment_amount FROM loan_payment WHERE loan_no = " + loanNo +
                    " ORDER BY payment_date, payment_no ASC");

            // Iterate over transactions
            while (paymentSet.next()) {
                String[] payment = {
                        paymentSet.getString("payment_date"),
                        paymentSet.getString("payment_amount")
                };

                // Append to list
                payments.add(payment);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return payments;
    }

    public void close() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
