package org.example.techstore.controller;

import org.example.techstore.model.Category;
import org.example.techstore.model.Product;
import org.example.techstore.service.CategoryService;
import org.example.techstore.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class SearchProducts {
    private final CategoryService categoryService;
    private final ProductService productService;
    private List<Product> products = new ArrayList<>();
    private String search = "";
    private Category categorySelected = null;

    public SearchProducts(CategoryService categoryService ,ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }


    @GetMapping("/search")
    public String searchpost(@RequestParam (required = false) String search, @RequestParam(required = false) Integer category, Model model) {
        if (search != null) {
            this.search = search;
           this.categorySelected = null;
        }


        if (category != null) {
            this.categorySelected = categoryService.getCategoryBycategoryID(category).orElse(null);
        }

        findProductsBySearch();
        if (categorySelected != null) {
            findProductsByCategory();
        }


        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("products", products);
        model.addAttribute("search", this.search);
        model.addAttribute("categorySelected", categorySelected);

        return "store";
    }

    private void findProductsBySearch() {
        products = productService.getProductsByNameContaining(search);
    }

    private void findProductsByCategory() {
        List<Product> result = new ArrayList<>();
        for (Product product : products) {
            if (product.getCategory().equals(categorySelected)) {
                result.add(product);
            }
        };
        products = result;
    }
}