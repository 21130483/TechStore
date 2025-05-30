package org.example.techstore.model;

import javax.persistence.*;

@Entity
@Table(name = "uservouchers")
public class UserVoucher {

    @EmbeddedId
    private UserVoucherId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("email")
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("voucherID")
    @JoinColumn(name = "voucherID", nullable = false)
    private Voucher voucher;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    // Getters and Setters

    public UserVoucherId getId() {
        return id;
    }

    public void setId(UserVoucherId id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "UserVoucher{" +
                "user=" + user.getEmail() +
                ", voucher=" + voucher.getVoucherID() +
                ", quantity=" + quantity +
                '}';
    }
}
