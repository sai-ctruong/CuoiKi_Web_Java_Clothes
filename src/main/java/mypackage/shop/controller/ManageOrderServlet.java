/*
 (Duyệt đơn hàng)
 */
package mypackage.shop.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mypackage.shop.dao.OrderDAO;
import mypackage.shop.model.Order;
import mypackage.shop.model.User;

/**
 * ManageOrderServlet - Admin order management
 * @author PC
 */
@WebServlet(name = "ManageOrderServlet", urlPatterns = {"/manage/orders"})
public class ManageOrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check admin permission
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Check if viewing order detail
        String orderIdParam = request.getParameter("id");
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                Order order = orderDAO.getOrderById(orderId);
                
                if (order != null) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
                    return;
                } else {
                    session.setAttribute("errorMessage", "Không tìm thấy đơn hàng #" + orderId + "!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID đơn hàng không hợp lệ!");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải đơn hàng: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/manage/orders");
            return;
        }
        
        String statusFilter = request.getParameter("status");
        String keyword = request.getParameter("keyword");
        List<Order> orders;
        
        System.out.println("=== ManageOrderServlet: keyword=" + keyword + ", status=" + statusFilter + " ===");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Search by customer name
            System.out.println("=== Searching orders by keyword: " + keyword.trim() + " ===");
            orders = orderDAO.searchOrdersByCustomerName(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("ALL")) {
            orders = orderDAO.getOrdersByStatus(statusFilter);
        } else {
            orders = orderDAO.getAllOrders();
        }
        
        System.out.println("=== Orders found: " + orders.size() + " ===");
        
        // Count by status for tabs
        request.setAttribute("countPending", orderDAO.countOrdersByStatus(Order.STATUS_PENDING));
        request.setAttribute("countShipping", orderDAO.countOrdersByStatus(Order.STATUS_SHIPPING));
        request.setAttribute("countDelivered", orderDAO.countOrdersByStatus(Order.STATUS_DELIVERED));
        request.setAttribute("countCancelled", orderDAO.countOrdersByStatus(Order.STATUS_CANCELLED));
        request.setAttribute("orders", orders);
        request.setAttribute("currentStatus", statusFilter != null ? statusFilter : "ALL");
        
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check admin permission
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String newStatus = request.getParameter("newStatus");
                String returnTo = request.getParameter("returnTo");
                
                // Validate status
                if (isValidStatus(newStatus)) {
                    boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
                    
                    if (success) {
                        session.setAttribute("successMessage", "Cập nhật trạng thái đơn hàng #" + orderId + " thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Không thể cập nhật trạng thái đơn hàng!");
                    }
                }
                
                // Return to detail page if requested
                if ("detail".equals(returnTo)) {
                    response.sendRedirect(request.getContextPath() + "/manage/orders?id=" + orderId);
                    return;
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID đơn hàng không hợp lệ!");
            }
        }
        
        // Redirect back with current filter
        String currentStatus = request.getParameter("currentStatus");
        if (currentStatus != null && !currentStatus.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage/orders?status=" + currentStatus);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage/orders");
        }
    }
    
    private boolean isValidStatus(String status) {
        return Order.STATUS_PENDING.equals(status) ||
               Order.STATUS_SHIPPING.equals(status) ||
               Order.STATUS_DELIVERED.equals(status) ||
               Order.STATUS_CANCELLED.equals(status);
    }
}
