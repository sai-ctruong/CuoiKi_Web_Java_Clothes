package mypackage.shop.model;

import jakarta.persistence.*;


@Entity
@Table(name = "Address")
public class Address {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
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
    private Boolean isDefault = false;
    
    // Constructors
    public Address() {
    }
    
    public Address(User user, String recipientName, String phone, String street, String city) {
        this.user = user;
        this.recipientName = recipientName;
        this.phone = phone;
        this.street = street;
        this.city = city;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Boolean isDefault) {
        this.isDefault = isDefault;
    }
}
