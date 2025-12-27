package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Error handler servlet for 404 and other errors
 */
@WebServlet(name = "ErrorHandlerServlet", urlPatterns = {"/error"})
public class ErrorHandlerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get error information
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        String requestUri = (String) request.getAttribute("jakarta.servlet.error.request_uri");
        Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");
        
        // Remove context path from URI for display
        if (requestUri != null && requestUri.startsWith(request.getContextPath())) {
            requestUri = requestUri.substring(request.getContextPath().length());
        }
        
        // Set error message based on status code
        String errorMessage = "Đã xảy ra lỗi không xác định";
        String errorTitle = "Lỗi";
        
        if (statusCode != null) {
            switch (statusCode) {
                case 404:
                    errorTitle = "Trang không tìm thấy";
                    errorMessage = "Trang bạn đang tìm kiếm không tồn tại hoặc đã được di chuyển.";
                    break;
                case 500:
                    errorTitle = "Lỗi máy chủ";
                    errorMessage = "Đã xảy ra lỗi máy chủ nội bộ. Vui lòng thử lại sau.";
                    break;
                case 403:
                    errorTitle = "Truy cập bị từ chối";
                    errorMessage = "Bạn không có quyền truy cập vào trang này.";
                    break;
                default:
                    errorTitle = "Lỗi " + statusCode;
                    errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại sau.";
            }
        }
        
        // Set attributes for JSP
        request.setAttribute("errorTitle", errorTitle);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("statusCode", statusCode);
        request.setAttribute("requestUri", requestUri);
        
        // Forward to error page
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}