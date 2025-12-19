package mypackage.shop.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Utility class để quản lý JPA EntityManager
 * Thay thế DBContext cho JDBC thuần
 */
public class JPAUtil {
    
    private static final String PERSISTENCE_UNIT_NAME = "ClothesShopPU";
    private static EntityManagerFactory entityManagerFactory;
    
    static {
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        } catch (Throwable ex) {
            System.err.println("Initial EntityManagerFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    /**
     * Lấy EntityManagerFactory singleton
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }
    
    /**
     * Tạo EntityManager mới
     * Lưu ý: Người gọi cần close() EntityManager sau khi sử dụng
     */
    public static EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }
    
    /**
     * Đóng EntityManagerFactory khi shutdown application
     */
    public static void shutdown() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
        }
    }
}
