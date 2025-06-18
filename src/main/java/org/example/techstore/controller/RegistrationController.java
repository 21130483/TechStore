package org.example.techstore.controller;

import org.example.techstore.service.EmailService;
import org.example.techstore.utils.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.example.techstore.model.User;
import org.example.techstore.repository.UserRepository;

import javax.mail.MessagingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
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

    //check username exists
    @PostMapping("/check-username-exists")
    @ResponseBody
    public Map<String, Boolean> checkUsernameExists(@RequestParam String username) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", userRepository.findByUsername(username).isPresent());
        return response;
    }

    //check email exists
    @PostMapping("/check-email-exists")
    @ResponseBody
    public Map<String, Boolean> checkEmailExists(@RequestParam String email) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", userRepository.findByEmail(email) != null);
        return response;
    }

    @PostMapping(value = "/req/signup", consumes = "application/json")
    public ResponseEntity<String> createUser(@RequestBody User user) {
        try {
            logger.info("Processing registration request for email: {}", user.getEmail());

            // Check if username already exists
            if (userRepository.findByUsername(user.getUsername()).isPresent()) {
                logger.warn("Registration failed - Username already exists: {}", user.getUsername());
                return ResponseEntity.badRequest().body("Username already exists");
            }

            // Check if email already exists
            User existingUser = userRepository.findByEmail(user.getEmail());
            if (existingUser != null) {
                if (existingUser.isVerified()) {
                    logger.warn("Registration failed - Email already registered and verified: {}", user.getEmail());
                    return ResponseEntity.badRequest().body("Email already registered and verified");
                } else {
                    // Resend verification email
                    logger.info("Resending verification email for existing unverified user: {}", user.getEmail());
                    String verificationToken = jwtTokenUtil.generateToken(existingUser.getEmail());
                    existingUser.setVerificationToken(verificationToken);
                    userRepository.save(existingUser);
                    try {
                        emailService.sendVerificationEmail(existingUser.getEmail(), verificationToken);
                        logger.info("Verification email resent successfully to: {}", user.getEmail());
                        return ResponseEntity.ok("Verification email resent. Please check your inbox.");
                    } catch (MessagingException e) {
                        logger.error("Failed to resend verification email to: {}. Error: {}", user.getEmail(), e.getMessage(), e);
                        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .body("Error sending verification email");
                    }
                }
            }

            // Create new user
            logger.info("Creating new user account for email: {}", user.getEmail());
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setVerified(false);
            user.setRole("USER");  // Set default role
            user.setAccess("ACTIVE");  // Set default access status
            
            // Set default values for required fields if they are null
            if (user.getDob() == null) {
                user.setDob(new Date()); // Set current date as default DOB
            }
            if (user.getGender() == null) {
                user.setGender("Not specified"); // Set default gender
            }
            if (user.getPhoneNumbers() == null) {
                user.setPhoneNumbers("Not provided"); // Set default phone number
            }
            if (user.getFullName() == null) {
                user.setFullName(user.getUsername()); // Use username as default full name
            }

            String verificationToken = jwtTokenUtil.generateToken(user.getEmail());
            user.setVerificationToken(verificationToken);
            userRepository.save(user);

            try {
                emailService.sendVerificationEmail(user.getEmail(), verificationToken);
                logger.info("Registration successful and verification email sent to: {}", user.getEmail());
                return ResponseEntity.ok("Registration successful! Please check your email to verify your account.");
            } catch (MessagingException e) {
                logger.error("Registration successful but failed to send verification email to: {}", 
                    user.getEmail(), e.getMessage(), e);
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("Registration successful but error sending verification email");
            }
        } catch (Exception e) {
            logger.error("Unexpected error during user registration: {}", e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An unexpected error occurred during registration");
        }
    }

    @GetMapping("/verify")
    public ResponseEntity<String> verifyEmail(@RequestParam String token) {
        try {
            logger.info("Processing email verification request with token");

            if (!jwtTokenUtil.validateToken(token)) {
                logger.warn("Email verification failed - Invalid or expired token");
                return ResponseEntity.badRequest().body("Invalid or expired verification token");
            }

            String email = jwtTokenUtil.getEmailFromToken(token);
            logger.debug("Token validated for email: {}", email);

            User user = userRepository.findByEmail(email);
            if (user == null) {
                logger.warn("Email verification failed - User not found for email: {}", email);
                return ResponseEntity.badRequest().body("User not found");
            }

            if (user.isVerified()) {
                logger.warn("Email verification failed - Email already verified for: {}", email);
                return ResponseEntity.badRequest().body("Email already verified");
            }

            if (!token.equals(user.getVerificationToken())) {
                logger.warn("Email verification failed - Invalid verification token for email: {}", email);
                return ResponseEntity.badRequest().body("Invalid verification token");
            }

            user.setVerified(true);
            user.setVerificationToken(null);
            userRepository.save(user);
            logger.info("Email verification successful for: {}", email);

            return ResponseEntity.ok("Email verified successfully! You can now login.");
        } catch (Exception e) {
            logger.error("Unexpected error during email verification: {}", e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An unexpected error occurred during email verification");
        }
    }
}