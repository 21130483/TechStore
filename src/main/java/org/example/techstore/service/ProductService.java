package org.example.techstore.service;

import org.example.techstore.model.Product;
import org.example.techstore.model.Category;
import org.example.techstore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryService categoryService;

    @Cacheable(value = "products")
    @Transactional(readOnly = true)
    public List<Product> getAllProducts() {
        return productRepository.findAllWithCategory();
    }

    @Cacheable(value = "product", key = "#id")
    @Transactional(readOnly = true)
    public Product getProductById(Integer id) {
        return productRepository.findByIdWithCategory(id);
    }

    @Cacheable(value = "product", key = "#code")
    @Transactional(readOnly = true)
    public Product getProductByCode(String code) {
        return productRepository.findByCodeWithCategory(code);
    }

    @CacheEvict(value = {"products", "product"}, allEntries = true)
    @Transactional
    public Product saveProduct(Product product) {
        if (product == null) {
            throw new IllegalArgumentException("Product cannot be null");
        }

        // Validate required fields
        if (product.getCode() == null || product.getCode().trim().isEmpty()) {
            throw new IllegalArgumentException("Product code is required");
        }
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Product name is required");
        }
        if (product.getPrice() == null || product.getPrice().compareTo(java.math.BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Product price must be greater than 0");
        }
        if (product.getQuantity() == null || product.getQuantity() < 0) {
            throw new IllegalArgumentException("Product quantity cannot be negative");
        }
        if (product.getCategory() == null || product.getCategory().getCategoryID() == null) {
            throw new IllegalArgumentException("Product category is required");
            }

        // Check for duplicate product code
        if (product.getProductID() == null && productRepository.existsByCode(product.getCode())) {
            throw new IllegalArgumentException("Product code already exists");
        }
        
        try {
        return productRepository.save(product);
        } catch (Exception e) {
            throw new RuntimeException("Error saving product: " + e.getMessage(), e);
        }
    }

    @CacheEvict(value = {"products", "product"}, allEntries = true)
    @Transactional
    public void deleteProduct(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("Product ID cannot be null");
        }
        try {
            productRepository.deleteById(id);
        } catch (Exception e) {
            throw new RuntimeException("Error deleting product: " + e.getMessage(), e);
        }
    }

    public String saveImage(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null;
        }

        // Create uploads directory if it doesn't exist
        Path uploadsDir = Paths.get("uploads");
        if (!Files.exists(uploadsDir)) {
            Files.createDirectories(uploadsDir);
        }

        // Generate unique filename
        String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        Path filePath = uploadsDir.resolve(filename);

        // Save file
        Files.copy(file.getInputStream(), filePath);

        return "/uploads/" + filename;
    }
}