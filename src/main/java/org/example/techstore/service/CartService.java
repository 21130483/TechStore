package org.example.techstore.service;

import org.example.techstore.model.Cart;
import org.example.techstore.model.User;
import org.example.techstore.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {
    @Autowired
    private CartRepository cartRepository;

    public List<Cart> getCartsByUser(User user) {
        return cartRepository.findByUser(user);
    };
}
