/*
 * (Tăng giảm số lượng, xóa item)
 * Đã sửa: Cập nhật Database thay vì Session
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
import mypackage.shop.model.User;

/**
 * UpdateCartServlet - Cập nhật giỏ hàng
 * Yêu cầu đăng nhập, thao tác trực tiếp với Database
 * @author PC
 */
@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/cart/update"})
public class UpdateCartServlet extends HttpServlet {

    private CartDAO cartDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
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
        
        // Bắt buộc đăng nhập
        User user = (User) session.getAttribute("user");
        if (user == null) {
            if (isAjax) {
                sendJsonResponse(response, false, "Vui lòng đăng nhập", 0);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }
        
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");  // CartItem ID
        String currentQtyParam = request.getParameter("current");
        String quantityParam = request.getParameter("quantity");

        try {
            if ("clear".equals(action)) {
                // Xóa toàn bộ giỏ hàng
                cartDAO.clearCart(user.getId());
                session.setAttribute("successMessage", "Đã xóa toàn bộ giỏ hàng");
            } else if (idParam != null) {
                int cartItemId = Integer.parseInt(idParam);
                
                switch (action != null ? action : "") {
                    case "remove":
                        // Xóa item khỏi giỏ
                        cartDAO.removeItem(cartItemId);
                        session.setAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng");
                        break;
                        
                    case "increase":
                        // Tăng số lượng
                        int currQty = 1;
                        if (currentQtyParam != null) {
                            currQty = Integer.parseInt(currentQtyParam);
                        }
                        cartDAO.updateQuantity(cartItemId, currQty + 1);
                        break;
                        
                    case "decrease":
                        // Giảm số lượng
                        int qty = 1;
                        if (currentQtyParam != null) {
                            qty = Integer.parseInt(currentQtyParam);
                        }
                        if (qty <= 1) {
                            cartDAO.removeItem(cartItemId);
                            session.setAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng");
                        } else {
                            cartDAO.updateQuantity(cartItemId, qty - 1);
                        }
                        break;
                        
                    default:
                        // Cập nhật số lượng trực tiếp
                        if (quantityParam != null) {
                            int newQty = Integer.parseInt(quantityParam);
                            if (newQty <= 0) {
                                cartDAO.removeItem(cartItemId);
                            } else {
                                cartDAO.updateQuantity(cartItemId, newQty);
                            }
                        }
                        break;
                }
            }
            
            // Lấy tổng số item sau cập nhật
            int totalItems = cartDAO.getCartItemCount(user.getId());
            session.setAttribute("cartCount", totalItems);
            
            if (isAjax) {
                sendJsonResponse(response, true, "Đã cập nhật giỏ hàng", totalItems);
                return;
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật giỏ hàng");
        }

        // Redirect về trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, int totalItems) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print("{\"status\":\"" + (success ? "success" : "error") + "\",\"message\":\"" + message + "\",\"totalItems\":" + totalItems + "}");
            out.flush();
        }
    }
}