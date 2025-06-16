package org.example.techstore.repository;

import org.example.techstore.model.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Date;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Integer> {

    // Tìm Voucher theo tên chứa chuỗi (LIKE)
    List<Voucher> findByNameContaining(String name);

    // Tìm Voucher còn hạn sử dụng
    List<Voucher> findByEndDateAfter(Date date);

    // Tìm Voucher theo mã
    List<Voucher> findByCode(String code);

    // Tìm Voucher đang active
    List<Voucher> findByActiveTrue();

    // Tìm Voucher theo loại
    List<Voucher> findByType(String type);

    // Tìm Voucher theo khoảng giá trị
    List<Voucher> findByValueBetween(Double minValue, Double maxValue);

    // Tìm Voucher theo khoảng thời gian
    List<Voucher> findByStartDateBeforeAndEndDateAfter(Date date, Date date2);

    // Tìm Voucher theo số lượng
    List<Voucher> findByQuantityGreaterThan(Integer quantity);
}