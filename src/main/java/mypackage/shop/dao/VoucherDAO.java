/*
 * (Check mã giảm giá)
 */

//Author: Hoai

package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import mypackage.shop.model.Voucher;
import mypackage.shop.utils.HibernateUtil;

import java.util.List;

/**
 * VoucherDAO - Data access for Voucher entity using Hibernate/JPA
 */
public class VoucherDAO {

    /**
     * Get EntityManager from HibernateUtil
     */
    private EntityManager getEntityManager() {
        return HibernateUtil.getEntityManagerFactory().createEntityManager();
    }

    /**
     * Find voucher by code
     */
    public Voucher findByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT v FROM Voucher v WHERE v.code = :code";
            TypedQuery<Voucher> query = em.createQuery(jpql, Voucher.class);
            query.setParameter("code", code);
            
            List<Voucher> results = query.getResultList();
            if (!results.isEmpty()) {
                System.out.println("VoucherDAO: Found voucher id=" + results.get(0).getId());
                return results.get(0);
            } else {
                System.out.println("VoucherDAO: No voucher found with code " + code);
            }
            return null;
        } catch (Exception e) {
            System.err.println("VoucherDAO Error: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Get all vouchers
     */
    public List<Voucher> getAllVouchers() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT v FROM Voucher v ORDER BY v.id DESC";
            TypedQuery<Voucher> query = em.createQuery(jpql, Voucher.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get all active vouchers
     */
    public List<Voucher> getActiveVouchers() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT v FROM Voucher v WHERE v.isActive = true ORDER BY v.id DESC";
            TypedQuery<Voucher> query = em.createQuery(jpql, Voucher.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get voucher by ID
     */
    public Voucher getVoucherById(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Voucher.class, id);
        } finally {
            em.close();
        }
    }
}