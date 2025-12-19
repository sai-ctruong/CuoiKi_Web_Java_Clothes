/*
 * CRUD Category management
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import mypackage.shop.dao.CategoryDAO;
import mypackage.shop.model.Category;
import mypackage.shop.model.User;

/**
 *
 * @author Phúc
 */
@WebServlet(name = "ManageCategoryServlet", urlPatterns = {"/admin/categories"})
public class ManageCategoryServlet extends HttpServlet {
    
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != User.Role.ADMIN) {
            session.setAttribute("errorMessage", "Bạn không có quyền truy cập trang quản trị");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            // List all categories
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/categories/list.jsp").forward(request, response);
            
        } else if (action.equals("add")) {
            // Show add form
            request.getRequestDispatcher("/admin/categories/form.jsp").forward(request, response);
            
        } else if (action.equals("edit")) {
            // Show edit form
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    Category category = categoryDAO.getCategoryById(id);
                    if (category != null) {
                        request.setAttribute("category", category);
                        request.getRequestDispatcher("/admin/categories/form.jsp").forward(request, response);
                    } else {
                        session.setAttribute("errorMessage", "Danh mục không tồn tại");
                        response.sendRedirect(request.getContextPath() + "/admin/categories");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã danh mục không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/admin/categories");
                }
            } else {
                session.setAttribute("errorMessage", "Vui lòng chọn danh mục cần sửa");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
            }
            
        } else if (action.equals("delete")) {
            // Delete category
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    
                    // Check if category is in use
                    if (categoryDAO.isCategoryInUse(id)) {
                        session.setAttribute("errorMessage", "Không thể xóa danh mục này vì đang có sản phẩm sử dụng");
                    } else {
                        boolean deleted = categoryDAO.deleteCategory(id);
                        if (deleted) {
                            session.setAttribute("successMessage", "Xóa danh mục thành công");
                        } else {
                            session.setAttribute("errorMessage", "Xóa danh mục thất bại");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã danh mục không hợp lệ");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != User.Role.ADMIN) {
            session.setAttribute("errorMessage", "Bạn không có quyền truy cập trang quản trị");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        
        if (action == null) {
            action = idParam != null ? "edit" : "add";
        }
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Tên danh mục không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/categories?action=" + action + 
                    (idParam != null ? "&id=" + idParam : ""));
            return;
        }
        
        Category category = new Category();
        category.setName(name.trim());
        category.setDescription(description != null ? description.trim() : null);
        
        boolean success = false;
        
        if (action.equals("add")) {
            success = categoryDAO.addCategory(category);
            if (success) {
                session.setAttribute("successMessage", "Thêm danh mục thành công");
            } else {
                session.setAttribute("errorMessage", "Thêm danh mục thất bại");
            }
        } else if (action.equals("edit")) {
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    category.setId(id);
                    success = categoryDAO.updateCategory(category);
                    if (success) {
                        session.setAttribute("successMessage", "Cập nhật danh mục thành công");
                    } else {
                        session.setAttribute("errorMessage", "Cập nhật danh mục thất bại");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã danh mục không hợp lệ");
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
