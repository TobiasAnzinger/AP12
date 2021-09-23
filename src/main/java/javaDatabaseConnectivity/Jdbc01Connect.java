package javaDatabaseConnectivity;

import java.sql.Connection;
import java.sql.DriverManager;

public class Jdbc01Connect {

    @SuppressWarnings("unused")
    public static void main(String[] args) {
        System.out.println("JDBC Connection test");
        System.out.println("====================");

        try {
//            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/db?allowMultiQueries=true", "root", "123"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Metadaten der Datenbank:");
        System.out.println("DB: " );
        System.out.println("Version: ");
    }

}
