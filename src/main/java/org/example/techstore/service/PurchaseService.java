package org.example.techstore.service;

import org.example.techstore.model.Product;
import org.example.techstore.model.Purchase;
import org.example.techstore.model.PurchaseId;
import org.example.techstore.model.User;
import org.example.techstore.repository.ProductRepository;
import org.example.techstore.repository.PurchaseRepository;
import org.example.techstore.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PurchaseService {
    private static final Logger logger = LoggerFactory.getLogger(PurchaseService.class);

    @Autowired
    private PurchaseRepository purchaseRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    @Transactional(readOnly = true)
    public List<Purchase> getAllPurchases() {
        logger.info("Fetching all purchases from repository");
        List<Purchase> purchases = (List<Purchase>) purchaseRepository.findAll();
        logger.info("Found {} purchases", purchases.size());
        return purchases;
    }

    @Transactional(readOnly = true)
    public Purchase getPurchaseById(String email, Integer productID) {
        logger.info("Fetching purchase with email: {} and productID: {}", email, productID);
        PurchaseId id = new PurchaseId(email, productID);
        return purchaseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Purchase not found"));
    }

    @Transactional(readOnly = true)
    public List<Purchase> getPurchasesByUserEmail(String email) {
        logger.info("Fetching purchases for user with email: {}", email);
        return purchaseRepository.findByUserEmail(email);
    }

    @Transactional
    public Purchase savePurchase(Purchase purchase) {
        logger.info("Saving purchase: {}", purchase);
        return purchaseRepository.save(purchase);
    }

    @Transactional
    public void deletePurchase(String email, Integer productID) {
        logger.info("Deleting purchase with email: {} and productID: {}", email, productID);
        PurchaseId id = new PurchaseId(email, productID);
        purchaseRepository.deleteById(id);
    }

    @Transactional
    public Purchase updatePurchaseStatus(String email, Integer productID, Integer status) {
        logger.info("Updating purchase status to {} for email: {} and productID: {}", status, email, productID);
        Purchase purchase = getPurchaseById(email, productID);
        purchase.setStatus(status);
        return purchaseRepository.save(purchase);
    }

    @Transactional
    public void addPurchase(String email, Integer productID, Integer quantity, int total, Date orderDate, String address) {
        PurchaseId id = new PurchaseId(email, productID);
        Purchase purchase = new Purchase();
        purchase.setId(id);
        purchase.setQuantity(quantity);
        purchase.setPrice(total);
        purchase.setOrderDate(orderDate);
        purchase.setAddress(address);
        purchase.setStatus(0); // PENDING status
        purchaseRepository.save(purchase);
    }

    public boolean addPurchaseCheckout(String email, Integer productId, Integer quantity, Integer price,
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
