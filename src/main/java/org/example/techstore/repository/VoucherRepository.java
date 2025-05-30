package org.example.techstore.repository;

import org.example.techstore.model.Voucher;
import org.springframework.data.repository.CrudRepository;
import java.util.List;
import java.util.Date;

public interface VoucherRepository extends CrudRepository<Voucher, Integer> {

    // Tìm Voucher theo tên chứa chuỗi (LIKE)
    List<Voucher> findByNameContaining(String name);

    // Tìm Voucher theo ngày hết hạn lớn hơn ngày cho trước (chưa hết hạn)
    List<Voucher> findByExpiredDatAfter(Date date);

    // Tìm Voucher theo điều kiện
    List<Voucher> findByCond(Integer cond);
}