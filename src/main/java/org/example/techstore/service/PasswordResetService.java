package org.example.techstore.service;

import org.example.techstore.model.User;
import org.example.techstore.repository.UserRepository;
import org.example.techstore.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PasswordResetService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean requestPasswordReset(String email) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (!userOpt.isPresent()) {
            return false;
        }

        User user = userOpt.get();
        String resetToken = jwtTokenUtil.generateToken(email);
        user.setResetToken(resetToken);
        userRepository.save(user);
        emailService.sendForgotPasswordEmail(email, resetToken);
        return true;
    }

    public boolean validateResetToken(String token) {
        if (!jwtTokenUtil.validateToken(token)) {
            return false;
        }
        String email = jwtTokenUtil.getEmailFromToken(token);
        Optional<User> userOpt = userRepository.findByEmail(email);
        return userOpt.isPresent() && token.equals(userOpt.get().getResetToken());
    }

    public boolean resetPassword(String token, String newPassword) {
        if (!validateResetToken(token)) {
            return false;
        }

        String email = jwtTokenUtil.getEmailFromToken(token);
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (!userOpt.isPresent()) {
            return false;
        }

        User user = userOpt.get();
        user.setPassword(passwordEncoder.encode(newPassword));
        user.setResetToken(null);
        userRepository.save(user);

        return true;
    }
}