/*
 * Address Model - Lưu địa chỉ giao hàng
 */
package mypackage.shop.model;

import jakarta.persistence.*;

/**
 * Address entity matching Address table in database
 * @author PC
 */
@Entity
@Table(name = "Address")
public class Address {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Column(name = "recipient_name", length = 100)
    private String recipientName;
    
    @Column(name = "phone", length = 20)
    private String phone;
    
    @Column(name = "street", length = 255)
    private String street;
    
    @Column(name = "city", length = 100)
    private String city;
    
    @Column(name = "is_default")
    private boolean isDefault;
    
    // Transient field for backward compatibility
    @Transient
    private int userId;

    // Constructors
    public Address() {
        this.isDefault = false;
    }

    public Address(User user, String recipientName, String phone, String street, String city) {
        this.user = user;
        this.recipientName = recipientName;
        this.phone = phone;
        this.street = street;
        this.city = city;
        this.isDefault = false;
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

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public boolean isDefault() {
        return isDefault;
    }
    
    // Alias getter to avoid EL reserved keyword 'default'
    public boolean getDefaultAddress() {
        return isDefault;
    }

    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    // Helper method - Full address
    public String getFullAddress() {
        return street + ", " + city;
    }
}
