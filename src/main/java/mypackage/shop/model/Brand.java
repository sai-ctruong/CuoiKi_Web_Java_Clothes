/*
 * (Thương hiệu)
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.util.List;


@Entity
@Table(name = "Brand")
public class Brand {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "logo_url", length = 255)
    private String logoUrl;
    
    @Column(name = "origin", length = 100)
    private String origin;
    
    // Relationship with products
    @OneToMany(mappedBy = "brand", fetch = FetchType.LAZY)
    private List<Product> products;
    
    // For display - count products of brand (transient - not persisted)
    @Transient
    private int productCount;

    // Constructors
    public Brand() {}

    public Brand(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Brand(int id, String name, String origin) {
        this.id = id;
        this.name = name;
        this.origin = origin;
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

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }
}
