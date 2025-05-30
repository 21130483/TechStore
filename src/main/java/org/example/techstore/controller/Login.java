package org.example.techstore.controller;

import org.example.techstore.model.User;
import org.example.techstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Login {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public Login(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/req/login")
    public String login() {
        for(User user : userService.getAllUsers()) {
            System.out.println(user.toString());
        }
        return "login";
    }

    @PostMapping("/req/login")
    public String checklogin(@RequestParam String username, @RequestParam String password) {
        System.out.println(username);

        if (userService.checkLogin(username, password)) {
            System.out.println("success");
            return "redirect:/";
        } else {
            System.out.println("failed");
            return "redirect:/req/login?error";
        }
    }
}
