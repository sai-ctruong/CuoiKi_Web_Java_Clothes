/*
 * Session-based CartItem (simplified version for shopping cart)
 */
//Author: Hoai

package mypackage.shop.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class SessionCartItem implements Serializable {
    private Product product;
    private Integer quantity;
    
    public SessionCartItem() {
        this.quantity = 1;
    }
    
    public SessionCartItem(Product product, Integer quantity) {
        this.product = product;
        this.quantity = quantity != null ? quantity : 1;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    public Integer getQuantity() {
        return quantity;
    }
    
    public void setQuantity(Integer quantity) {
        this.quantity = quantity != null && quantity > 0 ? quantity : 1;
    }
    
    public BigDecimal getSubtotal() {
        if (product == null || product.getPrice() == null || quantity == null) {
            return BigDecimal.ZERO;
        }
        return product.getPrice().multiply(new BigDecimal(quantity));
    }
}
