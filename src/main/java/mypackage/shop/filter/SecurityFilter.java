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
 * SecurityFilter - Kiểm tra quyền truy cập với phân quyền chi tiết
 * - ADMIN: Toàn quyền truy cập mọi trang admin
 * - STAFF: Chỉ truy cập Dashboard và Quản lý đơn hàng
 * - USER: Chỉ truy cập trang public và trang cá nhân
 * @author PC
 */
@WebFilter(filterName = "SecurityFilter", urlPatterns = {"/*"})
public class SecurityFilter implements Filter {

    // Các URL yêu cầu đăng nhập (user thường)
    private static final List<String> PROTECTED_URLS = Arrays.asList(
        "/profile", "/checkout", "/address", "/my-orders"
    );
    
    // Các URL Admin hoặc Staff được truy cập
    private static final List<String> ADMIN_STAFF_URLS = Arrays.asList(
        "/dashboard", "/manage/orders", "/admin/orders", "/admin/order-detail"
    );
    
    // Các URL CHỈ Admin mới được truy cập (Staff không được)
    private static final List<String> ADMIN_ONLY_URLS = Arrays.asList(
        "/manage/products", "/manage/categories", "/manage/brands", "/manage/users",
        "/admin/products", "/admin/categories", "/admin/brands", "/admin/users",
        "/admin/product-form", "/admin/category-form", "/admin/brand-form"
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
        
        // Kiểm tra trang CHỈ ADMIN (products, categories, brands, users)
        if (isAdminOnlyUrl(path)) {
            if (user == null) {
                // Chưa đăng nhập -> redirect về login
                session = httpRequest.getSession();
                session.setAttribute("redirectUrl", httpRequest.getRequestURL().toString());
                httpResponse.sendRedirect(contextPath + "/login");
                return;
            }
            
            if (!user.isAdmin()) {
                // Không phải Admin -> redirect về dashboard với thông báo lỗi
                session.setAttribute("errorMessage", "Chức năng này chỉ dành cho Admin!");
                httpResponse.sendRedirect(contextPath + "/dashboard");
                return;
            }
        }
        
        // Kiểm tra trang Admin hoặc Staff (dashboard, orders)
        if (isAdminStaffUrl(path)) {
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
        
        // Kiểm tra trang yêu cầu đăng nhập (user thường)
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
     * Check if URL requires authentication (regular user)
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
     * Check if URL is for Admin or Staff (dashboard, orders)
     */
    private boolean isAdminStaffUrl(String path) {
        for (String adminUrl : ADMIN_STAFF_URLS) {
            if (path.startsWith(adminUrl)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Check if URL is ADMIN ONLY (products, categories, brands, users)
     */
    private boolean isAdminOnlyUrl(String path) {
        for (String adminOnlyUrl : ADMIN_ONLY_URLS) {
            if (path.startsWith(adminOnlyUrl)) {
                return true;
            }
        }
        return false;
    }
}

