package mypackage.shop.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Entity lưu phiên chat giữa khách hàng và hệ thống
 */
@Entity
@Table(name = "chat_sessions")
public class ChatSession {
    
    @Id
    @Column(length = 36)
    private String id; // UUID
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user; // Nullable cho guest
    
    @Column(name = "guest_name", length = 100)
    private String guestName;
    
    @Column(name = "guest_email", length = 100)
    private String guestEmail;
    
    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private ChatStatus status = ChatStatus.ACTIVE;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public enum ChatStatus {
        ACTIVE, CLOSED
    }
    
    // Constructors
    public ChatSession() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public ChatSession(String id) {
        this();
        this.id = id;
    }
    
    // Getters and Setters
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public String getGuestName() {
        return guestName;
    }
    
    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }
    
    public String getGuestEmail() {
        return guestEmail;
    }
    
    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }
    
    public ChatStatus getStatus() {
        return status;
    }
    
    public void setStatus(ChatStatus status) {
        this.status = status;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
