package mypackage.shop.model;

import jakarta.persistence.*;

/**
 * Entity mapping với bảng ProductImage trong database
 */
@Entity
@Table(name = "ProductImage")
public class ProductImage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(name = "image_url", nullable = false, length = 255)
    private String imageUrl;
    
    @Column(name = "is_thumbnail")
    private Boolean isThumbnail = false;
    
    // Constructors
    public ProductImage() {
    }
    
    public ProductImage(Product product, String imageUrl, Boolean isThumbnail) {
        this.product = product;
        this.imageUrl = imageUrl;
        this.isThumbnail = isThumbnail;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public Boolean getIsThumbnail() {
        return isThumbnail;
    }

    public void setIsThumbnail(Boolean isThumbnail) {
        this.isThumbnail = isThumbnail;
    }
}
