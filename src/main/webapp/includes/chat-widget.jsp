<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Chat Widget CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/chat.css">

<!-- Chat Toggle Button -->
<button id="chatToggleBtn" class="chat-toggle-btn" aria-label="Mở chat">
    <i class="bi bi-chat-dots-fill"></i>
</button>

<!-- Chat Widget Panel -->
<div id="chatWidget" class="chat-widget">
    <!-- Header -->
    <div class="chat-header">
        <div class="chat-header-avatar">
            <i class="bi bi-robot"></i>
        </div>
        <div class="chat-header-info">
            <h4>Clothing Shop</h4>
            <p><span class="status-dot"></span>Hỗ trợ trực tuyến</p>
        </div>
        <button id="chatCloseBtn" class="chat-header-close" aria-label="Đóng">
            <i class="bi bi-x-lg"></i>
        </button>
    </div>
    
    <!-- Chat Content -->
    <div class="chat-body">
        <!-- Messages Area -->
        <div id="chatMessages" class="chat-messages">
            <!-- Messages will be added here by JavaScript -->
            
            <!-- Typing Indicator -->
            <div id="typingIndicator" class="typing-indicator">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="chat-quick-actions">
            <button class="quick-action-btn">Giao hàng</button>
            <button class="quick-action-btn">Đổi trả</button>
            <button class="quick-action-btn">Thanh toán</button>
            <button class="quick-action-btn">Liên hệ</button>
        </div>
        
        <!-- Input Area -->
        <div class="chat-input-area">
            <input type="text" id="chatInput" class="chat-input" 
                   placeholder="Nhập tin nhắn..." 
                   autocomplete="off">
            <button id="chatSendBtn" class="chat-send-btn" aria-label="Gửi">
                <i class="bi bi-send-fill"></i>
            </button>
        </div>
    </div>
</div>

<!-- Context Path for JavaScript -->
<script>
    window.CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>

<!-- Chat Widget JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/chat.js"></script>
