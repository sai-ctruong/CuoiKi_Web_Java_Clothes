/*
 * WishlistDAO - Database operations for wishlist
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import mypackage.shop.model.Wishlist;
import mypackage.shop.model.User;
import mypackage.shop.model.Product;

import java.util.List;

/**
 * WishlistDAO - Wishlist CRUD operations using JPA
 * @author PC
 */
public class WishlistDAO extends GenericDAO<Wishlist> {

    public WishlistDAO() {
        super(Wishlist.class);
    }

    /**
     * Get all wishlist items for a user
     */
    public List<Wishlist> getByUserId(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT w FROM Wishlist w " +
                         "LEFT JOIN FETCH w.product p " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE w.user.id = :userId " +
                         "ORDER BY w.createdAt DESC";
            return em.createQuery(jpql, Wishlist.class)
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
     * Check if product is in user's wishlist
     */
    public boolean isInWishlist(int userId, int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(w) FROM Wishlist w WHERE w.user.id = :userId AND w.product.id = :productId";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("userId", userId)
                          .setParameter("productId", productId)
                          .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Toggle wishlist - add if not exists, remove if exists
     * @return true if added, false if removed
     */
    public boolean toggle(int userId, int productId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Check if exists
            String checkJpql = "SELECT w FROM Wishlist w WHERE w.user.id = :userId AND w.product.id = :productId";
            List<Wishlist> existing = em.createQuery(checkJpql, Wishlist.class)
                                        .setParameter("userId", userId)
                                        .setParameter("productId", productId)
                                        .getResultList();
            
            boolean added;
            if (!existing.isEmpty()) {
                // Remove
                em.remove(existing.get(0));
                added = false;
            } else {
                // Add
                User user = em.find(User.class, userId);
                Product product = em.find(Product.class, productId);
                
                if (user != null && product != null) {
                    Wishlist wishlist = new Wishlist(user, product);
                    em.persist(wishlist);
                    added = true;
                } else {
                    added = false;
                }
            }
            
            tx.commit();
            return added;
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
     * Remove item from wishlist
     */
    public boolean remove(int userId, int productId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            String jpql = "DELETE FROM Wishlist w WHERE w.user.id = :userId AND w.product.id = :productId";
            int deleted = em.createQuery(jpql)
                           .setParameter("userId", userId)
                           .setParameter("productId", productId)
                           .executeUpdate();
            
            tx.commit();
            return deleted > 0;
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
     * Get wishlist count for user
     */
    public int getCount(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(w) FROM Wishlist w WHERE w.user.id = :userId";
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
