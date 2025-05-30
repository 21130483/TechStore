package org.example.techstore.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "purchases")
public class Purchase {

    @EmbeddedId
    private PurchaseId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("email")
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("productID")
    @JoinColumn(name = "productID", nullable = false)
    private Product product;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "price", nullable = false)
    private Integer price;

    @Temporal(TemporalType.DATE)
    @Column(name = "orderDate", nullable = false)
    private Date orderDate;

    @Column(name = "status", nullable = false)
    private Integer status;

    @Temporal(TemporalType.DATE)
    @Column(name = "receivedDate")
    private Date receivedDate;

    @Column(name = "starNumber")
    private Integer starNumber;

    @Column(name = "comment", length = 100)
    private String comment;

    @Column(name = "address", length = 100)
    private String address;

    @Temporal(TemporalType.DATE)
    @Column(name = "dateRated")
    private Date dateRated;

    // Getters and Setters

    public PurchaseId getId() {
        return id;
    }

    public void setId(PurchaseId id) {
        this.id = id;
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

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(Date receivedDate) {
        this.receivedDate = receivedDate;
    }

    public Integer getStarNumber() {
        return starNumber;
    }

    public void setStarNumber(Integer starNumber) {
        this.starNumber = starNumber;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateRated() {
        return dateRated;
    }

    public void setDateRated(Date dateRated) {
        this.dateRated = dateRated;
    }

    @Override
    public String toString() {
        return "Purchase{" +
                "user=" + user.getEmail() +
                ", product=" + product.getProductID() +
                ", quantity=" + quantity +
                ", price=" + price +
                ", orderDate=" + orderDate +
                ", status=" + status +
                ", receivedDate=" + receivedDate +
                ", starNumber=" + starNumber +
                ", comment='" + comment + '\'' +
                ", address='" + address + '\'' +
                ", dateRated=" + dateRated +
                '}';
    }
}
