package org.example.techstore.config;

import org.example.techstore.service.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
            .passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
                // Static resources
                .antMatchers(
                    "/assets/**",
                    "/static/**", 
                    "/css/**", 
                    "/js/**", 
                    "/img/**",
                    "/images/**", 
                    "/fonts/**", 
                    "/webfonts/**"
                ).permitAll()
                // Public pages
                .antMatchers("/", "/index", "/store", "/product/**", "/cart", "/checkout").permitAll()
                .antMatchers("/req/login", "/req/signup", "/req/verify", "/verify").permitAll()
                .antMatchers("/admin/**").permitAll()
                .anyRequest().permitAll()
            .and()
            .formLogin()
                .loginPage("/req/login")
                .loginProcessingUrl("/req/login")
                .usernameParameter("username")
                .passwordParameter("password")
                .defaultSuccessUrl("/")
                .failureUrl("/req/login?error")
                .permitAll()
            .and()
            .logout()
                .logoutSuccessUrl("/")
                .permitAll()
            .and()
            .anonymous()
                .principal("guest")
                .authorities("ROLE_ANONYMOUS");
    }
} 