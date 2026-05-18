package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.InputStream;

public class DBContext {
    private final String url;
    private final String userID;
    private final String password;

    public DBContext() {
        String defaultUrl = "jdbc:sqlserver://localhost:1433;databaseName=HanoiBusDB;encrypt=true;trustServerCertificate=true";
        String defaultUser = "sa";
        String defaultPassword = "123";

        Properties props = new Properties();
        try (InputStream is = DBContext.class.getClassLoader().getResourceAsStream("WEB-INF/ConnectDB.properties")) {
            if (is != null) {
                props.load(is);
                defaultUrl = props.getProperty("url", defaultUrl);
                defaultUser = props.getProperty("userID", defaultUser);
                defaultPassword = props.getProperty("password", defaultPassword);
            }
        } catch (Exception ignored) {
        }

        this.url = defaultUrl;
        this.userID = defaultUser;
        this.password = defaultPassword;
    }

    public Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}
