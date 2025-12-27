/*
 * (Chi tiết sản phẩm)
 */
package mypackage.shop.controller;

import mypackage.shop.dao.ProductDAO;
import mypackage.shop.dao.ReviewDAO;
import mypackage.shop.model.Product;
import mypackage.shop.model.Review;
import mypackage.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * ProductDetailServlet - Display product details with reviews
 * @author PC
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product"})
public class ProductDetailServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            System.out.println("ProductDetailServlet: No ID parameter provided");
            request.getSession().setAttribute("errorMessage", "Không tìm thấy ID sản phẩm. URL phải có dạng: /product?id=1");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int productId = Integer.parseInt(idParam);
            System.out.println("ProductDetailServlet: Looking for product ID: " + productId);
            
            Product product = productDAO.getProductById(productId);
            System.out.println("ProductDetailServlet: Product found: " + (product != null ? product.getName() : "null"));
            
            if (product == null) {
                System.out.println("ProductDetailServlet: Product not found for ID: " + productId);
                request.getSession().setAttribute("errorMessage", 
                    "Không tìm thấy sản phẩm với ID: " + productId + ". " +
                    "Có thể sản phẩm không tồn tại hoặc database chưa có dữ liệu. " +
                    "Hãy chạy script sample_products.sql để thêm dữ liệu mẫu.");
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            // Get reviews for this product
            List<Review> reviews = null;
            double avgRating = 0.0;
            int reviewCount = 0;
            
            try {
                reviews = reviewDAO.getReviewsByProductId(productId);
                avgRating = reviewDAO.getAverageRating(productId);
                reviewCount = reviewDAO.countReviews(productId);
                System.out.println("ProductDetailServlet: Reviews loaded: " + (reviews != null ? reviews.size() : 0));
            } catch (Exception e) {
                System.err.println("ProductDetailServlet: Error loading reviews: " + e.getMessage());
                reviews = List.of(); // Empty list as fallback
            }
            
            // Check if current user can review
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            boolean canReview = false;
            boolean hasReviewed = false;
            
            if (user != null) {
                try {
                    hasReviewed = reviewDAO.hasUserReviewed(user.getId(), productId);
                    canReview = !hasReviewed;
                } catch (Exception e) {
                    System.err.println("ProductDetailServlet: Error checking user review status: " + e.getMessage());
                }
            }
            
            request.setAttribute("product", product);
            request.setAttribute("reviews", reviews);
            request.setAttribute("avgRating", avgRating);
            request.setAttribute("reviewCount", reviewCount);
            request.setAttribute("canReview", canReview);
            request.setAttribute("hasReviewed", hasReviewed);
            
            System.out.println("ProductDetailServlet: Forwarding to product-detail.jsp");
            request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID sản phẩm không hợp lệ: " + idParam);
            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            System.err.println("ProductDetailServlet: Unexpected error: " + e.getMessage());
            e.printStackTrace();
            
            // More detailed error message
            String errorMsg = "Có lỗi xảy ra khi tải thông tin sản phẩm. ";
            if (e.getMessage().contains("database") || e.getMessage().contains("connection")) {
                errorMsg += "Lỗi kết nối database. Vui lòng kiểm tra cấu hình database.";
            } else if (e.getMessage().contains("persistence")) {
                errorMsg += "Lỗi JPA/Hibernate. Kiểm tra persistence.xml.";
            } else {
                errorMsg += "Chi tiết: " + e.getMessage();
            }
            
            request.getSession().setAttribute("errorMessage", errorMsg);
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
