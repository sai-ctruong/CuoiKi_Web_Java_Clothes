/*
 * ForgotPasswordServlet - Xử lý quên mật khẩu
 */
package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
import mypackage.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ForgotPasswordServlet - Password recovery
 * @author PC
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

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
        
        // Check if email exists
        if (userDAO.emailExists(email)) {
            // In a real application, we would send a password reset email here
            // For now, just show a success message
            request.setAttribute("success", 
                "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được email hướng dẫn đặt lại mật khẩu. " +
                "Vui lòng kiểm tra hộp thư của bạn.");
        } else {
            // For security, show the same message even if email doesn't exist
            request.setAttribute("success", 
                "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được email hướng dẫn đặt lại mật khẩu. " +
                "Vui lòng kiểm tra hộp thư của bạn.");
        }
        
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }
}
