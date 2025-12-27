/*
 * (Hình ảnh sản phẩm)
 */
package mypackage.shop.model;

import jakarta.persistence.*;

/**
 * ProductImage entity matching ProductImage table in database
 * @author PC
 */
@Entity
@Table(name = "ProductImage")
public class ProductImage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(name = "image_url", nullable = false, length = 255)
    private String imageUrl;
    
    @Column(name = "is_thumbnail")
    private boolean isThumbnail;
    
    // Transient field for backward compatibility
    @Transient
    private int productId;

    // Constructors
    public ProductImage() {}

    public ProductImage(Product product, String imageUrl, boolean isThumbnail) {
        this.product = product;
        this.imageUrl = imageUrl;
        this.isThumbnail = isThumbnail;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isThumbnail() {
        return isThumbnail;
    }

    public void setThumbnail(boolean thumbnail) {
        isThumbnail = thumbnail;
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
}
