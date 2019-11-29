package bestbank.application;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDAO {

    // Database Credentials
    private static String userName = "";
    private static String password = "";
    private static String dataBaseURL = "";

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
