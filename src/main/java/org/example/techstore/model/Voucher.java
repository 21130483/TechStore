package org.example.techstore.model;

import javax.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

@Data
@Entity
@Table(name = "vouchers")
public class Voucher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "voucherID")
    private Integer voucherID;

    @Column(name = "code", length = 50, nullable = false, unique = true)
    private String code;

    @Column(name = "name", length = 50, nullable = false)
    private String name;

    @Column(name = "type", length = 20, nullable = false)
    private String type;  // PERCENTAGE or FIXED_AMOUNT

    @Column(name = "value", nullable = false)
    private Double value;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "start_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date startDate;

    @Column(name = "end_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date endDate;

    @Column(name = "active", nullable = false)
    private Boolean active = true;

    // Getters and Setters

    public Integer getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(Integer voucherID) {
        this.voucherID = voucherID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "voucherID=" + voucherID +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", value=" + value +
                ", quantity=" + quantity +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", active=" + active +
                '}';
    }
}
