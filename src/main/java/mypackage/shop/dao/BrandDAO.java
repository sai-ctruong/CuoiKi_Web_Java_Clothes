/*
 * CRUD operations cho Brand
 */
package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mypackage.shop.model.Brand;

/**
 *
 * @author Phúc
 */
public class BrandDAO {
    
    private DBContext dbContext;
    
    public BrandDAO() {
        this.dbContext = new DBContext();
    }
    
    /**
     * Lấy tất cả brands
     */
    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM Brand ORDER BY name";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                brands.add(mapResultSetToBrand(rs));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return brands;
    }
    
    /**
     * Lấy brand theo ID
     */
    public Brand getBrandById(Integer id) {
        String sql = "SELECT * FROM Brand WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBrand(rs);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Thêm brand mới
     */
    public boolean addBrand(Brand brand) {
        String sql = "INSERT INTO Brand (name, logo_url, origin) VALUES (?, ?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, brand.getName());
            ps.setString(2, brand.getLogoUrl());
            ps.setString(3, brand.getOrigin());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Cập nhật brand
     */
    public boolean updateBrand(Brand brand) {
        String sql = "UPDATE Brand SET name = ?, logo_url = ?, origin = ? WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, brand.getName());
            ps.setString(2, brand.getLogoUrl());
            ps.setString(3, brand.getOrigin());
            ps.setInt(4, brand.getId());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa brand
     */
    public boolean deleteBrand(Integer id) {
        String sql = "DELETE FROM Brand WHERE id = ?";
        
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
     * Kiểm tra brand có đang được sử dụng trong Product không
     */
    public boolean isBrandInUse(Integer brandId) {
        String sql = "SELECT COUNT(*) as count FROM Product WHERE brand_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, brandId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Map ResultSet to Brand object
     */
    private Brand mapResultSetToBrand(ResultSet rs) throws SQLException {
        Brand brand = new Brand();
        brand.setId(rs.getInt("id"));
        brand.setName(rs.getString("name"));
        brand.setLogoUrl(rs.getString("logo_url"));
        brand.setOrigin(rs.getString("origin"));
        return brand;
    }
}
