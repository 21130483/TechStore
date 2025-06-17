package org.example.techstore.repository;

import org.example.techstore.model.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Date;
import java.util.Optional;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Integer> {

    // Tìm Voucher theo tên chứa chuỗi (LIKE)
    List<Voucher> findByNameContaining(String name);

    // Tìm Voucher còn hạn sử dụng
    List<Voucher> findByEndDateAfter(Date date);

    // Tìm Voucher theo mã
    Optional<Voucher> findByCode(String code);

    // Tìm Voucher đang active
    List<Voucher> findByActiveTrue();

    boolean existsByCode(String code);
}