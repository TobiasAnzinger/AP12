package javaDatabaseConnectivity;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;

public class Jdbc01Connect {

    @SuppressWarnings("unused")
    public static void main(String[] args) {

        Logger log = LoggerFactory.getLogger(Main.class);
        log.info("JDBC01 Connection test\n====================");
        Connection con = Util.getConnection("db");
        Util.close(con);
    }
}
