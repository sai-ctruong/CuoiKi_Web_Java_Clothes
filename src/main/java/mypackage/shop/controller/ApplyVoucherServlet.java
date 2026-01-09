
//Author: Hoai

package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import mypackage.shop.dao.VoucherDAO;
import mypackage.shop.model.Cart;
import mypackage.shop.model.Voucher;

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
        
        String code = request.getParameter("code");
        System.out.println("ApplyVoucherServlet: Received code = " + code);
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("voucherMessage", "Giỏ hàng trống!");
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        if (code == null || code.trim().isEmpty()) {
            session.setAttribute("voucherMessage", "Vui lòng nhập mã giảm giá!");
            session.setAttribute("voucherStatus", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        VoucherDAO voucherDAO = new VoucherDAO();
        try {
            Voucher voucher = voucherDAO.findByCode(code.trim());
            
            if (voucher == null) {
                session.setAttribute("voucherMessage", "Mã giảm giá không tồn tại!");
                session.setAttribute("voucherStatus", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            if (!voucher.isValid()) {
                session.setAttribute("voucherMessage", "Mã giảm giá đã hết hạn hoặc không hoạt động!");
                session.setAttribute("voucherStatus", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            if (voucher.getMinOrderValue() != null && cart.getTotalPrice().compareTo(voucher.getMinOrderValue()) < 0) {
                 session.setAttribute("voucherMessage", "Đơn hàng chưa đạt giá trị tối thiểu để áp dụng mã này!");
                 session.setAttribute("voucherStatus", "error");
                 response.sendRedirect(request.getContextPath() + "/cart");
                 return;
            }
            
            if (voucher.getUsageLimit() <= 0) {
                session.setAttribute("voucherMessage", "Mã giảm giá đã hết lượt sử dụng!");
                session.setAttribute("voucherStatus", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            cart.setVoucher(voucher);
            session.setAttribute("cart", cart); // Update session
            
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
