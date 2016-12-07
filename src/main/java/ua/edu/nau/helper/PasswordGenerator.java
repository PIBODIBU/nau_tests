package ua.edu.nau.helper;

import java.security.SecureRandom;

public class PasswordGenerator {
    private static final char[] symbols;

    static {
        StringBuilder tmp = new StringBuilder();
        for (char ch = '0'; ch <= '9'; ++ch)
            tmp.append(ch);
        for (char ch = 'a'; ch <= 'z'; ++ch)
            tmp.append(ch);
        symbols = tmp.toString().toCharArray();
    }

    public static String generate(Integer length) {
        if (length < 1)
            throw new IllegalArgumentException("length < 1: " + length);

        char[] buf = new char[length];
        SecureRandom random = new SecureRandom();

        for (int idx = 0; idx < buf.length; ++idx)
            buf[idx] = symbols[random.nextInt(symbols.length)];
        return new String(buf);
    }
}