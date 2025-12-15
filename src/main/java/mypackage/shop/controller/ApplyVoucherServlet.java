/*
 * (Xử lý áp dụng mã giảm giá)
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import mypackage.shop.dao.VoucherDAO;
import mypackage.shop.model.Cart;
import mypackage.shop.model.Voucher;

/**
 *
 * @author PC
 */
@WebServlet(name = "ApplyVoucherServlet", urlPatterns = {"/cart/apply-voucher"})
public class ApplyVoucherServlet extends HttpServlet {

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
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String code = request.getParameter("code");
            System.out.println("ApplyVoucherServlet: Received code = " + code);
            
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            
            // Check if cart exists and is not empty
            if (cart == null || cart.isEmpty()) {
                System.out.println("ApplyVoucherServlet: Cart is null or empty");
                out.print("{\"status\": \"error\", \"message\": \"Giỏ hàng trống!\"}");
                return;
            }
            
            // Check if code is empty
            if (code == null || code.trim().isEmpty()) {
                out.print("{\"status\": \"error\", \"message\": \"Vui lòng nhập mã giảm giá!\"}");
                return;
            }
            
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.findByCode(code.trim());
            
            // Check if voucher exists
            if (voucher == null) {
                out.print("{\"status\": \"error\", \"message\": \"Mã giảm giá không tồn tại!\"}");
                return;
            }
            
            // Check if voucher is valid
            if (!voucher.isValid()) {
                out.print("{\"status\": \"error\", \"message\": \"Mã giảm giá đã hết hạn hoặc không hoạt động!\"}");
                return;
            }
            
            // Check minimum order value
            if (voucher.getMinOrderValue() != null && cart.getTotalPrice().compareTo(voucher.getMinOrderValue()) < 0) {
                 out.print("{\"status\": \"error\", \"message\": \"Đơn hàng chưa đạt giá trị tối thiểu để áp dụng mã này!\"}");
                 return;
            }
            
            // Check usage limit (Optional: logic to decrease limit would be in Order placement, here just check > 0)
            if (voucher.getUsageLimit() <= 0) {
                out.print("{\"status\": \"error\", \"message\": \"Mã giảm giá đã hết lượt sử dụng!\"}");
                return;
            }
            
            // Apply voucher
            cart.setVoucher(voucher);
            session.setAttribute("cart", cart); // Update session
            
            // Calculate new values
            BigDecimal discountAmount = cart.getDiscountAmount();
            BigDecimal finalTotal = cart.getFinalTotal();
            
            // Return success JSON
            out.print("{");
            out.print("\"status\": \"success\",");
            out.print("\"message\": \"Áp dụng mã giảm giá thành công!\",");
            out.print("\"discountAmount\": " + discountAmount + ",");
            out.print("\"finalTotal\": " + finalTotal);
            out.print("}");
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
