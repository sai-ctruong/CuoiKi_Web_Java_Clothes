package mypackage.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mypackage.shop.dao.ChatDAO;
import mypackage.shop.model.ChatMessage;
import mypackage.shop.model.ChatSession;
import mypackage.shop.model.User;
import mypackage.shop.utils.ChatbotService;

import java.io.*;
import java.util.List;
import java.util.UUID;

/**
 * Servlet xử lý API chat qua AJAX
 */
@WebServlet(urlPatterns = {"/chat", "/chat/*"})
public class ChatServlet extends HttpServlet {
    
    private ChatDAO chatDAO = new ChatDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            if (pathInfo != null && pathInfo.equals("/history")) {
                // GET /chat/history?sessionId=xxx - Lấy lịch sử tin nhắn
                String sessionId = request.getParameter("sessionId");
                if (sessionId == null || sessionId.isEmpty()) {
                    out.print("{\"success\": false, \"error\": \"Missing sessionId\"}");
                    return;
                }
                
                List<ChatMessage> messages = chatDAO.getMessagesBySession(sessionId);
                StringBuilder json = new StringBuilder();
                json.append("{\"success\": true, \"messages\": [");
                
                for (int i = 0; i < messages.size(); i++) {
                    ChatMessage msg = messages.get(i);
                    if (i > 0) json.append(",");
                    json.append("{");
                    json.append("\"id\": ").append(msg.getId()).append(",");
                    json.append("\"senderType\": \"").append(msg.getSenderType()).append("\",");
                    json.append("\"message\": \"").append(escapeJson(msg.getMessage())).append("\",");
                    json.append("\"createdAt\": \"").append(msg.getCreatedAt()).append("\"");
                    json.append("}");
                }
                
                json.append("]}");
                out.print(json.toString());
                
            } else if (pathInfo != null && pathInfo.equals("/welcome")) {
                // GET /chat/welcome - Lấy tin nhắn chào mừng
                String welcomeMsg = ChatbotService.getWelcomeMessage();
                out.print("{\"success\": true, \"message\": \"" + escapeJson(welcomeMsg) + "\"}");
                
            } else {
                out.print("{\"success\": false, \"error\": \"Invalid endpoint\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"error\": \"" + escapeJson(e.getMessage()) + "\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            if (pathInfo != null && pathInfo.equals("/send")) {
                // POST /chat/send - Gửi tin nhắn
                handleSendMessage(request, response, out);
                
            } else if (pathInfo != null && pathInfo.equals("/session")) {
                // POST /chat/session - Tạo phiên chat mới
                handleCreateSession(request, response, out);
                
            } else {
                out.print("{\"success\": false, \"error\": \"Invalid endpoint\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"error\": \"" + escapeJson(e.getMessage()) + "\"}");
        }
    }
    
    /**
     * Xử lý gửi tin nhắn
     */
    private void handleSendMessage(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws IOException {
        
        String sessionId = request.getParameter("sessionId");
        String message = request.getParameter("message");
        
        if (sessionId == null || sessionId.isEmpty() || message == null || message.isEmpty()) {
            out.print("{\"success\": false, \"error\": \"Missing sessionId or message\"}");
            return;
        }
        
        // Lấy user từ session (nếu đã đăng nhập)
        HttpSession httpSession = request.getSession();
        User user = (User) httpSession.getAttribute("user");
        
        // Lưu tin nhắn của khách hàng
        ChatMessage customerMsg = new ChatMessage(sessionId, ChatMessage.SenderType.CUSTOMER, message);
        if (user != null) {
            customerMsg.setUser(user);
        }
        chatDAO.saveMessage(customerMsg);
        
        // Lấy response từ chatbot
        String botResponse = ChatbotService.getResponse(message);
        
        // Lưu tin nhắn của bot
        ChatMessage botMsg = new ChatMessage(sessionId, ChatMessage.SenderType.BOT, botResponse);
        chatDAO.saveMessage(botMsg);
        
        // Trả về response
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\": true,");
        json.append("\"customerMessage\": {");
        json.append("\"id\": ").append(customerMsg.getId()).append(",");
        json.append("\"senderType\": \"CUSTOMER\",");
        json.append("\"message\": \"").append(escapeJson(message)).append("\"");
        json.append("},");
        json.append("\"botResponse\": {");
        json.append("\"id\": ").append(botMsg.getId()).append(",");
        json.append("\"senderType\": \"BOT\",");
        json.append("\"message\": \"").append(escapeJson(botResponse)).append("\"");
        json.append("}");
        json.append("}");
        
        out.print(json.toString());
    }
    
    /**
     * Xử lý tạo phiên chat mới
     */
    private void handleCreateSession(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws IOException {
        
        HttpSession httpSession = request.getSession();
        User user = (User) httpSession.getAttribute("user");
        
        // Tạo phiên mới
        ChatSession chatSession = new ChatSession();
        chatSession.setId(UUID.randomUUID().toString());
        
        if (user != null) {
            chatSession.setUser(user);
        } else {
            // Guest
            String guestName = request.getParameter("guestName");
            String guestEmail = request.getParameter("guestEmail");
            chatSession.setGuestName(guestName);
            chatSession.setGuestEmail(guestEmail);
        }
        
        ChatSession created = chatDAO.createSession(chatSession);
        
        if (created != null) {
            // Lưu sessionId vào cookie để giữ qua các lần truy cập
            Cookie cookie = new Cookie("chatSessionId", created.getId());
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            cookie.setPath("/");
            response.addCookie(cookie);
            
            out.print("{\"success\": true, \"sessionId\": \"" + created.getId() + "\"}");
        } else {
            out.print("{\"success\": false, \"error\": \"Failed to create session\"}");
        }
    }
    
    /**
     * Escape special characters cho JSON
     */
    private String escapeJson(String text) {
        if (text == null) return "";
        return text
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r")
            .replace("\t", "\\t");
    }
}
