/*
 * OrderSuccessServlet - Display order success page
 */
package mypackage.shop.controller;

import mypackage.shop.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * OrderSuccessServlet - Show order confirmation
 * @author PC
 */
@WebServlet(name = "OrderSuccessServlet", urlPatterns = {"/order-success"})
public class OrderSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Order order = (Order) session.getAttribute("lastOrder");
        
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        request.setAttribute("order", order);
        
        // Clear from session after displaying
        session.removeAttribute("lastOrder");
        
        request.getRequestDispatcher("/order-success.jsp").forward(request, response);
    }
}
