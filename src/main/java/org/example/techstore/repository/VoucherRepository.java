package org.example.techstore.repository;

import org.example.techstore.model.Voucher;
import org.springframework.data.repository.CrudRepository;
import java.util.List;
import java.util.Date;

public interface VoucherRepository extends CrudRepository<Voucher, Integer> {

    // Tìm Voucher theo tên chứa chuỗi (LIKE)
    List<Voucher> findByNameContaining(String name);

    List<Voucher> findByExpiredDateAfter(Date expiredDateAfter);

    // Tìm Voucher theo điều kiện
    List<Voucher> findByCond(Integer cond);
}