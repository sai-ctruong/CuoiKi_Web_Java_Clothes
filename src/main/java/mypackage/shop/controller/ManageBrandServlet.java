/*
 * CRUD Brand management
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
import mypackage.shop.dao.BrandDAO;
import mypackage.shop.model.Brand;
import mypackage.shop.model.User;

/**
 *
 * @author Phúc
 */
@WebServlet(name = "ManageBrandServlet", urlPatterns = {"/admin/brands"})
public class ManageBrandServlet extends HttpServlet {
    
    private BrandDAO brandDAO;
    
    @Override
    public void init() throws ServletException {
        brandDAO = new BrandDAO();
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
            // List all brands
            List<Brand> brands = brandDAO.getAllBrands();
            request.setAttribute("brands", brands);
            request.getRequestDispatcher("/admin/brands/list.jsp").forward(request, response);
            
        } else if (action.equals("add")) {
            // Show add form
            request.getRequestDispatcher("/admin/brands/form.jsp").forward(request, response);
            
        } else if (action.equals("edit")) {
            // Show edit form
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    Brand brand = brandDAO.getBrandById(id);
                    if (brand != null) {
                        request.setAttribute("brand", brand);
                        request.getRequestDispatcher("/admin/brands/form.jsp").forward(request, response);
                    } else {
                        session.setAttribute("errorMessage", "Thương hiệu không tồn tại");
                        response.sendRedirect(request.getContextPath() + "/admin/brands");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã thương hiệu không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/admin/brands");
                }
            } else {
                session.setAttribute("errorMessage", "Vui lòng chọn thương hiệu cần sửa");
                response.sendRedirect(request.getContextPath() + "/admin/brands");
            }
            
        } else if (action.equals("delete")) {
            // Delete brand
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    
                    // Check if brand is in use
                    if (brandDAO.isBrandInUse(id)) {
                        session.setAttribute("errorMessage", "Không thể xóa thương hiệu này vì đang có sản phẩm sử dụng");
                    } else {
                        boolean deleted = brandDAO.deleteBrand(id);
                        if (deleted) {
                            session.setAttribute("successMessage", "Xóa thương hiệu thành công");
                        } else {
                            session.setAttribute("errorMessage", "Xóa thương hiệu thất bại");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã thương hiệu không hợp lệ");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/brands");
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
        String logoUrl = request.getParameter("logo_url");
        String origin = request.getParameter("origin");
        
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Tên thương hiệu không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/brands?action=" + action + 
                    (idParam != null ? "&id=" + idParam : ""));
            return;
        }
        
        Brand brand = new Brand();
        brand.setName(name.trim());
        brand.setLogoUrl(logoUrl != null && !logoUrl.trim().isEmpty() ? logoUrl.trim() : null);
        brand.setOrigin(origin != null && !origin.trim().isEmpty() ? origin.trim() : null);
        
        boolean success = false;
        
        if (action.equals("add")) {
            success = brandDAO.addBrand(brand);
            if (success) {
                session.setAttribute("successMessage", "Thêm thương hiệu thành công");
            } else {
                session.setAttribute("errorMessage", "Thêm thương hiệu thất bại");
            }
        } else if (action.equals("edit")) {
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    brand.setId(id);
                    success = brandDAO.updateBrand(brand);
                    if (success) {
                        session.setAttribute("successMessage", "Cập nhật thương hiệu thành công");
                    } else {
                        session.setAttribute("errorMessage", "Cập nhật thương hiệu thất bại");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã thương hiệu không hợp lệ");
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/brands");
    }
}
