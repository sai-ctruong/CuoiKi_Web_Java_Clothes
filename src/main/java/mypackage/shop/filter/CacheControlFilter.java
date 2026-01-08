package mypackage.shop.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Filter thêm Cache Headers cho static resources
 * Giúp browser cache CSS, JS, Images để không cần tải lại
 */
@WebFilter(filterName = "CacheControlFilter", urlPatterns = {"/assets/*"})
public class CacheControlFilter implements Filter {
    
    // Cache time: 1 tuần cho static resources
    private static final long CACHE_DURATION_SECONDS = 7 * 24 * 60 * 60; // 7 days
    
    // Cache time ngắn hơn cho ảnh sản phẩm (có thể cập nhật)
    private static final long IMAGE_CACHE_DURATION = 24 * 60 * 60; // 1 day
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String uri = httpRequest.getRequestURI();
        long cacheDuration = getCacheDuration(uri);
        
        // Set cache headers
        httpResponse.setHeader("Cache-Control", "public, max-age=" + cacheDuration);
        httpResponse.setDateHeader("Expires", System.currentTimeMillis() + (cacheDuration * 1000));
        
        // ETag for cache validation
        String etag = generateETag(uri);
        httpResponse.setHeader("ETag", etag);
        
        // Check If-None-Match header
        String ifNoneMatch = httpRequest.getHeader("If-None-Match");
        if (etag.equals(ifNoneMatch)) {
            httpResponse.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    /**
     * Xác định thời gian cache dựa trên loại file
     */
    private long getCacheDuration(String uri) {
        if (uri.endsWith(".css") || uri.endsWith(".js")) {
            return CACHE_DURATION_SECONDS;
        }
        if (uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg") || 
            uri.endsWith(".gif") || uri.endsWith(".webp") || uri.endsWith(".svg")) {
            return IMAGE_CACHE_DURATION;
        }
        if (uri.endsWith(".woff") || uri.endsWith(".woff2") || uri.endsWith(".ttf")) {
            return CACHE_DURATION_SECONDS; // Fonts cache lâu
        }
        return CACHE_DURATION_SECONDS / 7; // Default: 1 ngày
    }
    
    /**
     * Generate simple ETag based on URI
     */
    private String generateETag(String uri) {
        return "\"" + Integer.toHexString(uri.hashCode()) + "\"";
    }
    
    @Override
    public void destroy() {
    }
}
