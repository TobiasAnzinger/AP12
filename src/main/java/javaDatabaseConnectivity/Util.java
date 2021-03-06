package javaDatabaseConnectivity;

import org.nocrala.tools.texttablefmt.Table;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;


public class Util {

    private static Connection connection = null;

    static Logger log = LoggerFactory.getLogger(Util.class);

    private Util() {
    }

    public static Connection getConnection(final String db) {
        try {
            if (connection != null && !connection.isClosed()) {
                return connection;
            }
            Properties properties = readPropertyFile("src/main/resources/" + db + ".properties");


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

    public static void close(AutoCloseable obj) {
        try {
            if (obj != null) {
                obj.close();
            }
        } catch (Exception e) {
            log.error("failed to close the object");
        }

    }

    private static Properties readPropertyFile(String filename) {
        Properties prop = new Properties();
        try {
            prop.load(new FileReader(filename));
            return prop;
        } catch (FileNotFoundException e) {
            log.error("Could not find a property file with the name: " + filename);
        } catch (IOException e) {
            log.error("");
        }
        return null;
    }

    public static void printResultSet(final ResultSet rs) throws SQLException {

        final int colcnt = rs.getMetaData().getColumnCount();
        final Table t = new Table(colcnt);
        for (int col = 1; col <= colcnt; col++) {
            t.addCell(rs.getMetaData().getColumnLabel(col));
        }
        while (rs.next()) {
            for (int col = 1; col <= colcnt; col++) {
                final Object o = rs.getObject(col);
                t.addCell(o == null ? "" : o.toString());
            }
        }
        System.out.println(t.render());
    }


}
