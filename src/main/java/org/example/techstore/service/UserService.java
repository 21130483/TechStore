package org.example.techstore.service;

import org.example.techstore.model.User;
import org.example.techstore.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    public User checkLogin(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            return passwordEncoder.matches(password, user.getPassword())?user:null;
        }
        return null;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User addUser(User user) {
        try {
            logger.info("Adding new user: {}", user.getEmail());
            
            // Validate required fields
            if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                throw new IllegalArgumentException("Email is required");
            }
            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                throw new IllegalArgumentException("Username is required");
            }
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                throw new IllegalArgumentException("Password is required");
            }
            if (user.getPhoneNumbers() == null || user.getPhoneNumbers().trim().isEmpty()) {
                throw new IllegalArgumentException("Phone number is required");
            }
            if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                throw new IllegalArgumentException("Full name is required");
            }
            if (user.getDob() == null) {
                throw new IllegalArgumentException("Date of birth is required");
            }
            if (user.getGender() == null || user.getGender().trim().isEmpty()) {
                throw new IllegalArgumentException("Gender is required");
            }
            if (user.getRole() == null || user.getRole().trim().isEmpty()) {
                throw new IllegalArgumentException("Role is required");
            }

            // Encode password
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            logger.info("Password encoded successfully");

            // Set default values if not provided
            if (user.getAccess() == null || user.getAccess().trim().isEmpty()) {
                user.setAccess("ACTIVE");
            }
            if (user.isVerified() == null) {
                user.setVerified(true);
            }

            // Save user
            User savedUser = userRepository.save(user);
            logger.info("User saved successfully: {}", savedUser.getEmail());
            return savedUser;
        } catch (Exception e) {
            logger.error("Error adding user: {}", e.getMessage(), e);
            throw new RuntimeException("Error adding user: " + e.getMessage());
        }
    }

    public User updateUser(User user) {
        User existingUser = userRepository.findByEmail(user.getEmail());
        if (existingUser != null) {
            // Only update password if a new one is provided
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                user.setPassword(passwordEncoder.encode(user.getPassword()));
            } else {
                user.setPassword(existingUser.getPassword());
            }
            return userRepository.save(user);
        }
        return null;
    }

    public void deleteUser(String email) {
        userRepository.deleteById(email);
    }

    public boolean isEmailExists(String email) {
        return userRepository.findByEmail(email) != null;
    }

    public boolean isUsernameExists(String username) {
        return userRepository.findByUsername(username).isPresent();
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User findByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }

    public User save(User user) {
        return userRepository.save(user);
    }
}