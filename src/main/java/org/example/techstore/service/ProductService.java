package org.example.techstore.service;

import org.example.techstore.model.Product;
import org.example.techstore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    }

    public List<Product> getProductsByNameContaining(String search) {
        return productRepository.findByNameContaining(search);
    }
}

