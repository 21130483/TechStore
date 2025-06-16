package org.example.techstore.repository;

import org.example.techstore.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findAll();

    Product findByCode(String code);

    List<Product> findByNameContaining(String name);

    List<Product> findByCategoryCategoryID(Integer categoryID);

    List<Product> findByTrademark(String trademark);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.code = ?1")
    Product findByCodeWithCategory(String code);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.productID = ?1")
    Product findByIdWithCategory(Integer id);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.category")
    List<Product> findAllWithCategory();

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.code = ?1")
    boolean existsByCode(String code);
}