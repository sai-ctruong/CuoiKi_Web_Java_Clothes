package mypackage.shop.filter;

import mypackage.shop.model.User;
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
import java.util.Arrays;
import java.util.List;

/**
 * SecurityFilter - Kiểm tra quyền truy cập
 * - Chặn truy cập trang cần đăng nhập (profile, checkout, address, my-orders)
 * - Chặn user thường vào trang Admin (dashboard, manage*)
 * @author PC
 */
@WebFilter(filterName = "SecurityFilter", urlPatterns = {"/*"})
public class SecurityFilter implements Filter {

    // Các URL yêu cầu đăng nhập
    private static final List<String> PROTECTED_URLS = Arrays.asList(
        "/profile", "/checkout", "/address", "/my-orders"
    );
    
    // Các URL chỉ Admin hoặc Staff mới được truy cập
    private static final List<String> ADMIN_URLS = Arrays.asList(
        "/dashboard", "/manage", "/admin"
    );
    
    // Các URL tĩnh không cần filter
    private static final List<String> STATIC_URLS = Arrays.asList(
        "/assets/", "/css/", "/js/", "/images/", "/fonts/"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = uri.substring(contextPath.length());
        
        // Bỏ qua static resources
        if (isStaticResource(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Lấy user từ session
        HttpSession session = httpRequest.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        // Kiểm tra trang Admin
        if (isAdminUrl(path)) {
            if (user == null) {
                // Chưa đăng nhập -> redirect về login
                session = httpRequest.getSession();
                session.setAttribute("redirectUrl", httpRequest.getRequestURL().toString());
                httpResponse.sendRedirect(contextPath + "/login");
                return;
            }
            
            if (!user.isAdmin() && !user.isStaff()) {
                // Không phải Admin/Staff -> redirect về home với thông báo lỗi
                session.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này!");
                httpResponse.sendRedirect(contextPath + "/home");
                return;
            }
        }
        
        // Kiểm tra trang yêu cầu đăng nhập
        if (isProtectedUrl(path)) {
            if (user == null) {
                // Chưa đăng nhập -> lưu URL và redirect về login
                session = httpRequest.getSession();
                session.setAttribute("redirectUrl", httpRequest.getRequestURL().toString());
                httpResponse.sendRedirect(contextPath + "/login");
                return;
            }
        }
        
        // Cho phép tiếp tục
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup
    }
    
    /**
     * Check if URL is a static resource
     */
    private boolean isStaticResource(String path) {
        for (String staticUrl : STATIC_URLS) {
            if (path.startsWith(staticUrl)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Check if URL requires authentication
     */
    private boolean isProtectedUrl(String path) {
        for (String protectedUrl : PROTECTED_URLS) {
            if (path.startsWith(protectedUrl)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Check if URL is admin-only
     */
    private boolean isAdminUrl(String path) {
        for (String adminUrl : ADMIN_URLS) {
            if (path.startsWith(adminUrl)) {
                return true;
            }
        }
        return false;
    }
}
