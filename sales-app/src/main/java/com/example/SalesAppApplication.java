package com.example;

import java.security.Principal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.oauth2.client.EnableOAuth2Sso;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@EnableOAuth2Sso
@RestController
public class SalesAppApplication {

    public static void main(String[] args) {
        SpringApplication.run(SalesAppApplication.class, args);
    }

    @RequestMapping
    public String hello(Principal p) {
        return "Hello " + p.getName();

    }

}
