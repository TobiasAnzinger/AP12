package javaDatabaseConnectivity;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Beispiel: Jdbc05PreparedStatements
 *
 * @author <a href="mailto:mgn.schule@gmx.de">Michael Niedermair</a>
 * @version $Revision: 1537 $
 */
public class Jdbc05PreparedStatements {

   public static void main(final String[] args) {

      System.out.println("JDBC Prepared Statements");
      System.out.println("========================");

      Connection connection = null;
      PreparedStatement pst = null;

      try {

         // 1. Holen einer Connection
         connection = Util.getConnection("FB");

         // 2. Prepared Statement erzeugen
         pst = connection
                  .prepareStatement("SELECT * from SPIELER WHERE Geschlecht=?");

         // 3. Werte zuweisen
         // TODO

         // 4. Metadaten ermitteln
         // TODO

         // 5. Resultset ausgeben
         // TODO

      } catch (SQLException e) {
         System.out.println(e.getMessage());
         e.printStackTrace();
      } finally {
         Util.close(pst);
         Util.close(connection);
      }
   }
}
