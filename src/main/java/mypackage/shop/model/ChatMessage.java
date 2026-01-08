package mypackage.shop.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Entity lưu từng tin nhắn trong phiên chat
 */
@Entity
@Table(name = "chat_messages")
public class ChatMessage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "session_id", length = 36, nullable = false)
    private String sessionId;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user; // Nullable cho guest hoặc bot
    
    @Enumerated(EnumType.STRING)
    @Column(name = "sender_type", length = 20, nullable = false)
    private SenderType senderType;
    
    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public enum SenderType {
        CUSTOMER, // Tin nhắn từ khách hàng
        BOT,      // Tin nhắn từ chatbot tự động
        STAFF     // Tin nhắn từ nhân viên CSKH
    }
    
    // Constructors
    public ChatMessage() {
        this.createdAt = LocalDateTime.now();
    }
    
    public ChatMessage(String sessionId, SenderType senderType, String message) {
        this();
        this.sessionId = sessionId;
        this.senderType = senderType;
        this.message = message;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getSessionId() {
        return sessionId;
    }
    
    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public SenderType getSenderType() {
        return senderType;
    }
    
    public void setSenderType(SenderType senderType) {
        this.senderType = senderType;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
