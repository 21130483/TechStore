package org.example.techstore.service;

import org.example.techstore.model.Product;
import org.example.techstore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    public Optional<Product> getProductByproductID(Integer productID) {
        return productRepository.findByproductID(productID);
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public void deleteProduct(Integer id) {
        productRepository.deleteById(id);
    }

    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    public List<Product> getProductsByNameContaining(String search) {
        return productRepository.findByNameContaining(search);
    }

    public List<Product> getRecentProducts() {
        LocalDate today = LocalDate.now();
        LocalDate fromDate = today.minusDays(30);
        return productRepository.findProductsAddedInLast30Days(Date.valueOf(fromDate));
    }

    public List<Product> getTop10MostOrderedProducts() {
        return productRepository.findTop10Ordered();
    }

    public List<Product> findRandomByCategoryId(int categoryId) {
        return productRepository.findRandomByCategoryId(categoryId);
    }
}

