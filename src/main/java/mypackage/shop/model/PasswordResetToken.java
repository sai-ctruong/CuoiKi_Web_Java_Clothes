/*
 * PasswordResetToken - Token for password reset functionality
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "password_reset_tokens")
public class PasswordResetToken {
    
    // Token expires after 1 hour
    private static final int EXPIRATION_HOURS = 1;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "token", nullable = false, unique = true, length = 100)
    private String token;
    
    @Column(name = "user_id", nullable = false)
    private int userId;
    
    @Column(name = "expiry_date", nullable = false)
    private Timestamp expiryDate;
    
    @Column(name = "created_at")
    private Timestamp createdAt;
    
    // Constructors
    public PasswordResetToken() {
        this.createdAt = Timestamp.valueOf(LocalDateTime.now());
    }
    
    public PasswordResetToken(int userId) {
        this();
        this.userId = userId;
        this.token = UUID.randomUUID().toString();
        this.expiryDate = Timestamp.valueOf(LocalDateTime.now().plusHours(EXPIRATION_HOURS));
    }
    
    // Check if token is expired
    public boolean isExpired() {
        return new Timestamp(System.currentTimeMillis()).after(this.expiryDate);
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Timestamp expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
