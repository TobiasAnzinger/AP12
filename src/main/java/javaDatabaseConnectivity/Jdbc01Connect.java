package javaDatabaseConnectivity;

public class Jdbc01Connect {

    @SuppressWarnings("unused")
    public static void main(String[] args) {
        System.out.println("JDBC Connection test");
        System.out.println("====================");

        Util.getConnection("BEISPIEL");
    }
}
