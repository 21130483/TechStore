package org.example.techstore.controller;

import org.example.techstore.model.Product;
import org.example.techstore.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class ProductDetail {
    ProductService productService;
    @RequestMapping("/productDetail")
    public String productDetail(@RequestParam("id") Integer id, Model model) {
        Optional<Product> productOpt = productService.getProductById(id);

        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            return "product"; // Tên file JSP
        } else {
            model.addAttribute("error", "Không tìm thấy sản phẩm");
            return "index";
        }
    }
}
