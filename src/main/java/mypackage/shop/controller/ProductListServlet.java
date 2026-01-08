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
import java.math.BigDecimal;
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
        
        // Price filter parameters
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        Double minPrice = null;
        Double maxPrice = null;
        
        // Parse price parameters
        try {
            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            // Invalid price format, ignore
        }
        
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
        
        // Apply price filter
        if (minPrice != null || maxPrice != null) {
            products = filterByPrice(products, minPrice, maxPrice);
        }
        
        // Apply sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            products = sortProducts(products, sortBy);
        }
        
        // Set filter attributes for JSP
        request.setAttribute("products", products);
        request.setAttribute("currentSort", sortBy);
        request.setAttribute("currentMinPrice", minPrice);
        request.setAttribute("currentMaxPrice", maxPrice);
        
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
    
    /**
     * Filter products by price range
     */
    private List<Product> filterByPrice(List<Product> products, Double minPrice, Double maxPrice) {
        return products.stream()
                .filter(product -> {
                    BigDecimal price = product.getPrice();
                    boolean matchMin = minPrice == null || price.doubleValue() >= minPrice;
                    boolean matchMax = maxPrice == null || price.doubleValue() <= maxPrice;
                    return matchMin && matchMax;
                })
                .collect(java.util.stream.Collectors.toList());
    }
    
    /**
     * Sort products by specified criteria
     */
    private List<Product> sortProducts(List<Product> products, String sortBy) {
        switch (sortBy) {
            case "price-asc":
                products.sort((a, b) -> a.getPrice().compareTo(b.getPrice()));
                break;
            case "price-desc":
                products.sort((a, b) -> b.getPrice().compareTo(a.getPrice()));
                break;
            case "name":
                products.sort((a, b) -> a.getName().compareToIgnoreCase(b.getName()));
                break;
            case "name-desc":
                products.sort((a, b) -> b.getName().compareToIgnoreCase(a.getName()));
                break;
            case "newest":
                products.sort((a, b) -> {
                    if (a.getCreatedAt() == null && b.getCreatedAt() == null) return 0;
                    if (a.getCreatedAt() == null) return 1;
                    if (b.getCreatedAt() == null) return -1;
                    return b.getCreatedAt().compareTo(a.getCreatedAt());
                });
                break;
            default:
                // No sorting or unknown sort type
                break;
        }
        return products;
    }
}
