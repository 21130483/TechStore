package org.example.techstore.repository;

import org.example.techstore.model.Category;
import org.example.techstore.model.Product;
import org.springframework.data.repository.CrudRepository;
import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends CrudRepository<Category, Integer> {
    List<Category> findAll();
    // Tìm danh sách Category theo tên (giống LIKE)
    List<Category> findByNameContaining(String name);

    Optional<Category> findBycategoryID(Integer categoryID);

}
