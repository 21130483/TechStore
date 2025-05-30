package org.example.techstore.repository;

import org.example.techstore.model.User;
import org.example.techstore.model.Wish;
import org.example.techstore.model.WishId;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface WishRepository extends CrudRepository<Wish, WishId> {

    List<Wish> findByUser(User user);

    // Tìm tất cả Wish của product theo productID
    List<Wish> findByProductProductID(Integer productID);
}

