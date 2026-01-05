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
 * Utility class for file uploads
 * @author PC
 */
public class UploadUtils {
    
    // Allowed image extensions
    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};
    
    /**
     * Save uploaded file to specified directory
     * @param filePart The file part from multipart form
     * @param uploadDir The directory to save to
     * @return The generated filename, or null if failed
     */
    public static String saveFile(Part filePart, String uploadDir) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String originalFileName = getFileName(filePart);
        if (originalFileName == null || originalFileName.isEmpty()) {
            return null;
        }
        
        // Validate extension
        String extension = getFileExtension(originalFileName);
        if (!isAllowedExtension(extension)) {
            throw new IOException("File type not allowed: " + extension);
        }
        
        // Generate unique filename
        String newFileName = generateUniqueFileName(originalFileName);
        
        // Create directory if not exists
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        
        // Save file
        Path filePath = Paths.get(uploadDir, newFileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        
        return newFileName;
    }
    
    /**
     * Delete file from server
     * @param filePath Full path to file
     * @return true if deleted successfully
     */
    public static boolean deleteFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }
        try {
            Path path = Paths.get(filePath);
            return Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Generate unique filename to avoid conflicts
     * @param originalName Original file name
     * @return Unique file name
     */
    public static String generateUniqueFileName(String originalName) {
        String extension = getFileExtension(originalName);
        String uniqueId = UUID.randomUUID().toString().substring(0, 8);
        long timestamp = System.currentTimeMillis();
        return timestamp + "_" + uniqueId + "." + extension;
    }
    
    /**
     * Get file extension
     */
    public static String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    }
    
    /**
     * Extract filename from Part header
     */
    public static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String token : contentDisposition.split(";")) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf("=") + 1).trim()
                            .replace("\"", "");
                    // Handle full path in some browsers
                    int index = fileName.lastIndexOf("\\");
                    if (index >= 0) {
                        fileName = fileName.substring(index + 1);
                    }
                    index = fileName.lastIndexOf("/");
                    if (index >= 0) {
                        fileName = fileName.substring(index + 1);
                    }
                    return fileName;
                }
            }
        }
        return null;
    }
    
    /**
     * Check if extension is allowed
     */
    public static boolean isAllowedExtension(String extension) {
        if (extension == null || extension.isEmpty()) {
            return false;
        }
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (allowed.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }
}
