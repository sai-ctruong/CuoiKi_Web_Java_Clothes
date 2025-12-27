/*
 * (Xóa sản phẩm khỏi giỏ)
 * Đã sửa: Sử dụng CartDAO thay vì Session Cart
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import mypackage.shop.dao.CartDAO;
import mypackage.shop.model.User;

@WebServlet(name = "RemoveCartServlet", urlPatterns = {"/cart/remove"})
public class RemoveCartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        cartDAO = new CartDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Bắt buộc đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                // Giả sử id truyền vào là id của CartItem (giống UpdateCartServlet)
                // Nếu là ProductId thì cần logic tìm CartItemByProductId, nhưng pattern hiện tại là dùng CartItemId
                int cartItemId = Integer.parseInt(idParam);
                
                boolean success = cartDAO.removeItem(cartItemId);
                
                if (success) {
                    session.setAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng");
                    
                    // Cập nhật lại số lượng trong session
                    int totalItems = cartDAO.getCartItemCount(user.getId());
                    session.setAttribute("cartCount", totalItems);
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa sản phẩm. Vui lòng thử lại.");
                }
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "ID sản phẩm không hợp lệ");
            }
        }
        
        // Redirect back to cart page (or wherever the request came from)
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
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
}