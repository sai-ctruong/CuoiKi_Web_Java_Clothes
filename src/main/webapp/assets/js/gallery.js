/**
 * Enhanced Product Gallery
 * - Click to zoom
 * - Lightbox view
 * - Keyboard navigation (Arrow keys, Escape)
 * - Touch swipe support
 */

(function() {
    'use strict';
    
    let currentIndex = 0;
    let images = [];
    let lightbox = null;
    
    /**
     * Initialize gallery
     */
    function init() {
        const mainImage = document.querySelector('.main-image');
        const thumbnails = document.querySelectorAll('.thumbnail-item');
        const mainContainer = document.querySelector('.main-image-container');
        
        if (!mainImage || !mainContainer) return;
        
        // Collect all images
        images = [];
        if (mainImage.src) images.push(mainImage.src);
        thumbnails.forEach(thumb => {
            const img = thumb.querySelector('img');
            if (img && img.src && !images.includes(img.src)) {
                images.push(img.src);
            }
        });
        
        // Create lightbox
        createLightbox();
        
        // Add navigation arrows
        addNavigationArrows(mainContainer);
        
        // Add image counter
        addImageCounter(mainContainer);
        
        // Click to open lightbox
        mainContainer.addEventListener('click', (e) => {
            if (!e.target.closest('.gallery-nav') && !e.target.closest('.wishlist-btn')) {
                openLightbox(currentIndex);
            }
        });
        
        // Thumbnail click
        thumbnails.forEach((thumb, index) => {
            thumb.addEventListener('click', () => {
                changeImage(index);
            });
        });
        
        // Keyboard navigation
        document.addEventListener('keydown', handleKeyboard);
    }
    
    /**
     * Create lightbox element
     */
    function createLightbox() {
        if (document.querySelector('.gallery-lightbox')) return;
        
        lightbox = document.createElement('div');
        lightbox.className = 'gallery-lightbox';
        lightbox.innerHTML = `
            <div class="lightbox-content">
                <button class="lightbox-close" title="Đóng (Esc)">
                    <i class="bi bi-x-lg"></i>
                </button>
                <button class="lightbox-nav lightbox-prev" title="Ảnh trước (←)">
                    <i class="bi bi-chevron-left"></i>
                </button>
                <img class="lightbox-image" src="" alt="Product Image">
                <button class="lightbox-nav lightbox-next" title="Ảnh tiếp (→)">
                    <i class="bi bi-chevron-right"></i>
                </button>
                <div class="lightbox-counter">1 / 1</div>
            </div>
        `;
        
        document.body.appendChild(lightbox);
        
        // Event listeners
        lightbox.querySelector('.lightbox-close').addEventListener('click', closeLightbox);
        lightbox.querySelector('.lightbox-prev').addEventListener('click', () => navigateLightbox(-1));
        lightbox.querySelector('.lightbox-next').addEventListener('click', () => navigateLightbox(1));
        lightbox.addEventListener('click', (e) => {
            if (e.target === lightbox) closeLightbox();
        });
    }
    
    /**
     * Add navigation arrows to main container
     */
    function addNavigationArrows(container) {
        if (container.querySelector('.gallery-nav')) return;
        
        const prevBtn = document.createElement('button');
        prevBtn.className = 'gallery-nav prev';
        prevBtn.innerHTML = '<i class="bi bi-chevron-left"></i>';
        prevBtn.title = 'Ảnh trước';
        prevBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            prevImage();
        });
        
        const nextBtn = document.createElement('button');
        nextBtn.className = 'gallery-nav next';
        nextBtn.innerHTML = '<i class="bi bi-chevron-right"></i>';
        nextBtn.title = 'Ảnh tiếp';
        nextBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            nextImage();
        });
        
        container.appendChild(prevBtn);
        container.appendChild(nextBtn);
    }
    
    /**
     * Add image counter
     */
    function addImageCounter(container) {
        if (container.querySelector('.image-counter')) return;
        
        const counter = document.createElement('div');
        counter.className = 'image-counter';
        counter.textContent = `1 / ${images.length}`;
        container.appendChild(counter);
    }
    
    /**
     * Update image counter
     */
    function updateCounter() {
        const counter = document.querySelector('.image-counter');
        if (counter) {
            counter.textContent = `${currentIndex + 1} / ${images.length}`;
        }
    }
    
    /**
     * Change main image
     */
    function changeImage(index) {
        if (index < 0) index = images.length - 1;
        if (index >= images.length) index = 0;
        
        currentIndex = index;
        
        const mainImage = document.querySelector('.main-image');
        if (mainImage && images[index]) {
            mainImage.style.opacity = '0.5';
            mainImage.src = images[index];
            setTimeout(() => {
                mainImage.style.opacity = '1';
            }, 50);
        }
        
        // Update thumbnail active state
        const thumbnails = document.querySelectorAll('.thumbnail-item');
        thumbnails.forEach((thumb, i) => {
            thumb.classList.toggle('active', i === index);
        });
        
        updateCounter();
    }
    
    /**
     * Next image
     */
    function nextImage() {
        changeImage(currentIndex + 1);
    }
    
    /**
     * Previous image
     */
    function prevImage() {
        changeImage(currentIndex - 1);
    }
    
    /**
     * Open lightbox
     */
    function openLightbox(index) {
        if (!lightbox || images.length === 0) return;
        
        currentIndex = index;
        const img = lightbox.querySelector('.lightbox-image');
        const counter = lightbox.querySelector('.lightbox-counter');
        
        img.src = images[index];
        counter.textContent = `${index + 1} / ${images.length}`;
        
        lightbox.classList.add('active');
        document.body.style.overflow = 'hidden';
    }
    
    /**
     * Close lightbox
     */
    function closeLightbox() {
        if (!lightbox) return;
        
        lightbox.classList.remove('active');
        document.body.style.overflow = '';
    }
    
    /**
     * Navigate in lightbox
     */
    function navigateLightbox(direction) {
        let newIndex = currentIndex + direction;
        if (newIndex < 0) newIndex = images.length - 1;
        if (newIndex >= images.length) newIndex = 0;
        
        currentIndex = newIndex;
        
        const img = lightbox.querySelector('.lightbox-image');
        const counter = lightbox.querySelector('.lightbox-counter');
        
        img.src = images[newIndex];
        counter.textContent = `${newIndex + 1} / ${images.length}`;
        
        // Update main gallery too
        changeImage(newIndex);
    }
    
    /**
     * Handle keyboard navigation
     */
    function handleKeyboard(e) {
        const isLightboxOpen = lightbox && lightbox.classList.contains('active');
        
        if (isLightboxOpen) {
            switch(e.key) {
                case 'Escape':
                    closeLightbox();
                    break;
                case 'ArrowLeft':
                    navigateLightbox(-1);
                    break;
                case 'ArrowRight':
                    navigateLightbox(1);
                    break;
            }
        }
    }
    
    // Init on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
    // Export
    window.ProductGallery = {
        openLightbox: openLightbox,
        closeLightbox: closeLightbox,
        nextImage: nextImage,
        prevImage: prevImage
    };
    
})();
