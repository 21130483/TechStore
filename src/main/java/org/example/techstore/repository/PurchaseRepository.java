package org.example.techstore.repository;

import org.example.techstore.model.Purchase;
import org.example.techstore.model.PurchaseId;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PurchaseRepository extends CrudRepository<Purchase, PurchaseId> {
    List<Purchase> findByUserEmail(String email);
}
