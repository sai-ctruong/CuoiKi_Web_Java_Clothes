/*
 * thống kê, quản lý user cho Admin
 */
package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Phúc
 */
public class AdminDAO {
    
    private DBContext dbContext;
    
    public AdminDAO() {
        this.dbContext = new DBContext();
    }
    
    /**
     * Đếm tổng số products
     */
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) as total FROM Product";
        return getCount(sql);
    }
    
    /**
     * Đếm tổng số categories
     */
    public int getTotalCategories() {
        String sql = "SELECT COUNT(*) as total FROM Category";
        return getCount(sql);
    }
    
    /**
     * Đếm tổng số brands
     */
    public int getTotalBrands() {
        String sql = "SELECT COUNT(*) as total FROM Brand";
        return getCount(sql);
    }
    
    /**
     * Đếm tổng số orders
     */
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) as total FROM `Order`";
        return getCount(sql);
    }
    
    /**
     * Đếm tổng số users
     */
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) as total FROM Users";
        return getCount(sql);
    }
    
    /**
     * Helper method để đếm từ một query
     */
    private int getCount(String sql) {
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
}