import org.apache.derby.client.am.Connection;
import org.apache.derby.client.am.DatabaseMetaData;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;



public class JDBCTest {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Properties props = new Properties();
        props.setProperty("user", "GUEST");
        conn = (Connection) DriverManager.getConnection("jdbc:derby://localhost:1527/JavaTunesDB", props);
        DatabaseMetaData dbmd = (DatabaseMetaData) conn.getMetaData();
        System.out.println(dbmd.getDriverName() + ",  " + dbmd.getDatabaseProductName());
        System.out.println("Username: " + dbmd.getUserName());
        conn.close();
    }
}
