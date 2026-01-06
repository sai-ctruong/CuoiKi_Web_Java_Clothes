<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<script>
    // Set contextPath global variable for JavaScript files
    window.contextPath = '${pageContext.request.contextPath}';
</script>

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
                            <div class="user-dropdown-container">
                                <button class="user-btn" type="button" id="userDropdown">
                                    <i class="bi bi-person-circle me-1"></i>
                                    <span class="user-name"><c:out value="${sessionScope.user.username}"/></span>
                                    <i class="bi bi-chevron-down ms-1"></i>
                                </button>
                                <div class="user-dropdown-menu" id="userDropdownMenu">
                                    <a class="user-dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="bi bi-person me-2"></i>Hồ sơ
                                    </a>
                                    <a class="user-dropdown-item" href="${pageContext.request.contextPath}/orders">
                                        <i class="bi bi-box me-2"></i>Đơn hàng
                                    </a>
                                    <c:if test="${sessionScope.user.admin == true || sessionScope.user.staff == true}">
                                        <div class="user-dropdown-divider"></div>
                                        <a class="user-dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                                            <i class="bi bi-speedometer2 me-2"></i>Quản trị
                                        </a>
                                    </c:if>
                                    <div class="user-dropdown-divider"></div>
                                    <a class="user-dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                    </a>
                                </div>
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

// Initialize dropdown when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    var userBtn = document.getElementById('userDropdown');
    var userMenu = document.getElementById('userDropdownMenu');
    
    if (!userBtn || !userMenu) return;
    
    // Toggle dropdown on click
    userBtn.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        // Close other dropdowns
        document.querySelectorAll('.user-dropdown-menu.show').forEach(function(m) {
            if (m !== userMenu) m.classList.remove('show');
        });
        
        // Toggle current
        var isVisible = userMenu.classList.contains('show');
        userMenu.classList.toggle('show', !isVisible);
        userBtn.setAttribute('aria-expanded', !isVisible);
    });
    
    // Close on outside click
    document.addEventListener('click', function(e) {
        if (!userBtn.contains(e.target) && !userMenu.contains(e.target)) {
            userMenu.classList.remove('show');
            userBtn.setAttribute('aria-expanded', 'false');
        }
    });
    
    // Close on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && userMenu.classList.contains('show')) {
            userMenu.classList.remove('show');
            userBtn.setAttribute('aria-expanded', 'false');
            userBtn.focus();
        }
    });
    
    // Close after item click
    userMenu.querySelectorAll('.user-dropdown-item').forEach(function(item) {
        item.addEventListener('click', function() {
            userMenu.classList.remove('show');
            userBtn.setAttribute('aria-expanded', 'false');
        });
    });
});
</script>