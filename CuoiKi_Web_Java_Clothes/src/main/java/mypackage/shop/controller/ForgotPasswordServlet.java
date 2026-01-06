/*
 * ForgotPasswordServlet - Xử lý quên mật khẩu với gửi email
 */
package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
import mypackage.shop.dao.PasswordResetTokenDAO;
import mypackage.shop.model.User;
import mypackage.shop.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ForgotPasswordServlet - Password recovery with email
 * @author PC
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập địa chỉ email!");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        email = email.trim().toLowerCase();
        
        // Find user by email
        User user = userDAO.findByEmail(email);
        
        if (user != null) {
            try {
                // Generate reset token
                String token = tokenDAO.createToken(user.getId());
                
                if (token != null) {
                    // Build reset link
                    String baseUrl = request.getScheme() + "://" + request.getServerName();
                    if (request.getServerPort() != 80 && request.getServerPort() != 443) {
                        baseUrl += ":" + request.getServerPort();
                    }
                    baseUrl += request.getContextPath();
                    
                    String resetLink = baseUrl + "/reset-password?token=" + token;
                    
                    // Send email
                    boolean emailSent = EmailUtils.sendPasswordResetEmail(email, resetLink);
                    
                    if (emailSent) {
                        System.out.println("Password reset email sent to: " + email);
                    } else {
                        System.err.println("Failed to send password reset email to: " + email);
                    }
                }
            } catch (Exception e) {
                System.err.println("Error processing password reset for: " + email);
                e.printStackTrace();
            }
        }
        
        // Always show the same message for security (prevent email enumeration)
        request.setAttribute("success", 
            "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được email hướng dẫn đặt lại mật khẩu. " +
            "Vui lòng kiểm tra hộp thư của bạn (bao gồm thư mục Spam).");
        
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }
}
