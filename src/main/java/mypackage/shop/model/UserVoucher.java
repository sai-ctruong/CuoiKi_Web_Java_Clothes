/*
 * UserVoucher Model - Lưu voucher được gán cho người dùng
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.sql.Timestamp;

/**
 * UserVoucher entity matching UserVoucher table in database
 * Liên kết voucher với user cụ thể
 * @author PC
 */
@Entity
@Table(name = "UserVoucher")
public class UserVoucher {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "voucher_id", nullable = false)
    private Voucher voucher;
    
    @Column(name = "is_used")
    private boolean isUsed;
    
    @Column(name = "assigned_at")
    private Timestamp assignedAt;
    
    @Column(name = "used_at")
    private Timestamp usedAt;

    // Constructors
    public UserVoucher() {
        this.isUsed = false;
    }

    public UserVoucher(User user, Voucher voucher) {
        this.user = user;
        this.voucher = voucher;
        this.isUsed = false;
        this.assignedAt = new Timestamp(System.currentTimeMillis());
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

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean used) {
        isUsed = used;
    }

    public Timestamp getAssignedAt() {
        return assignedAt;
    }

    public void setAssignedAt(Timestamp assignedAt) {
        this.assignedAt = assignedAt;
    }

    public Timestamp getUsedAt() {
        return usedAt;
    }

    public void setUsedAt(Timestamp usedAt) {
        this.usedAt = usedAt;
    }

    /**
     * Check if this user voucher is available to use
     * Must not be used and the underlying voucher must be valid
     */
    public boolean isAvailable() {
        return !isUsed && voucher != null && voucher.isValid();
    }
}
