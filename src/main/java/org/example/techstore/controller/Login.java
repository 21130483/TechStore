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
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class Login {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final CartService cartService;

    @Autowired
    public Login(UserService userService, PasswordEncoder passwordEncoder,CartService cartService) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.cartService = cartService;
    }

    @GetMapping("/req/login")
    public String login() {
        return "login";
    }

//    @PostMapping("/req/login")
    @PostMapping("/checklogin")
    public String checklogin(@RequestParam String username, @RequestParam String password, HttpSession session) {
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            return "redirect:/req/login?error=empty_username";
        }
        if (password == null || password.trim().isEmpty()) {
            return "redirect:/req/login?error=empty_password";
        }
        
        // Check if username exists
        if (!userService.isUsernameExists(username)) {
            return "redirect:/req/login?error=username_not_found";
        }
        
        try {
            User user = userService.checkLogin(username, password);

            if (user != null) {
                session.setAttribute("user", user);
                int cartsize = cartService.getCartsByUser(user).size();
                session.setAttribute("cartsize", cartsize);
                return "redirect:/";
            } else {
                return "redirect:/req/login?error=true"; // Sai tài khoản hoặc mật khẩu
            }

        } catch (Exception e) {
            e.printStackTrace(); // Ghi log
            return "redirect:/req/login?error=server"; // Lỗi hệ thống
        }

    }

    @PostMapping("/check-username")
    @ResponseBody
    public Map<String, Boolean> checkUsername(@RequestParam String username) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", userService.isUsernameExists(username));
        return response;
    }
}
