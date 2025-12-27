/*
 * (Xử lý thêm vào giỏ)
 * Đã sửa: Bắt buộc đăng nhập + Lưu vào Database
 */

//Author: Hoai

package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import mypackage.shop.dao.CartDAO;
import mypackage.shop.dao.ProductDAO;
import mypackage.shop.model.Product;
import mypackage.shop.model.User;

/**
 * AddToCartServlet - Thêm sản phẩm vào giỏ hàng
 * Yêu cầu đăng nhập, lưu trực tiếp vào Database
 * @author PC
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/cart/add"})
public class AddToCartServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String ajaxParam = request.getParameter("ajax");
        boolean isAjax = "true".equals(ajaxParam);
        
        // ===== BẮT BUỘC ĐĂNG NHẬP =====
        User user = (User) session.getAttribute("user");
        if (user == null) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập để thêm giỏ hàng!\",\"requireLogin\":true}");
                    out.flush();
                }
                return;
            }
            // Lưu URL để redirect sau khi login
            String referer = request.getHeader("Referer");
            session.setAttribute("redirectUrl", referer != null ? referer : request.getContextPath() + "/");
            session.setAttribute("errorMessage", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get parameters from request
        String productIdParam = request.getParameter("id");
        if (productIdParam == null || productIdParam.isEmpty()) {
            productIdParam = request.getParameter("productId");
        }
        String quantityParam = request.getParameter("quantity");
        String sizeParam = request.getParameter("size");
        
        // Validate product ID
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            sendError(response, session, isAjax, "Mã sản phẩm không được để trống", request);
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            int quantity = 1; // Default quantity is 1
            
            // Parse quantity if provided
            if (quantityParam != null && !quantityParam.trim().isEmpty()) {
                try {
                    quantity = Integer.parseInt(quantityParam);
                    if (quantity <= 0) {
                        quantity = 1;
                    }
                } catch (NumberFormatException e) {
                    quantity = 1;
                }
            }

            // Get product from database
            Product product = productDAO.getProductById(productId);
            
            if (product == null) {
                sendError(response, session, isAjax, "Sản phẩm không tồn tại hoặc đã bị xóa", request);
                return;
            }

            // ===== LƯU VÀO DATABASE (với size) =====
            String size = (sizeParam != null && !sizeParam.trim().isEmpty()) ? sizeParam.trim() : "M";
            boolean success = cartDAO.addToCart(user.getId(), productId, quantity, size);
            
            if (!success) {
                sendError(response, session, isAjax, "Không thể thêm sản phẩm vào giỏ hàng", request);
                return;
            }

            // Lấy tổng số item trong giỏ
            int totalItems = cartDAO.getCartItemCount(user.getId());
            
            // Update session cart count
            session.setAttribute("cartCount", totalItems);

            // Respond
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"status\":\"success\",\"message\":\"Đã thêm '" + escapeJson(product.getName()) + "' vào giỏ hàng!\",\"totalItems\":" + totalItems + "}");
                    out.flush();
                }
                return;
            }

            // Set success message
            session.setAttribute("successMessage", "Đã thêm sản phẩm '" + product.getName() + "' vào giỏ hàng thành công!");

            // Redirect back
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/");

        } catch (NumberFormatException e) {
            sendError(response, session, isAjax, "Mã sản phẩm không hợp lệ", request);
        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, session, isAjax, "Có lỗi xảy ra: " + e.getMessage(), request);
        }
    }
    
    private void sendError(HttpServletResponse response, HttpSession session, boolean isAjax, String message, HttpServletRequest request) 
            throws IOException {
        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"status\":\"error\",\"message\":\"" + escapeJson(message) + "\"}");
                out.flush();
            }
        } else {
            session.setAttribute("errorMessage", message);
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : request.getContextPath() + "/");
        }
    }
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r");
    }
}