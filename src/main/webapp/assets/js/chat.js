/**
 * Chat Widget JavaScript
 * Xử lý logic chat với chatbot
 */

(function() {
    'use strict';
    
    // Constants
    const CONTEXT_PATH = window.CONTEXT_PATH || '';
    const STORAGE_KEY = 'chatSessionId';
    
    // State
    let sessionId = localStorage.getItem(STORAGE_KEY) || null;
    let isOpen = false;
    let currentTab = 'bot';
    
    // DOM Elements
    let widget, toggleBtn, messagesContainer, inputField, sendBtn, typingIndicator;
    
    /**
     * Initialize chat widget
     */
    function init() {
        // Get DOM elements
        widget = document.getElementById('chatWidget');
        toggleBtn = document.getElementById('chatToggleBtn');
        messagesContainer = document.getElementById('chatMessages');
        inputField = document.getElementById('chatInput');
        sendBtn = document.getElementById('chatSendBtn');
        typingIndicator = document.getElementById('typingIndicator');
        
        if (!widget || !toggleBtn) {
            console.warn('Chat widget elements not found');
            return;
        }
        
        // Event listeners
        toggleBtn.addEventListener('click', toggleChat);
        sendBtn.addEventListener('click', sendMessage);
        inputField.addEventListener('keypress', handleKeyPress);
        
        // Tab switching
        document.querySelectorAll('.chat-tab').forEach(tab => {
            tab.addEventListener('click', () => switchTab(tab.dataset.tab));
        });
        
        // Quick actions
        document.querySelectorAll('.quick-action-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                inputField.value = btn.textContent;
                sendMessage();
            });
        });
        
        // Close button
        document.getElementById('chatCloseBtn')?.addEventListener('click', toggleChat);
        
        // Check for existing session from cookie
        const cookieSession = getCookie('chatSessionId');
        if (cookieSession) {
            sessionId = cookieSession;
            localStorage.setItem(STORAGE_KEY, sessionId);
        }
        
        console.log('Chat widget initialized');
    }
    
    /**
     * Toggle chat widget open/close
     */
    function toggleChat() {
        isOpen = !isOpen;
        widget.classList.toggle('open', isOpen);
        toggleBtn.classList.toggle('active', isOpen);
        
        // Change icon
        const icon = toggleBtn.querySelector('i');
        if (icon) {
            icon.className = isOpen ? 'bi bi-x-lg' : 'bi bi-chat-dots-fill';
        }
        
        if (isOpen && !sessionId) {
            createSession();
        }
        
        if (isOpen) {
            inputField.focus();
        }
    }
    
    /**
     * Create new chat session
     */
    async function createSession() {
        try {
            const response = await fetch(CONTEXT_PATH + '/chat/session', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            });
            
            const data = await response.json();
            
            if (data.success) {
                sessionId = data.sessionId;
                localStorage.setItem(STORAGE_KEY, sessionId);
                
                // Show welcome message
                showWelcomeMessage();
            }
        } catch (error) {
            console.error('Failed to create session:', error);
            // Show offline welcome message
            showWelcomeMessage();
        }
    }
    
    /**
     * Show welcome message
     */
    async function showWelcomeMessage() {
        try {
            const response = await fetch(CONTEXT_PATH + '/chat/welcome');
            const data = await response.json();
            
            if (data.success) {
                addMessage(data.message, 'bot');
            }
        } catch (error) {
            // Fallback welcome message
            addMessage(
                'Xin chào! 👋\n\n' +
                'Tôi là trợ lý ảo của Clothing Shop.\n' +
                'Tôi có thể giúp bạn về:\n' +
                '• Thông tin giao hàng\n' +
                '• Chính sách đổi trả\n' +
                '• Phương thức thanh toán\n\n' +
                'Hãy đặt câu hỏi nhé! 😊',
                'bot'
            );
        }
    }
    
    /**
     * Send message to chatbot
     */
    async function sendMessage() {
        const message = inputField.value.trim();
        
        if (!message) return;
        
        // Clear input
        inputField.value = '';
        
        // Add customer message to UI
        addMessage(message, 'customer');
        
        // Show typing indicator
        showTyping(true);
        
        // Disable send button
        sendBtn.disabled = true;
        
        try {
            // Ensure we have a session
            if (!sessionId) {
                await createSession();
            }
            
            const response = await fetch(CONTEXT_PATH + '/chat/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `sessionId=${encodeURIComponent(sessionId)}&message=${encodeURIComponent(message)}`
            });
            
            const data = await response.json();
            
            // Simulate typing delay for natural feel
            setTimeout(() => {
                showTyping(false);
                
                if (data.success && data.botResponse) {
                    addMessage(data.botResponse.message, 'bot');
                } else {
                    // Fallback to offline chatbot
                    const offlineResponse = getOfflineResponse(message);
                    addMessage(offlineResponse, 'bot');
                }
                
                sendBtn.disabled = false;
            }, 500 + Math.random() * 500);
            
        } catch (error) {
            console.error('Failed to send message:', error);
            
            setTimeout(() => {
                showTyping(false);
                // Use offline response
                const offlineResponse = getOfflineResponse(message);
                addMessage(offlineResponse, 'bot');
                sendBtn.disabled = false;
            }, 500);
        }
    }
    
    /**
     * Offline chatbot response (fallback)
     */
    function getOfflineResponse(message) {
        const msg = message.toLowerCase();
        
        if (msg.match(/chào|hello|hi|xin chào/)) {
            return 'Xin chào! 👋 Tôi có thể giúp bạn về giao hàng, đổi trả, thanh toán. Bạn cần hỗ trợ gì?';
        }
        if (msg.match(/giao hàng|ship|vận chuyển|bao lâu/)) {
            return '📦 Giao hàng 2-5 ngày. Miễn phí ship đơn từ 500K!';
        }
        if (msg.match(/đổi trả|hoàn tiền|return/)) {
            return '🔄 Đổi trả miễn phí trong 7 ngày. Sản phẩm còn nguyên tag.';
        }
        if (msg.match(/thanh toán|payment|cod/)) {
            return '💳 Hỗ trợ COD và chuyển khoản ngân hàng.';
        }
        if (msg.match(/liên hệ|hotline|điện thoại/)) {
            return '📞 Hotline: 1900 1234 | Email: info@clothingshop.com';
        }
        if (msg.match(/voucher|giảm giá|khuyến mãi/)) {
            return '🎫 Xem voucher tại trang chủ hoặc mục Ví Voucher trong tài khoản!';
        }
        if (msg.match(/cảm ơn|thanks|thank/)) {
            return 'Rất vui được hỗ trợ bạn! Chúc mua sắm vui vẻ! 🛍️';
        }
        
        return 'Xin lỗi, tôi chưa hiểu. Hãy hỏi về giao hàng, đổi trả, thanh toán hoặc gọi 1900 1234!';
    }
    
    /**
     * Add message to chat UI
     */
    function addMessage(text, type) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `chat-message ${type}`;
        
        // Convert line breaks and markdown-like formatting
        let formattedText = text
            .replace(/\n/g, '<br>')
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/•/g, '&bull;');
        
        // Add bot icon for bot messages
        if (type === 'bot') {
            formattedText = '<span class="bot-icon">🤖</span> ' + formattedText;
        }
        
        messageDiv.innerHTML = formattedText;
        
        // Insert before typing indicator (not at the end)
        if (typingIndicator && typingIndicator.parentNode === messagesContainer) {
            messagesContainer.insertBefore(messageDiv, typingIndicator);
        } else {
            messagesContainer.appendChild(messageDiv);
        }
        
        // Scroll to bottom
        scrollToBottom();
    }
    
    /**
     * Show/hide typing indicator
     */
    function showTyping(show) {
        if (typingIndicator) {
            typingIndicator.classList.toggle('show', show);
            if (show) scrollToBottom();
        }
    }
    
    /**
     * Scroll messages to bottom
     */
    function scrollToBottom() {
        if (messagesContainer) {
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
    }
    
    /**
     * Handle Enter key press
     */
    function handleKeyPress(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    }
    
    /**
     * Switch between tabs (Bot, Messenger, Zalo)
     */
    function switchTab(tab) {
        currentTab = tab;
        
        // Update tab buttons
        document.querySelectorAll('.chat-tab').forEach(t => {
            t.classList.toggle('active', t.dataset.tab === tab);
        });
        
        // Show/hide bot tab content
        document.querySelectorAll('.chat-tab-content').forEach(content => {
            content.classList.toggle('active', content.dataset.tab === tab);
        });
        
        // Show/hide social tabs (Messenger, Zalo)
        document.querySelectorAll('.chat-social-tab').forEach(content => {
            content.classList.toggle('active', content.dataset.tab === tab);
        });
    }
    
    /**
     * Get cookie value by name
     */
    function getCookie(name) {
        const value = `; ${document.cookie}`;
        const parts = value.split(`; ${name}=`);
        if (parts.length === 2) return parts.pop().split(';').shift();
        return null;
    }
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
    // Export for debugging
    window.ChatWidget = {
        toggle: toggleChat,
        send: sendMessage,
        getSession: () => sessionId
    };
    
})();
