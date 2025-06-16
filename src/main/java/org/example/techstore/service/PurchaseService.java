package org.example.techstore.service;

import org.example.techstore.model.Purchase;
import org.example.techstore.repository.PurchaseRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class PurchaseService {
    private static final Logger logger = LoggerFactory.getLogger(PurchaseService.class);

    @Autowired
    private PurchaseRepository purchaseRepository;

    @Transactional(readOnly = true)
    public List<Purchase> getAllPurchases() {
        try {
            logger.info("Fetching all purchases sorted by purchaseID ascending");
            List<Purchase> purchases = purchaseRepository.findAll(Sort.by(Sort.Direction.ASC, "purchaseID"));
            logger.info("Found {} purchases", purchases.size());
            return purchases;
        } catch (Exception e) {
            logger.error("Error fetching purchases: {}", e.getMessage(), e);
            throw new RuntimeException("Error fetching purchases: " + e.getMessage(), e);
        }
    }

    @Transactional(readOnly = true)
    public Purchase getPurchaseById(Integer id) {
        try {
            logger.info("Fetching purchase with ID: {}", id);
            Optional<Purchase> purchase = purchaseRepository.findById(id);
            if (purchase.isPresent()) {
                logger.info("Found purchase: {}", purchase.get());
                return purchase.get();
            }
            logger.info("No purchase found with ID: {}", id);
            return null;
        } catch (Exception e) {
            logger.error("Error fetching purchase by ID: {}", e.getMessage(), e);
            throw new RuntimeException("Error fetching purchase: " + e.getMessage(), e);
        }
    }

    @Transactional
    public Purchase updatePurchaseStatus(Integer id, String status) {
        try {
            logger.info("Updating purchase status for ID: {} to: {}", id, status);
            Purchase purchase = purchaseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Purchase not found with id: " + id));

            // Validate status
            if (!isValidStatus(status)) {
                throw new IllegalArgumentException("Invalid status: " + status);
            }

            purchase.setStatus(status);
            Purchase updatedPurchase = purchaseRepository.save(purchase);
            logger.info("Successfully updated purchase status");
            return updatedPurchase;
        } catch (Exception e) {
            logger.error("Error updating purchase status: {}", e.getMessage(), e);
            throw new RuntimeException("Error updating purchase status: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void deletePurchase(Integer id) {
        try {
            logger.info("Deleting purchase with ID: {}", id);
            purchaseRepository.deleteById(id);
            logger.info("Successfully deleted purchase");
        } catch (Exception e) {
            logger.error("Error deleting purchase: {}", e.getMessage(), e);
            throw new RuntimeException("Error deleting purchase: " + e.getMessage(), e);
        }
    }

    @Transactional
    public Purchase savePurchase(Purchase purchase) {
        try {
            logger.info("Saving purchase: {}", purchase);
            
            // Validate purchase data
            if (purchase.getUser() == null) {
                throw new IllegalArgumentException("User cannot be null");
            }
            if (purchase.getProduct() == null) {
                throw new IllegalArgumentException("Product cannot be null");
            }
            if (purchase.getQuantity() == null || purchase.getQuantity() <= 0) {
                throw new IllegalArgumentException("Quantity must be greater than 0");
            }
            if (purchase.getTotalPrice() == null || purchase.getTotalPrice().compareTo(java.math.BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Total price must be greater than 0");
            }
            if (purchase.getShippingAddress() == null || purchase.getShippingAddress().trim().isEmpty()) {
                throw new IllegalArgumentException("Shipping address cannot be empty");
            }
            if (purchase.getPaymentMethod() == null || purchase.getPaymentMethod().trim().isEmpty()) {
                throw new IllegalArgumentException("Payment method cannot be empty");
            }

            // Set default values
            if (purchase.getStatus() == null) {
                purchase.setStatus("PENDING");
            }
            if (purchase.getPurchaseDate() == null) {
                purchase.setPurchaseDate(new java.util.Date());
            }

            Purchase savedPurchase = purchaseRepository.save(purchase);
            logger.info("Successfully saved purchase with ID: {}", savedPurchase.getPurchaseID());
            return savedPurchase;
        } catch (Exception e) {
            logger.error("Error saving purchase: {}", e.getMessage(), e);
            throw new RuntimeException("Error saving purchase: " + e.getMessage(), e);
        }
    }

    private boolean isValidStatus(String status) {
        return status != null && (
            status.equals("PENDING") ||
            status.equals("PROCESSING") ||
            status.equals("SHIPPED") ||
            status.equals("DELIVERED") ||
            status.equals("CANCELLED")
        );
    }
} 