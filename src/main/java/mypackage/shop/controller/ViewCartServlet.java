/*
 * (Xem giỏ hàng)
 * Đã sửa: Đọc từ Database thay vì Session
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import mypackage.shop.dao.CartDAO;
import mypackage.shop.model.CartItem;
import mypackage.shop.model.CartItemDTO;
import mypackage.shop.model.User;
import mypackage.shop.model.Voucher;
import mypackage.shop.dao.VoucherDAO;

/**
 * ViewCartServlet - Hiển thị giỏ hàng
 * Đọc dữ liệu từ Database
 * @author PC
 */
@WebServlet(name = "ViewCartServlet", urlPatterns = {"/cart"})
public class ViewCartServlet extends HttpServlet {

    private CartDAO cartDAO;
    private VoucherDAO voucherDAO;
    
    @Override 
    public void init() throws ServletException {
        super.init();
        cartDAO = new CartDAO();
        voucherDAO = new VoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        List<CartItemDTO> cartItems = new ArrayList<>();
        BigDecimal subtotal = BigDecimal.ZERO;
        
        // Nếu đã đăng nhập, lấy giỏ hàng từ Database
        if (user != null) {
            List<CartItem> dbCartItems = cartDAO.getCartByUserId(user.getId());
            
            for (CartItem item : dbCartItems) {
                CartItemDTO dto = new CartItemDTO();
                dto.setId(item.getId());  // CartItemDTO.id được sử dụng cho delete/update
                dto.setProductName(item.getProduct().getName());
                dto.setProductPrice(item.getProduct().getPrice());
                dto.setProductBrand(item.getProduct().getBrandName());  // Dùng getBrandName() thay vì getBrand()
                dto.setProductImage(item.getProduct().getThumbnailUrl());
                dto.setProductSize(item.getProduct().getSize());
                dto.setProductColor(item.getProduct().getColor());
                dto.setQuantity(item.getQuantity());
                dto.setSubtotal(item.getSubtotal());
                cartItems.add(dto);
                subtotal = subtotal.add(item.getSubtotal());
            }
        }
        // Nếu chưa đăng nhập, giỏ hàng sẽ trống (theo yêu cầu bắt buộc đăng nhập)
        
        // Calculate discount if voucher applied
        BigDecimal discount = BigDecimal.ZERO;
        Voucher appliedVoucher = (Voucher) session.getAttribute("appliedVoucher");
        
        if (appliedVoucher != null && subtotal.compareTo(BigDecimal.ZERO) > 0) {
            discount = appliedVoucher.calculateDiscount(subtotal);
        }
        
        // Calculate final total
        BigDecimal total = subtotal.subtract(discount);
        if (total.compareTo(BigDecimal.ZERO) < 0) {
            total = BigDecimal.ZERO;
        }
        
        // Load available vouchers for display
        List<Voucher> availableVouchers = voucherDAO.getActiveVouchers();
        
        // Set attributes for JSP
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);
        request.setAttribute("appliedVoucher", appliedVoucher);
        request.setAttribute("availableVouchers", availableVouchers);
        
        // Forward to cart.jsp
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}