/*
 * (Chi tiết đơn hàng)
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.math.BigDecimal;


@Entity
@Table(name = "OrderDetail")
public class OrderDetail {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;
    
    @Column(name = "quantity", nullable = false)
    private int quantity;
    
    @Column(name = "unit_price", nullable = false, precision = 10, scale = 2)
    private BigDecimal unitPrice;
    
    // Transient fields for backward compatibility and display
    @Transient
    private int orderId;
    @Transient
    private int productId;
    @Transient
    private String productName;
    @Transient
    private String productImage;

    // Constructors
    public OrderDetail() {
    }

    public OrderDetail(Order order, Product product, int quantity, BigDecimal unitPrice) {
        this.order = order;
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // Calculate subtotal
    public BigDecimal getSubtotal() {
        if (unitPrice == null) return BigDecimal.ZERO;
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getOrderId() {
        if (order != null) {
            return order.getId();
        }
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
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

    public String getProductImage() {
        if (product != null) {
            return product.getThumbnailUrl();
        }
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
}
