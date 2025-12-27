/*
 *(Danh sách sản phẩm & Lọc)
 */
package mypackage.shop.controller;

import mypackage.shop.dao.ProductDAO;
import mypackage.shop.dao.CategoryDAO;
import mypackage.shop.dao.BrandDAO;
import mypackage.shop.model.Product;
import mypackage.shop.model.Category;
import mypackage.shop.model.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ProductListServlet - Display all products with filtering
 * @author PC
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/products", "/category"})
public class ProductListServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private BrandDAO brandDAO = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Product> products;
        String categoryId = request.getParameter("id");
        String brandId = request.getParameter("brand");
        String sortBy = request.getParameter("sort");
        
        // Get filter options
        List<Category> categories = categoryDAO.getAllCategories();
        List<Brand> brands = brandDAO.getAllBrands();
        
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        
        // Filter by category
        if (categoryId != null && !categoryId.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                products = productDAO.getProductsByCategory(catId);
                
                // Find category name
                for (Category cat : categories) {
                    if (cat.getId() == catId) {
                        request.setAttribute("currentCategory", cat);
                        break;
                    }
                }
            } catch (NumberFormatException e) {
                products = productDAO.getAllProducts();
            }
        } else if (brandId != null && !brandId.isEmpty()) {
            // Filter by brand
            try {
                int bId = Integer.parseInt(brandId);
                products = productDAO.getProductsByBrand(bId);
            } catch (NumberFormatException e) {
                products = productDAO.getAllProducts();
            }
        } else {
            // Get all products
            products = productDAO.getAllProducts();
        }
        
        request.setAttribute("products", products);
        request.setAttribute("currentSort", sortBy);
        
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}
