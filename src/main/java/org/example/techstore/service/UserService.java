package org.example.techstore.service;

import org.example.techstore.model.User;
import org.example.techstore.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public boolean checkLogin(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password).isPresent();
    }
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}