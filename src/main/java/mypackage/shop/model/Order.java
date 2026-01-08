/*
 * Đơn hàng tổng
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;


@Entity
@Table(name = "Orders")
public class Order {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
    
    @Column(name = "full_name", length = 100)
    private String fullName;
    
    @Column(name = "phone", length = 20)
    private String phone;
    
    @Column(name = "shipping_address", length = 255)
    private String shippingAddress;
    
    @Column(name = "total_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalAmount;
    
    @Column(name = "status", length = 20)
    private String status;          // PENDING, SHIPPING, DELIVERED, CANCELLED
    
    @Column(name = "payment_method", length = 20)
    private String paymentMethod;   // COD, VNPAY, BANKING
    
    @Column(name = "order_date")
    private Timestamp orderDate;
    
    // Applied voucher info (transient - stored via voucherCode)
    @Transient
    private String voucherCode;
    @Transient
    private BigDecimal discountAmount;
    
    // Order details relationship
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail> orderDetails;
    
    // Transient field for backward compatibility
    @Transient
    private int userId;

    // Status constants
    public static final String STATUS_PENDING = "PENDING";
    public static final String STATUS_SHIPPING = "SHIPPING";
    public static final String STATUS_DELIVERED = "DELIVERED";
    public static final String STATUS_CANCELLED = "CANCELLED";
    
    // Payment method constants
    public static final String PAYMENT_COD = "COD";
    public static final String PAYMENT_VNPAY = "VNPAY";
    public static final String PAYMENT_BANKING = "BANKING";

    // Constructors
    public Order() {
        this.status = STATUS_PENDING;
        this.paymentMethod = PAYMENT_COD;
        this.orderDate = new Timestamp(System.currentTimeMillis());
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

    public int getUserId() {
        if (user != null) {
            return user.getId();
        }
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
    
    // Helper methods
    public String getStatusDisplay() {
        switch (status) {
            case STATUS_PENDING: return "Chờ xử lý";
            case STATUS_SHIPPING: return "Đang giao";
            case STATUS_DELIVERED: return "Đã giao";
            case STATUS_CANCELLED: return "Đã hủy";
            default: return status;
        }
    }
    
    public String getPaymentMethodDisplay() {
        switch (paymentMethod) {
            case PAYMENT_COD: return "Thanh toán khi nhận hàng";
            case PAYMENT_VNPAY: return "VNPay";
            case PAYMENT_BANKING: return "Chuyển khoản";
            default: return paymentMethod;
        }
    }
}
