/*
 * HomeServlet - Trang chủ
 */
package mypackage.shop.controller;

import mypackage.shop.dao.ProductDAO;
import mypackage.shop.dao.CategoryDAO;
import mypackage.shop.dao.CartDAO;
import mypackage.shop.model.Product;
import mypackage.shop.model.Category;
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
 * HomeServlet - Xử lý trang chủ
 * @author PC
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get all products for "View All" section
        List<Product> allProducts = productDAO.getAllProducts();
        request.setAttribute("allProducts", allProducts);
        
        // Get featured products (latest 8)
        List<Product> products = allProducts;
        if (products.size() > 8) {
            products = products.subList(0, 8);
        }
        
        // Get categories
        List<Category> categories = categoryDAO.getAllCategories();
        if (categories.size() > 4) {
            categories = categories.subList(0, 4);
        }
        
        // Update cart count if user logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            int cartCount = cartDAO.getCartItemCount(user.getId());
            session.setAttribute("cartCount", cartCount);
        }
        
        request.setAttribute("featuredProducts", products);
        request.setAttribute("categories", categories);
        
        // Forward đến index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
