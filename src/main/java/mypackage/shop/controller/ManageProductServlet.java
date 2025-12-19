/*
 * CRUD Sản phẩm
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import mypackage.shop.dao.CategoryDAO;
import mypackage.shop.dao.BrandDAO;
import mypackage.shop.dao.ProductDAO;
import mypackage.shop.dao.ProductImageDAO;
import mypackage.shop.model.Brand;
import mypackage.shop.model.Category;
import mypackage.shop.model.Product;
import mypackage.shop.model.ProductImage;
import mypackage.shop.model.User;
import mypackage.shop.utils.UploadUtils;

/**
 *
 * @author Phúc
 */
@WebServlet(name = "ManageProductServlet", urlPatterns = {"/admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ManageProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private BrandDAO brandDAO;
    private ProductImageDAO productImageDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        brandDAO = new BrandDAO();
        productImageDAO = new ProductImageDAO();
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
            // List all products
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/admin/products/list.jsp").forward(request, response);
            
        } else if (action.equals("add")) {
            // Show add form
            List<Category> categories = categoryDAO.getAllCategories();
            List<Brand> brands = brandDAO.getAllBrands();
            request.setAttribute("categories", categories);
            request.setAttribute("brands", brands);
            request.getRequestDispatcher("/admin/products/form.jsp").forward(request, response);
            
        } else if (action.equals("edit")) {
            // Show edit form
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    Product product = productDAO.getProductById(id);
                    if (product != null) {
                        // Get product images
                        List<ProductImage> images = productImageDAO.getImagesByProductId(id);
                        product.setImages(images);
                        
                        List<Category> categories = categoryDAO.getAllCategories();
                        List<Brand> brands = brandDAO.getAllBrands();
                        
                        request.setAttribute("product", product);
                        request.setAttribute("categories", categories);
                        request.setAttribute("brands", brands);
                        request.getRequestDispatcher("/admin/products/form.jsp").forward(request, response);
                    } else {
                        session.setAttribute("errorMessage", "Sản phẩm không tồn tại");
                        response.sendRedirect(request.getContextPath() + "/admin/products");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                }
            } else {
                session.setAttribute("errorMessage", "Vui lòng chọn sản phẩm cần sửa");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            }
            
        } else if (action.equals("delete")) {
            // Delete product
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    
                    // Check if product is in use
                    if (productDAO.isProductInUse(id)) {
                        session.setAttribute("errorMessage", "Không thể xóa sản phẩm này vì đang có đơn hàng sử dụng");
                    } else {
                        // Get all images to delete from filesystem
                        List<ProductImage> images = productImageDAO.getImagesByProductId(id);
                        String appPath = getServletContext().getRealPath("");
                        
                        // Delete images from filesystem
                        for (ProductImage image : images) {
                            UploadUtils.deleteImage(image.getImageUrl(), appPath);
                        }
                        
                        // Delete images from database
                        productImageDAO.deleteImagesByProductId(id);
                        
                        // Delete product
                        boolean deleted = productDAO.deleteProduct(id);
                        if (deleted) {
                            session.setAttribute("successMessage", "Xóa sản phẩm thành công");
                        } else {
                            session.setAttribute("errorMessage", "Xóa sản phẩm thất bại");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } else if (action.equals("delete-image")) {
            // Delete a single image
            String imageIdParam = request.getParameter("imageId");
            String productIdParam = request.getParameter("productId");
            
            if (imageIdParam != null && productIdParam != null) {
                try {
                    Integer imageId = Integer.parseInt(imageIdParam);
                    Integer productId = Integer.parseInt(productIdParam);
                    
                    ProductImage image = productImageDAO.getImageById(imageId);
                    if (image != null) {
                        // Delete from filesystem
                        String appPath = getServletContext().getRealPath("");
                        UploadUtils.deleteImage(image.getImageUrl(), appPath);
                        
                        // Delete from database
                        boolean deleted = productImageDAO.deleteImage(imageId);
                        if (deleted) {
                            session.setAttribute("successMessage", "Xóa ảnh thành công");
                        } else {
                            session.setAttribute("errorMessage", "Xóa ảnh thất bại");
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/products?action=edit&id=" + productId);
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã ảnh không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                }
            }
        } else if (action.equals("set-thumbnail")) {
            // Set thumbnail
            String imageIdParam = request.getParameter("imageId");
            String productIdParam = request.getParameter("productId");
            
            if (imageIdParam != null && productIdParam != null) {
                try {
                    Integer imageId = Integer.parseInt(imageIdParam);
                    Integer productId = Integer.parseInt(productIdParam);
                    
                    boolean success = productImageDAO.setThumbnail(imageId, productId);
                    if (success) {
                        session.setAttribute("successMessage", "Đặt ảnh đại diện thành công");
                    } else {
                        session.setAttribute("errorMessage", "Đặt ảnh đại diện thất bại");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/products?action=edit&id=" + productId);
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã ảnh không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                }
            }
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
        
        // Get form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceParam = request.getParameter("price");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String categoryIdParam = request.getParameter("category_id");
        String brandIdParam = request.getParameter("brand_id");
        String thumbnailImageIdParam = request.getParameter("thumbnail_image_id");
        
        // Validation
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Tên sản phẩm không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin/products?action=" + action + 
                    (idParam != null ? "&id=" + idParam : ""));
            return;
        }
        
        BigDecimal price;
        try {
            price = new BigDecimal(priceParam);
            if (price.compareTo(BigDecimal.ZERO) < 0) {
                throw new NumberFormatException("Price cannot be negative");
            }
        } catch (NumberFormatException | NullPointerException e) {
            session.setAttribute("errorMessage", "Giá sản phẩm không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/products?action=" + action + 
                    (idParam != null ? "&id=" + idParam : ""));
            return;
        }
        
        // Create/Update Product
        Product product = new Product();
        product.setName(name.trim());
        product.setDescription(description != null ? description.trim() : null);
        product.setPrice(price);
        product.setSize(size != null && !size.trim().isEmpty() ? size.trim() : null);
        product.setColor(color != null && !color.trim().isEmpty() ? color.trim() : null);
        
        // Set Category
        if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
            try {
                Integer categoryId = Integer.parseInt(categoryIdParam);
                Category category = new Category();
                category.setId(categoryId);
                product.setCategory(category);
            } catch (NumberFormatException e) {
                // Invalid category ID, set to null
            }
        }
        
        // Set Brand
        if (brandIdParam != null && !brandIdParam.trim().isEmpty()) {
            try {
                Integer brandId = Integer.parseInt(brandIdParam);
                Brand brand = new Brand();
                brand.setId(brandId);
                product.setBrand(brand);
            } catch (NumberFormatException e) {
                // Invalid brand ID, set to null
            }
        }
        
        String appPath = getServletContext().getRealPath("");
        Integer productId;
        
        if (action.equals("add")) {
            // Add new product
            productId = productDAO.addProduct(product);
            
            if (productId != null) {
                // Handle image uploads
                List<Part> imageParts = getImageParts(request);
                
                if (!imageParts.isEmpty()) {
                    int thumbnailIndex = -1;
                    if (thumbnailImageIdParam != null && !thumbnailImageIdParam.trim().isEmpty()) {
                        try {
                            thumbnailIndex = Integer.parseInt(thumbnailImageIdParam);
                        } catch (NumberFormatException e) {
                            // Invalid thumbnail index
                        }
                    }
                    
                    // Save images
                    Product savedProduct = new Product();
                    savedProduct.setId(productId);
                    
                    for (int i = 0; i < imageParts.size(); i++) {
                        String imagePath = UploadUtils.saveImage(imageParts.get(i), appPath);
                        if (imagePath != null) {
                            ProductImage productImage = new ProductImage();
                            productImage.setProduct(savedProduct);
                            productImage.setImageUrl(imagePath);
                            productImage.setIsThumbnail(i == thumbnailIndex);
                            
                            productImageDAO.addImage(productImage);
                        }
                    }
                }
                
                session.setAttribute("successMessage", "Thêm sản phẩm thành công");
            } else {
                session.setAttribute("errorMessage", "Thêm sản phẩm thất bại");
            }
            
        } else if (action.equals("edit")) {
            // Update existing product
            if (idParam != null) {
                try {
                    Integer id = Integer.parseInt(idParam);
                    product.setId(id);
                    boolean success = productDAO.updateProduct(product);
                    
                    if (success) {
                        productId = id;
                        
                        // Handle new image uploads
                        List<Part> imageParts = getImageParts(request);
                        if (!imageParts.isEmpty()) {
                            Product savedProduct = new Product();
                            savedProduct.setId(productId);
                            
                            for (Part part : imageParts) {
                                String imagePath = UploadUtils.saveImage(part, appPath);
                                if (imagePath != null) {
                                    ProductImage productImage = new ProductImage();
                                    productImage.setProduct(savedProduct);
                                    productImage.setImageUrl(imagePath);
                                    productImage.setIsThumbnail(false);
                                    
                                    productImageDAO.addImage(productImage);
                                }
                            }
                        }
                        
                        // Handle thumbnail selection from existing images
                        if (thumbnailImageIdParam != null && !thumbnailImageIdParam.trim().isEmpty()) {
                            try {
                                Integer thumbnailImageId = Integer.parseInt(thumbnailImageIdParam);
                                productImageDAO.setThumbnail(thumbnailImageId, productId);
                            } catch (NumberFormatException e) {
                                // Invalid thumbnail ID
                            }
                        }
                        
                        session.setAttribute("successMessage", "Cập nhật sản phẩm thành công");
                    } else {
                        session.setAttribute("errorMessage", "Cập nhật sản phẩm thất bại");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ");
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    /**
     * Get image parts from request
     */
    private List<Part> getImageParts(HttpServletRequest request) throws IOException, ServletException {
        List<Part> imageParts = new ArrayList<>();
        List<Part> parts = new ArrayList<>(request.getParts());
        
        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String contentType = part.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    imageParts.add(part);
                }
            }
        }
        
        return imageParts;
    }
}