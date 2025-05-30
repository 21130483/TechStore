package org.example.techstore.model;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class UserVoucherId implements Serializable {

    private String email;
    private Integer voucherID;

    public UserVoucherId() {}

    public UserVoucherId(String email, Integer voucherID) {
        this.email = email;
        this.voucherID = voucherID;
    }

    // Getters and Setters

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(Integer voucherID) {
        this.voucherID = voucherID;
    }

    // equals & hashCode

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof UserVoucherId)) return false;
        UserVoucherId that = (UserVoucherId) o;
        return Objects.equals(email, that.email) &&
                Objects.equals(voucherID, that.voucherID);
    }

    @Override
    public int hashCode() {
        return Objects.hash(email, voucherID);
    }
}
