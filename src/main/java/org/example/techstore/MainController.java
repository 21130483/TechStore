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

    @RequestMapping("/product")
    public String product() {
        return "product"; // Không cần ghi đường dẫn đầy đủ
    }
}
