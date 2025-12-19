package mypackage.shop.controller;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import mypackage.shop.model.*;
import mypackage.shop.utils.JPAUtil;

/**
 * Servlet test để kiểm tra JPA hoạt động
 * Truy cập: http://localhost:8080/ProjectCuoiKi_Clothes-1.0-SNAPSHOT/test-jpa
 */
@WebServlet(name = "TestJPAServlet", urlPatterns = {"/test-jpa"})
public class TestJPAServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>JPA Test</title>");
        out.println("<style>body{font-family:Arial;padding:20px;} .success{color:green;} .error{color:red;} table{border-collapse:collapse;margin:10px 0;} td,th{border:1px solid #ddd;padding:8px;}</style>");
        out.println("</head><body>");
        out.println("<h1>🔍 Kiểm tra JPA/Hibernate</h1>");
        
        EntityManager em = null;
        try {
            // Test 1: Kết nối EntityManager
            out.println("<h2>1. Kết nối EntityManager</h2>");
            em = JPAUtil.getEntityManager();
            out.println("<p class='success'>✅ EntityManager tạo thành công!</p>");
            
            // Test 2: Query Users
            out.println("<h2>2. Query bảng Users</h2>");
            List<User> users = em.createQuery("SELECT u FROM User u", User.class).getResultList();
            out.println("<p class='success'>✅ Tìm thấy " + users.size() + " users</p>");
            out.println("<table><tr><th>ID</th><th>Username</th><th>Email</th><th>Role</th></tr>");
            for (User u : users) {
                out.println("<tr><td>" + u.getId() + "</td><td>" + u.getUsername() + "</td><td>" + u.getEmail() + "</td><td>" + u.getRole() + "</td></tr>");
            }
            out.println("</table>");
            
            // Test 3: Query Categories
            out.println("<h2>3. Query bảng Category</h2>");
            List<Category> categories = em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
            out.println("<p class='success'>✅ Tìm thấy " + categories.size() + " categories</p>");
            out.println("<table><tr><th>ID</th><th>Name</th><th>Description</th></tr>");
            for (Category c : categories) {
                out.println("<tr><td>" + c.getId() + "</td><td>" + c.getName() + "</td><td>" + c.getDescription() + "</td></tr>");
            }
            out.println("</table>");
            
            // Test 4: Query Products
            out.println("<h2>4. Query bảng Product</h2>");
            List<Product> products = em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
            out.println("<p class='success'>✅ Tìm thấy " + products.size() + " products</p>");
            out.println("<table><tr><th>ID</th><th>Name</th><th>Price</th><th>Size</th><th>Color</th></tr>");
            for (Product p : products) {
                out.println("<tr><td>" + p.getId() + "</td><td>" + p.getName() + "</td><td>" + p.getPrice() + "</td><td>" + p.getSize() + "</td><td>" + p.getColor() + "</td></tr>");
            }
            out.println("</table>");
            
            // Test 5: Query Brands
            out.println("<h2>5. Query bảng Brand</h2>");
            List<Brand> brands = em.createQuery("SELECT b FROM Brand b", Brand.class).getResultList();
            out.println("<p class='success'>✅ Tìm thấy " + brands.size() + " brands</p>");
            out.println("<table><tr><th>ID</th><th>Name</th><th>Origin</th></tr>");
            for (Brand b : brands) {
                out.println("<tr><td>" + b.getId() + "</td><td>" + b.getName() + "</td><td>" + b.getOrigin() + "</td></tr>");
            }
            out.println("</table>");
            
            out.println("<hr><h2 class='success'>🎉 TẤT CẢ TEST ĐỀU THÀNH CÔNG!</h2>");
            out.println("<p>JPA/Hibernate đã kết nối và mapping đúng với database.</p>");
            
        } catch (Exception e) {
            out.println("<h2 class='error'>❌ LỖI</h2>");
            out.println("<p class='error'>" + e.getClass().getName() + ": " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        
        out.println("</body></html>");
    }
}
