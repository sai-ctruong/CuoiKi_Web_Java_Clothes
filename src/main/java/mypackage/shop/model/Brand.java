package mypackage.shop.model;

import jakarta.persistence.*;
import java.util.List;


@Entity
@Table(name = "Brand")
public class Brand {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "logo_url", length = 255)
    private String logoUrl;
    
    @Column(name = "origin", length = 100)
    private String origin;
    
    // Relationship với Product
    @OneToMany(mappedBy = "brand", fetch = FetchType.LAZY)
    private List<Product> products;
    
    // Constructors
    public Brand() {
    }
    
    public Brand(String name, String origin) {
        this.name = name;
        this.origin = origin;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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
}
