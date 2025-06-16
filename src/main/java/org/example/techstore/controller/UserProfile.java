package org.example.techstore.controller;

import org.example.techstore.model.Cart;
import org.example.techstore.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class UserProfile {
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/req/login";
        } else {
            return "profile";
        }
    }
}
