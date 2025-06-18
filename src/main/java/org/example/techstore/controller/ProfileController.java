package org.example.techstore.controller;

import org.example.techstore.model.Cart;
import org.example.techstore.model.Purchase;
import org.example.techstore.model.User;
import org.example.techstore.model.Wish;
import org.example.techstore.service.PurchaseService;
import org.example.techstore.service.UserService;
import org.example.techstore.service.WishService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ProfileController {
    private final PasswordEncoder passwordEncoder;
    private final PurchaseService purchaseService;
    private final WishService wishService;
    private final UserService userService;

    public ProfileController(PurchaseService purchaseService, WishService wishService, UserService userService, PasswordEncoder passwordEncoder) {
        this.purchaseService = purchaseService;
        this.wishService = wishService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/req/login";
        } else {
            List<Purchase> purchases = purchaseService.getPurchasesByUserEmail(user.getEmail());
            List<Wish> wishes = wishService.getWishesByUser(user);

            model.addAttribute("user", user);
            model.addAttribute("purchases", purchases);
            model.addAttribute("wishes", wishes);

            return "profile";
        }

    }

    @PostMapping("/change_password")
    public String changePassword(HttpSession session,
                                 @RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/req/login";
        }

        // So sánh mật khẩu hiện tại
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
//            model.addAttribute("error", "Mật khẩu hiện tại không đúng");
            return "profile"; // hoặc đổi sang trang đổi mật khẩu riêng
        }

        if (!newPassword.equals(confirmPassword)) {
//            model.addAttribute("error", "Mật khẩu mới không khớp");
            return "profile";
        }

        // Cập nhật mật khẩu
        user.setPassword(passwordEncoder.encode(newPassword));
        userService.save(user);

        model.addAttribute("success", "Đổi mật khẩu thành công");
        return "profile";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model){
        session.invalidate();
        return "redirect:/";

    }
}
