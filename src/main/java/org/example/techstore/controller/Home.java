package org.example.techstore.controller;

import org.example.techstore.model.Product;
import org.example.techstore.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class Home {
    ProductService productService;

    public Home(ProductService productService) {
        this.productService = productService;
    }

    @RequestMapping("/")
    public String root() {
        return "redirect:/index";
    }
    @RequestMapping("/index")
    public String home(Model model) {
        List<Product> productList = productService.getAllProducts();
        model.addAttribute("products", productList);
        return "index";
    }
}