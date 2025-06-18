package org.example.techstore.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.util.Locale;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Bean
    public LocaleResolver localeResolver() {
        SessionLocaleResolver localeResolver = new SessionLocaleResolver();
        localeResolver.setDefaultLocale(new Locale("vi"));
        return localeResolver;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
        interceptor.setParamName("lang");
        return interceptor;
    }

    @Bean
    public MessageSource messageSource() {
        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        messageSource.setBasename("i18n/messages");
        messageSource.setDefaultEncoding("UTF-8");
        return messageSource;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Handle /assets/** URLs
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/assets/", "classpath:/static/");
                
        // Handle direct resource type URLs
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/assets/css/", "classpath:/static/css/");
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/assets/js/", "classpath:/static/js/");
        registry.addResourceHandler("/img/**")
                .addResourceLocations("classpath:/assets/img/", "classpath:/static/img/");
        registry.addResourceHandler("/fonts/**")
                .addResourceLocations("classpath:/assets/fonts/", "classpath:/static/fonts/");
        registry.addResourceHandler("/webfonts/**")
                .addResourceLocations("classpath:/assets/webfonts/", "classpath:/static/webfonts/");
                
        // Handle images URLs
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/assets/img/", "classpath:/static/img/");
    }
} 