package org.example.techstore.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.example.techstore.model.User;
import org.example.techstore.service.BlogService;
import org.example.techstore.service.ProductService;
import org.example.techstore.service.UserService;
import org.example.techstore.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collections;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private VoucherService voucherService;

    @Autowired
    private BlogService blogService;

    @GetMapping("")
    public String adminDashboard(Model model) {
        logger.info("Accessing admin dashboard");
        try {
            // Add default values first
            model.addAttribute("visitorCount", 0);
            model.addAttribute("transactions", new ArrayList<>());
            
            // Add statistics data
            try {
                logger.info("Getting user count");
                int userCount = userService.getAllUsers().size();
                model.addAttribute("userCount", userCount);
            } catch (Exception e) {
                logger.error("Error getting user count: " + e.getMessage());
                model.addAttribute("userCount", 0);
            }

            try {
                logger.info("Getting product count");
                int productCount = productService.getAllProducts().size();
                model.addAttribute("productCount", productCount);
            } catch (Exception e) {
                logger.error("Error getting product count: " + e.getMessage());
                model.addAttribute("productCount", 0);
            }

            try {
                logger.info("Getting voucher count");
                int voucherCount = voucherService.getAllVouchers().size();
                model.addAttribute("voucherCount", voucherCount);
            } catch (Exception e) {
                logger.error("Error getting voucher count: " + e.getMessage());
                model.addAttribute("voucherCount", 0);
            }

            try {
                logger.info("Getting blog count");
                int blogCount = blogService.getAllBlogs().size();
                model.addAttribute("blogCount", blogCount);
            } catch (Exception e) {
                logger.error("Error getting blog count: " + e.getMessage());
                model.addAttribute("blogCount", 0);
            }

            logger.info("Successfully prepared admin dashboard data");
            return "admin";
        } catch (Exception e) {
            logger.error("Error in adminDashboard: " + e.getMessage(), e);
            // Add empty data to prevent null pointer exceptions in the view
            model.addAttribute("userCount", 0);
            model.addAttribute("productCount", 0);
            model.addAttribute("voucherCount", 0);
            model.addAttribute("blogCount", 0);
            model.addAttribute("visitorCount", 0);
            model.addAttribute("transactions", Collections.emptyList());
            return "admin";
        }
    }

    @GetMapping("/users")
    public String manageUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "manageruser";
    }

    @GetMapping("/products")
    public String manageProducts(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "managerproduct";
    }

    @GetMapping("/vouchers")
    public String manageVouchers(Model model) {
        model.addAttribute("vouchers", voucherService.getAllVouchers());
        return "managervoucher";
    }

    @GetMapping("/blogs")
    public String manageBlogs(Model model) {
        model.addAttribute("blogs", blogService.getAllBlogs());
        return "bloguser";
    }

    // Product management endpoints
    @GetMapping("/products/add")
    public String showAddProductForm() {
        return "addproduct";
    }

    @GetMapping("/products/edit/{id}")
    public String showEditProductForm(@PathVariable Integer id, Model model) {
        model.addAttribute("product", productService.getProductById(id));
        return "editproduct";
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Integer id) {
        productService.deleteProduct(id);
        return "redirect:/admin/products";
    }

    // Voucher management endpoints
    @GetMapping("/vouchers/add")
    public String showAddVoucherForm() {
        return "addvoucher";
    }

    @GetMapping("/vouchers/edit/{id}")
    public String showEditVoucherForm(@PathVariable Integer id, Model model) {
        model.addAttribute("voucher", voucherService.getVoucherById(id));
        return "editvoucher";
    }

    @PostMapping("/vouchers/delete/{id}")
    public String deleteVoucher(@PathVariable Integer id) {
        voucherService.deleteVoucher(id);
        return "redirect:/admin/vouchers";
    }

    // Blog management endpoints
    @GetMapping("/blogs/view/{id}")
    public String viewBlog(@PathVariable Integer id, Model model) {
        model.addAttribute("blog", blogService.getBlogById(id));
        return "viewblog";
    }

    @PostMapping("/blogs/toggle/{id}")
    public String toggleBlogStatus(@PathVariable Integer id) {
        blogService.getBlogById(id).ifPresent(blog -> {
            String newStatus = blog.getStatus().equals("PUBLISHED") ? "DRAFT" : "PUBLISHED";
            blogService.updateBlogStatus(id, newStatus);
        });
        return "redirect:/admin/blogs";
    }

    @PostMapping("/blogs/delete/{id}")
    public String deleteBlog(@PathVariable Integer id) {
        blogService.deleteBlog(id);
        return "redirect:/admin/blogs";
    }
} 