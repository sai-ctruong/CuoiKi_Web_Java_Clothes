/*
 * CRUD Sản phẩm
 */
package mypackage.shop.controller;

import mypackage.shop.dao.ProductDAO;
import mypackage.shop.dao.CategoryDAO;
import mypackage.shop.dao.BrandDAO;
import mypackage.shop.model.Product;
import mypackage.shop.utils.UploadUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * ManageProductServlet - CRUD operations for products
 * @author PC
 */
@WebServlet(name = "ManageProductServlet", urlPatterns = {"/manage/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 50     // 50 MB
)
public class ManageProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BrandDAO brandDAO = new BrandDAO();
    
    /**
     * Get both upload directories (source and target)
     * Source: persistent storage, survives rebuilds
     * Target: where server reads from
     */
    private String[] getUploadDirectories() {
        String realPath = getServletContext().getRealPath("/");
        
        // Target directory (where server reads from)
        java.io.File targetUploadDir = new java.io.File(realPath, "uploads/products");
        if (!targetUploadDir.exists()) {
            targetUploadDir.mkdirs();
        }
        
        // Source directory (persistent storage)
        java.io.File targetDir = new java.io.File(realPath);
        java.io.File projectRoot = targetDir.getParentFile().getParentFile();
        java.io.File sourceUploadDir = new java.io.File(projectRoot, "src/main/webapp/uploads/products");
        if (!sourceUploadDir.exists()) {
            sourceUploadDir.mkdirs();
        }
        
        return new String[] { 
            sourceUploadDir.getAbsolutePath(),  // [0] source - persistent
            targetUploadDir.getAbsolutePath()   // [1] target - for server
        };
    }
    
    /**
     * Get upload directory - saves to BOTH source and target
     */
    private String getUploadDirectory() {
        return getUploadDirectories()[0]; // Return source for primary save
    }
    
    /**
     * Copy a saved file from source to target for immediate access
     */
    private void copyToTarget(String fileName) {
        try {
            String[] dirs = getUploadDirectories();
            java.io.File source = new java.io.File(dirs[0], fileName);
            java.io.File target = new java.io.File(dirs[1], fileName);
            
            if (source.exists() && !target.exists()) {
                java.nio.file.Files.copy(source.toPath(), target.toPath());
            }
        } catch (Exception e) {
            System.err.println("Error copying file to target: " + e.getMessage());
        }
    }
    
    /**
     * Sync all images from source to target on init
     */
    @Override
    public void init() throws ServletException {
        super.init();
        syncImagesToTarget();
    }
    
    /**
     * Copy all images from source folder to target folder
     */
    private void syncImagesToTarget() {
        try {
            String[] dirs = getUploadDirectories();
            java.io.File sourceDir = new java.io.File(dirs[0]);
            java.io.File targetDir = new java.io.File(dirs[1]);
            
            if (sourceDir.exists() && sourceDir.isDirectory()) {
                java.io.File[] files = sourceDir.listFiles();
                if (files != null) {
                    for (java.io.File file : files) {
                        if (file.isFile()) {
                            java.io.File targetFile = new java.io.File(targetDir, file.getName());
                            if (!targetFile.exists()) {
                                java.nio.file.Files.copy(file.toPath(), targetFile.toPath());
                                System.out.println("Synced image: " + file.getName());
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error syncing images: " + e.getMessage());
        }
    }

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
                deleteProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("edit".equals(action)) {
            updateProduct(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage/products");
        }
    }
    
    /**
     * List all products
     */
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        List<Product> products;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productDAO.searchProducts(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else {
            products = productDAO.getAllProducts();
        }
        
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
    
    /**
     * Show add product form
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("brands", brandDAO.getAllBrands());
        request.setAttribute("formAction", "add");
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }
    
    /**
     * Show edit product form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(id);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.setAttribute("categories", categoryDAO.getAllCategories());
                request.setAttribute("brands", brandDAO.getAllBrands());
                request.setAttribute("formAction", "edit");
                request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/manage/products");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID sản phẩm không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/manage/products");
        }
    }
    
    /**
     * Add new product
     */
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Product product = new Product();
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(new BigDecimal(request.getParameter("price")));
            product.setSize(request.getParameter("size"));
            product.setColor(request.getParameter("color"));
            
            String categoryId = request.getParameter("categoryId");
            if (categoryId != null && !categoryId.isEmpty()) {
                product.setCategoryId(Integer.parseInt(categoryId));
            }
            
            String brandId = request.getParameter("brandId");
            if (brandId != null && !brandId.isEmpty()) {
                product.setBrandId(Integer.parseInt(brandId));
            }
            
            // Add product
            int productId = productDAO.addProduct(product);
            
            if (productId > 0) {
                // Handle image upload
                Part imagePart = request.getPart("image");
                if (imagePart != null && imagePart.getSize() > 0) {
                    // Lưu vào thư mục source để ảnh không bị mất khi rebuild
                    String uploadDir = getUploadDirectory();
                    String fileName = UploadUtils.saveFile(imagePart, uploadDir);
                    if (fileName != null) {
                        String imageUrl = "/uploads/products/" + fileName;
                        productDAO.addProductImage(productId, imageUrl, true);
                        // Copy to target for immediate display
                        copyToTarget(fileName);
                    }
                }
                
                request.getSession().setAttribute("successMessage", "Thêm sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Thêm sản phẩm thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/products");
    }
    
    /**
     * Update existing product
     */
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(id);
            
            if (product != null) {
                product.setName(request.getParameter("name"));
                product.setDescription(request.getParameter("description"));
                product.setPrice(new BigDecimal(request.getParameter("price")));
                product.setSize(request.getParameter("size"));
                product.setColor(request.getParameter("color"));
                
                String categoryId = request.getParameter("categoryId");
                if (categoryId != null && !categoryId.isEmpty()) {
                    product.setCategoryId(Integer.parseInt(categoryId));
                } else {
                    product.setCategoryId(0);
                }
                
                String brandId = request.getParameter("brandId");
                if (brandId != null && !brandId.isEmpty()) {
                    product.setBrandId(Integer.parseInt(brandId));
                } else {
                    product.setBrandId(0);
                }
                
                boolean updated = productDAO.updateProduct(product);
                
                if (updated) {
                    // Handle new image upload
                    Part imagePart = request.getPart("image");
                    if (imagePart != null && imagePart.getSize() > 0) {
                        // Lưu vào thư mục source để ảnh không bị mất khi rebuild
                        String uploadDir = getUploadDirectory();
                        String fileName = UploadUtils.saveFile(imagePart, uploadDir);
                        if (fileName != null) {
                            // Delete old images and add new one
                            productDAO.deleteProductImages(id);
                            String imageUrl = "/uploads/products/" + fileName;
                            productDAO.addProductImage(id, imageUrl, true);
                            // Copy to target for immediate display
                            copyToTarget(fileName);
                        }
                    }
                    
                    request.getSession().setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy sản phẩm!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/products");
    }
    
    /**
     * Delete product
     */
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Delete product images first
            productDAO.deleteProductImages(id);
            
            boolean deleted = productDAO.deleteProduct(id);
            
            if (deleted) {
                request.getSession().setAttribute("successMessage", "Xóa sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Xóa sản phẩm thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/manage/products");
    }
}
