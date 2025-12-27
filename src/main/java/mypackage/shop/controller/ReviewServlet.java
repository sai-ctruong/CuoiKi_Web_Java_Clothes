package mypackage.shop.controller;

import mypackage.shop.dao.ReviewDAO;
import mypackage.shop.model.Review;
import mypackage.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * ReviewServlet - Handle product review submissions
 * @author PC
 */
@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            session.setAttribute("errorMessage", "Vui lòng đăng nhập để đánh giá sản phẩm!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            
            // Validate rating
            if (rating < 1 || rating > 5) {
                session.setAttribute("errorMessage", "Đánh giá phải từ 1-5 sao!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
                return;
            }
            
            // Check if already reviewed
            if (reviewDAO.hasUserReviewed(user.getId(), productId)) {
                session.setAttribute("errorMessage", "Bạn đã đánh giá sản phẩm này rồi!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
                return;
            }
            
            // Create and save review
            Review review = new Review();
            review.setUserId(user.getId());
            review.setProductId(productId);
            review.setRating(rating);
            review.setComment(comment != null ? comment.trim() : "");
            
            boolean success = reviewDAO.addReview(review);
            
            if (success) {
                session.setAttribute("successMessage", "Cảm ơn bạn đã đánh giá sản phẩm!");
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
            }
            
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
