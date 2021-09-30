package javaDatabaseConnectivity;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class Jdbc02ExecuteUpdate {

    public static void main(String[] args) {


        Logger log = LoggerFactory.getLogger(Main.class);
        log.info("JDBC02 Execute update\n====================");
        Connection con = Util.getConnection("BEISPIEL");
        Statement statement;

        try {
            statement = con.createStatement();
            String sql1 = "DROP TABLE IF EXISTS lieferant ";
            int rowsUpdated = statement.executeUpdate(sql1);
            log.info("updated " + rowsUpdated + " rows");

            String sql2 = "CREATE TABLE lieferant(\n" +
                          "id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,\n" +
                          "name VARCHAR(255) NOT NULL,\n" +
                          "created TIMESTAMP,\n" +
                          "updated TIMESTAMP DEFAULT {ts '2013-01-01 01:00:00.0'}\n" +
                          ")\n";
            rowsUpdated = statement.executeUpdate(sql2);
            log.info("updated " + rowsUpdated + " rows");

            String sql3 = "INSERT INTO lieferant SET name=\"Niedermeier\";\n" +
                          "INSERT INTO lieferant SET name=\"Müller\";\n" +
                          "INSERT INTO lieferant SET name=\"Maier\";\n";
            statement.execute(sql3);
            log.info("updated " + rowsUpdated + " rows");

        } catch (SQLException e) {
            log.error("failed to update rows");
            e.printStackTrace();
        }

        Util.close(con);


    }
}
