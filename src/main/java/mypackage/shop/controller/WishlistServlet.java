/*
 * WishlistServlet - handles wishlist operations
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import mypackage.shop.dao.WishlistDAO;
import mypackage.shop.model.User;
import mypackage.shop.model.Wishlist;

/**
 * WishlistServlet - View and toggle wishlist items
 * @author PC
 */
@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist", "/wishlist/toggle"})
public class WishlistServlet extends HttpServlet {

    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/wishlist/toggle".equals(servletPath)) {
            handleToggle(request, response);
        } else {
            handleViewWishlist(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleToggle(request, response);
    }

    /**
     * View wishlist page
     */
    private void handleViewWishlist(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("errorMessage", "Vui lòng đăng nhập để xem danh sách yêu thích");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Wishlist> wishlistItems = wishlistDAO.getByUserId(user.getId());
        request.setAttribute("wishlistItems", wishlistItems);
        request.setAttribute("wishlistCount", wishlistItems.size());
        
        request.getRequestDispatcher("/wishlist.jsp").forward(request, response);
    }

    /**
     * Toggle wishlist item (add/remove)
     */
    private void handleToggle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String ajaxParam = request.getParameter("ajax");
        boolean isAjax = "true".equals(ajaxParam);
        
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            if (isAjax) {
                sendJsonResponse(response, false, "Vui lòng đăng nhập", false);
            } else {
                session.setAttribute("errorMessage", "Vui lòng đăng nhập để sử dụng tính năng này");
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }
        
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.isEmpty()) {
            productIdParam = request.getParameter("id");
        }
        
        if (productIdParam == null || productIdParam.isEmpty()) {
            if (isAjax) {
                sendJsonResponse(response, false, "Thiếu ID sản phẩm", false);
            } else {
                session.setAttribute("errorMessage", "Thiếu ID sản phẩm");
                response.sendRedirect(request.getContextPath() + "/products");
            }
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdParam);
            boolean added = wishlistDAO.toggle(user.getId(), productId);
            
            if (isAjax) {
                String message = added ? "Đã thêm vào yêu thích" : "Đã xóa khỏi yêu thích";
                sendJsonResponse(response, true, message, added);
            } else {
                String message = added ? "Đã thêm sản phẩm vào danh sách yêu thích" : "Đã xóa sản phẩm khỏi danh sách yêu thích";
                session.setAttribute("successMessage", message);
                
                String referer = request.getHeader("Referer");
                response.sendRedirect(referer != null ? referer : request.getContextPath() + "/products");
            }
            
        } catch (NumberFormatException e) {
            if (isAjax) {
                sendJsonResponse(response, false, "ID sản phẩm không hợp lệ", false);
            } else {
                session.setAttribute("errorMessage", "ID sản phẩm không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/products");
            }
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, boolean added) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print("{\"status\":\"" + (success ? "success" : "error") + 
                     "\",\"message\":\"" + message + 
                     "\",\"added\":" + added + "}");
            out.flush();
        }
    }
}
