/*
 * CRUD Danh mục sản phẩm
 */
package mypackage.shop.controller;

import mypackage.shop.dao.CategoryDAO;
import mypackage.shop.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ManageCategoryServlet - CRUD operations for categories
 * @author PC
 */
@WebServlet(name = "ManageCategoryServlet", urlPatterns = {"/manage/categories"})
public class ManageCategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addCategory(request, response);
        } else if ("edit".equals(action)) {
            updateCategory(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage/categories");
        }
    }
    
    /**
     * List all categories
     */
    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }
    
    /**
     * Show add category form
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("formAction", "add");
        request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
    }
    
    /**
     * Show edit category form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDAO.getCategoryById(id);
            
            if (category != null) {
                request.setAttribute("category", category);
                request.setAttribute("formAction", "edit");
                request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy danh mục!");
                response.sendRedirect(request.getContextPath() + "/manage/categories");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID danh mục không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/manage/categories");
        }
    }
    
    /**
     * Add new category
     */
    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            // Validate
            if (name == null || name.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục không được để trống!");
                response.sendRedirect(request.getContextPath() + "/manage/categories?action=add");
                return;
            }
            
            // Check duplicate name
            if (categoryDAO.isCategoryNameExists(name.trim(), 0)) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục đã tồn tại!");
                response.sendRedirect(request.getContextPath() + "/manage/categories?action=add");
                return;
            }
            
            Category category = new Category();
            category.setName(name.trim());
            category.setDescription(description);
            
            int id = categoryDAO.addCategory(category);
            
            if (id > 0) {
                request.getSession().setAttribute("successMessage", "Thêm danh mục thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Thêm danh mục thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/categories");
    }
    
    /**
     * Update existing category
     */
    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            // Validate
            if (name == null || name.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục không được để trống!");
                response.sendRedirect(request.getContextPath() + "/manage/categories?action=edit&id=" + id);
                return;
            }
            
            // Check duplicate name (exclude current category)
            if (categoryDAO.isCategoryNameExists(name.trim(), id)) {
                request.getSession().setAttribute("errorMessage", "Tên danh mục đã tồn tại!");
                response.sendRedirect(request.getContextPath() + "/manage/categories?action=edit&id=" + id);
                return;
            }
            
            Category category = categoryDAO.getCategoryById(id);
            if (category != null) {
                category.setName(name.trim());
                category.setDescription(description);
                
                boolean updated = categoryDAO.updateCategory(category);
                
                if (updated) {
                    request.getSession().setAttribute("successMessage", "Cập nhật danh mục thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật danh mục thất bại!");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy danh mục!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/categories");
    }
    
    /**
     * Delete category
     */
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Check if category has products
            Category category = categoryDAO.getCategoryById(id);
            if (category != null && category.getProductCount() > 0) {
                request.getSession().setAttribute("errorMessage", 
                    "Không thể xóa danh mục đang có " + category.getProductCount() + " sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/manage/categories");
                return;
            }
            
            boolean deleted = categoryDAO.deleteCategory(id);
            
            if (deleted) {
                request.getSession().setAttribute("successMessage", "Xóa danh mục thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Xóa danh mục thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/categories");
    }
}
