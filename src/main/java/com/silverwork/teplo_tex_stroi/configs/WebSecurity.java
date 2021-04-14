package com.silverwork.teplo_tex_stroi.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;

@EnableWebSecurity
public class WebSecurity extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/order/**").authenticated()
                .antMatchers("/profile/**").authenticated()
                .antMatchers("/order/addUser").authenticated()
                .antMatchers("/admin").hasAnyRole("ADMIN", "MANAGER")
                .antMatchers("/api/**").hasIpAddress("192.168.0.110")
                .and()
                .formLogin()
                .and()
                .logout().logoutSuccessUrl("/");
    }

    @Bean
    public UserDetailsManager users(){
        UserDetails admin= User.builder()
                .username("admin")
                .password("{noop}admin")
                .roles("ADMIN", "USER")
                .build();
        UserDetails guest = User.builder()
                .username("guest")
                .password("{noop}guest")
                .roles("USER")
                .build();
        return new InMemoryUserDetailsManager(admin,guest);
    }
}
