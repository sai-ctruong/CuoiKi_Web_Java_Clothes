package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
import mypackage.shop.model.User;
import mypackage.shop.model.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RegisterServlet - Xử lý đăng ký
 * @author PC
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    /**
     * GET - Hiển thị form đăng ký
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    /**
     * POST - Xử lý đăng ký
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        
        // Validate input
        StringBuilder errors = new StringBuilder();
        
        if (username == null || username.trim().isEmpty()) {
            errors.append("Tên đăng nhập không được để trống. ");
        } else if (username.length() < 3 || username.length() > 50) {
            errors.append("Tên đăng nhập phải từ 3-50 ký tự. ");
        }
        
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.append("Email không hợp lệ. ");
        }
        
        if (password == null || password.length() < 6) {
            errors.append("Mật khẩu phải ít nhất 6 ký tự. ");
        }
        
        if (!password.equals(confirmPassword)) {
            errors.append("Mật khẩu xác nhận không khớp. ");
        }
        
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.append("Họ tên không được để trống. ");
        }
        
        // Check if username/email exists
        if (userDAO.usernameExists(username)) {
            errors.append("Tên đăng nhập đã tồn tại. ");
        }
        
        if (userDAO.emailExists(email)) {
            errors.append("Email đã được sử dụng. ");
        }
        
        // If has errors, return to form
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setFullName(fullName.trim());
        user.setPhone(phone != null ? phone.trim() : null);
        user.setRole(Role.CUSTOMER);
        user.setStatus(true);
        
        // Save to database
        boolean success = userDAO.register(user);
        
        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
