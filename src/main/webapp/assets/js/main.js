/**
 * Clothing Shop - Modern JavaScript Enhancements
 * Bootstrap 5.3+ Compatible
 */
(function() {
    'use strict';
    
    // Add CSS animations on load (only once)
    if (!document.getElementById('main-animations-style')) {
        const styleEl = document.createElement('style');
        styleEl.id = 'main-animations-style';
        styleEl.textContent = `
            @keyframes bounce {
                0%, 20%, 60%, 100% { transform: translateY(0); }
                40% { transform: translateY(-10px); }
                80% { transform: translateY(-5px); }
            }
            .lazy { opacity: 0; transition: opacity 0.3s; }
            .lazy.loaded { opacity: 1; }
            .toast-container { position: fixed; top: 80px; right: 20px; z-index: 9999; }
        `;
        document.head.appendChild(styleEl);
    }
    
    // Create toast container
    let toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container';
        document.body.appendChild(toastContainer);
    }

    // Initialize when DOM is loaded
    document.addEventListener('DOMContentLoaded', function() {
        initializeApp();
    });

    /**
     * Initialize application
     */
    function initializeApp() {
        initializeTooltips();
        initializeSmoothScrolling();
        initializeNewsletterForm();
        initializeProductInteractions();
        initializeBackToTop();
        initializeLazyLoading();
        console.log('🎉 Clothing Shop initialized successfully!');
    }

    /**
     * Initialize Bootstrap tooltips
     */
    function initializeTooltips() {
        if (typeof bootstrap !== 'undefined') {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        }
    }

    /**
     * Initialize smooth scrolling for anchor links
     */
    function initializeSmoothScrolling() {
        document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
            anchor.addEventListener('click', function (e) {
                const targetId = this.getAttribute('href');
                if (targetId && targetId !== '#') {
                    const target = document.querySelector(targetId);
                    if (target) {
                        e.preventDefault();
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                }
            });
        });
    }

    /**
     * Initialize newsletter form
     */
    function initializeNewsletterForm() {
        const newsletterForm = document.getElementById('newsletterForm');
        if (newsletterForm) {
            newsletterForm.addEventListener('submit', function(e) {
                e.preventDefault();
                handleNewsletterSubmit(this);
            });
        }
        
        // Don't intercept .newsletter-form - let it submit normally to servlet
        // The form has action="/newsletter/subscribe" and will be handled by server
    }

    /**
     * Handle newsletter form submission - Now actually calls the servlet
     */
    function handleNewsletterSubmit(form) {
        const emailInput = form.querySelector('input[type="email"]');
        const email = emailInput ? emailInput.value : '';
        const submitBtn = form.querySelector('button[type="submit"]');
        
        if (!email) {
            showToast('Vui lòng nhập email hợp lệ', 'warning');
            return;
        }
        
        setButtonLoading(submitBtn, true);
        
        // Get the form action URL or construct it
        const contextPath = document.querySelector('meta[name="context-path"]')?.content || '';
        const actionUrl = form.action || (contextPath + '/newsletter/subscribe');
        
        // Actually submit to the servlet using fetch
        fetch(actionUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'email=' + encodeURIComponent(email)
        })
        .then(function(response) {
            // The servlet redirects, so we just reload the page to see the message
            window.location.reload();
        })
        .catch(function(error) {
            setButtonLoading(submitBtn, false);
            showToast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
            console.error('Newsletter error:', error);
        });
    }

    /**
     * Initialize product interactions
     */
    function initializeProductInteractions() {
        // Product filter tabs
        document.querySelectorAll('#productTabs button').forEach(function(tab) {
            tab.addEventListener('click', function() {
                filterProducts();
            });
        });
    }

    /**
     * Filter products animation
     */
    function filterProducts() {
        const productCards = document.querySelectorAll('.product-card');
        productCards.forEach(function(card, index) {
            card.style.opacity = '0.5';
            card.style.transform = 'scale(0.95)';
            setTimeout(function() {
                card.style.opacity = '1';
                card.style.transform = 'scale(1)';
            }, index * 50);
        });
    }

    /**
     * Toggle wishlist
     */
    function toggleWishlist(productId) {
        const button = event.target.closest('.action-btn');
        if (!button) return;
        
        const icon = button.querySelector('i');
        if (!icon) return;
        
        if (icon.classList.contains('bi-heart')) {
            icon.classList.remove('bi-heart');
            icon.classList.add('bi-heart-fill');
            button.style.color = '#dc3545';
            showToast('Đã thêm vào danh sách yêu thích', 'info');
        } else {
            icon.classList.remove('bi-heart-fill');
            icon.classList.add('bi-heart');
            button.style.color = '';
            showToast('Đã xóa khỏi danh sách yêu thích', 'info');
        }
        
        button.style.transform = 'scale(1.2)';
        setTimeout(function() {
            button.style.transform = 'scale(1)';
        }, 200);
    }

    /**
     * Quick view product
     */
    function quickView(productId) {
        const modal = document.getElementById('quickViewModal');
        if (modal) {
            const modalBody = modal.querySelector('.modal-body');
            if (modalBody) {
                modalBody.style.opacity = '0.5';
                setTimeout(function() {
                    modalBody.style.opacity = '1';
                }, 500);
            }
        }
    }

    /**
     * Initialize back to top button
     */
    function initializeBackToTop() {
        // Check if already exists
        if (document.querySelector('.fab')) return;
        
        const backToTopBtn = document.createElement('button');
        backToTopBtn.className = 'fab';
        backToTopBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
        backToTopBtn.style.display = 'none';
        backToTopBtn.setAttribute('title', 'Về đầu trang');
        document.body.appendChild(backToTopBtn);
        
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopBtn.style.display = 'flex';
            } else {
                backToTopBtn.style.display = 'none';
            }
        });
        
        backToTopBtn.addEventListener('click', function() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    /**
     * Initialize lazy loading for images
     */
    function initializeLazyLoading() {
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver(function(entries, observer) {
                entries.forEach(function(entry) {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        if (img.dataset.src) {
                            img.src = img.dataset.src;
                            img.classList.remove('lazy');
                            imageObserver.unobserve(img);
                        }
                    }
                });
            });
            
            document.querySelectorAll('img[data-src]').forEach(function(img) {
                imageObserver.observe(img);
            });
        }
    }

    /**
     * Set button loading state
     */
    function setButtonLoading(button, loading) {
        if (!button) return;
        if (loading) {
            button.classList.add('btn-loading');
            button.disabled = true;
        } else {
            button.classList.remove('btn-loading');
            button.disabled = false;
        }
    }

    /**
     * Show toast notification
     */
    function showToast(message, type) {
        type = type || 'info';
        
        // Use cart.js toast if available
        if (typeof window.showCartToast === 'function') {
            window.showCartToast(type, message);
            return;
        }
        
        const container = document.querySelector('.toast-container');
        if (!container) return;
        
        const toastId = 'toast-' + Date.now();
        const iconMap = {
            success: 'bi-check-circle-fill',
            error: 'bi-x-circle-fill',
            warning: 'bi-exclamation-triangle-fill',
            info: 'bi-info-circle-fill'
        };
        
        const toastHTML = 
            '<div class="toast" id="' + toastId + '" role="alert">' +
                '<div class="toast-header">' +
                    '<i class="bi ' + (iconMap[type] || iconMap.info) + ' me-2"></i>' +
                    '<strong class="me-auto">Thông báo</strong>' +
                    '<button type="button" class="btn-close" data-bs-dismiss="toast"></button>' +
                '</div>' +
                '<div class="toast-body">' + message + '</div>' +
            '</div>';
        
        container.insertAdjacentHTML('beforeend', toastHTML);
        
        const toastElement = document.getElementById(toastId);
        if (toastElement && typeof bootstrap !== 'undefined') {
            const toast = new bootstrap.Toast(toastElement, { autohide: true, delay: 4000 });
            toast.show();
            
            toastElement.addEventListener('hidden.bs.toast', function() {
                this.remove();
            });
        }
    }

    /**
     * Format currency
     */
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    /**
     * Debounce function for search
     */
    function debounce(func, wait) {
        var timeout;
        return function() {
            var context = this, args = arguments;
            clearTimeout(timeout);
            timeout = setTimeout(function() {
                func.apply(context, args);
            }, wait);
        };
    }

    // Export only non-conflicting functions to global scope
    window.toggleWishlist = toggleWishlist;
    window.quickView = quickView;
    window.showToast = showToast;
    window.formatCurrency = formatCurrency;
    
    // NOTE: addToCart is now defined in cart.js ONLY to avoid conflicts
    
})();