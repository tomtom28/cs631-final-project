package bestbank.application;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static java.lang.System.*;

public class ApplicationDAO {

    // Database Credentials
    private static String userName = "root";
    private static String password = "";
    private static String dataBaseURL = "jdbc:mysql://localhost:3306/bestbank";

    // Gets DB Connection Instance
    public static Connection getDBConnection() {
        try {
            // Determine if connected to localhost or heroku
            String JAWSDB_MARIA_URL = System.getenv("JAWSDB_MARIA_URL");
            if (JAWSDB_MARIA_URL != null) { // deployed
                return DriverManager.getConnection("jdbc:" + JAWSDB_MARIA_URL);
            }
            else { // localhost
                return DriverManager.getConnection(dataBaseURL, userName, password);
            }
        }
        catch (SQLException e) {
            out.println(e);
            return null;
        }
    }

}
