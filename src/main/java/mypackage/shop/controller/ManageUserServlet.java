/*
 * ManageUserServlet - Quản lý người dùng cho Admin
 */
package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
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
 * ManageUserServlet - Admin user management
 * @author PC
 */
@WebServlet(name = "ManageUserServlet", urlPatterns = {"/manage/users"})
public class ManageUserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

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
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            // Edit user form
            try {
                int userId = Integer.parseInt(request.getParameter("id"));
                User editUser = userDAO.getUserById(userId);
                if (editUser != null) {
                    request.setAttribute("editUser", editUser);
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID người dùng không hợp lệ!");
            }
        }
        
        // Get users (with search if provided)
        String keyword = request.getParameter("keyword");
        List<User> users;
        
        System.out.println("=== ManageUserServlet: keyword=" + keyword + " ===");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            System.out.println("=== Searching users by keyword: " + keyword.trim() + " ===");
            users = userDAO.searchUsersByFullName(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else {
            users = userDAO.getAllUsers();
        }
        
        System.out.println("=== Users found: " + users.size() + " ===");
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
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
        
        if ("updateRole".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newRole = request.getParameter("role");
                
                User targetUser = userDAO.getUserById(userId);
                if (targetUser != null) {
                    targetUser.setRole(newRole);
                    boolean success = userDAO.updateProfile(targetUser);
                    
                    if (success) {
                        session.setAttribute("successMessage", "Cập nhật vai trò thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Không thể cập nhật vai trò!");
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID người dùng không hợp lệ!");
            }
        } else if ("toggleStatus".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                
                User targetUser = userDAO.getUserById(userId);
                if (targetUser != null) {
                    targetUser.setStatus(!targetUser.isStatus());
                    boolean success = userDAO.updateProfile(targetUser);
                    
                    if (success) {
                        session.setAttribute("successMessage", 
                            targetUser.isStatus() ? "Đã kích hoạt tài khoản!" : "Đã vô hiệu hóa tài khoản!");
                    } else {
                        session.setAttribute("errorMessage", "Không thể cập nhật trạng thái!");
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID người dùng không hợp lệ!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/users");
    }
}
