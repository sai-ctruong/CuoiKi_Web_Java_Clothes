<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm - Clothing Shop</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 70px;
            background: var(--bg-light);
        }
        
        .search-hero {
            background: linear-gradient(135deg, var(--dark) 0%, var(--dark-surface) 100%);
            padding: 4rem 0 3rem;
            margin-bottom: 3rem;
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
            box-shadow: var(--shadow-lg);
        }
        
        .search-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            color: white;
            margin-bottom: 1rem;
        }
        
        .search-hero p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        
        .modern-search-form {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .search-input-group {
            position: relative;
            background: white;
            border-radius: var(--radius-xl);
            padding: 0.5rem;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        }
        
        .search-input {
            border: none;
            padding: 1rem 1.5rem;
            font-size: 1.1rem;
            border-radius: var(--radius-lg);
            background: transparent;
            flex: 1;
        }
        
        .search-input:focus {
            outline: none;
            box-shadow: none;
        }
        
        .search-btn {
            background: var(--gold);
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: var(--radius-lg);
            font-weight: 600;
            transition: var(--transition);
        }
        
        .search-btn:hover {
            background: var(--gold-dark);
            color: white;
            transform: translateY(-2px);
        }
        
        .search-suggestions {
            margin-top: 2rem;
            text-align: center;
        }
        
        .suggestion-tag {
            display: inline-block;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            margin: 0.25rem;
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        
        .suggestion-tag:hover {
            background: var(--gold);
            color: white;
            transform: translateY(-2px);
        }
        
        .search-results {
            padding: 2rem 0;
        }
        
        .results-header {
            background: white;
            border-radius: var(--radius-xl);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            text-align: center;
        }
        
        .results-info {
            font-size: 1.1rem;
            color: var(--text-dark);
            margin: 0;
        }
        
        .results-info strong {
            color: var(--gold-dark);
        }
        
        .modern-product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }
        
        .modern-product-card {
            background: white;
            border-radius: var(--radius-xl);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            position: relative;
        }
        
        .modern-product-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
        }
        
        .product-image-container {
            position: relative;
            aspect-ratio: 3/4;
            overflow: hidden;
        }
        
        .product-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        
        .modern-product-card:hover .product-image-container img {
            transform: scale(1.05);
        }
        
        .product-actions {
            position: absolute;
            top: 1rem;
            right: 1rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            opacity: 0;
            transform: translateX(20px);
            transition: var(--transition);
        }
        
        .modern-product-card:hover .product-actions {
            opacity: 1;
            transform: translateX(0);
        }
        
        .action-btn {
            width: 40px;
            height: 40px;
            background: white;
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            color: var(--text-body);
            cursor: pointer;
        }
        
        .action-btn:hover {
            background: var(--gold);
            color: white;
            transform: scale(1.1);
        }
        
        .action-btn.wishlist-active {
            background: #e74c3c;
            color: white;
        }
        
        .quick-add-btn {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: var(--dark);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
            transform: translateY(100%);
            transition: var(--transition);
        }
        
        .modern-product-card:hover .quick-add-btn {
            transform: translateY(0);
        }
        
        .quick-add-btn:hover {
            background: var(--gold);
            color: white;
        }
        
        .product-details {
            padding: 1.5rem;
        }
        
        .product-category {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }
        
        .product-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.75rem;
            line-height: 1.3;
        }
        
        .product-name a {
            color: inherit;
            text-decoration: none;
        }
        
        .product-name a:hover {
            color: var(--gold);
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.75rem;
        }
        
        .rating-stars {
            color: #ffc107;
            font-size: 0.9rem;
        }
        
        .rating-count {
            color: var(--text-muted);
            font-size: 0.8rem;
        }
        
        .product-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--gold-dark);
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-sm);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: var(--gold);
            margin-bottom: 1.5rem;
        }
        
        .empty-state h4 {
            color: var(--text-dark);
            margin-bottom: 1rem;
        }
        
        .empty-state p {
            color: var(--text-muted);
            margin-bottom: 2rem;
        }
        
        .search-tips {
            background: white;
            border-radius: var(--radius-xl);
            padding: 2rem;
            margin-top: 2rem;
            box-shadow: var(--shadow-sm);
        }
        
        .search-tips h5 {
            color: var(--text-dark);
            margin-bottom: 1rem;
        }
        
        .search-tips ul {
            color: var(--text-body);
            margin: 0;
        }
        
        /* Responsive */
        @media (max-width: 767.98px) {
            .search-hero {
                padding: 2rem 0;
            }
            
            .search-hero h1 {
                font-size: 2rem;
            }
            
            .modern-product-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
            }
            
            .search-input-group {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .search-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <!-- Search Hero Section -->
    <div class="search-hero" data-aos="fade-down">
        <div class="container">
            <div class="text-center">
                <h1><i class="bi bi-search me-3"></i>Tìm Kiếm Sản Phẩm</h1>
                <p>Khám phá bộ sưu tập thời trang đa dạng của chúng tôi</p>
                
                <form class="modern-search-form" action="${pageContext.request.contextPath}/search" method="GET">
                    <div class="search-input-group d-flex">
                        <input type="text" name="q" class="search-input" 
                               placeholder="Tìm kiếm áo, quần, váy..." 
                               value="${keyword}" autofocus>
                        <button type="submit" class="search-btn">
                            <i class="bi bi-search me-2"></i>Tìm Kiếm
                        </button>
                    </div>
                </form>
                
                <div class="search-suggestions">
                    <small class="text-white-50 d-block mb-2">Gợi ý tìm kiếm:</small>
                    <a href="${pageContext.request.contextPath}/search?q=áo" class="suggestion-tag">Áo</a>
                    <a href="${pageContext.request.contextPath}/search?q=quần" class="suggestion-tag">Quần</a>
                    <a href="${pageContext.request.contextPath}/search?q=váy" class="suggestion-tag">Váy</a>
                    <a href="${pageContext.request.contextPath}/search?q=đầm" class="suggestion-tag">Đầm</a>
                    <a href="${pageContext.request.contextPath}/search?q=áo khoác" class="suggestion-tag">Áo Khoác</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Search Results -->
    <div class="search-results">
        <div class="container">
            <c:choose>
                <c:when test="${not empty keyword}">
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="empty-state" data-aos="fade-up">
                                <i class="bi bi-search"></i>
                                <h4>Không tìm thấy kết quả</h4>
                                <p>Không có sản phẩm nào phù hợp với từ khóa "<strong>${keyword}</strong>"</p>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-gold">
                                    <i class="bi bi-grid me-2"></i>Xem Tất Cả Sản Phẩm
                                </a>
                            </div>
                            
                            <div class="search-tips" data-aos="fade-up" data-aos-delay="200">
                                <h5><i class="bi bi-lightbulb me-2"></i>Gợi ý tìm kiếm</h5>
                                <ul>
                                    <li>Kiểm tra lại chính tả từ khóa</li>
                                    <li>Thử sử dụng từ khóa ngắn gọn hơn</li>
                                    <li>Tìm kiếm theo loại sản phẩm: áo, quần, váy...</li>
                                    <li>Duyệt qua các danh mục sản phẩm</li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="results-header" data-aos="fade-up">
                                <p class="results-info">
                                    Tìm thấy <strong>${products.size()}</strong> kết quả cho "<strong>${keyword}</strong>"
                                </p>
                            </div>
                            
                            <div class="modern-product-grid">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <div class="modern-product-card" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                                        <div class="product-image-container">
                                            <img src="${not empty product.thumbnailUrl ? pageContext.request.contextPath.concat(product.thumbnailUrl) : 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400'}" 
                                                 alt="${product.name}">
                                            
                                            <div class="product-actions">
                                                <button class="action-btn wishlist-btn" 
                                                        onclick="toggleWishlist(${product.id}, this)" 
                                                        title="Thêm vào yêu thích">
                                                    <i class="bi bi-heart"></i>
                                                </button>
                                                <a href="${pageContext.request.contextPath}/product?id=${product.id}" 
                                                   class="action-btn" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                            </div>
                                            
                                            <button class="quick-add-btn" onclick="quickAddToCart(${product.id})">
                                                <i class="bi bi-cart-plus me-2"></i>Thêm Vào Giỏ
                                            </button>
                                        </div>
                                        
                                        <div class="product-details">
                                            <div class="product-category">${product.categoryName}</div>
                                            <h5 class="product-name">
                                                <a href="${pageContext.request.contextPath}/product?id=${product.id}">${product.name}</a>
                                            </h5>
                                            <div class="product-rating">
                                                <div class="rating-stars">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-half"></i>
                                                </div>
                                                <span class="rating-count">(${status.index * 5 + 12})</span>
                                            </div>
                                            <div class="product-price">
                                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" data-aos="fade-up">
                        <i class="bi bi-lightbulb"></i>
                        <h4>Bắt Đầu Tìm Kiếm</h4>
                        <p>Nhập tên sản phẩm, thương hiệu hoặc loại sản phẩm bạn muốn tìm</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-gold">
                            <i class="bi bi-grid me-2"></i>Duyệt Tất Cả Sản Phẩm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <!-- Bootstrap 5.3.3 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- AOS Animation -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true,
            offset: 100
        });
        
        // Wishlist functionality
        function toggleWishlist(productId, button) {
            const icon = button.querySelector('i');
            const isActive = button.classList.contains('wishlist-active');
            
            if (isActive) {
                button.classList.remove('wishlist-active');
                icon.classList.remove('bi-heart-fill');
                icon.classList.add('bi-heart');
                showToast('Đã xóa khỏi danh sách yêu thích', 'info');
            } else {
                button.classList.add('wishlist-active');
                icon.classList.remove('bi-heart');
                icon.classList.add('bi-heart-fill');
                showToast('Đã thêm vào danh sách yêu thích', 'success');
                
                // Add heart animation
                button.style.transform = 'scale(1.3)';
                setTimeout(() => {
                    button.style.transform = 'scale(1)';
                }, 200);
            }
            
            // Here you would typically make an AJAX call to update the wishlist
            // fetch('/wishlist/toggle', { method: 'POST', body: JSON.stringify({productId}) })
        }
        
        // Quick add to cart - Uses real AJAX API
        function quickAddToCart(productId) {
            const button = event.target.closest('.quick-add-btn');
            const originalText = button.innerHTML;
            
            // Show loading state
            button.innerHTML = '<i class="bi bi-arrow-repeat spin me-2"></i>Đang thêm...';
            button.disabled = true;
            
            // Get context path
            const contextPath = '${pageContext.request.contextPath}';
            
            // Make AJAX request to add to cart
            fetch(contextPath + '/cart/add?id=' + productId + '&ajax=true', {
                method: 'GET',
                headers: { 'Accept': 'application/json' }
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    button.innerHTML = '<i class="bi bi-check me-2"></i>Đã thêm!';
                    button.style.background = '#28a745';
                    showToast(data.message || 'Sản phẩm đã được thêm vào giỏ hàng', 'success');
                    
                    // Update cart badge if available
                    if (data.totalItems) {
                        const cartBadge = document.querySelector('#cart-count');
                        if (cartBadge) {
                            cartBadge.textContent = data.totalItems;
                        }
                    }
                } else if (data.requireLogin) {
                    // Redirect to login
                    window.location.href = contextPath + '/login';
                    return;
                } else {
                    button.innerHTML = '<i class="bi bi-x me-2"></i>Lỗi!';
                    button.style.background = '#dc3545';
                    showToast(data.message || 'Có lỗi xảy ra', 'error');
                }
                
                // Reset button after 2 seconds
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.style.background = '';
                    button.disabled = false;
                }, 2000);
            })
            .catch(error => {
                console.error('Add to cart error:', error);
                button.innerHTML = originalText;
                button.style.background = '';
                button.disabled = false;
                showToast('Có lỗi xảy ra. Vui lòng thử lại.', 'error');
            });
        }
        
        // Toast notification function
        function showToast(message, type = 'info') {
            const toast = document.createElement('div');
            const alertType = type === 'success' ? 'success' : type === 'error' ? 'danger' : 'info';
            const iconType = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle';
            toast.className = 'alert alert-' + alertType + ' position-fixed';
            toast.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 300px;';
            toast.innerHTML = '<i class="bi bi-' + iconType + ' me-2"></i>' + message;
            
            document.body.appendChild(toast);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                toast.remove();
            }, 3000);
        }
        
        // Spin animation
        const style = document.createElement('style');
        style.textContent = `
            .spin {
                animation: spin 1s linear infinite;
            }
            @keyframes spin {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
