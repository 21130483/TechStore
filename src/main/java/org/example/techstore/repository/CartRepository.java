package org.example.techstore.repository;

import org.example.techstore.model.Cart;
import org.example.techstore.model.CartId;
import org.example.techstore.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CartRepository extends CrudRepository<Cart, CartId> {

    List<Cart> findByUser(User user);

    // Lấy tất cả các giỏ hàng chứa một sản phẩm theo productID
    List<Cart> findByProductProductID(Integer productID);
}
