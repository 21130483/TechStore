package org.example.techstore.controller;

import org.example.techstore.service.PasswordResetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/req")
public class PasswordResetController {

    @Autowired
    private PasswordResetService passwordResetService;

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    @ResponseBody
    public ResponseEntity<String> processForgotPassword(@RequestParam("email") String email) {
        boolean success = passwordResetService.requestPasswordReset(email);
        if (success) {
            return ResponseEntity.ok("Password reset instructions have been sent to your email.");
        } else {
            return ResponseEntity.badRequest().body("Email not found.");
        }
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(@RequestParam("token") String token, Model model) {
        if (passwordResetService.validateResetToken(token)) {
            model.addAttribute("token", token);
            return "reset-password";
        }
        return "redirect:/req/login?error=invalid_token";
    }

    @PostMapping("/reset-password")
    @ResponseBody
    public ResponseEntity<String> processResetPassword(
            @RequestParam("token") String token,
            @RequestParam("password") String password) {
        boolean success = passwordResetService.resetPassword(token, password);
        if (success) {
            return ResponseEntity.ok("Password has been reset successfully.");
        } else {
            return ResponseEntity.badRequest().body("Invalid or expired token.");
        }
    }
}