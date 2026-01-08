/**
 * Theme Toggle JavaScript
 * Xử lý Dark/Light mode switch
 */

(function() {
    'use strict';
    
    const STORAGE_KEY = 'theme';
    const DARK = 'dark';
    const LIGHT = 'light';
    
    /**
     * Get saved theme or detect from system preference
     */
    function getSavedTheme() {
        const saved = localStorage.getItem(STORAGE_KEY);
        if (saved) return saved;
        
        // Check system preference
        if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            return DARK;
        }
        
        return LIGHT;
    }
    
    /**
     * Apply theme to document
     */
    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem(STORAGE_KEY, theme);
        
        // Update toggle button icon
        updateToggleIcon(theme);
    }
    
    /**
     * Update toggle button icon
     */
    function updateToggleIcon(theme) {
        const toggleBtn = document.getElementById('themeToggle');
        if (!toggleBtn) return;
        
        const sunIcon = toggleBtn.querySelector('.bi-sun-fill');
        const moonIcon = toggleBtn.querySelector('.bi-moon-fill');
        
        if (sunIcon && moonIcon) {
            if (theme === DARK) {
                sunIcon.style.display = 'inline-block';
                moonIcon.style.display = 'none';
            } else {
                sunIcon.style.display = 'none';
                moonIcon.style.display = 'inline-block';
            }
        }
    }
    
    /**
     * Toggle between themes
     */
    function toggleTheme() {
        const current = document.documentElement.getAttribute('data-theme') || LIGHT;
        const newTheme = current === DARK ? LIGHT : DARK;
        applyTheme(newTheme);
    }
    
    /**
     * Initialize theme on page load
     */
    function init() {
        // Apply saved theme immediately
        const theme = getSavedTheme();
        applyTheme(theme);
        
        // Set up toggle button
        const toggleBtn = document.getElementById('themeToggle');
        if (toggleBtn) {
            toggleBtn.addEventListener('click', toggleTheme);
        }
        
        // Listen for system theme changes
        if (window.matchMedia) {
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                if (!localStorage.getItem(STORAGE_KEY)) {
                    applyTheme(e.matches ? DARK : LIGHT);
                }
            });
        }
        
    }
    
    // Apply theme immediately to prevent flash
    (function() {
        const theme = getSavedTheme();
        document.documentElement.setAttribute('data-theme', theme);
    })();
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
    // Export for external use
    window.ThemeToggle = {
        toggle: toggleTheme,
        set: applyTheme,
        get: () => document.documentElement.getAttribute('data-theme') || LIGHT
    };
    
})();
