package mypackage.shop.controller;

import mypackage.shop.dao.OrderDAO;
import mypackage.shop.model.Order;
import mypackage.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * OrderHistoryServlet - User order history and details
 * @author PC
 */
@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/orders", "/my-orders"})
public class OrderHistoryServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            // View order details
            try {
                int orderId = Integer.parseInt(orderIdParam);
                Order order = orderDAO.getOrderById(orderId);
                
                // Check if order belongs to current user
                if (order != null && order.getUserId() == user.getId()) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/orders");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/orders");
            }
        } else {
            // List all orders
            List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/order-history.jsp").forward(request, response);
        }
    }
}
