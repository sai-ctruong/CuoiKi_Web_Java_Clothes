/**
 * Toast Notifications System
 * Modern, customizable toast notifications
 * 
 * Usage:
 *   Toast.success('Thành công!', 'Đã thêm vào giỏ hàng');
 *   Toast.error('Lỗi!', 'Không thể thực hiện');
 *   Toast.warning('Cảnh báo!', 'Sản phẩm sắp hết');
 *   Toast.info('Thông tin', 'Đang xử lý...');
 *   Toast.cart('Đã thêm', 'Áo thun Premium', { action: { text: 'Xem giỏ', url: '/cart' }});
 */

(function() {
    'use strict';
    
    const DEFAULT_DURATION = 4000;
    let container = null;
    
    // Icons for each type
    const ICONS = {
        success: 'bi-check-lg',
        error: 'bi-x-lg',
        warning: 'bi-exclamation-triangle',
        info: 'bi-info-lg',
        cart: 'bi-bag-check'
    };
    
    /**
     * Initialize toast container
     */
    function init() {
        if (container) return container;
        
        container = document.createElement('div');
        container.className = 'toast-container';
        container.setAttribute('aria-live', 'polite');
        container.setAttribute('aria-atomic', 'true');
        document.body.appendChild(container);
        
        return container;
    }
    
    /**
     * Create and show a toast
     */
    function show(type, title, message, options = {}) {
        init();
        
        const duration = options.duration || DEFAULT_DURATION;
        const icon = options.icon || ICONS[type] || ICONS.info;
        
        // Create toast element
        const toast = document.createElement('div');
        toast.className = `toast-notification ${type}`;
        toast.style.setProperty('--duration', `${duration}ms`);
        toast.setAttribute('role', 'alert');
        
        // Build toast HTML
        let actionHTML = '';
        if (options.action) {
            actionHTML = `
                <a href="${options.action.url || '#'}" class="toast-action">
                    <i class="bi ${options.action.icon || 'bi-arrow-right'}"></i>
                    ${options.action.text || 'Xem'}
                </a>
            `;
        }
        
        toast.innerHTML = `
            <div class="toast-icon">
                <i class="bi ${icon}"></i>
            </div>
            <div class="toast-content">
                <div class="toast-title">${title}</div>
                ${message ? `<div class="toast-message">${message}</div>` : ''}
                ${actionHTML}
            </div>
            <button class="toast-close" aria-label="Đóng">
                <i class="bi bi-x"></i>
            </button>
            <div class="toast-progress"></div>
        `;
        
        // Add to container
        container.appendChild(toast);
        
        // Close button handler
        const closeBtn = toast.querySelector('.toast-close');
        closeBtn.addEventListener('click', () => hideToast(toast));
        
        // Auto dismiss
        if (duration > 0) {
            setTimeout(() => {
                hideToast(toast);
            }, duration);
        }
        
        // Click action handler
        if (options.onClick) {
            toast.style.cursor = 'pointer';
            toast.addEventListener('click', (e) => {
                if (!e.target.closest('.toast-close') && !e.target.closest('.toast-action')) {
                    options.onClick();
                    hideToast(toast);
                }
            });
        }
        
        return toast;
    }
    
    /**
     * Hide a toast with animation
     */
    function hideToast(toast) {
        if (!toast || toast.classList.contains('hiding')) return;
        
        toast.classList.add('hiding');
        
        setTimeout(() => {
            if (toast.parentNode) {
                toast.parentNode.removeChild(toast);
            }
        }, 300);
    }
    
    /**
     * Clear all toasts
     */
    function clearAll() {
        if (!container) return;
        
        const toasts = container.querySelectorAll('.toast-notification');
        toasts.forEach(toast => hideToast(toast));
    }
    
    // Public API
    window.Toast = {
        show: show,
        
        success: (title, message, options = {}) => 
            show('success', title, message, options),
        
        error: (title, message, options = {}) => 
            show('error', title, message, options),
        
        warning: (title, message, options = {}) => 
            show('warning', title, message, options),
        
        info: (title, message, options = {}) => 
            show('info', title, message, options),
        
        cart: (title, message, options = {}) => {
            // Get context path dynamically
            const pathParts = window.location.pathname.split('/');
            const contextPath = pathParts.length > 1 && pathParts[1] ? '/' + pathParts[1] : '';
            
            return show('cart', title, message, {
                ...options,
                action: options.action || { 
                    text: 'Xem giỏ hàng', 
                    url: contextPath + '/cart',
                    icon: 'bi-bag'
                }
            });
        },
        
        clear: clearAll,
        hide: hideToast
    };
    
    // Initialize on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
})();
