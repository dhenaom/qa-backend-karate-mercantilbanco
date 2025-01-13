package pa.com.bancomercantil.authentication.karate.utils;

import java.util.Random;

public class NameUtils {
    private static final Random random = new Random();

    public static String generateRandomName(int length) {
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

        StringBuilder randomString = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(chars.length());
            randomString.append(chars.charAt(randomIndex));
        }
        return randomString.toString();
    }
}