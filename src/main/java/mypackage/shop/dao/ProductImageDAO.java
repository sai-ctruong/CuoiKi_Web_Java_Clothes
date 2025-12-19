/*
 * DAO để quản lý ProductImage
 */
package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mypackage.shop.model.ProductImage;

/**
 *
 * @author Phúc
 */
public class ProductImageDAO {
    
    private DBContext dbContext;
    
    public ProductImageDAO() {
        this.dbContext = new DBContext();
    }
    
    /**
     * Lấy tất cả images của một product
     */
    public List<ProductImage> getImagesByProductId(Integer productId) {
        List<ProductImage> images = new ArrayList<>();
        String sql = "SELECT * FROM ProductImage WHERE product_id = ? ORDER BY is_thumbnail DESC, id";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images.add(mapResultSetToProductImage(rs));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return images;
    }
    
    /**
     * Lấy image theo ID
     */
    public ProductImage getImageById(Integer id) {
        String sql = "SELECT * FROM ProductImage WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProductImage(rs);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Thêm image mới
     */
    public boolean addImage(ProductImage image) {
        String sql = "INSERT INTO ProductImage (product_id, image_url, is_thumbnail) VALUES (?, ?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, image.getProduct().getId());
            ps.setString(2, image.getImageUrl());
            ps.setBoolean(3, image.getIsThumbnail() != null ? image.getIsThumbnail() : false);
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa image
     */
    public boolean deleteImage(Integer id) {
        String sql = "DELETE FROM ProductImage WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa tất cả images của một product
     */
    public boolean deleteImagesByProductId(Integer productId) {
        String sql = "DELETE FROM ProductImage WHERE product_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            
            int result = ps.executeUpdate();
            return result >= 0; // >= 0 vì có thể không có image nào
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Set thumbnail cho một image (và unset các image khác của cùng product)
     */
    public boolean setThumbnail(Integer imageId, Integer productId) {
        Connection conn = null;
        try {
            conn = dbContext.getConnection();
            conn.setAutoCommit(false);
            
            // Unset tất cả thumbnails của product này
            String unsetSql = "UPDATE ProductImage SET is_thumbnail = false WHERE product_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(unsetSql)) {
                ps.setInt(1, productId);
                ps.executeUpdate();
            }
            
            // Set thumbnail cho image này
            String setSql = "UPDATE ProductImage SET is_thumbnail = true WHERE id = ? AND product_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(setSql)) {
                ps.setInt(1, imageId);
                ps.setInt(2, productId);
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return false;
    }
    
    /**
     * Map ResultSet to ProductImage object
     */
    private ProductImage mapResultSetToProductImage(ResultSet rs) throws SQLException {
        ProductImage image = new ProductImage();
        image.setId(rs.getInt("id"));
        image.setImageUrl(rs.getString("image_url"));
        image.setIsThumbnail(rs.getBoolean("is_thumbnail"));
        
        // Note: Product object sẽ được set từ bên ngoài nếu cần
        // Vì lazy loading, không load Product ở đây
        
        return image;
    }
}
