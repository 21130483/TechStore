package org.example.techstore.controller;

import org.example.techstore.model.Category;
import org.example.techstore.model.Product;
import org.example.techstore.service.CategoryService;
import org.example.techstore.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class SearchProducts {
    private final CategoryService categoryService;
    private final ProductService productService;
    private List<Product> products = new ArrayList<>();
    private String search = "";
    private Category categorySelected;

    public SearchProducts(CategoryService categoryService ,ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }

    @GetMapping("/search")
    public String searchget(){
        return "store";
    }

    @PostMapping("/search")
    public String searchpost(@RequestParam String search, Model model) {
        products = productService.getProductsByNameContaining(search);

        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("products", products);
        model.addAttribute("search", search);
        return "store";
    }
}