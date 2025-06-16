package org.example.techstore.controller;

import org.example.techstore.model.Product;
import org.example.techstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ProductDetail {
    @Autowired
    private ProductService productService;

    @GetMapping("/product/{id}")
    public String showProductDetail(@PathVariable("id") Integer productId, Model model) {
        Product product = productService.getProductById(productId);
        if (product != null) {
        model.addAttribute("product", product);
        return "productdetail";
        }
        return "redirect:/";
    }
}
