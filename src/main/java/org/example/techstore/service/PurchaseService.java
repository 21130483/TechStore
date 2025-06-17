package org.example.techstore.service;

import org.example.techstore.model.Purchase;
import org.example.techstore.model.PurchaseId;
import org.example.techstore.repository.PurchaseRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class PurchaseService {
    private static final Logger logger = LoggerFactory.getLogger(PurchaseService.class);

    @Autowired
    private PurchaseRepository purchaseRepository;

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
}
