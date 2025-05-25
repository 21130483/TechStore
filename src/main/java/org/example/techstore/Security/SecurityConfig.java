package org.example.techstore.Security;

import lombok.AllArgsConstructor;
import org.example.techstore.Model.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@AllArgsConstructor
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private final AppUserService appUserService;

    @Bean
    public UserDetailsService userDetailsService(){
        return appUserService;
    }

    @Bean
    public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(appUserService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception{
        return httpSecurity
                .csrf(AbstractHttpConfigurer::disable)
                .formLogin(httpForm -> {
                    httpForm.loginPage("/req/login")
                            .loginProcessingUrl("/req/login")
                            .defaultSuccessUrl("/index")
                            .failureUrl("/req/login?error")
                            .permitAll();
                })
                .authorizeRequests(auth -> {
                    auth.antMatchers("/", "/verify/**", "/req/**", "/index", "/css/**", "/js/**", "/img/**", "/fonts/**", "/h2-console/**").permitAll();
                    auth.antMatchers("/cart/**", "/checkout/**").authenticated();
                    auth.anyRequest().authenticated();
                })
                .sessionManagement(session -> {
                    session.maximumSessions(1)
                            .expiredUrl("/req/login?expired");
                    session.invalidSessionUrl("/req/login?invalid");
                })
                .headers(headers -> headers.frameOptions().disable())
                .build();
    }
}
