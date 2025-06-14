package org.example.techstore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

//    @RequestMapping("/")
//    public String root() {
//        return "redirect:/index";
//    }
//    @RequestMapping("/index")
//    public String home() {
//        return "index"; // Không cần ghi đường dẫn đầy đủ
//    }

    @RequestMapping("/cart")
    public String cart() {
        return "cart"; // Không cần ghi đường dẫn đầy đủ
    }

    @RequestMapping("/checkout")
    public String checkout() {
        return "checkout"; // Không cần ghi đường dẫn đầy đủ
    }

    @RequestMapping("/store")
    public String store() {
        return "store"; // Không cần ghi đường dẫn đầy đủ
    }

//    @RequestMapping("/product")
//    public String product() {
//        return "product"; // Không cần ghi đường dẫn đầy đủ
//    }

    @RequestMapping("/profile")
    public String profile() {
        return "profile"; // Không cần ghi đường dẫn đầy đủ
    }

    @GetMapping("/req/signup")
    public String signup(){
        return "signup";
    }
}
