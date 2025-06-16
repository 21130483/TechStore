package org.example.techstore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {


    @RequestMapping("/checkout")
    public String checkout() {
        return "checkout"; // Không cần ghi đường dẫn đầy đủ
    }


    @GetMapping("/req/signup")
    public String signup(){
        return "signup";
    }
}
