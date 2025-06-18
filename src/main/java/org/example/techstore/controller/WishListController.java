package org.example.techstore.controller;

import org.example.techstore.model.User;
import org.example.techstore.service.CartService;
import org.example.techstore.service.WishService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class WishListController {
    private final WishService wishService;

    public WishListController(WishService wishService) {
        this.wishService = wishService;
    }

    @PostMapping("/addwishajax")
    @ResponseBody
    public Map<String, Object> addToCartAjax(@RequestParam("productId") int productId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user"); // hoặc "account"
        if (user == null) {
            response.put("success", false);
            response.put("redirect", "/req/login");
            return response;
        }


        if(!wishService.addWish(user.getEmail(), productId)){
            response.put("success", false);
            response.put("message", "Đã tồn tại");
            wishService.removeWish(user.getEmail(), productId);
            return response;
        }

        response.put("success", true);
//        response.put("cartSize", "cartsize");
        return response;
    }
}
