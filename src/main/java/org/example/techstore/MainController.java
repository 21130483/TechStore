package org.example.techstore;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Collection;

@Controller
public class MainController {
    @RequestMapping("/")
    public String home() {
        return "index"; // Không cần ghi đường dẫn đầy đủ
    }
}
