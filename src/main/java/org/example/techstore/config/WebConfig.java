package org.example.techstore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

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