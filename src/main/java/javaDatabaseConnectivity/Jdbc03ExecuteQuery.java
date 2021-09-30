package javaDatabaseConnectivity;

import java.sql.*;

/**
 * Beispiel: Jdbc03ExecuteQuery
 *
 * @author <a href="mailto:mgn.schule@gmx.de">Michael Niedermair</a>
 * @version $Revision: 1117 $
 */
public class Jdbc03ExecuteQuery {

    public static void main(final String[] args) {

        System.out.println("JDBC Execute Query");
        System.out.println("==================");

        Connection connection = null;
        Statement statement = null;

        try {

            // 1. Holen einer Connection
            connection = Util.getConnection("db");

            // 2. Erzeugen eines Statements
            statement = connection.createStatement();

            // 3. Struktur der Tabelle LIEFERANT anzeigen
            String sql1 = "DESC lieferant";
            ResultSet rs = statement.executeQuery(sql1);

            // 4. Metadatern ermitteln
            ResultSetMetaData rsmd = rs.getMetaData();
            int colmax = rsmd.getColumnCount();
            System.out.println("Column count: " + colmax + "\n");

            // 5. Resultset ausgeben
            Util.printResultSet(rs);

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            Util.close(statement);
            Util.close(connection);
        }
    }
}
