package org.example.techstore.controller;

import org.example.techstore.model.User;
import org.example.techstore.repository.UserRepository;
import org.example.techstore.service.EmailService;
import org.example.techstore.utils.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.Optional;

@Controller
public class RegistrationController {
    private static final Logger logger = LoggerFactory.getLogger(RegistrationController.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "register";
        }

        // Check if email already exists
        Optional<User> existingUserByEmail = userRepository.findByEmail(user.getEmail());
        if (existingUserByEmail.isPresent()) {
            model.addAttribute("error", "Email đã được sử dụng");
            return "register";
        }

        // Check if username already exists
        Optional<User> existingUserByUsername = userRepository.findByUsername(user.getUsername());
        if (existingUserByUsername.isPresent()) {
            model.addAttribute("error", "Tên đăng nhập đã được sử dụng");
            return "register";
        }

        // Hash password and save user
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);

        return "redirect:/login?registered";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String email, Model model) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (!userOpt.isPresent()) {
            model.addAttribute("error", "Email không tồn tại trong hệ thống");
            return "forgot-password";
        }

        User user = userOpt.get();
        String resetToken = jwtTokenUtil.generateToken(email);
        user.setResetToken(resetToken);
        userRepository.save(user);

        try {
            emailService.sendForgotPasswordEmail(email, resetToken);
            model.addAttribute("success", "Hướng dẫn đặt lại mật khẩu đã được gửi đến email của bạn");
        } catch (Exception e) {
            logger.error("Error sending password reset email", e);
            model.addAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
        }

        return "forgot-password";
    }
}