
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
import mypackage.shop.dao.ProductDAO;
import mypackage.shop.model.Cart;
import mypackage.shop.model.Product;
import mypackage.shop.model.SessionCartItem;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/cart/add"})
public class AddToCartServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
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
        
        String productIdParam = request.getParameter("id");
        String quantityParam = request.getParameter("quantity");
        
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Mã sản phẩm không được để trống");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        try {
            Integer productId = Integer.parseInt(productIdParam);
            int quantity = 1;
            
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
                // Product not found - redirect to home with error message
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Sản phẩm không tồn tại hoặc đã bị xóa");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            SessionCartItem cartItem = new SessionCartItem(product, quantity);
            cart.addItem(cartItem);

            session.setAttribute("successMessage", "Đã thêm sản phẩm '" + product.getName() + "' vào giỏ hàng thành công!");

            String ajaxParam = request.getParameter("ajax");
            if ("true".equals(ajaxParam)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"status\":\"success\", \"message\":\"Đã thêm sản phẩm vào giỏ hàng thành công!\", \"totalItems\":" + cart.getTotalItems() + "}");
                    out.flush();
                }
                return;
            }

            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {              
                response.sendRedirect(request.getContextPath() + "/");
            }

        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            e.printStackTrace();
            String ajaxParam = request.getParameter("ajax");
            if ("true".equals(ajaxParam)) {
               response.setContentType("application/json");
               response.setCharacterEncoding("UTF-8");
               try (PrintWriter out = response.getWriter()) {
                   out.print("{\"status\":\"error\", \"message\":\"Có lỗi xảy ra: " + e.getMessage() + "\"}");
                   out.flush();
               }
               return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng: " + e.getMessage());

            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        }
    }
}
