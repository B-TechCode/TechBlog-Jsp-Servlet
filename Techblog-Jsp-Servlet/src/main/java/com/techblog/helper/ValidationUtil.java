package com.techblog.helper;

public class ValidationUtil {

    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    public static boolean isValidText(String text) {
        return text != null && !text.trim().isEmpty() && text.length() <= 500;
    }
}