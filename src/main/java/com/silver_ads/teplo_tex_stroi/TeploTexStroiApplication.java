package com.silver_ads.teplo_tex_stroi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class TeploTexStroiApplication {

    public static void main(String[] args) {
        SpringApplication.run(TeploTexStroiApplication.class, args);
    }

}
