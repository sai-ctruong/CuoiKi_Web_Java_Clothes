/*
 * (Mã giảm giá)
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Voucher entity matching Voucher table in database
 * @author PC
 */
@Entity
@Table(name = "Voucher")
public class Voucher {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "code", nullable = false, unique = true, length = 20)
    private String code;
    
    @Column(name = "discount_percent")
    private Integer discountPercent;      // % discount (e.g., 10 = 10%)
    
    @Column(name = "discount_amount", precision = 10, scale = 2)
    private BigDecimal discountAmount;     // Fixed amount discount
    
    @Column(name = "min_order_value", precision = 10, scale = 2)
    private BigDecimal minOrderValue;      // Minimum order to apply
    
    @Column(name = "start_date")
    private Timestamp startDate;
    
    @Column(name = "end_date")
    private Timestamp endDate;
    
    @Column(name = "usage_limit")
    private int usageLimit;
    
    @Column(name = "is_active")
    private boolean isActive;

    // Constructors
    public Voucher() {
        this.isActive = true;
        this.usageLimit = 100;
    }

    /**
     * Calculate discount amount for given order total
     */
    public BigDecimal calculateDiscount(BigDecimal orderTotal) {
        if (orderTotal == null || orderTotal.compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }
        
        // Check minimum order value
        if (minOrderValue != null && orderTotal.compareTo(minOrderValue) < 0) {
            return BigDecimal.ZERO;
        }
        
        // Calculate discount
        if (discountPercent != null && discountPercent > 0) {
            // Percent discount
            return orderTotal.multiply(BigDecimal.valueOf(discountPercent))
                           .divide(BigDecimal.valueOf(100));
        } else if (discountAmount != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) {
            // Fixed amount discount (not exceed order total)
            return discountAmount.min(orderTotal);
        }
        
        return BigDecimal.ZERO;
    }

    /**
     * Check if voucher is currently valid
     */
    public boolean isValid() {
        if (!isActive) return false;
        
        Timestamp now = new Timestamp(System.currentTimeMillis());
        
        if (startDate != null && now.before(startDate)) return false;
        if (endDate != null && now.after(endDate)) return false;
        
        return true;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(BigDecimal minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public int getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
