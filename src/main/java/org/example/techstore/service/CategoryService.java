package org.example.techstore.service;

import org.example.techstore.model.Category;
import org.example.techstore.model.Product;
import org.example.techstore.repository.CategoryRepository;
import org.example.techstore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    public Optional<Category> getCategoryBycategoryID(Integer categoryID) {
        return categoryRepository.findBycategoryID(categoryID);
    }
}
