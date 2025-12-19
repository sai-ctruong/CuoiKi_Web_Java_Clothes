/*
 * (Lấy list sản phẩm, chi tiết, tìm kiếm, lọc)
 * CRUD operations cho Product
 */

//Author: Hoai, Phúc (mở rộng)

package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
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
    
    /**
     * Lấy tất cả products (có pagination)
     */
    public List<Product> getAllProducts() {
        return getAllProducts(0, Integer.MAX_VALUE);
    }
    
    /**
     * Lấy products với pagination
     */
    public List<Product> getAllProducts(int offset, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.id as category_id, c.name as category_name, c.description as category_description, "
                   + "b.id as brand_id, b.name as brand_name, b.logo_url as brand_logo_url, b.origin as brand_origin "
                   + "FROM Product p "
                   + "LEFT JOIN Category c ON p.category_id = c.id "
                   + "LEFT JOIN Brand b ON p.brand_id = b.id "
                   + "ORDER BY p.created_at DESC, p.id DESC "
                   + "LIMIT ? OFFSET ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    /**
     * Lấy products theo category
     */
    public List<Product> getProductsByCategory(Integer categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.id as category_id, c.name as category_name, c.description as category_description, "
                   + "b.id as brand_id, b.name as brand_name, b.logo_url as brand_logo_url, b.origin as brand_origin "
                   + "FROM Product p "
                   + "LEFT JOIN Category c ON p.category_id = c.id "
                   + "LEFT JOIN Brand b ON p.brand_id = b.id "
                   + "WHERE p.category_id = ? "
                   + "ORDER BY p.created_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    /**
     * Lấy products theo brand
     */
    public List<Product> getProductsByBrand(Integer brandId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.id as category_id, c.name as category_name, c.description as category_description, "
                   + "b.id as brand_id, b.name as brand_name, b.logo_url as brand_logo_url, b.origin as brand_origin "
                   + "FROM Product p "
                   + "LEFT JOIN Category c ON p.category_id = c.id "
                   + "LEFT JOIN Brand b ON p.brand_id = b.id "
                   + "WHERE p.brand_id = ? "
                   + "ORDER BY p.created_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, brandId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    /**
     * Đếm tổng số products
     */
    public int getTotalProductsCount() {
        String sql = "SELECT COUNT(*) as total FROM Product";
        
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
    
    /**
     * Thêm product mới
     */
    public Integer addProduct(Product product) {
        String sql = "INSERT INTO Product (name, description, price, size, color, category_id, brand_id, created_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getSize());
            ps.setString(5, product.getColor());
            
            if (product.getCategory() != null && product.getCategory().getId() != null) {
                ps.setInt(6, product.getCategory().getId());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }
            
            if (product.getBrand() != null && product.getBrand().getId() != null) {
                ps.setInt(7, product.getBrand().getId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            
            LocalDateTime now = LocalDateTime.now();
            ps.setTimestamp(8, java.sql.Timestamp.valueOf(now));
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Get generated ID
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Cập nhật product
     */
    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET name = ?, description = ?, price = ?, size = ?, color = ?, "
                   + "category_id = ?, brand_id = ? WHERE id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getSize());
            ps.setString(5, product.getColor());
            
            if (product.getCategory() != null && product.getCategory().getId() != null) {
                ps.setInt(6, product.getCategory().getId());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }
            
            if (product.getBrand() != null && product.getBrand().getId() != null) {
                ps.setInt(7, product.getBrand().getId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            
            ps.setInt(8, product.getId());
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa product
     */
    public boolean deleteProduct(Integer id) {
        String sql = "DELETE FROM Product WHERE id = ?";
        
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
     * Kiểm tra product có đang được sử dụng trong OrderDetail không
     */
    public boolean isProductInUse(Integer productId) {
        String sql = "SELECT COUNT(*) as count FROM OrderDetail WHERE product_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            
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
