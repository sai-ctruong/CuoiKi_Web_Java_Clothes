/*
 * (Lớp bao gồm list các CartItem và tổng tiền)
 * Session-based cart for shopping
 */
package mypackage.shop.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class Cart implements Serializable {
    private List<SessionCartItem> items;
    
    public Cart() {
        this.items = new ArrayList<>();
    }
    
    public List<SessionCartItem> getItems() {
        return items;
    }
    
    public void setItems(List<SessionCartItem> items) {
        this.items = items;
    }
    
    public int getCount() {
        return items.size();
    }
    
    public void addItem(SessionCartItem item) {
        if (item == null || item.getProduct() == null) {
            return;
        }
        
        Integer productId = item.getProduct().getId();
        Integer quantity = item.getQuantity() != null ? item.getQuantity() : 1;
        
        // Check if product already exists in cart
        SessionCartItem existingItem = findItemByProductId(productId);
        
        if (existingItem != null) {
            // Update quantity if product already exists
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            // Add new item if product doesn't exist
            items.add(item);
        }
    }
    
    public void removeItem(Integer productId) {
        items.removeIf(item -> item.getProduct() != null && item.getProduct().getId().equals(productId));
    }
    
    public void updateItemQuantity(Integer productId, int quantity) {
        SessionCartItem item = findItemByProductId(productId);
        if (item != null) {
            if (quantity <= 0) {
                removeItem(productId);
            } else {
                item.setQuantity(quantity);
            }
        }
    }
    
    public SessionCartItem findItemByProductId(Integer productId) {
        return items.stream()
                .filter(item -> item.getProduct() != null && item.getProduct().getId().equals(productId))
                .findFirst()
                .orElse(null);
    }
    
    public BigDecimal getTotalPrice() {
        BigDecimal total = BigDecimal.ZERO;
        for (SessionCartItem item : items) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
    
    public int getTotalItems() {
        return items.stream()
                .mapToInt(item -> item.getQuantity() != null ? item.getQuantity() : 0)
                .sum();
    }
    
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    private Voucher voucher;

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public BigDecimal getDiscountAmount() {
        if (voucher == null) {
            return BigDecimal.ZERO;
        }

        BigDecimal total = getTotalPrice();
        
        // Calculate discount based on percent
        if (voucher.getDiscountPercent() != null && voucher.getDiscountPercent() > 0) {
            BigDecimal discount = total.multiply(BigDecimal.valueOf(voucher.getDiscountPercent()))
                                       .divide(BigDecimal.valueOf(100));
            return discount;
        }
        
        // Calculate discount based on fixed amount
        if (voucher.getDiscountAmount() != null) {
            return voucher.getDiscountAmount();
        }
        
        return BigDecimal.ZERO;
    }

    public BigDecimal getFinalTotal() {
        BigDecimal total = getTotalPrice();
        BigDecimal discount = getDiscountAmount();
        BigDecimal finalTotal = total.subtract(discount);
        return finalTotal.compareTo(BigDecimal.ZERO) > 0 ? finalTotal : BigDecimal.ZERO;
    }
    
    public void clear() {
        items.clear();
        voucher = null;
    }
}
