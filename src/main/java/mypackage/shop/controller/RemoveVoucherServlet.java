/*
 * (Xóa mã giảm giá)
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
import mypackage.shop.model.Cart;

/**
 *
 * @author PC
 */
@WebServlet(name = "RemoveVoucherServlet", urlPatterns = {"/cart/remove-voucher"})
public class RemoveVoucherServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("RemoveVoucherServlet: Request received.");
        
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart != null) {
            System.out.println("RemoveVoucherServlet: Removing voucher from cart.");
            cart.setVoucher(null); // Remove voucher
            session.setAttribute("cart", cart); // Update session
            
            // Set message
            session.setAttribute("voucherMessage", "Đã hủy mã giảm giá");
            session.setAttribute("voucherStatus", "success");
        } else {
             System.out.println("RemoveVoucherServlet: Cart is null.");
        }
        
        // Redirect back to cart
        response.sendRedirect(request.getContextPath() + "/cart");
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
}
