package org.example.techstore.repository;

import org.example.techstore.model.Purchase;
import org.example.techstore.model.PurchaseId;
import org.example.techstore.model.User;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface PurchaseRepository extends CrudRepository<Purchase, PurchaseId> {

    List<Purchase> findByUser(User user);


    List<Purchase> findByProductProductID(Integer productID);

    // Có thể thêm các query phức tạp hơn nếu cần
}
