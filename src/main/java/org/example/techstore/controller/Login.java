package org.example.techstore.controller;

import org.example.techstore.model.User;
import org.example.techstore.service.CartService;
import org.example.techstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class Login {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final CartService cartService;

    @Autowired
    public Login(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.cartService = new CartService();
    }

    @GetMapping("/req/login")
    public String login() {
        return "login";
    }

    @PostMapping("/req/login")
    public String checklogin(@RequestParam String username, @RequestParam String password, HttpSession session) {
        User user = userService.checkLogin(username, password);

        if ( user==null) {
            System.out.println("success");
            session.setAttribute("user", user);
            System.out.println(user.toString());
            int cartsize = cartService.getCartsByUser(user).size();
            System.out.println("cartsize "+cartsize);
            if(cartsize>0) {
                session.setAttribute("cartsize", cartsize);
            }
            return "redirect:/";
        } else {
            System.out.println("failed");
            return "redirect:/req/login?error";
        }
    }
}
