package jpa;

public class Util {

    public static String truncateString(String s, int length) {
        return s.length() >= 30 ? s.substring(0, length) : s;
    }

}
