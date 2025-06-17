package org.example.techstore.controller;

import org.example.techstore.model.Cart;
import org.example.techstore.model.User;
import org.example.techstore.service.CartService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CartController{
    CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @PostMapping("/addcartajax")
    @ResponseBody
    public Map<String, Object> addToCartAjax(@RequestParam("productId") int productId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user"); // hoặc "account"
        if (user == null) {
            response.put("success", false);
            response.put("redirect", "/req/login");
            return response;
        }

        cartService.addToCart(user.getEmail(), productId);

        int cartsize = cartService.getCartsByUser(user).size();
        session.setAttribute("cartsize", cartsize);
        response.put("success", true);
        response.put("cartSize", cartsize);
        return response;
    }
    @GetMapping("/minuscart")
    public String minusToCart(@RequestParam("productId") int productId, HttpSession session, Model model) {


        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user"); // hoặc "account"
        if (user == null) {
            return "redirect:/req/login";
        }
        cartService.minusFromCart(user.getEmail(), productId);
        return cart(session, model );

    }

    @GetMapping("/addcart")
    public String addToCart(@RequestParam("productId") int productId, HttpSession session, Model model) {
        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user"); // hoặc "account"
        if (user == null) {
            return "redirect:/req/login";
        }
        cartService.addToCart(user.getEmail(), productId);
        return cart(session, model );

    }

    @GetMapping("/removeCart")
    public String removeToCart(@RequestParam("productId") int productId, HttpSession session, Model model) {
        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user"); // hoặc "account"
        if (user == null) {
            return "redirect:/req/login";
        }
        cartService.removeFromCart(user.getEmail(), productId);
        return cart(session, model);

    }

    @GetMapping("/cart")
    public String cart(HttpSession session,Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/req/login";
        } else {
            List<Cart> carts = cartService.getCartsByUser(user);
            int total = 0;
            for (Cart cart : carts) {
                total += cart.getQuantity()*cart.getProduct().getPrice();
            }

            model.addAttribute("carts", carts);
            model.addAttribute("total", total);

            return "cart";
        }
    }
}

