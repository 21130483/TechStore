package org.example.techstore.controller;

import org.example.techstore.model.Cart;
import org.example.techstore.model.User;
import org.example.techstore.service.CartService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserCart {
    CartService cartService;

    public UserCart(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/cart")
    public String cart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/req/login";
        } else {
            List<Cart> carts = cartService.getCartsByUser(user);
            model.addAttribute("carts", carts);
            return "cart";
        }
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam Long productId) {
        // thêm sản phẩm vào giỏ hàng trong session hoặc database
        return "redirect:/cart"; // hoặc JSON nếu là AJAX
    }

}