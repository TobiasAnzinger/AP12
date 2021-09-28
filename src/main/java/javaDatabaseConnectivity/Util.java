package javaDatabaseConnectivity;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class Util {

    private static Connection connection = null;

    static Logger log = LoggerFactory.getLogger(Util.class);

    public static Connection getConnection(final String db) {
        try {
            if (connection != null && !connection.isClosed()) {
                return connection;
            }
            Properties properties = readPropertyFile(db + ".properties");

//            Class.forName(properties.getProperty("DBDRIVER"));
            assert properties != null;
            connection = DriverManager.getConnection(
                    properties.getProperty("DBURL"),
                    properties.getProperty("DBUSER"),
                    properties.getProperty("DBPW")
            );
            DatabaseMetaData databaseMetaData = connection.getMetaData();
            log.info("Connected to database: " + db);
            log.info("Metadaten der Datenbank: " + databaseMetaData.getDriverName()
                    + "\nDB: " + databaseMetaData.getDatabaseProductName()
                    + "\nVersion: " + databaseMetaData.getDriverVersion());
        } catch (SQLException e) {
            log.error("Failed to connect to the database");
            e.printStackTrace();
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static Properties readPropertyFile(String filename) {
        Properties prop = new Properties();
        try {
            prop.load(new FileReader(filename));
            return prop;
        } catch (FileNotFoundException e) {
            log.error("Could not fina a property file with the name: " + filename);
        } catch (IOException e) {
            log.error("");
        }
        return null;
    }

}
