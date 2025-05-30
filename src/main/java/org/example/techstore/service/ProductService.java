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

    public Optional<Product> getProductById(Integer productID) {
        return productRepository.findByproductID(productID);
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

}
