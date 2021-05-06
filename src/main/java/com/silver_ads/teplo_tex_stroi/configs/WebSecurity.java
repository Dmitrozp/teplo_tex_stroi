package com.silver_ads.teplo_tex_stroi.configs;

import com.silver_ads.teplo_tex_stroi.service.UserServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;

@EnableWebSecurity
public class WebSecurity extends WebSecurityConfigurerAdapter {

    @Autowired
    UserServicesImpl userServices;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        http.requiresChannel().anyRequest().requiresSecure();

        http.authorizeRequests()
                .antMatchers("/order/**").authenticated()
                .antMatchers("/profile/**").hasAnyRole("ADMIN", "USER", "SUPER_USER")
                .antMatchers("/manager").hasAnyRole("ADMIN", "MANAGER", "SUPER_MANAGER")
                .antMatchers("/admin").hasAnyRole("ADMIN")
                .and()
                .formLogin()
                .and()
                .logout().logoutSuccessUrl("/")
                .and()
                .csrf().disable();
    }

//    @Bean
//    public UserDetailsManager users(){
//        UserDetails admin= User.builder()
//                .username("admin")
//                .password("{noop}admin")
//                .roles("ADMIN", "USER")
//                .build();
//        UserDetails guest = User.builder()
//                .username("guest")
//                .password("{noop}guest")
//                .roles("USER")
//                .build();
//        return new InMemoryUserDetailsManager(admin,guest);
//    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        authenticationProvider.setUserDetailsService(userServices);

        return authenticationProvider;
    }
}
