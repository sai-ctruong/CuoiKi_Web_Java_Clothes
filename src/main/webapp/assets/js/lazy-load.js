/**
 * Lazy Loading Images
 * Chỉ tải ảnh khi user scroll đến vị trí
 */

(function() {
    'use strict';
    
    // Intersection Observer for lazy loading
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                
                // Load actual image
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                    img.removeAttribute('data-src');
                }
                
                if (img.dataset.srcset) {
                    img.srcset = img.dataset.srcset;
                    img.removeAttribute('data-srcset');
                }
                
                // Add loaded class for fade-in effect
                img.classList.add('lazy-loaded');
                
                // Stop observing this image
                observer.unobserve(img);
            }
        });
    }, {
        rootMargin: '50px 0px', // Start loading 50px before visible
        threshold: 0.01
    });
    
    /**
     * Initialize lazy loading cho tất cả ảnh có class 'lazy'
     */
    function initLazyLoad() {
        const lazyImages = document.querySelectorAll('img.lazy, img[data-src]');
        
        if ('IntersectionObserver' in window) {
            lazyImages.forEach(img => {
                // Set placeholder nếu chưa có
                if (!img.src || img.src === window.location.href) {
                    img.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400"%3E%3Crect fill="%23f0f0f0" width="400" height="400"/%3E%3C/svg%3E';
                }
                imageObserver.observe(img);
            });
        } else {
            // Fallback: load all images immediately
            lazyImages.forEach(img => {
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                }
            });
        }
    }
    
    /**
     * Convert existing images to lazy load format
     * Gọi hàm này để convert ảnh động
     */
    function convertToLazy(container) {
        const images = (container || document).querySelectorAll('img:not(.lazy):not(.lazy-loaded)');
        images.forEach(img => {
            if (img.src && !img.src.startsWith('data:')) {
                img.dataset.src = img.src;
                img.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400"%3E%3Crect fill="%23f0f0f0" width="400" height="400"/%3E%3C/svg%3E';
                img.classList.add('lazy');
                imageObserver.observe(img);
            }
        });
    }
    
    // Auto-init on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initLazyLoad);
    } else {
        initLazyLoad();
    }
    
    // Export for external use
    window.LazyLoad = {
        init: initLazyLoad,
        convert: convertToLazy,
        observe: (img) => imageObserver.observe(img)
    };
    
})();
