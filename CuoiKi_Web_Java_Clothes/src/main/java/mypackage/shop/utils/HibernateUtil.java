package mypackage.shop.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Hibernate Utility class for managing EntityManagerFactory
 * Provides singleton pattern for EntityManagerFactory and thread-safe EntityManager access
 */
public class HibernateUtil {
    
    private static final EntityManagerFactory emf;
    private static final ThreadLocal<EntityManager> threadLocalEntityManager = new ThreadLocal<>();
    
    static {
        try {
            emf = Persistence.createEntityManagerFactory("my_persistence_unit");
        } catch (Throwable ex) {
            System.err.println("Initial EntityManagerFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    /**
     * Get the EntityManagerFactory singleton
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }
    
    /**
     * Get EntityManager for current thread
     * Creates new one if not exists
     */
    public static EntityManager getEntityManager() {
        EntityManager em = threadLocalEntityManager.get();
        if (em == null || !em.isOpen()) {
            em = emf.createEntityManager();
            threadLocalEntityManager.set(em);
        }
        return em;
    }
    
    /**
     * Close EntityManager for current thread
     */
    public static void closeEntityManager() {
        EntityManager em = threadLocalEntityManager.get();
        if (em != null && em.isOpen()) {
            em.close();
        }
        threadLocalEntityManager.remove();
    }
    
    /**
     * Shutdown EntityManagerFactory
     * Call this when application is shutting down
     */
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
