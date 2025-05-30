package org.example.techstore.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "vouchers")
public class Voucher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "voucherID")
    private Integer voucherID;

    @Column(name = "name", length = 50, nullable = false)
    private String name;

    @Column(name = "sale", nullable = false)
    private Integer sale;

    @Temporal(TemporalType.DATE)
    @Column(name = "expiredDate", nullable = false)
    private Date expiredDate;

    @Column(name = "cond", nullable = false)
    private Integer cond;

    // Getters and Setters

    public Integer getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(Integer voucherID) {
        this.voucherID = voucherID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSale() {
        return sale;
    }

    public void setSale(Integer sale) {
        this.sale = sale;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Integer getCond() {
        return cond;
    }

    public void setCond(Integer cond) {
        this.cond = cond;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "voucherID=" + voucherID +
                ", name='" + name + '\'' +
                ", sale=" + sale +
                ", expiredDat=" + expiredDate +
                ", condition=" + cond +
                '}';
    }
}
