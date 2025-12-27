/*
 * UserDAO sử dụng JPA EntityManager
 * Đây là phiên bản mới sử dụng Hibernate/JPA
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import mypackage.shop.model.User;
import mypackage.shop.model.Role;
import mypackage.shop.util.HibernateUtil;
import mypackage.shop.utils.PasswordUtils;

import java.sql.Timestamp;
import java.util.List;

/**
 * Data Access Object for User operations using JPA EntityManager
 * @author PC
 */
public class UserDAO extends GenericDAO<User> {
    
    public UserDAO() {
        super(User.class);
    }
    
    /**
     * Register new user
     * @param user User object to register
     * @return true if registration successful
     */
    public boolean register(User user) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Hash password before saving
            user.setPassword(PasswordUtils.hashPassword(user.getPassword()));
            user.setRole(user.getRole() != null ? user.getRole() : Role.CUSTOMER);
            user.setStatus(true);
            user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            em.persist(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            System.err.println("=== REGISTER USER ERROR ===");
            System.err.println("Error: " + e.getMessage());
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
     * Login user with username/email and password
     * @param usernameOrEmail Username or Email
     * @param password Plain text password
     * @return User object if login successful, null otherwise
     */
    public User login(String usernameOrEmail, String password) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE (u.username = :login OR u.email = :login) AND u.status = true";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("login", usernameOrEmail);
            
            User user = query.getSingleResult();
            
            if (user != null) {
                String storedPassword = user.getPassword();
                boolean passwordMatch;
                
                if (PasswordUtils.isHashed(storedPassword)) {
                    passwordMatch = PasswordUtils.verifyPassword(password, storedPassword);
                } else {
                    // Plain text password (legacy)
                    passwordMatch = password.equals(storedPassword);
                }
                
                if (passwordMatch) {
                    return user;
                }
            }
        } catch (NoResultException e) {
            // No user found
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return null;
    }
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object or null
     */
    public User getUserById(int userId) {
        return findById(userId);
    }
    
    /**
     * Update user profile
     * @param user User object with updated info
     * @return true if update successful
     */
    public boolean updateProfile(User user) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            User existingUser = em.find(User.class, user.getId());
            if (existingUser != null) {
                existingUser.setFullName(user.getFullName());
                existingUser.setPhone(user.getPhone());
                existingUser.setEmail(user.getEmail());
                existingUser.setStatus(user.isStatus());
                existingUser.setRole(user.getRole());
                em.merge(existingUser);
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
     * Update user password
     * @param userId User ID
     * @param newPassword New plain text password (will be hashed)
     * @return true if update successful
     */
    public boolean updatePassword(int userId, String newPassword) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            User user = em.find(User.class, userId);
            if (user != null) {
                user.setPassword(PasswordUtils.hashPassword(newPassword));
                em.merge(user);
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
     * Check if username already exists
     * @param username Username to check
     * @return true if exists
     */
    public boolean usernameExists(String username) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.username = :username";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("username", username)
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
     * Check if email already exists
     * @param email Email to check
     * @return true if exists
     */
    public boolean emailExists(String email) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("email", email)
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
     * Get all users (for Admin)
     * @return List of all users
     */
    public List<User> getAllUsers() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT u FROM User u ORDER BY u.createdAt DESC";
            return em.createQuery(jpql, User.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }
    
    /**
     * Search users by full name
     * @param keyword Search keyword
     * @return List of matching users
     */
    public List<User> searchUsersByFullName(String keyword) {
        EntityManager em = getEntityManager();
        try {
            System.out.println("=== SEARCHING USERS BY NAME: " + keyword + " ===");
            String jpql = "SELECT u FROM User u WHERE LOWER(u.fullName) LIKE LOWER(:keyword) ORDER BY u.createdAt DESC";
            List<User> results = em.createQuery(jpql, User.class)
                    .setParameter("keyword", "%" + keyword + "%")
                    .getResultList();
            System.out.println("=== FOUND " + results.size() + " USERS ===");
            return results;
        } catch (Exception e) {
            System.err.println("=== ERROR SEARCHING USERS: " + e.getMessage() + " ===");
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }
}
