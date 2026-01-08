/*
 * DTO for cart item display in JSP (mapping from SessionCartItem)
 */
package mypackage.shop.model;

import java.io.Serializable;
import java.math.BigDecimal;


public class CartItemDTO implements Serializable {
    private int id;  // product ID
    private String productName;
    private String productImage;
    private String productSize;
    private String productColor;
    private String productBrand;
    private BigDecimal productPrice;
    private int quantity;
    private BigDecimal subtotal;

    public CartItemDTO() {}

    /**
     * Create DTO from SessionCartItem
     */
    public static CartItemDTO fromSessionCartItem(SessionCartItem item) {
        if (item == null || item.getProduct() == null) {
            return null;
        }
        
        CartItemDTO dto = new CartItemDTO();
        Product product = item.getProduct();
        
        dto.setId(product.getId());
        dto.setProductName(product.getName());
        dto.setProductImage(product.getThumbnailUrl());
        dto.setProductSize(product.getSize());
        dto.setProductColor(product.getColor());
        dto.setProductBrand(product.getBrandName());
        dto.setProductPrice(product.getPrice());
        dto.setQuantity(item.getQuantity() != null ? item.getQuantity() : 1);
        dto.setSubtotal(item.getSubtotal());
        
        return dto;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public String getProductBrand() {
        return productBrand;
    }

    public void setProductBrand(String productBrand) {
        this.productBrand = productBrand;
    }
}
