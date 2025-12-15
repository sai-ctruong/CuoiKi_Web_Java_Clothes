/*
 * (Lấy list sản phẩm, chi tiết, tìm kiếm, lọc)
 */

//Author: Hoai

package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import mypackage.shop.model.Brand;
import mypackage.shop.model.Category;
import mypackage.shop.model.Product;

public class ProductDAO {
    
    private DBContext dbContext;

    public ProductDAO() {
        this.dbContext = new DBContext();
    }

    // Get product by ID using JDBC
    public Product getProductById(Integer productId) {
        String sql = "SELECT p.*, c.id as category_id, c.name as category_name, c.description as category_description, "
                   + "b.id as brand_id, b.name as brand_name, b.logo_url as brand_logo_url, b.origin as brand_origin "
                   + "FROM Product p "
                   + "LEFT JOIN Category c ON p.category_id = c.id "
                   + "LEFT JOIN Brand b ON p.brand_id = b.id "
                   + "WHERE p.id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Map ResultSet to Product object
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        
        // Handle price - convert to BigDecimal
        BigDecimal price = rs.getBigDecimal("price");
        product.setPrice(price != null ? price : BigDecimal.ZERO);
        
        product.setSize(rs.getString("size"));
        product.setColor(rs.getString("color"));
        
        // Set created_at if exists
        if (rs.getTimestamp("created_at") != null) {
            product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }

        // Set Category if exists
        if (rs.getObject("category_id") != null) {
            Category category = new Category();
            category.setId(rs.getInt("category_id"));
            category.setName(rs.getString("category_name"));
            category.setDescription(rs.getString("category_description"));
            product.setCategory(category);
        }

        // Set Brand if exists
        if (rs.getObject("brand_id") != null) {
            Brand brand = new Brand();
            brand.setId(rs.getInt("brand_id"));
            brand.setName(rs.getString("brand_name"));
            brand.setLogoUrl(rs.getString("brand_logo_url"));
            brand.setOrigin(rs.getString("brand_origin"));
            product.setBrand(brand);
        }

        return product;
    }
}
