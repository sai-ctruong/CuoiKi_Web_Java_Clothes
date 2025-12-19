/*
 (Kiểm tra xem User đã đăng nhập chưa trước khi vào trang cá nhân/thanh toán. 
Kiểm tra xem có phải Admin không trước khi vào trang Dashboard).
 */
package mypackage.shop.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import mypackage.shop.model.User;

/**
 *
 * @author Phúc
 */
@WebFilter(filterName = "SecurityFilter", urlPatterns = {"/admin/*"})
public class SecurityFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Kiểm tra xem user đã đăng nhập chưa
        if (session == null || session.getAttribute("user") == null) {
            // Chưa đăng nhập, redirect về trang chủ
            session = httpRequest.getSession(true);
            session.setAttribute("errorMessage", "Vui lòng đăng nhập để truy cập trang quản trị");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }
        
        // Kiểm tra role của user
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.Role.ADMIN) {
            // Không phải admin, redirect về trang chủ với thông báo lỗi
            session.setAttribute("errorMessage", "Bạn không có quyền truy cập trang quản trị");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }
        
        // User đã đăng nhập và là admin, cho phép tiếp tục
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}