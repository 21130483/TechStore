package org.example.techstore;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class TechStoreApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(TechStoreApplication.class, args);
    }
}