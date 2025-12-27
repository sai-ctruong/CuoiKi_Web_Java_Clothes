package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
import mypackage.shop.dao.AddressDAO;
import mypackage.shop.model.User;
import mypackage.shop.model.Address;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * ProfileServlet - Xem/Sửa thông tin người dùng
 * @author PC
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private AddressDAO addressDAO = new AddressDAO();

    /**
     * GET - Hiển thị trang profile
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Reload user data from database
        User user = userDAO.getUserById(currentUser.getId());
        if (user != null) {
            session.setAttribute("user", user);
            request.setAttribute("user", user);
        }
        
        // Get user addresses
        List<Address> addresses = addressDAO.getAddressesByUserId(currentUser.getId());
        request.setAttribute("addresses", addresses);
        
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    /**
     * POST - Cập nhật thông tin profile
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response, currentUser, session);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, currentUser);
        } else {
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
    
    /**
     * Update profile information
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, 
                              User currentUser, HttpSession session) throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // Validate
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Họ tên không được để trống!");
            doGet(request, response);
            return;
        }
        
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Email không hợp lệ!");
            doGet(request, response);
            return;
        }
        
        // Check email exists (if changed)
        if (!email.equals(currentUser.getEmail()) && userDAO.emailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng!");
            doGet(request, response);
            return;
        }
        
        // Update user
        currentUser.setFullName(fullName.trim());
        currentUser.setEmail(email.trim());
        currentUser.setPhone(phone != null ? phone.trim() : null);
        
        boolean success = userDAO.updateProfile(currentUser);
        
        if (success) {
            // Update session
            session.setAttribute("user", currentUser);
            request.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
        }
        
        doGet(request, response);
    }
    
    /**
     * Change password
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response, 
                               User currentUser) throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate
        if (newPassword == null || newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải ít nhất 6 ký tự!");
            doGet(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            doGet(request, response);
            return;
        }
        
        // Verify current password
        User loginResult = userDAO.login(currentUser.getUsername(), currentPassword);
        if (loginResult == null) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            doGet(request, response);
            return;
        }
        
        // Update password
        boolean success = userDAO.updatePassword(currentUser.getId(), newPassword);
        
        if (success) {
            request.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
        }
        
        doGet(request, response);
    }
}
