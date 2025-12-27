/*
 * AdminDAO sử dụng JPA EntityManager - thống kê, quản lý user cho Admin
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import mypackage.shop.utils.HibernateUtil;
import mypackage.shop.model.*;

/**
 * AdminDAO - Dashboard statistics using JPA
 * @author PC
 */
public class AdminDAO {

    /**
     * Get EntityManager
     */
    protected EntityManager getEntityManager() {
        return HibernateUtil.getEntityManagerFactory().createEntityManager();
    }

    /**
     * Get total products count
     */
    public int getTotalProducts() {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(p) FROM Product p", Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get total categories count
     */
    public int getTotalCategories() {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(c) FROM Category c", Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get total brands count
     */
    public int getTotalBrands() {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(b) FROM Brand b", Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get total users count
     */
    public int getTotalUsers() {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(u) FROM User u", Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get total orders count
     */
    public int getTotalOrders() {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(o) FROM Order o", Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get pending orders count
     */
    public int getPendingOrders() {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(o) FROM Order o WHERE o.status = 'PENDING'", Long.class).getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get total revenue
     */
    public double getTotalRevenue() {
        EntityManager em = getEntityManager();
        try {
            Double revenue = em.createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status = 'DELIVERED'", Double.class
            ).getSingleResult();
            return revenue != null ? revenue : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
}
