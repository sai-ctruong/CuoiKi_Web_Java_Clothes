/*
 * (Xử lý lưu file ảnh khi Admin up sản phẩm mới).
 */
package mypackage.shop.utils;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

/**
 *
 * @author Phúc
 */
public class UploadUtils {
    
    private static final String UPLOAD_DIR = "uploads";
    private static final String PRODUCT_IMAGES_DIR = "products";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp"};
    
    /**
     * Lấy đường dẫn thư mục upload gốc
     */
    public static String getUploadPath() {
        return UPLOAD_DIR;
    }
    
    /**
     * Lấy đường dẫn thư mục upload ảnh sản phẩm
     */
    public static String getProductImagesPath() {
        return UPLOAD_DIR + File.separator + PRODUCT_IMAGES_DIR;
    }
    
    /**
     * Lưu file ảnh từ Part
     * @param filePart Part từ request
     * @param appPath Đường dẫn ứng dụng (context path)
     * @return Đường dẫn tương đối của file đã lưu, hoặc null nếu lỗi
     */
    public static String saveImage(Part filePart, String appPath) {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String fileName = getFileName(filePart);
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }
        
        // Validate file extension
        if (!isValidImageFile(fileName)) {
            return null;
        }
        
        // Validate file size
        if (filePart.getSize() > MAX_FILE_SIZE) {
            return null;
        }
        
        try {
            // Generate unique filename
            String uniqueFileName = generateFileName(fileName);
            
            // Create upload directory if it doesn't exist
            String uploadDirPath = appPath + File.separator + getProductImagesPath();
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Save file
            Path filePath = Paths.get(uploadDirPath, uniqueFileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            }
            
            // Return relative path for database storage
            return getProductImagesPath() + File.separator + uniqueFileName;
            
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Lưu nhiều file ảnh
     * @param fileParts Mảng các Part từ request
     * @param appPath Đường dẫn ứng dụng
     * @return Mảng đường dẫn tương đối của các file đã lưu
     */
    public static String[] saveImages(Part[] fileParts, String appPath) {
        if (fileParts == null || fileParts.length == 0) {
            return new String[0];
        }
        
        java.util.List<String> savedPaths = new java.util.ArrayList<>();
        for (Part part : fileParts) {
            String path = saveImage(part, appPath);
            if (path != null) {
                savedPaths.add(path);
            }
        }
        
        return savedPaths.toArray(new String[0]);
    }
    
    /**
     * Xóa file ảnh
     * @param imagePath Đường dẫn tương đối hoặc tuyệt đối của file
     * @param appPath Đường dẫn ứng dụng
     * @return true nếu xóa thành công
     */
    public static boolean deleteImage(String imagePath, String appPath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return false;
        }
        
        try {
            File imageFile;
            if (imagePath.startsWith(appPath)) {
                // Absolute path
                imageFile = new File(imagePath);
            } else {
                // Relative path
                imageFile = new File(appPath, imagePath);
            }
            
            if (imageFile.exists() && imageFile.isFile()) {
                return imageFile.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Tạo tên file unique
     * @param originalFileName Tên file gốc
     * @return Tên file mới với UUID prefix
     */
    public static String generateFileName(String originalFileName) {
        String extension = getFileExtension(originalFileName);
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return uuid + extension;
    }
    
    /**
     * Lấy tên file từ Part
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) {
            return null;
        }
        
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                // Extract only filename, not full path
                return fileName.substring(fileName.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }
    
    /**
     * Lấy phần mở rộng của file
     */
    private static String getFileExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "";
        }
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0 && lastDot < fileName.length() - 1) {
            return fileName.substring(lastDot).toLowerCase();
        }
        return "";
    }
    
    /**
     * Kiểm tra xem file có phải là ảnh hợp lệ không
     */
    private static boolean isValidImageFile(String fileName) {
        String extension = getFileExtension(fileName);
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (extension.equals(allowed)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Lấy đường dẫn đầy đủ để hiển thị ảnh trong JSP
     * @param relativePath Đường dẫn tương đối từ database
     * @param contextPath Context path của ứng dụng
     * @return Đường dẫn URL để sử dụng trong img tag
     */
    public static String getImageUrl(String relativePath, String contextPath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return contextPath + "/assets/images/placeholder.jpg"; // Placeholder image
        }
        
        // Replace backslashes with forward slashes for URL
        String urlPath = relativePath.replace("\\", "/");
        return contextPath + "/" + urlPath;
    }
}