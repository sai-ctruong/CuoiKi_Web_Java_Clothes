package mypackage.shop.controller;

import mypackage.shop.dao.UserDAO;
import mypackage.shop.dao.CartDAO;
import mypackage.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LoginServlet - Xử lý đăng nhập
 * @author PC
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    /**
     * GET - Hiển thị form đăng nhập
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Nếu đã đăng nhập, redirect về home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    /**
     * POST - Xử lý đăng nhập
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userDAO.login(usernameOrEmail.trim(), password);
        
        if (user != null) {
            // Check if account is active
            if (!user.isStatus()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Initialize cart count for header badge
            CartDAO cartDAO = new CartDAO();
            int cartCount = cartDAO.getCartItemCount(user.getId());
            session.setAttribute("cartCount", cartCount);
            
            // Check if there was a redirect URL (from SecurityFilter)
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                response.sendRedirect(redirectUrl);
            } else {
                // Tất cả user đều redirect về home
                // Admin/Staff có thể vào Dashboard từ menu header
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.setAttribute("username", usernameOrEmail);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
