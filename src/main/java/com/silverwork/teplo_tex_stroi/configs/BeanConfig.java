package com.silverwork.teplo_tex_stroi.configs;

import com.silverwork.teplo_tex_stroi.entity.Order;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

@Configuration
public class BeanConfig {

    @Bean
    @Scope("prototype")
    public Order beanOrder() {
        return new Order();
    }
}
