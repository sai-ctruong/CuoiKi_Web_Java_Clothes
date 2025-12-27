/*
 * Wishlist entity - stores user's favorite products
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.util.Date;

/**
 * Wishlist entity for storing user's favorite products
 * @author PC
 */
@Entity
@Table(name = "Wishlist", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"user_id", "product_id"})
})
public class Wishlist {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    
    // Constructors
    public Wishlist() {
        this.createdAt = new Date();
    }
    
    public Wishlist(User user, Product product) {
        this.user = user;
        this.product = product;
        this.createdAt = new Date();
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
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
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    // Convenience methods
    public int getUserId() {
        return user != null ? user.getId() : 0;
    }
    
    public int getProductId() {
        return product != null ? product.getId() : 0;
    }
}
