package com.silverwork.teplo_tex_stroi.configs;

import com.silverwork.teplo_tex_stroi.service.UserServices;
import com.silverwork.teplo_tex_stroi.service.UserServicesImpl;
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
        http.authorizeRequests()
                .antMatchers("/order/**").authenticated()
                .antMatchers("/profile/**").authenticated()
                .antMatchers("/order/addUser").authenticated()
                .antMatchers("/admin").hasAnyRole("ADMIN", "MANAGER")
//                .antMatchers("/api/**").anonymous()
                .and()
                .formLogin()
                .and()
                .logout().logoutSuccessUrl("/")
                .and().csrf().disable();
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
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider(){
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        authenticationProvider.setUserDetailsService(userServices);

        return authenticationProvider;
    }
}