package org.example.techstore.controller;

import org.example.techstore.model.Cart;
import org.example.techstore.model.User;
import org.example.techstore.service.CartService;
import org.example.techstore.service.PurchaseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;


@Controller
public class CheckOut {
    CartService cartService;
    PurchaseService purchaseService;

    public CheckOut(CartService cartService, PurchaseService purchaseService) {
        this.cartService = cartService;
        this.purchaseService = purchaseService;
    }

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
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
            return "checkout";
        }
    }

    @PostMapping("/checkout")
    public String addPurchase(@RequestParam String city, String district,String ward,String addressdetail,HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/req/login";
        }
        String address = addressdetail+", "+ ward+", "+district +", "+city;
        for (Cart cart : cartService.getCartsByUser(user)) {
            purchaseService.addPurchaseCheckout(user.getEmail(), cart.getProduct().getProductID(), cart.getQuantity(), cart.getTotal(), new Date(), address);
            cartService.removeFromCartsByCart(cart);
        }
        session.setAttribute("cartsize", 0);
        return "redirect:/";
    }

}
