package org.example.techstore.model;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class AddressId implements Serializable {

    private Integer addressID;
    private String email;

    public AddressId() {}

    public AddressId(Integer addressID, String email) {
        this.addressID = addressID;
        this.email = email;
    }

    // Getters and Setters

    public Integer getAddressID() {
        return addressID;
    }

    public void setAddressID(Integer addressID) {
        this.addressID = addressID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // equals & hashCode

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AddressId)) return false;
        AddressId that = (AddressId) o;
        return Objects.equals(addressID, that.addressID) &&
                Objects.equals(email, that.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(addressID, email);
    }
}
