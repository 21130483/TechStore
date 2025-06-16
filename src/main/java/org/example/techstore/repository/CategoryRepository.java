package org.example.techstore.repository;

import org.example.techstore.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    
    @Query("SELECT c FROM Category c LEFT JOIN FETCH c.products WHERE c.categoryID = :id")
    Optional<Category> findByIdWithProducts(@Param("id") Integer id);
    
    @Query("SELECT c FROM Category c LEFT JOIN FETCH c.products")
    List<Category> findAllWithProducts();
    
    @Query("SELECT CASE WHEN COUNT(c) > 0 THEN true ELSE false END FROM Category c WHERE c.name = :name")
    boolean existsByName(@Param("name") String name);
    
    @Query("SELECT c FROM Category c WHERE c.name = :name")
    Optional<Category> findByName(@Param("name") String name);
}