/*
 * ResetPasswordServlet - Xử lý đặt lại mật khẩu
 */
package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
import mypackage.shop.dao.PasswordResetTokenDAO;
import mypackage.shop.model.PasswordResetToken;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ResetPasswordServlet - Handle password reset with token
 * @author PC
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ!");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Validate token
        PasswordResetToken resetToken = tokenDAO.findByToken(token);
        
        if (resetToken == null) {
            request.setAttribute("error", "Link đặt lại mật khẩu đã hết hạn hoặc không hợp lệ. Vui lòng yêu cầu link mới.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Token is valid, show reset form
        request.setAttribute("token", token);
        request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate inputs
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Token không hợp lệ!");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Validate token
        PasswordResetToken resetToken = tokenDAO.findByToken(token);
        
        if (resetToken == null) {
            request.setAttribute("error", "Link đặt lại mật khẩu đã hết hạn hoặc không hợp lệ. Vui lòng yêu cầu link mới.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Update password
        boolean updated = userDAO.updatePassword(resetToken.getUserId(), password);
        
        if (updated) {
            // Delete the used token
            tokenDAO.deleteToken(token);
            
            // Redirect to login with success message
            request.getSession().setAttribute("success", "Mật khẩu đã được đặt lại thành công! Vui lòng đăng nhập với mật khẩu mới.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        }
    }
}
