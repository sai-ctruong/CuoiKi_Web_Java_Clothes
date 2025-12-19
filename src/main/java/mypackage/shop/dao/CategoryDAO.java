/*
 * (Lấy danh mục hiển thị lên Menu)
 * CRUD operations cho Category
 */
package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mypackage.shop.model.Category;

/**
 *
 * @author Phúc
 */
public class CategoryDAO {
    
    private DBContext dbContext;
    
    public CategoryDAO() {
        this.dbContext = new DBContext();
    }
    
    /**
     * Lấy tất cả categories
     */
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category ORDER BY name";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                categories.add(mapResultSetToCategory(rs));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    /**
     * Lấy category theo ID
     */
    public Category getCategoryById(Integer id) {
        String sql = "SELECT * FROM Category WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCategory(rs);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Thêm category mới
     */
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO Category (name, description) VALUES (?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Cập nhật category
     */
    public boolean updateCategory(Category category) {
        String sql = "UPDATE Category SET name = ?, description = ? WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getId());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa category
     */
    public boolean deleteCategory(Integer id) {
        String sql = "DELETE FROM Category WHERE id = ?";
        
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
     * Kiểm tra category có đang được sử dụng trong Product không
     */
    public boolean isCategoryInUse(Integer categoryId) {
        String sql = "SELECT COUNT(*) as count FROM Product WHERE category_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            
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
     * Map ResultSet to Category object
     */
    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDescription(rs.getString("description"));
        return category;
    }
}