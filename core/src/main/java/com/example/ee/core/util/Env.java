package com.example.ee.core.util;

import java.io.InputStream;
import java.util.Properties;

public class Env {
    private  static Properties prop = new Properties();
    static {
        try {
            InputStream inputStream =  Env.class.getClassLoader().getResourceAsStream("application.properties");
            prop.load(inputStream);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public static String getProperty(String key) {
        return prop.getProperty(key);
    }
}
