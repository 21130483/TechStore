package org.example.techstore.service;

import org.example.techstore.model.Category;
import org.example.techstore.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    @Transactional(readOnly = true)
    @Cacheable(value = "categories")
    public List<Category> getAllCategories() {
        return categoryRepository.findAllWithProducts();
    }

    @Transactional(readOnly = true)
    @Cacheable(value = "categories", key = "#id")
    public Category getCategoryById(Integer id) {
        return categoryRepository.findByIdWithProducts(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
    }

    @Transactional(readOnly = true)
    @Cacheable(value = "categories", key = "#name")
    public Category getCategoryByName(String name) {
        return categoryRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException("Category not found with name: " + name));
    }

    @Transactional
    @CacheEvict(value = "categories", allEntries = true)
    public Category saveCategory(Category category) {
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Category name cannot be empty");
        }
        
        if (category.getCategoryID() == null && categoryRepository.existsByName(category.getName())) {
            throw new IllegalArgumentException("Category with name '" + category.getName() + "' already exists");
        }
        
        return categoryRepository.save(category);
    }

    @Transactional
    @CacheEvict(value = "categories", allEntries = true)
    public void deleteCategory(Integer id) {
        categoryRepository.deleteById(id);
    }

    @PostConstruct
    @Transactional
    public void initDefaultCategories() {
        if (categoryRepository.count() == 0) {
            Category laptop = new Category();
            laptop.setName("Laptop");
            laptop.setDescription("Laptop và máy tính xách tay");
            categoryRepository.save(laptop);

            Category smartphone = new Category();
            smartphone.setName("Smartphone");
            smartphone.setDescription("Điện thoại thông minh");
            categoryRepository.save(smartphone);

            Category tablet = new Category();
            tablet.setName("Tablet");
            tablet.setDescription("Máy tính bảng");
            categoryRepository.save(tablet);

            Category accessory = new Category();
            accessory.setName("Phụ kiện");
            accessory.setDescription("Phụ kiện điện tử");
            categoryRepository.save(accessory);
        }
    }
} 