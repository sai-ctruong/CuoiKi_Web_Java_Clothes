/*
 * AdminDAO sử dụng JPA EntityManager - thống kê, quản lý user cho Admin
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import mypackage.shop.util.HibernateUtil;
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
     * Get total revenue from delivered orders
     */
    public double getTotalRevenue() {
        EntityManager em = getEntityManager();
        try {
            // First, count delivered orders
            Long deliveredCount = em.createQuery(
                "SELECT COUNT(o) FROM Order o WHERE o.status = 'DELIVERED'", Long.class
            ).getSingleResult();
            System.out.println("=== DELIVERED ORDERS COUNT: " + deliveredCount + " ===");
            
            // totalAmount is BigDecimal, so we need to handle it properly
            Object result = em.createQuery(
                "SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status = 'DELIVERED'"
            ).getSingleResult();
            
            System.out.println("=== REVENUE RESULT: " + result + " (type: " + (result != null ? result.getClass().getName() : "null") + ") ===");
            
            if (result == null) {
                return 0;
            }
            
            double revenue = 0;
            if (result instanceof java.math.BigDecimal) {
                revenue = ((java.math.BigDecimal) result).doubleValue();
            } else if (result instanceof Double) {
                revenue = (Double) result;
            } else if (result instanceof Long) {
                revenue = ((Long) result).doubleValue();
            } else if (result instanceof Integer) {
                revenue = ((Integer) result).doubleValue();
            } else {
                revenue = Double.parseDouble(result.toString());
            }
            
            System.out.println("=== TOTAL REVENUE: " + revenue + " ===");
            return revenue;
        } catch (Exception e) {
            System.err.println("=== ERROR GETTING TOTAL REVENUE: " + e.getMessage() + " ===");
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
}
