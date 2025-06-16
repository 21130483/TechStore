package org.example.techstore.repository;

import org.example.techstore.model.Purchase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, Integer> {
    List<Purchase> findByUserEmail(String email);
    List<Purchase> findByStatus(String status);
    List<Purchase> findByStatusAndUserEmail(String status, String email);
}
