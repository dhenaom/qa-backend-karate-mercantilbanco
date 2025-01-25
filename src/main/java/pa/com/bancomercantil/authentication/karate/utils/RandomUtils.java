package pa.com.bancomercantil.authentication.karate.utils;

import java.util.Random;

public class RandomUtils {
    private static final Random random = new Random();

    public static String generateRandomUtil(int length, String type) {
        String chars;
        if (type.equals("number")) {
            chars = "0123456789";
        } else if (type.equals("password")) {
            chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        } else {
            chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        }
        StringBuilder randomString = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(chars.length());
            randomString.append(chars.charAt(randomIndex));
        }
        return randomString.toString();
    }
}