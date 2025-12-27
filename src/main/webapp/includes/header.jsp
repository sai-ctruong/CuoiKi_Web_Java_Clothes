<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<header class="main-header">
    <div class="container">
        <div class="header-content">
            <!-- Logo -->
            <div class="header-logo">
                <a href="${pageContext.request.contextPath}/home" class="logo-link">
                    <i class="bi bi-bag-heart-fill text-gold me-2"></i>
                    <span class="logo-text">Clothing Shop</span>
                </a>
            </div>
            
            <!-- Main Navigation -->
            <nav class="main-nav">
                <ul class="nav-list">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/home" class="nav-link">
                            <i class="bi bi-house me-1"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/products" class="nav-link">
                            <i class="bi bi-grid me-1"></i>Sản Phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/about" class="nav-link">
                            <i class="bi bi-info-circle me-1"></i>Giới Thiệu
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/contact" class="nav-link">
                            <i class="bi bi-telephone me-1"></i>Liên Hệ
                        </a>
                    </li>
                </ul>
            </nav>
            
            <!-- Header Actions -->
            <div class="header-actions">
                <!-- Search -->
                <div class="search-box">
                    <form action="${pageContext.request.contextPath}/search" method="GET" class="search-form">
                        <input type="text" name="q" placeholder="Tìm kiếm..." class="search-input" value="${param.q}">
                        <button type="submit" class="search-btn">
                            <i class="bi bi-search"></i>
                        </button>
                    </form>
                </div>
                
                <!-- Cart -->
                <a href="${pageContext.request.contextPath}/cart" class="action-btn" title="Giỏ hàng">
                    <i class="bi bi-bag"></i>
                    <span class="action-badge" id="cart-count">
                        <c:choose>
                            <c:when test="${not empty sessionScope.cartCount}">
                                ${sessionScope.cartCount}
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </span>
                </a>
                
                <!-- User Menu -->
                <div class="user-menu">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown">
                                <button class="user-btn dropdown-toggle" type="button" id="userDropdown" aria-expanded="false" style="cursor: pointer;">
                                    <i class="bi bi-person-circle me-1"></i>
                                    <span class="user-name"><c:out value="${sessionScope.user.username}"/></span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" id="userDropdownMenu" aria-labelledby="userDropdown" style="z-index: 9999; margin-top: 10px;">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="bi bi-person me-2"></i>Hồ sơ
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                        <i class="bi bi-box me-2"></i>Đơn hàng
                                    </a></li>
                                    <c:if test="${sessionScope.user.admin || sessionScope.user.staff}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                                            <i class="bi bi-speedometer2 me-2"></i>Quản trị
                                        </a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                    </a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="auth-buttons">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-gold btn-sm">
                                    Đăng Nhập
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
// Update cart count dynamically
function updateCartCount(count) {
    var cartBadge = document.getElementById('cart-count');
    if (cartBadge) {
        cartBadge.textContent = count || '0';
    }
}

// Initialize Dropdown (Pure JS - Force Manual Toggle)
(function() {
    function initUserDropdown() {
        var userDropdownBtn = document.getElementById('userDropdown');
        var dropdownMenu = document.getElementById('userDropdownMenu');
        
        if (!userDropdownBtn || !dropdownMenu) {
            console.log('User dropdown elements not found');
            return;
        }
        
        // Ensure dropdown is hidden initially
        dropdownMenu.style.display = 'none';
        dropdownMenu.classList.remove('show');
        
        // Direct onclick handler to override any other listeners
        userDropdownBtn.onclick = function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            // Check current state
            var isVisible = dropdownMenu.style.display === 'block' || 
                           dropdownMenu.classList.contains('show') ||
                           window.getComputedStyle(dropdownMenu).display === 'block';
            
            console.log('Dropdown clicked, isVisible:', isVisible);
            
            if (isVisible) {
                dropdownMenu.style.display = 'none';
                dropdownMenu.classList.remove('show');
                userDropdownBtn.setAttribute('aria-expanded', 'false');
            } else {
                dropdownMenu.style.display = 'block';
                dropdownMenu.classList.add('show');
                userDropdownBtn.setAttribute('aria-expanded', 'true');
                console.log('Dropdown shown');
            }
        };

        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (userDropdownBtn && dropdownMenu) {
                var isVisible = dropdownMenu.style.display === 'block' || 
                               dropdownMenu.classList.contains('show');
                
                if (isVisible && 
                    !userDropdownBtn.contains(e.target) && 
                    !dropdownMenu.contains(e.target)) {
                    dropdownMenu.style.display = 'none';
                    dropdownMenu.classList.remove('show');
                    userDropdownBtn.setAttribute('aria-expanded', 'false');
                }
            }
        });
        
        console.log('User dropdown initialized');
    }
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initUserDropdown);
    } else {
        initUserDropdown();
    }
})();
</script>