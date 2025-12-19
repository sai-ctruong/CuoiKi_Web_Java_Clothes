/*
Trang thống kê chính (admin quản trị)
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import mypackage.shop.dao.AdminDAO;
import mypackage.shop.model.User;

/**
 *
 * @author Phúc
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/admin/dashboard"})
public class DashboardServlet extends HttpServlet {
    
    private AdminDAO adminDAO;
    
    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != User.Role.ADMIN) {
            session.setAttribute("errorMessage", "Bạn không có quyền truy cập trang quản trị");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        // Lấy thống kê
        int totalProducts = adminDAO.getTotalProducts();
        int totalCategories = adminDAO.getTotalCategories();
        int totalBrands = adminDAO.getTotalBrands();
        int totalOrders = adminDAO.getTotalOrders();
        int totalUsers = adminDAO.getTotalUsers();
        
        // Set attributes để hiển thị trong JSP
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalBrands", totalBrands);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        
        // Forward to dashboard JSP
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}