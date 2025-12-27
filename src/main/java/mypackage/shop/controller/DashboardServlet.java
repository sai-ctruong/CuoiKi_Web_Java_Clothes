/*
Trang thống kê chính (admin quản trị)
 */
package mypackage.shop.controller;

import mypackage.shop.dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Dashboard Servlet - Admin main page with statistics
 * @author PC
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get statistics
        int totalProducts = adminDAO.getTotalProducts();
        int totalCategories = adminDAO.getTotalCategories();
        int totalBrands = adminDAO.getTotalBrands();
        int totalUsers = adminDAO.getTotalUsers();
        int totalOrders = adminDAO.getTotalOrders();
        int pendingOrders = adminDAO.getPendingOrders();
        double totalRevenue = adminDAO.getTotalRevenue();
        
        // Set attributes
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalBrands", totalBrands);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        
        // Forward to dashboard page
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
