/*
 * (Danh mục sản phẩm: Áo, Quần...)
 */
package mypackage.shop.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Category")
public class Category {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    // Relationship with products
    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
    private List<Product> products;
    
    // For display - count products in category (transient - not persisted)
    @Transient
    private int productCount;

    // Constructors
    public Category() {}

    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Category(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
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
