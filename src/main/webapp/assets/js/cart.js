/**
 * Cart functionality with fly-to-cart animation
 * Handles AJAX add-to-cart without page reload
 */
(function() {
    'use strict';
    
    // Add CSS animations on load (only once)
    if (!document.getElementById('cart-animations-style')) {
        const styleEl = document.createElement('style');
        styleEl.id = 'cart-animations-style';
        styleEl.textContent = `
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes slideOut {
                from { transform: translateX(0); opacity: 1; }
                to { transform: translateX(100%); opacity: 0; }
            }
            @keyframes cartPulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.3); }
                100% { transform: scale(1); }
            }
            .btn-add-cart { cursor: pointer; }
        `;
        document.head.appendChild(styleEl);
    }

    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initAddToCartButtons();
        initToastContainer();
    });

    /**
     * Global addToCart function for onclick handlers
     */
    window.addToCart = function(productId, event) {
        if (event) event.preventDefault();
        
        // Find the button that was clicked
        let buttonEl = null;
        if (event && event.target) {
            buttonEl = event.target.closest('.btn-add-cart');
        }
        if (!buttonEl) {
            buttonEl = document.querySelector('.btn-add-cart[onclick*="' + productId + '"]');
        }
        
        // Find the product card for animation
        const productCard = buttonEl ? buttonEl.closest('.product-card') : null;
        const productImage = productCard ? productCard.querySelector('.product-img, img') : null;
        
        // Trigger add to cart with animation
        addToCartWithAnimation(productId, productImage, buttonEl);
    };

    /**
     * Initialize all "Add to Cart" buttons
     */
    function initAddToCartButtons() {
        document.querySelectorAll('.btn-add-cart[href], [data-add-cart]').forEach(function(btn) {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                const href = this.getAttribute('href') || this.dataset.href;
                if (!href) return;
                
                // Extract product ID from URL
                const url = new URL(href, window.location.origin);
                const productId = url.searchParams.get('id');
                
                if (!productId) return;
                
                // Find the product card/image for animation
                const productCard = this.closest('.product-card') || this.closest('.product-image-wrapper');
                const productImage = productCard ? productCard.querySelector('.product-image, img') : null;
                
                // Trigger add to cart with animation
                addToCartWithAnimation(productId, productImage, this);
            });
        });
    }

    /**
     * Create toast notification container
     */
    function initToastContainer() {
        if (!document.getElementById('toast-container')) {
            const container = document.createElement('div');
            container.id = 'toast-container';
            container.style.cssText = 'position:fixed;top:100px;right:20px;z-index:9999;display:flex;flex-direction:column;gap:10px;';
            document.body.appendChild(container);
        }
    }

    /**
     * Add product to cart with flying animation
     */
    function addToCartWithAnimation(productId, productImageEl, buttonEl) {
        // Disable button to prevent double-clicks
        if (buttonEl) {
            buttonEl.style.pointerEvents = 'none';
        }
        
        // Get cart icon position
        const cartIcon = document.querySelector('.bi-cart3, .bi-cart')?.closest('a') || 
                         document.querySelector('[href*="/cart"]');
        
        // --- OPTIMISTIC UI: START ANIMATION IMMEDIATELY ---
        // 1. Run Flying Animation
        if (productImageEl && cartIcon) {
            createFlyingImage(productImageEl, cartIcon);
        }
        
        // 2. Optimistically Update Badge
        // Get current count - First try #cart-count (from header.jsp), then other selectors
        let currentBadge = document.getElementById('cart-count') || 
                           document.querySelector('.action-badge, .cart-badge, .position-absolute.badge');
        let currentCount = 0;
        if (currentBadge) {
            currentCount = parseInt(currentBadge.textContent) || 0;
        } else {
            // Try to parse from cart link if badge invalid
             const cartLink = document.querySelector('.bi-bag, .bi-cart3, .bi-cart')?.closest('a');
             if (cartLink) {
                 const badge = cartLink.querySelector('.action-badge, .badge');
                 if (badge) currentCount = parseInt(badge.textContent) || 0;
             }
        }
        
        // Optimistic increment
        updateCartBadge(currentCount + 1);
        
        // --- BACKGROUND SERVER REQUEST ---
        const contextPath = window.location.pathname.split('/')[1] || '';
        const url = (contextPath ? '/' + contextPath : '') + '/cart/add?id=' + productId + '&ajax=true';
        
        fetch(url, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then(function(response) { return response.json(); })
        .then(function(data) {
            if (data.status === 'success') {
                // Sync with actual server count (usually same as optimistic)
                updateCartBadge(data.totalItems);
                
                // Show success toast immediately
                showToast('success', data.message || 'Đã thêm vào giỏ hàng!');
                
            } else if (data.requireLogin) {
                // Revert optimistic update
                updateCartBadge(currentCount); 
                
                // Redirect to login
                window.location.href = (contextPath ? '/' + contextPath : '') + '/login';
                return;
            } else {
                // Revert optimistic update on error
                updateCartBadge(currentCount);
                showToast('error', data.message || 'Có lỗi xảy ra');
            }
        })
        .catch(function(error) {
            console.error('Add to cart error:', error);
            // Revert optimistic update on network error
            updateCartBadge(currentCount);
            showToast('error', 'Có lỗi xảy ra. Vui lòng thử lại.');
        })
        .finally(function() {
            if (buttonEl) {
                setTimeout(function() {
                    buttonEl.style.pointerEvents = '';
                }, 500);
            }
        });
    }

    /**
     * Create and animate flying image to cart
     */
    function createFlyingImage(sourceEl, targetEl) {
        const sourceRect = sourceEl.getBoundingClientRect();
        const targetRect = targetEl.getBoundingClientRect();
        
        const flyingEl = document.createElement('div');
        flyingEl.style.cssText = 'position:fixed;z-index:10000;width:80px;height:80px;border-radius:50%;overflow:hidden;box-shadow:0 5px 20px rgba(0,0,0,0.3);pointer-events:none;transition:all 0.8s cubic-bezier(0.25,0.46,0.45,0.94);';
        
        const img = document.createElement('img');
        img.src = sourceEl.src || (sourceEl.querySelector('img') ? sourceEl.querySelector('img').src : '');
        img.style.cssText = 'width:100%;height:100%;object-fit:cover;';
        flyingEl.appendChild(img);
        
        flyingEl.style.left = (sourceRect.left + sourceRect.width / 2 - 40) + 'px';
        flyingEl.style.top = (sourceRect.top + sourceRect.height / 2 - 40) + 'px';
        flyingEl.style.transform = 'scale(1)';
        flyingEl.style.opacity = '1';
        
        document.body.appendChild(flyingEl);
        
        requestAnimationFrame(function() {
            flyingEl.style.left = (targetRect.left + targetRect.width / 2 - 20) + 'px';
            flyingEl.style.top = (targetRect.top + targetRect.height / 2 - 20) + 'px';
            flyingEl.style.transform = 'scale(0.3)';
            flyingEl.style.opacity = '0.5';
        });
        
        setTimeout(function() {
            if (targetEl) {
                targetEl.style.transition = 'transform 0.3s ease';
                targetEl.style.transform = 'scale(1.3)';
                setTimeout(function() {
                    targetEl.style.transform = 'scale(1)';
                }, 300);
            }
        }, 700);
        
        setTimeout(function() { flyingEl.remove(); }, 900);
    }

    /**
     * Update cart badge count
     */
    function updateCartBadge(count) {
        // First try to find by ID (header.jsp uses #cart-count)
        let badge = document.getElementById('cart-count');
        
        // Fallback to other selectors
        if (!badge) {
            badge = document.querySelector('.cart-badge, .action-badge, .bi-cart + .badge, .position-absolute.badge');
        }
        
        const cartLink = document.querySelector('[href*="/cart"], .bi-bag')?.closest('a');
        
        if (!badge && cartLink) {
            badge = cartLink.querySelector('.badge, .action-badge');
        }
        
        if (count > 0) {
            const displayCount = count > 99 ? '99+' : count;
            
            if (badge) {
                badge.textContent = displayCount;
                badge.style.display = '';
                badge.style.animation = 'none';
                badge.offsetHeight; // Trigger reflow
                badge.style.animation = 'cartPulse 0.5s ease';
            } else if (cartLink) {
                const newBadge = document.createElement('span');
                newBadge.className = 'action-badge';
                newBadge.id = 'cart-count';
                newBadge.textContent = displayCount;
                cartLink.appendChild(newBadge);
            }
        } else if (badge) {
            badge.textContent = '0';
        }
        
        // Also call header's updateCartCount if available (for sync)
        if (typeof window.updateCartCount === 'function') {
            window.updateCartCount(count);
        }
    }

    /**
     * Show toast notification using Toast API
     */
    function showToast(type, message) {
        // Use new Toast API if available
        if (window.Toast) {
            if (type === 'success') {
                window.Toast.cart('Thành công!', message);
            } else if (type === 'error') {
                window.Toast.error('Lỗi', message);
            } else {
                window.Toast.info('Thông báo', message);
            }
            return;
        }
        
        // Fallback to simple alert if Toast not loaded
        alert(message);
    }

    /**
     * Get context path
     */
    function getContextPath() {
        const path = window.location.pathname;
        const contextEnd = path.indexOf('/', 1);
        return contextEnd > 0 ? path.substring(0, contextEnd) : '';
    }

})();
