package org.example.techstore.repository;

import org.example.techstore.model.Product;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProductRepository extends CrudRepository<Product, Integer> {

    // Tìm sản phẩm theo tên chứa chuỗi (LIKE)
    List<Product> findByNameContaining(String name);

    // Tìm sản phẩm theo category
    List<Product> findByCategoryCategoryID(Integer categoryID);

    // Tìm sản phẩm theo trademark
    List<Product> findByTrademark(String trademark);
}
