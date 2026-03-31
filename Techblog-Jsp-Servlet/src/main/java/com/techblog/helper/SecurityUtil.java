package com.techblog.helper;

public class SecurityUtil {

    public static String escapeHtml(String input) {

        if (input == null) return null;

        return input
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}