/*
 * $Id: JDBCCSV.java 1543 2015-10-27 09:55:05Z michael $
 */
package javaDatabaseConnectivity;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * Beispiel: Lesen einer CSV-Datei mit Hilfe von JDBC.
 *
 * @author <a href="mailto:mgn.schule@gmx.de">Michael Niedermair</a>
 * @version $Revision: 1543 $
 */
public class JDBCCSV {

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
      while (rs.next()) {
         final String name = rs.getString(1);
         final String vorname = rs.getString(2);
         final String strasse = rs.getString(3);
         final String plz = rs.getString(4);
         final String ort = rs.getString(5);
         final int alter = rs.getInt(6);
         System.out.println(name + ", " + vorname + " --> " + alter);
      }
   }
}
