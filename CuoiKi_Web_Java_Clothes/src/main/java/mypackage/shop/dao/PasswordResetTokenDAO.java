/*
 * PasswordResetTokenDAO - Data Access Object for password reset tokens
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import mypackage.shop.model.PasswordResetToken;
import mypackage.shop.utils.HibernateUtil;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * Data Access Object for Password Reset Token operations
 * @author PC
 */
public class PasswordResetTokenDAO {
    
    private EntityManager getEntityManager() {
        return HibernateUtil.getEntityManager();
    }
    
    /**
     * Create a new password reset token for user
     * @param userId User ID
     * @return The generated token string
     */
    public String createToken(int userId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Delete any existing tokens for this user
            em.createQuery("DELETE FROM PasswordResetToken t WHERE t.userId = :userId")
              .setParameter("userId", userId)
              .executeUpdate();
            
            // Create new token
            PasswordResetToken token = new PasswordResetToken(userId);
            em.persist(token);
            
            tx.commit();
            return token.getToken();
            
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * Find valid (non-expired) token
     * @param token Token string
     * @return PasswordResetToken or null if not found/expired
     */
    public PasswordResetToken findByToken(String token) {
        EntityManager em = getEntityManager();
        try {
            PasswordResetToken resetToken = em.createQuery(
                    "SELECT t FROM PasswordResetToken t WHERE t.token = :token", 
                    PasswordResetToken.class)
                .setParameter("token", token)
                .getSingleResult();
            
            // Check if expired
            if (resetToken.isExpired()) {
                return null;
            }
            
            return resetToken;
            
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
     * Delete token after use
     * @param token Token string to delete
     */
    public void deleteToken(String token) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            em.createQuery("DELETE FROM PasswordResetToken t WHERE t.token = :token")
              .setParameter("token", token)
              .executeUpdate();
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    
    /**
     * Delete all tokens for a user
     * @param userId User ID
     */
    public void deleteByUserId(int userId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            em.createQuery("DELETE FROM PasswordResetToken t WHERE t.userId = :userId")
              .setParameter("userId", userId)
              .executeUpdate();
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    
    /**
     * Clean up expired tokens (can be called periodically)
     */
    public void deleteExpiredTokens() {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            Timestamp now = Timestamp.valueOf(LocalDateTime.now());
            em.createQuery("DELETE FROM PasswordResetToken t WHERE t.expiryDate < :now")
              .setParameter("now", now)
              .executeUpdate();
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
