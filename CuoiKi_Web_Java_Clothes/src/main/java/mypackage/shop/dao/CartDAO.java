/*
 * CartDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import mypackage.shop.model.CartItem;
import mypackage.shop.model.User;
import mypackage.shop.model.Product;

import java.util.List;

/**
 * CartDAO - Cart operations using JPA
 * @author PC
 */
public class CartDAO extends GenericDAO<CartItem> {

    public CartDAO() {
        super(CartItem.class);
    }

    /**
     * Get all cart items for a user
     */
    public List<CartItem> getCartByUserId(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT c FROM CartItem c " +
                         "LEFT JOIN FETCH c.product p " +
                         "LEFT JOIN FETCH p.brand " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE c.user.id = :userId " +
                         "ORDER BY c.id DESC";
            return em.createQuery(jpql, CartItem.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get cart item by user and product
     */
    public CartItem getCartItem(int userId, int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT c FROM CartItem c " +
                         "LEFT JOIN FETCH c.product p " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE c.user.id = :userId AND c.product.id = :productId";
            return em.createQuery(jpql, CartItem.class)
                    .setParameter("userId", userId)
                    .setParameter("productId", productId)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Add item to cart (or increase quantity if same product+size exists)
     * Backward compatible version - uses null size
     */
    public boolean addToCart(int userId, int productId, int quantity) {
        return addToCart(userId, productId, quantity, null);
    }
    
    /**
     * Add item to cart with size (or increase quantity if same product+size exists)
     */
    public boolean addToCart(int userId, int productId, int quantity, String size) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Check if item with same product AND size already exists
            String checkJpql;
            List<CartItem> existing;
            
            if (size != null && !size.isEmpty()) {
                checkJpql = "SELECT c FROM CartItem c WHERE c.user.id = :userId AND c.product.id = :productId AND c.size = :size";
                existing = em.createQuery(checkJpql, CartItem.class)
                            .setParameter("userId", userId)
                            .setParameter("productId", productId)
                            .setParameter("size", size)
                            .getResultList();
            } else {
                checkJpql = "SELECT c FROM CartItem c WHERE c.user.id = :userId AND c.product.id = :productId AND (c.size IS NULL OR c.size = '')";
                existing = em.createQuery(checkJpql, CartItem.class)
                            .setParameter("userId", userId)
                            .setParameter("productId", productId)
                            .getResultList();
            }
            
            if (!existing.isEmpty()) {
                // Update quantity
                CartItem item = existing.get(0);
                item.setQuantity(item.getQuantity() + quantity);
                em.merge(item);
            } else {
                // Insert new item
                User user = em.find(User.class, userId);
                Product product = em.find(Product.class, productId);
                
                CartItem newItem = new CartItem(user, product, quantity, size);
                em.persist(newItem);
            }
            
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Update item quantity
     */
    public boolean updateQuantity(int cartItemId, int quantity) {
        if (quantity <= 0) {
            return removeItem(cartItemId);
        }
        
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            CartItem item = em.find(CartItem.class, cartItemId);
            if (item != null) {
                item.setQuantity(quantity);
                em.merge(item);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Remove item from cart
     */
    public boolean removeItem(int cartItemId) {
        return delete(cartItemId);
    }

    /**
     * Clear entire cart for user
     */
    public boolean clearCart(int userId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            String jpql = "DELETE FROM CartItem c WHERE c.user.id = :userId";
            em.createQuery(jpql)
              .setParameter("userId", userId)
              .executeUpdate();
            
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Get cart item count for user
     */
    public int getCartItemCount(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(c.quantity), 0) FROM CartItem c WHERE c.user.id = :userId";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("userId", userId)
                          .getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
}
