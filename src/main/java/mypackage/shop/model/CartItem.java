/*
 * (Sản phẩm trong giỏ: chứa Product + Quantity)
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.math.BigDecimal;


@Entity
@Table(name = "CartItem")
public class CartItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(name = "quantity")
    private int quantity;
    
    // Transient fields for backward compatibility and display
    @Transient
    private int userId;
    @Transient
    private int productId;
    @Transient
    private String productName;
    @Transient
    private BigDecimal productPrice;
    @Transient
    private String productImage;
    
    // Persistent size field - stored in database
    @Column(name = "size", length = 10)
    private String size;
    
    @Transient
    private String productColor;

    // Constructors
    public CartItem() {
        this.quantity = 1;
    }

    public CartItem(User user, Product product, int quantity) {
        this.user = user;
        this.product = product;
        this.quantity = quantity;
    }

    public CartItem(User user, Product product, int quantity, String size) {
        this.user = user;
        this.product = product;
        this.quantity = quantity;
        this.size = size;
    }

    // Calculate subtotal for this item
    public BigDecimal getSubtotal() {
        BigDecimal price = getProductPrice();
        if (price == null) return BigDecimal.ZERO;
        return price.multiply(BigDecimal.valueOf(quantity));
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public BigDecimal getProductPrice() {
        if (product != null) {
            return product.getPrice();
        }
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
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

    public String getProductSize() {
        // Return stored size from cart item first, then fallback to product's default size
        if (size != null && !size.isEmpty()) {
            return size;
        }
        if (product != null) {
            return product.getSize();
        }
        return "M"; // Default size
    }

    public void setProductSize(String size) {
        this.size = size;
    }
    
    public String getSize() {
        return size;
    }
    
    public void setSize(String size) {
        this.size = size;
    }

    public String getProductColor() {
        if (product != null) {
            return product.getColor();
        }
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }
}
