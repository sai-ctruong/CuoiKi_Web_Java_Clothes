/*
 * Servlet to get cart data as JSON
 */
package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.Locale;
import mypackage.shop.model.Cart;
import mypackage.shop.model.SessionCartItem;

/**
 *
 * @author Antigravity
 */
@WebServlet(name = "GetCartServlet", urlPatterns = {"/cart/api/get"})
public class GetCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (cart == null || cart.isEmpty()) {
                out.print("{\"items\": [], \"totalPrice\": 0, \"totalItems\": 0}");
                return;
            }
            
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"totalItems\": ").append(cart.getTotalItems()).append(",");
            json.append("\"totalPrice\": ").append(cart.getTotalPrice()).append(",");
            json.append("\"items\": [");
            
            int count = 0;
            int size = cart.getItems().size();
            Locale vn = new Locale("vi", "VN");
            NumberFormat f = NumberFormat.getCurrencyInstance(vn);
            
            for (SessionCartItem item : cart.getItems()) {
                json.append("{");
                json.append("\"productId\": ").append(item.getProduct().getId()).append(",");
                json.append("\"name\": \"").append(escapeJson(item.getProduct().getName())).append("\",");
                json.append("\"price\": ").append(item.getProduct().getPrice()).append(",");
                json.append("\"priceFormatted\": \"").append(f.format(item.getProduct().getPrice())).append("\",");
                json.append("\"quantity\": ").append(item.getQuantity()).append(",");
                
                String thumb = item.getProduct().getThumbnail();
                if (thumb == null || thumb.isEmpty()) {
                    thumb = "https://picsum.photos/400/500?random=" + item.getProduct().getId();
                }
                json.append("\"thumbnail\": \"").append(thumb).append("\",");
                
                json.append("\"color\": \"").append(item.getProduct().getColor() != null ? escapeJson(item.getProduct().getColor()) : "").append("\",");
                json.append("\"size\": \"").append(item.getProduct().getSize() != null ? escapeJson(item.getProduct().getSize()) : "").append("\"");
                json.append("}");
                
                if (count < size - 1) {
                    json.append(",");
                }
                count++;
            }
            
            json.append("]");
            json.append("}");
            out.print(json.toString());
        }
    }
    
    // Simple helper to escape quotes for JSON
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
