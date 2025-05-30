package org.example.techstore.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "wishes")
public class Wish implements Serializable {

    @EmbeddedId
    private WishId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("email")
    @JoinColumn(name = "email", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("productID")
    @JoinColumn(name = "productID", nullable = false)
    private Product product;

    // Getters and Setters

    public WishId getId() {
        return id;
    }

    public void setId(WishId id) {
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

    @Override
    public String toString() {
        return "Wish{" +
                "userEmail=" + user.getEmail() +
                ", productID=" + product.getProductID() +
                '}';
    }
}
