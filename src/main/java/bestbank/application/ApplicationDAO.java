package bestbank.application;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDAO {

    // Database Credentials
    private static String userName = "root";
    private static String password = "root";
    private static String dataBaseURL = "jdbc:mysql://localhost:3306/bestbank";

    // Gets DB Connection Instance
    public static Connection getDBConnection() {
        try {
            return DriverManager.getConnection(dataBaseURL, userName, password);
        }
        catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }

}
