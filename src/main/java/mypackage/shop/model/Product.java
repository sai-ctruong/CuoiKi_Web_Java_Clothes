/*
 * Sản phẩm chính
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "Product")
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "name", nullable = false, length = 255)
    private String name;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "price", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;
    
    @Column(name = "size", length = 20)
    private String size;
    
    @Column(name = "color", length = 50)
    private String color;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    private Brand brand;
    
    @Column(name = "created_at")
    private Timestamp createdAt;
    
    // Relationship with product images
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProductImage> images;
    
    // Relationship with reviews
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Review> reviews;
    
    // Transient fields for display purposes (not persisted)
    @Transient
    private String categoryName;
    @Transient
    private String brandName;
    @Transient
    private String thumbnailUrl;
    @Transient
    private int stockQuantity;
    // For backward compatibility with existing code using categoryId/brandId
    @Transient
    private int categoryId;
    @Transient
    private int brandId;

    // Constructors
    public Product() {}

    public Product(int id, String name, BigDecimal price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<ProductImage> getImages() {
        return images;
    }

    public void setImages(List<ProductImage> images) {
        this.images = images;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    // Transient field getters/setters for backward compatibility
    public int getCategoryId() {
        if (category != null) {
            return category.getId();
        }
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        if (brand != null) {
            return brand.getId();
        }
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getCategoryName() {
        if (category != null) {
            return category.getName();
        }
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getBrandName() {
        if (brand != null) {
            return brand.getName();
        }
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getThumbnailUrl() {
        String url = null;
        
        // Try to get from images if available
        if (images != null && !images.isEmpty()) {
            for (ProductImage img : images) {
                if (img.isThumbnail()) {
                    url = img.getImageUrl();
                    break;
                }
            }
            // Return first image if no thumbnail marked
            if (url == null) {
                url = images.get(0).getImageUrl();
            }
        } else {
            url = thumbnailUrl;
        }
        
        
        if (url != null && !url.startsWith("/uploads") && url.contains("/uploads")) {
            int uploadIndex = url.indexOf("/uploads");
            url = url.substring(uploadIndex);
        }
        
        return url;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
}
