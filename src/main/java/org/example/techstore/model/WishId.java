package org.example.techstore.model;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class WishId implements Serializable {

    private String email;
    private Integer productID;

    public WishId() {
    }

    public WishId(String email, Integer productID) {
        this.email = email;
        this.productID = productID;
    }

    // Getters and Setters

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    // equals and hashCode

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof WishId)) return false;
        WishId wishId = (WishId) o;
        return Objects.equals(getEmail(), wishId.getEmail()) &&
                Objects.equals(getProductID(), wishId.getProductID());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getEmail(), getProductID());
    }
}
