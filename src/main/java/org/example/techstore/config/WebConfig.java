package org.example.techstore.config;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.concurrent.ConcurrentMapCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableCaching
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        registry.viewResolver(resolver);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve static resources from /static directory
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");

        // Serve static resources from /assets directory
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/assets/");

        // Serve static resources from /resources directory
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Admin dashboard
        registry.addViewController("/admin").setViewName("admin");
        
        // Product management
        registry.addViewController("/admin/products").setViewName("managerproduct");
        registry.addViewController("/admin/products/add").setViewName("addproduct");
        registry.addViewController("/admin/products/edit").setViewName("editproduct");
        
        // Voucher management
        registry.addViewController("/admin/vouchers").setViewName("managervoucher");
        registry.addViewController("/admin/vouchers/add").setViewName("addvoucher");
        registry.addViewController("/admin/vouchers/edit").setViewName("editvoucher");
        
        // Blog management
        registry.addViewController("/admin/blogs").setViewName("bloguser");
        registry.addViewController("/admin/blogs/add").setViewName("addblog");
        registry.addViewController("/admin/blogs/edit").setViewName("editblog");
        registry.addViewController("/admin/blogs/view").setViewName("viewblog");
        
        // User management
        registry.addViewController("/admin/users").setViewName("manageruser");
        registry.addViewController("/admin/users/add").setViewName("adduser");
        registry.addViewController("/admin/users/edit").setViewName("edituser");
        
        // Order management
        registry.addViewController("/admin/orders").setViewName("managerorder");
        registry.addViewController("/admin/orders/view").setViewName("vieworder");
    }

    @Bean
    public CacheManager cacheManager() {
        return new ConcurrentMapCacheManager("products", "product", "categories", "category", "users", "user", "blogs", "blog", "vouchers", "voucher", "purchases", "purchase");
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        return resolver;
    }
} 