package org.example.techstore.service;

import org.example.techstore.model.*;
import org.example.techstore.repository.CategoryRepository;
import org.example.techstore.repository.ProductRepository;
import org.example.techstore.repository.PurchaseRepository;
import org.example.techstore.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PurchaseService {
    @Autowired
    private PurchaseRepository purchaseRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    public boolean addPurchase(String email, Integer productId, Integer quantity, Integer price,
                               Date orderDate, String address) {
        Optional<User> userOpt = userRepository.findById(email);
        Optional<Product> productOpt = productRepository.findById(productId);

        if (userOpt.isEmpty() || productOpt.isEmpty()) {
            return false; // User hoặc Product không tồn tại
        }

        User user = userOpt.get();
        Product product = productOpt.get();

        PurchaseId purchaseId = new PurchaseId(email, productId);
        Purchase purchase = new Purchase();

        purchase.setId(purchaseId);
        purchase.setUser(user);
        purchase.setProduct(product);
        purchase.setQuantity(quantity);
        purchase.setPrice(price);
        purchase.setOrderDate(orderDate);
        purchase.setStatus(0); // ví dụ: 0 = chưa xử lý
        purchase.setAddress(address);

        purchaseRepository.save(purchase);
        return true;
    }


}
