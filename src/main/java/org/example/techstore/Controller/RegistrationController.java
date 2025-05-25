package org.example.techstore.Controller;

import org.example.techstore.service.EmailService;
import org.example.techstore.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.example.techstore.Model.AppUser;
import org.example.techstore.Model.AppUserRepository;

import javax.mail.MessagingException;

@RestController
public class RegistrationController {

    @Autowired
    private AppUserRepository appUserRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @PostMapping(value = "/req/signup", consumes = "application/json")
    public ResponseEntity<String> createUser(@RequestBody AppUser user) {
        // Check if username already exists
        if (appUserRepository.findByUsername(user.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body("Username already exists");
        }

        // Check if email already exists
        AppUser existingUser = appUserRepository.findByEmail(user.getEmail());
        if (existingUser != null) {
            if (existingUser.isVerified()) {
                return ResponseEntity.badRequest().body("Email already registered and verified");
            } else {
                // Resend verification email
                String verificationToken = jwtTokenUtil.generateToken(existingUser.getEmail());
                existingUser.setVerficationToken(verificationToken);
                appUserRepository.save(existingUser);
                try {
                    emailService.sendVerificationEmail(existingUser.getEmail(), verificationToken);
                    return ResponseEntity.ok("Verification email resent. Please check your inbox.");
                } catch (MessagingException e) {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .body("Error sending verification email");
                }
            }
        }

        // Create new user
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setVerified(false);
        String verificationToken = jwtTokenUtil.generateToken(user.getEmail());
        user.setVerficationToken(verificationToken);
        appUserRepository.save(user);

        try {
            emailService.sendVerificationEmail(user.getEmail(), verificationToken);
            return ResponseEntity.ok("Registration successful! Please check your email to verify your account.");
        } catch (MessagingException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Registration successful but error sending verification email");
        }
    }

    @GetMapping("/verify")
    public ResponseEntity<String> verifyEmail(@RequestParam String token) {
        if (!jwtTokenUtil.validateToken(token)) {
            return ResponseEntity.badRequest().body("Invalid or expired verification token");
        }

        String email = jwtTokenUtil.getEmailFromToken(token);
        AppUser user = appUserRepository.findByEmail(email);

        if (user == null) {
            return ResponseEntity.badRequest().body("User not found");
        }

        if (user.isVerified()) {
            return ResponseEntity.badRequest().body("Email already verified");
        }

        if (!token.equals(user.getVerficationToken())) {
            return ResponseEntity.badRequest().body("Invalid verification token");
        }

        user.setVerified(true);
        user.setVerficationToken(null);
        appUserRepository.save(user);

        return ResponseEntity.ok("Email verified successfully! You can now login.");
    }
}
