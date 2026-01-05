/*
 * UserVoucherDAO - Data access cho UserVoucher entity
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import mypackage.shop.model.UserVoucher;
import mypackage.shop.utils.HibernateUtil;

import java.sql.Timestamp;
import java.util.List;

/**
 * UserVoucherDAO - Quản lý voucher được gán cho user
 * @author PC
 */
public class UserVoucherDAO {

    /**
     * Get EntityManager from HibernateUtil
     */
    private EntityManager getEntityManager() {
        return HibernateUtil.getEntityManagerFactory().createEntityManager();
    }

    /**
     * Lấy danh sách voucher chưa sử dụng của user
     * @param userId ID của user
     * @return Danh sách UserVoucher còn khả dụng
     */
    public List<UserVoucher> getAvailableVouchersByUserId(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT uv FROM UserVoucher uv " +
                          "JOIN FETCH uv.voucher v " +
                          "WHERE uv.user.id = :userId " +
                          "AND uv.isUsed = false " +
                          "AND v.isActive = true " +
                          "ORDER BY uv.assignedAt DESC";
            TypedQuery<UserVoucher> query = em.createQuery(jpql, UserVoucher.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("UserVoucherDAO Error: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Kiểm tra user có sở hữu voucher này không
     * @param userId ID của user
     * @param voucherId ID của voucher
     * @return UserVoucher nếu tìm thấy, null nếu không
     */
    public UserVoucher getUserVoucher(int userId, int voucherId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT uv FROM UserVoucher uv " +
                          "JOIN FETCH uv.voucher v " +
                          "WHERE uv.user.id = :userId " +
                          "AND uv.voucher.id = :voucherId " +
                          "AND uv.isUsed = false";
            TypedQuery<UserVoucher> query = em.createQuery(jpql, UserVoucher.class);
            query.setParameter("userId", userId);
            query.setParameter("voucherId", voucherId);
            
            List<UserVoucher> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            System.err.println("UserVoucherDAO Error: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Đánh dấu voucher đã sử dụng
     * @param userVoucherId ID của UserVoucher
     * @return true nếu thành công
     */
    public boolean markAsUsed(int userVoucherId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            
            UserVoucher uv = em.find(UserVoucher.class, userVoucherId);
            if (uv != null) {
                uv.setUsed(true);
                uv.setUsedAt(new Timestamp(System.currentTimeMillis()));
                em.merge(uv);
            }
            
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("UserVoucherDAO Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy UserVoucher by code và userId
     * @param userId ID của user
     * @param voucherCode mã voucher
     * @return UserVoucher nếu tìm thấy
     */
    public UserVoucher getUserVoucherByCode(int userId, String voucherCode) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT uv FROM UserVoucher uv " +
                          "JOIN FETCH uv.voucher v " +
                          "WHERE uv.user.id = :userId " +
                          "AND v.code = :code " +
                          "AND uv.isUsed = false";
            TypedQuery<UserVoucher> query = em.createQuery(jpql, UserVoucher.class);
            query.setParameter("userId", userId);
            query.setParameter("code", voucherCode);
            
            List<UserVoucher> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            System.err.println("UserVoucherDAO Error: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}
