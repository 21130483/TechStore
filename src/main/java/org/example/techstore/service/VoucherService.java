package org.example.techstore.service;

import org.example.techstore.model.Voucher;
import org.example.techstore.repository.VoucherRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class VoucherService {
    private static final Logger logger = LoggerFactory.getLogger(VoucherService.class);
    
    @Autowired
    private VoucherRepository voucherRepository;

    @Transactional(readOnly = true)
    public List<Voucher> getAllVouchers() {
        try {
            logger.info("Fetching all vouchers from database");
            List<Voucher> vouchers = voucherRepository.findAll();
            logger.info("Found {} vouchers", vouchers.size());
            return vouchers;
        } catch (Exception e) {
            logger.error("Error fetching vouchers: {}", e.getMessage(), e);
            throw new RuntimeException("Error fetching vouchers: " + e.getMessage(), e);
        }
    }

    @Transactional(readOnly = true)
    public Optional<Voucher> getVoucherById(Integer id) {
        logger.info("Fetching voucher with ID: {}", id);
        try {
            Optional<Voucher> voucher = voucherRepository.findById(id);
            if (voucher.isPresent()) {
                logger.info("Found voucher: {}", voucher.get());
            } else {
                logger.info("No voucher found with ID: {}", id);
            }
            return voucher;
        } catch (Exception e) {
            logger.error("Error fetching voucher by ID: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to fetch voucher: " + e.getMessage(), e);
        }
    }

    @Transactional(readOnly = true)
    public List<Voucher> getVoucherByCode(String code) {
        try {
            logger.info("Finding voucher by code: {}", code);
            List<Voucher> vouchers = voucherRepository.findByCode(code);
            logger.info("Found {} vouchers with code {}", vouchers.size(), code);
            return vouchers;
        } catch (Exception e) {
            logger.error("Error finding voucher by code: {}", e.getMessage(), e);
            throw new RuntimeException("Error finding voucher by code: " + e.getMessage(), e);
        }
    }

    @Transactional
    public Voucher saveVoucher(Voucher voucher) {
        try {
            logger.info("Saving voucher: {}", voucher);
            
            // Validate voucher data
            if (voucher.getCode() == null || voucher.getCode().trim().isEmpty()) {
                throw new IllegalArgumentException("Voucher code cannot be empty");
            }
            if (voucher.getName() == null || voucher.getName().trim().isEmpty()) {
                throw new IllegalArgumentException("Voucher name cannot be empty");
            }
            if (voucher.getType() == null || voucher.getType().trim().isEmpty()) {
                throw new IllegalArgumentException("Voucher type cannot be empty");
            }
            if (voucher.getValue() == null || voucher.getValue() <= 0) {
                throw new IllegalArgumentException("Voucher value must be greater than 0");
            }
            if (voucher.getQuantity() == null || voucher.getQuantity() <= 0) {
                throw new IllegalArgumentException("Voucher quantity must be greater than 0");
            }
            if (voucher.getStartDate() == null) {
                throw new IllegalArgumentException("Start date cannot be null");
            }
            if (voucher.getEndDate() == null) {
                throw new IllegalArgumentException("End date cannot be null");
            }
            if (voucher.getStartDate().after(voucher.getEndDate())) {
                throw new IllegalArgumentException("Start date must be before end date");
            }

            // Set default active status if not set
            if (voucher.getActive() == null) {
                voucher.setActive(true);
            }

            // Check if voucher code already exists
            List<Voucher> existingVouchers = voucherRepository.findByCode(voucher.getCode());
            if (!existingVouchers.isEmpty()) {
                throw new IllegalArgumentException("Voucher code already exists: " + voucher.getCode());
            }

            // Save the voucher
            Voucher savedVoucher = voucherRepository.save(voucher);
            logger.info("Successfully saved voucher with ID: {}", savedVoucher.getVoucherID());
            return savedVoucher;
        } catch (Exception e) {
            logger.error("Error saving voucher: {}", e.getMessage(), e);
            throw new RuntimeException("Error saving voucher: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void deleteVoucher(Integer id) {
        logger.info("Deleting voucher with ID: {}", id);
        try {
        voucherRepository.deleteById(id);
            logger.info("Successfully deleted voucher with ID: {}", id);
        } catch (Exception e) {
            logger.error("Error deleting voucher: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to delete voucher: " + e.getMessage(), e);
        }
    }

    @Transactional
    public Voucher updateVoucher(Integer id, Voucher voucherDetails) {
        logger.info("Updating voucher with ID: {}", id);
        try {
            Voucher voucher = voucherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Voucher not found with id: " + id));

            logger.info("Current voucher details: code={}, name={}, type={}, value={}, quantity={}, startDate={}, endDate={}, active={}", 
                voucher.getCode(), voucher.getName(), voucher.getType(), voucher.getValue(), 
                voucher.getQuantity(), voucher.getStartDate(), voucher.getEndDate(), voucher.getActive());

            voucher.setCode(voucherDetails.getCode());
            voucher.setName(voucherDetails.getName());
            voucher.setType(voucherDetails.getType());
            voucher.setValue(voucherDetails.getValue());
            voucher.setQuantity(voucherDetails.getQuantity());
            voucher.setStartDate(voucherDetails.getStartDate());
            voucher.setEndDate(voucherDetails.getEndDate());
            voucher.setActive(voucherDetails.getActive());

            Voucher updatedVoucher = voucherRepository.save(voucher);
            logger.info("Successfully updated voucher with ID: {}", updatedVoucher.getVoucherID());
            return updatedVoucher;
        } catch (Exception e) {
            logger.error("Error updating voucher: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to update voucher: " + e.getMessage(), e);
        }
    }

    public boolean isVoucherValid(Voucher voucher) {
        if (voucher == null || !voucher.getActive()) {
            return false;
        }

        long currentTime = System.currentTimeMillis();
        return currentTime >= voucher.getStartDate().getTime() && 
               currentTime <= voucher.getEndDate().getTime() && 
               voucher.getQuantity() > 0;
    }

    public double calculateDiscount(Voucher voucher, double totalAmount) {
        if (!isVoucherValid(voucher)) {
            return 0;
        }

        double discount = 0;
        if (voucher.getType().equals("PERCENTAGE")) {
            discount = totalAmount * (voucher.getValue() / 100);
        } else if (voucher.getType().equals("FIXED_AMOUNT")) {
            discount = Math.min(voucher.getValue(), totalAmount);
        }

        return discount;
    }

    @Transactional
    public void decreaseQuantity(Voucher voucher) {
        if (voucher != null && voucher.getQuantity() > 0) {
            try {
                logger.info("Decreasing quantity for voucher: {}", voucher.getCode());
                voucher.setQuantity(voucher.getQuantity() - 1);
                voucherRepository.save(voucher);
                logger.info("Successfully decreased quantity for voucher: {}", voucher.getCode());
            } catch (Exception e) {
                logger.error("Error decreasing voucher quantity: " + e.getMessage(), e);
                throw e;
            }
        }
    }
} 