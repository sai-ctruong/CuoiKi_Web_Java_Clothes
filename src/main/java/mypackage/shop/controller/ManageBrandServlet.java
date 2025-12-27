/*
 * CRUD Thương hiệu
 */
package mypackage.shop.controller;

import mypackage.shop.dao.BrandDAO;
import mypackage.shop.model.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ManageBrandServlet - CRUD operations for brands
 * @author PC
 */
@WebServlet(name = "ManageBrandServlet", urlPatterns = {"/manage/brands"})
public class ManageBrandServlet extends HttpServlet {

    private final BrandDAO brandDAO = new BrandDAO();

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
                deleteBrand(request, response);
                break;
            default:
                listBrands(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addBrand(request, response);
        } else if ("edit".equals(action)) {
            updateBrand(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage/brands");
        }
    }
    
    /**
     * List all brands
     */
    private void listBrands(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Brand> brands = brandDAO.getAllBrands();
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("/admin/brands.jsp").forward(request, response);
    }
    
    /**
     * Show add brand form
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("formAction", "add");
        request.getRequestDispatcher("/admin/brand-form.jsp").forward(request, response);
    }
    
    /**
     * Show edit brand form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Brand brand = brandDAO.getBrandById(id);
            
            if (brand != null) {
                request.setAttribute("brand", brand);
                request.setAttribute("formAction", "edit");
                request.getRequestDispatcher("/admin/brand-form.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy thương hiệu!");
                response.sendRedirect(request.getContextPath() + "/manage/brands");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID thương hiệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/manage/brands");
        }
    }
    
    /**
     * Add new brand
     */
    private void addBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            String origin = request.getParameter("origin");
            String logoUrl = request.getParameter("logoUrl");
            
            // Validate
            if (name == null || name.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Tên thương hiệu không được để trống!");
                response.sendRedirect(request.getContextPath() + "/manage/brands?action=add");
                return;
            }
            
            Brand brand = new Brand();
            brand.setName(name.trim());
            brand.setOrigin(origin);
            brand.setLogoUrl(logoUrl);
            
            int id = brandDAO.addBrand(brand);
            
            if (id > 0) {
                request.getSession().setAttribute("successMessage", "Thêm thương hiệu thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Thêm thương hiệu thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/brands");
    }
    
    /**
     * Update existing brand
     */
    private void updateBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String origin = request.getParameter("origin");
            String logoUrl = request.getParameter("logoUrl");
            
            // Validate
            if (name == null || name.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Tên thương hiệu không được để trống!");
                response.sendRedirect(request.getContextPath() + "/manage/brands?action=edit&id=" + id);
                return;
            }
            
            Brand brand = brandDAO.getBrandById(id);
            if (brand != null) {
                brand.setName(name.trim());
                brand.setOrigin(origin);
                brand.setLogoUrl(logoUrl);
                
                boolean updated = brandDAO.updateBrand(brand);
                
                if (updated) {
                    request.getSession().setAttribute("successMessage", "Cập nhật thương hiệu thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật thương hiệu thất bại!");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy thương hiệu!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/brands");
    }
    
    /**
     * Delete brand
     */
    private void deleteBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Check if brand has products
            Brand brand = brandDAO.getBrandById(id);
            if (brand != null && brand.getProductCount() > 0) {
                request.getSession().setAttribute("errorMessage", 
                    "Không thể xóa thương hiệu đang có " + brand.getProductCount() + " sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/manage/brands");
                return;
            }
            
            boolean deleted = brandDAO.deleteBrand(id);
            
            if (deleted) {
                request.getSession().setAttribute("successMessage", "Xóa thương hiệu thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Xóa thương hiệu thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/brands");
    }
}
