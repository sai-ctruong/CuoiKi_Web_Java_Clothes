/*
 * (Đánh giá sản phẩm)
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.sql.Timestamp;

/**
 * Review entity matching Review table in database
 * @author PC
 */
@Entity
@Table(name = "Review")
public class Review {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(name = "rating")
    private int rating;         // 1-5 stars
    
    @Column(name = "comment", columnDefinition = "TEXT")
    private String comment;
    
    @Column(name = "created_at")
    private Timestamp createdAt;
    
    // Transient fields for backward compatibility and display
    @Transient
    private int userId;
    @Transient
    private int productId;
    @Transient
    private String userName;
    @Transient
    private String productName;

    // Constructors
    public Review() {
        this.createdAt = new Timestamp(System.currentTimeMillis());
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

    public int getUserId() {
        if (user != null) {
            return user.getId();
        }
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        if (product != null) {
            return product.getId();
        }
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        if (rating >= 1 && rating <= 5) {
            this.rating = rating;
        }
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        if (user != null) {
            return user.getFullName() != null ? user.getFullName() : user.getUsername();
        }
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getProductName() {
        if (product != null) {
            return product.getName();
        }
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    // Helper method for star display
    public String getStarsHtml() {
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                sb.append("<i class=\"bi bi-star-fill text-warning\"></i>");
            } else {
                sb.append("<i class=\"bi bi-star text-muted\"></i>");
            }
        }
        return sb.toString();
    }
}
