package org.example.techstore.repository;

import org.example.techstore.model.Category;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface CategoryRepository extends CrudRepository<Category, Integer> {
    List<Category> findAll();
    // Tìm danh sách Category theo tên (giống LIKE)
    List<Category> findByNameContaining(String name);

}
