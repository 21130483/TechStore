package org.example.techstore.service;

import org.example.techstore.model.Voucher;
import org.example.techstore.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;

    public List<Voucher> getAllVouchers() {
        return voucherRepository.findAll();
    }

    public Optional<Voucher> getVoucherById(Integer id) {
        return voucherRepository.findById(id);
    }

    public Optional<Voucher> getVoucherByCode(String code) {
        return voucherRepository.findByCode(code);
    }

    public boolean existsByCode(String code) {
        return voucherRepository.existsByCode(code);
    }

    public Voucher saveVoucher(Voucher voucher) {
        return voucherRepository.save(voucher);
    }

    public void deleteVoucher(Integer id) {
        voucherRepository.deleteById(id);
    }

    public List<Voucher> getActiveVouchers() {
        return voucherRepository.findByActiveTrue();
    }

    public List<Voucher> getValidVouchers() {
        Date now = new Date();
        return voucherRepository.findByEndDateAfter(now);
    }

    public List<Voucher> searchVouchersByName(String name) {
        return voucherRepository.findByNameContaining(name);
    }

    public boolean isVoucherValid(Voucher voucher) {
        if (!voucher.getActive()) {
            return false;
        }

        Date now = new Date();
        return now.after(voucher.getStartDate()) && now.before(voucher.getEndDate()) && voucher.getQuantity() > 0;
    }

    public void decreaseVoucherQuantity(Voucher voucher) {
        if (voucher.getQuantity() > 0) {
            voucher.setQuantity(voucher.getQuantity() - 1);
            voucherRepository.save(voucher);
        }
    }
} 