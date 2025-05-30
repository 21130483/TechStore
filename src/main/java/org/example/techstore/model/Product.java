package org.example.techstore.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productID")
    private Integer productID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryID", nullable = false)
    private Category category;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Temporal(TemporalType.DATE)
    @Column(name = "dateAdded", nullable = false)
    private Date dateAdded;

    @Column(name = "price", nullable = false)
    private Integer price;

    @Column(name = "sale", nullable = false)
    private Integer sale;

    @Column(name = "orderedNumbers", nullable = false)
    private Integer orderedNumbers;

    @Column(name = "name", length = 100, nullable = false)
    private String name;

    @Column(name = "trademark", length = 50, nullable = false)
    private String trademark;

    @Column(name = "content", length = 1000, nullable = false)
    private String content;

    // Getters and Setters

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getSale() {
        return sale;
    }

    public void setSale(Integer sale) {
        this.sale = sale;
    }

    public Integer getOrderedNumbers() {
        return orderedNumbers;
    }

    public void setOrderedNumbers(Integer orderedNumbers) {
        this.orderedNumbers = orderedNumbers;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTrademark() {
        return trademark;
    }

    public void setTrademark(String trademark) {
        this.trademark = trademark;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", sale=" + sale +
                '}';
    }
}
