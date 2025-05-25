package org.example.techstore.service;

import org.example.techstore.Model.AppUser;
import org.example.techstore.Model.AppUserRepository;
import org.example.techstore.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class PasswordResetService {

    @Autowired
    private AppUserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean requestPasswordReset(String email) {
        AppUser user = userRepository.findByEmail(email);
        if (user != null) {
            String resetToken = jwtTokenUtil.generateToken(email);
            user.setResetToken(resetToken);
            userRepository.save(user);
            emailService.sendForgotPasswordEmail(email, resetToken);
            return true;
        }
        return false;
    }

    public boolean validateResetToken(String token) {
        if (!jwtTokenUtil.validateToken(token)) {
            return false;
        }
        String email = jwtTokenUtil.getEmailFromToken(token);
        AppUser user = userRepository.findByEmail(email);
        return user != null && token.equals(user.getResetToken());
    }

    public boolean resetPassword(String token, String newPassword) {
        if (!validateResetToken(token)) {
            return false;
        }

        String email = jwtTokenUtil.getEmailFromToken(token);
        AppUser user = userRepository.findByEmail(email);
        
        user.setPassword(passwordEncoder.encode(newPassword));
        user.setResetToken(null);
        userRepository.save(user);
        
        return true;
    }
} 