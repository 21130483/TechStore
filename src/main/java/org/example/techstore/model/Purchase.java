package org.example.techstore.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "purchases")
public class Purchase {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "purchaseID")
    private Integer purchaseID;

    @ManyToOne
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "productID", nullable = false)
    private Product product;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "total_price", nullable = false)
    private BigDecimal totalPrice;

    @Column(name = "status", length = 20, nullable = false)
    private String status = "PENDING"; // PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "purchase_date", nullable = false)
    private Date purchaseDate;

    @Column(name = "shipping_address", length = 255, nullable = false)
    private String shippingAddress;

    @Column(name = "payment_method", length = 50, nullable = false)
    private String paymentMethod;

    // Getters and Setters
    public Integer getPurchaseID() {
        return purchaseID;
    }

    public void setPurchaseID(Integer purchaseID) {
        this.purchaseID = purchaseID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Override
    public String toString() {
        return "Purchase{" +
                "purchaseID=" + purchaseID +
                ", user=" + user.getEmail() +
                ", product=" + product.getProductID() +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                ", status='" + status + '\'' +
                ", purchaseDate=" + purchaseDate +
                ", shippingAddress='" + shippingAddress + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                '}';
    }
}
