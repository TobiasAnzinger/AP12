package javaDatabaseConnectivity;

import org.nocrala.tools.texttablefmt.Table;

import java.io.File;
import java.sql.*;
import java.util.Properties;

/**
 * Beispiel: Ausgabe in einer Text-Tabelle.
 *
 * @author <a href="mailto:mgn.schule@gmx.de">Michael Niedermair</a>
 * @version $Revision: 1543 $
 */
public class TextTableFormater {

   public static void main(final String[] args)
            throws ClassNotFoundException, SQLException {

      final File dir = new File("src/csv/");
      Class.forName("org.relique.jdbc.csv.CsvDriver");
      final Properties props = new Properties();
      props.put("charset", "UTF-8");
      props.put("quotechar", "\"");
      props.put("separator", ",");
      props.put("suppressHeaders", "false");
      props.put("columnTypes", "String,String,String,String,String,Integer");
      final Connection con = DriverManager.getConnection(
               "jdbc:relique:csv:" + dir.getAbsolutePath(), props);
      final Statement stmt = con.createStatement();
      final ResultSet rs = stmt.executeQuery("SELECT * FROM adr ORDER by 1");

      printResultSet(rs);
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
            t.addCell(o.toString());
         }
      }
      System.out.println(t.render());
   }
}
