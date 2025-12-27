/*
 * ReviewDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import mypackage.shop.model.Review;
import mypackage.shop.model.User;
import mypackage.shop.model.Product;

import java.sql.Timestamp;
import java.util.List;

/**
 * ReviewDAO - Handles product reviews using JPA
 * @author PC
 */
public class ReviewDAO extends GenericDAO<Review> {

    public ReviewDAO() {
        super(Review.class);
    }

    /**
     * Add new review
     */
    public boolean addReview(Review review) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Get User and Product entities
            User user = em.find(User.class, review.getUserId());
            Product product = em.find(Product.class, review.getProductId());
            
            review.setUser(user);
            review.setProduct(product);
            review.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            em.persist(review);
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
     * Get all reviews for a product
     */
    public List<Review> getReviewsByProductId(int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT r FROM Review r " +
                         "LEFT JOIN FETCH r.user " +
                         "WHERE r.product.id = :productId " +
                         "ORDER BY r.createdAt DESC";
            List<Review> reviews = em.createQuery(jpql, Review.class)
                    .setParameter("productId", productId)
                    .getResultList();
            
            // Initialize transient fields while EntityManager is still open
            for (Review review : reviews) {
                if (review.getUser() != null) {
                    // Force lazy loading and cache the userName
                    String name = review.getUser().getFullName();
                    if (name == null || name.isEmpty()) {
                        name = review.getUser().getUsername();
                    }
                    review.setUserName(name != null ? name : "Người dùng");
                }
            }
            
            return reviews;
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get average rating for a product
     */
    public double getAverageRating(int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT AVG(r.rating) FROM Review r WHERE r.product.id = :productId";
            Double avg = em.createQuery(jpql, Double.class)
                          .setParameter("productId", productId)
                          .getSingleResult();
            return avg != null ? avg : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        } finally {
            em.close();
        }
    }

    /**
     * Count total reviews for a product
     */
    public int countReviews(int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("productId", productId)
                          .getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Check if user has already reviewed this product
     */
    public boolean hasUserReviewed(int userId, int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(r) FROM Review r WHERE r.user.id = :userId AND r.product.id = :productId";
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
     * Check if user has purchased this product (for review eligibility)
     */
    public boolean hasUserPurchased(int userId, int productId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(od) FROM OrderDetail od " +
                         "WHERE od.order.user.id = :userId " +
                         "AND od.product.id = :productId " +
                         "AND od.order.status != 'CANCELLED'";
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
}
