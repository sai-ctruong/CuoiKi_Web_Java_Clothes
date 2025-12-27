/*
 * (Xử lý áp dụng mã giảm giá)
 * Fixed: Now reads cart from database instead of session
 */

//Author: Hoai

package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import mypackage.shop.dao.CartDAO;
import mypackage.shop.dao.VoucherDAO;
import mypackage.shop.model.CartItem;
import mypackage.shop.model.User;
import mypackage.shop.model.Voucher;

@WebServlet(name = "ApplyVoucherServlet", urlPatterns = {"/cart/apply-voucher"})
public class ApplyVoucherServlet extends HttpServlet {

    private CartDAO cartDAO;
    private VoucherDAO voucherDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        cartDAO = new CartDAO();
        voucherDAO = new VoucherDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        System.out.println("ApplyVoucherServlet: Received code = " + code);
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            session.setAttribute("voucherMessage", "Vui lòng đăng nhập để sử dụng mã giảm giá!");
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Get cart items from database
        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());
        
        // Check if cart is empty
        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("voucherMessage", "Giỏ hàng trống!");
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate subtotal from cart items
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getSubtotal());
        }
        
        // Check if code is empty
        if (code == null || code.trim().isEmpty()) {
            session.setAttribute("voucherMessage", "Vui lòng nhập mã giảm giá!");
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            Voucher voucher = voucherDAO.findByCode(code.trim());
            
            // Check if voucher exists
            if (voucher == null) {
                session.setAttribute("voucherMessage", "Mã giảm giá không tồn tại!");
                session.setAttribute("voucherStatus", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Check if voucher is valid
            if (!voucher.isValid()) {
                session.setAttribute("voucherMessage", "Mã giảm giá đã hết hạn hoặc không hoạt động!");
                session.setAttribute("voucherStatus", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Check minimum order value
            if (voucher.getMinOrderValue() != null && subtotal.compareTo(voucher.getMinOrderValue()) < 0) {
                 session.setAttribute("voucherMessage", "Đơn hàng chưa đạt giá trị tối thiểu để áp dụng mã này!");
                 session.setAttribute("voucherStatus", "error");
                 response.sendRedirect(request.getContextPath() + "/cart");
                 return;
            }
            
            // Check usage limit
            if (voucher.getUsageLimit() <= 0) {
                session.setAttribute("voucherMessage", "Mã giảm giá đã hết lượt sử dụng!");
                session.setAttribute("voucherStatus", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Apply voucher - store in session for use by ViewCartServlet
            session.setAttribute("appliedVoucher", voucher);
            
            session.setAttribute("voucherMessage", "Áp dụng mã giảm giá thành công!");
            session.setAttribute("voucherStatus", "success");
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("voucherMessage", "Có lỗi xảy ra: " + e.getMessage());
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}