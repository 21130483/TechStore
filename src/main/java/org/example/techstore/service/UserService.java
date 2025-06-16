package org.example.techstore.service;

import org.example.techstore.model.User;
import org.example.techstore.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    public User checkLogin(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            System.out.println(passwordEncoder.encode(user.getPassword()));
            System.out.println(user.getPassword());
            return passwordEncoder.matches(password, user.getPassword())?user:null;
        }
        return null;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }


}