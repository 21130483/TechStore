package org.example.techstore.repository;

import org.example.techstore.model.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface ProductRepository extends CrudRepository<Product, Integer> {
    List<Product> findAll();

    Optional<Product> findByproductID(Integer productID);

    // Tìm sản phẩm theo tên chứa chuỗi (LIKE)
    List<Product> findByNameContaining(String name);

    // Tìm sản phẩm theo category
    List<Product> findByCategoryCategoryID(Integer categoryID);

    // Tìm sản phẩm theo trademark
    List<Product> findByTrademark(String trademark);

    @Query("SELECT p FROM Product p WHERE p.dateAdded >= :fromDate")
    List<Product> findProductsAddedInLast30Days(@Param("fromDate") Date fromDate);

    @Query(value = "SELECT * FROM products ORDER BY ordered_numbers DESC LIMIT 10", nativeQuery = true)
    List<Product> findTop10Ordered();

    @Query(value = "SELECT * FROM products WHERE categoryid = :categoryId ORDER BY RAND() LIMIT 6", nativeQuery = true)
    List<Product> findRandomByCategoryId(@Param("categoryId") int categoryId);




}
