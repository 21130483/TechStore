package org.example.techstore.controller;

import org.example.techstore.model.User;
import org.example.techstore.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Login {
    private final UserService userService;

    public Login(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String login(){
        for(User user : userService.getAllUsers()) {
            System.out.println(user.toString());
        }
        return "login";
    }

    @PostMapping("/login")
    public String checklogin(@RequestParam String username, @RequestParam String password) {
        System.out.println(username);

        if (userService.checkLogin(username, password)) {
            System.out.println("success");
            return "redirect:/";

        } else {
            System.out.println("failed");
            return "login";
        }
    }
}
