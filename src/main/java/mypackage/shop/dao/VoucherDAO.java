/*
 * (Check mã giảm giá)
 */

//Author: Hoai

package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import mypackage.shop.model.Voucher;

public class VoucherDAO {

    private DBContext dbContext;

    public VoucherDAO() {
        this.dbContext = new DBContext();
    }

    public Voucher findByCode(String code) {
        String sql = "SELECT * FROM Voucher WHERE code = ?";
        System.out.println("VoucherDAO: Finding voucher with code: " + code);
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, code);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("VoucherDAO: Found voucher id=" + rs.getInt("id"));
                    return mapResultSetToVoucher(rs);
                } else {
                    System.out.println("VoucherDAO: No voucher found with code " + code);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("VoucherDAO Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    private Voucher mapResultSetToVoucher(ResultSet rs) throws SQLException {
        Voucher voucher = new Voucher();
        voucher.setId(rs.getInt("id"));
        voucher.setCode(rs.getString("code"));
        
        int discountPercent = rs.getInt("discount_percent");
        if (!rs.wasNull()) {
            voucher.setDiscountPercent(discountPercent);
        }
        
        voucher.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        voucher.setMinOrderValue(rs.getBigDecimal("min_order_value"));
        
        if (rs.getTimestamp("start_date") != null) {
            voucher.setStartDate(rs.getTimestamp("start_date").toLocalDateTime());
        }
        
        if (rs.getTimestamp("end_date") != null) {
            voucher.setEndDate(rs.getTimestamp("end_date").toLocalDateTime());
        }
        
        voucher.setUsageLimit(rs.getInt("usage_limit"));
        voucher.setIsActive(rs.getBoolean("is_active"));
        
        return voucher;
    }
}
