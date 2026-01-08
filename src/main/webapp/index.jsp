<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Clothing Shop - Thời trang cao cấp, phong cách hiện đại">
    <title>Clothing Shop - Thời Trang Cao Cấp</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,500;0,600;1,500&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <!-- Messages -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show position-fixed" 
             style="top: 90px; right: 20px; z-index: 9999; min-width: 300px;" role="alert">
            <i class="bi bi-check-circle me-2"></i>${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show position-fixed" 
             style="top: 90px; right: 20px; z-index: 9999; min-width: 300px;" role="alert">
            <i class="bi bi-exclamation-circle me-2"></i>${sessionScope.errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-bg"></div>
        <div class="container">
            <div class="row align-items-center min-vh-100 py-5">
                <div class="col-lg-7">
                    <div class="hero-content">
                        <div class="hero-badge">
                            <i class="bi bi-stars me-2"></i>Bộ Sưu Tập 2026
                        </div>
                        
                        <h1 class="hero-title">
                            Khám Phá<br>
                            <span class="accent font-serif fst-italic">Phong Cách</span><br>
                            Của Bạn
                        </h1>
                        
                        <p class="hero-subtitle">
                            Nơi hội tụ những thiết kế độc đáo, mang đậm dấu ấn cá nhân 
                            và sự tinh tế trong từng đường kim mũi chỉ.
                        </p>
                        
                        <div class="d-flex gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-gold btn-lg px-5">
                                <i class="bi bi-bag me-2"></i>Mua Sắm Ngay
                            </a>
                            <a href="${pageContext.request.contextPath}/about" class="btn btn-outline-light btn-lg px-4">
                                <i class="bi bi-arrow-right me-2"></i>Khám Phá
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-5 d-none d-lg-block">
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="stat-card">
                                <h3>1000+</h3>
                                <p>Sản phẩm cao cấp</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card">
                                <h3>50K+</h3>
                                <p>Khách hàng tin tưởng</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card">
                                <h3>99%</h3>
                                <p>Đánh giá hài lòng</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card">
                                <h3>24/7</h3>
                                <p>Hỗ trợ tận tâm</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-5" id="products">
        <div class="container py-4">
            <div class="section-header">
                <span class="section-badge">Nổi Bật</span>
                <h2 class="section-title">Sản Phẩm Xu Hướng</h2>
                <p class="section-subtitle">Những thiết kế được yêu thích nhất mùa này</p>
            </div>

            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty featuredProducts}">
                        <c:forEach items="${featuredProducts}" var="product" varStatus="status">
                            <div class="product-card">
                                <c:if test="${status.index < 4}">
                                    <c:choose>
                                        <c:when test="${status.index == 0}">
                                            <span class="product-badge badge-bestseller">
                                                <i class="bi bi-fire me-1"></i>Bán Chạy
                                            </span>
                                        </c:when>
                                        <c:when test="${status.index == 1}">
                                            <span class="product-badge badge-new">
                                                <i class="bi bi-star-fill me-1"></i>Mới Nhất
                                            </span>
                                        </c:when>
                                        <c:when test="${status.index == 2}">
                                            <span class="product-badge badge-premium">
                                                <i class="bi bi-gem me-1"></i>Cao Cấp
                                            </span>
                                        </c:when>
                                        <c:when test="${status.index == 3}">
                                            <span class="product-badge badge-limited">
                                                <i class="bi bi-lightning-fill me-1"></i>Giới Hạn
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </c:if>
                                
                                <div class="product-img-wrapper">
                                    <img src="${not empty product.thumbnailUrl ? pageContext.request.contextPath.concat(product.thumbnailUrl) : 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400'}" 
                                         alt="${product.name}" class="product-img">
                                    
                                    <div class="product-actions">
                                        <button class="action-btn" title="Yêu thích"><i class="bi bi-heart"></i></button>
                                        <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="action-btn" title="Xem">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                    </div>
                                    
                                    <button class="btn-add-cart" onclick="addToCart(${product.id})">
                                        <i class="bi bi-bag-plus me-2"></i>Thêm Vào Giỏ
                                    </button>
                                </div>
                                
                                <div class="product-info">
                                    <div class="product-category">${product.categoryName}</div>
                                    <h5 class="product-title">
                                        <a href="${pageContext.request.contextPath}/product?id=${product.id}">${product.name}</a>
                                    </h5>
                                    <div class="d-flex align-items-center gap-2 mb-2">
                                        <div class="text-warning">
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-half small"></i>
                                        </div>
                                        <small class="text-muted">(${status.index * 12 + 18})</small>
                                    </div>
                                    <div class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Demo products when no data -->
                        <c:forEach begin="1" end="8" var="p">
                            <div class="product-card">
                                <c:if test="${p <= 4}">
                                    <c:choose>
                                        <c:when test="${p == 1}">
                                            <span class="product-badge badge-bestseller">
                                                <i class="bi bi-fire me-1"></i>Bán Chạy
                                            </span>
                                        </c:when>
                                        <c:when test="${p == 2}">
                                            <span class="product-badge badge-new">
                                                <i class="bi bi-star-fill me-1"></i>Mới Nhất
                                            </span>
                                        </c:when>
                                        <c:when test="${p == 3}">
                                            <span class="product-badge badge-premium">
                                                <i class="bi bi-gem me-1"></i>Cao Cấp
                                            </span>
                                        </c:when>
                                        <c:when test="${p == 4}">
                                            <span class="product-badge badge-limited">
                                                <i class="bi bi-lightning-fill me-1"></i>Giới Hạn
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </c:if>
                                
                                <div class="product-img-wrapper">
                                    <img src="https://images.unsplash.com/photo-${p == 1 ? '1523381210434-271e8be1f52b' : p == 2 ? '1434389677669-e08b4cac3105' : p == 3 ? '1591047139829-d91aecb6caea' : p == 4 ? '1576566588028-4147f3842f27' : p == 5 ? '1556905055-8f358a7a47b2' : p == 6 ? '1515886657613-9f3515b0c78f' : p == 7 ? '1509631179647-0177331693ae' : '1551488831-00ddcb6c6bd3'}?w=400" 
                                         alt="Product ${p}" class="product-img">
                                    
                                    <div class="product-actions">
                                        <button class="action-btn"><i class="bi bi-heart"></i></button>
                                        <a href="${pageContext.request.contextPath}/product?id=${p}" class="action-btn" title="Xem chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                    </div>
                                    
                                    <button class="btn-add-cart">
                                        <i class="bi bi-bag-plus me-2"></i>Thêm Vào Giỏ
                                    </button>
                                </div>
                                
                                <div class="product-info">
                                    <div class="product-category">Thời Trang</div>
                                    <h5 class="product-title"><a href="#">Premium Collection ${p}</a></h5>
                                    <div class="d-flex align-items-center gap-2 mb-2">
                                        <div class="text-warning">
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-fill small"></i>
                                            <i class="bi bi-star-half small"></i>
                                        </div>
                                        <small class="text-muted">(${p * 15})</small>
                                    </div>
                                    <div class="product-price"><fmt:formatNumber value="${p * 189000}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="text-center mt-5">
                <button type="button" class="btn btn-gold btn-lg px-5" id="btnShowAllProducts" onclick="toggleAllProducts()">
                    Xem Tất Cả Sản Phẩm <i class="bi bi-arrow-down ms-2"></i>
                </button>
            </div>
            
            <!-- All Products Section (Hidden by default) -->
            <div id="allProductsSection" style="display: none; margin-top: 3rem;">
                <div class="section-header">
                    <span class="section-badge">Tất Cả</span>
                    <h2 class="section-title">Toàn Bộ Sản Phẩm</h2>
                </div>
                
                <div class="product-grid">
                    <c:choose>
                        <c:when test="${not empty allProducts}">
                            <c:forEach items="${allProducts}" var="product" varStatus="status">
                                <div class="product-card">
                                    <div class="product-img-wrapper">
                                        <img src="${not empty product.thumbnailUrl ? pageContext.request.contextPath.concat(product.thumbnailUrl) : 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400'}" 
                                             alt="${product.name}" class="product-img">
                                        
                                        <div class="product-actions">
                                            <button class="action-btn" title="Yêu thích"><i class="bi bi-heart"></i></button>
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="action-btn" title="Xem">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </div>
                                        
                                        <button class="btn-add-cart" onclick="addToCart(${product.id})">
                                            <i class="bi bi-bag-plus me-2"></i>Thêm Vào Giỏ
                                        </button>
                                    </div>
                                    
                                    <div class="product-info">
                                        <div class="product-category">${product.categoryName}</div>
                                        <h5 class="product-title">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}">${product.name}</a>
                                        </h5>
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <div class="text-warning">
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-half small"></i>
                                            </div>
                                            <small class="text-muted">(${status.index * 10 + 15})</small>
                                        </div>
                                        <div class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Show products from featuredProducts if allProducts not available -->
                            <c:forEach items="${featuredProducts}" var="product" varStatus="status">
                                <div class="product-card">
                                    <div class="product-img-wrapper">
                                        <img src="${not empty product.thumbnailUrl ? pageContext.request.contextPath.concat(product.thumbnailUrl) : 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400'}" 
                                             alt="${product.name}" class="product-img">
                                        
                                        <div class="product-actions">
                                            <button class="action-btn" title="Yêu thích"><i class="bi bi-heart"></i></button>
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="action-btn" title="Xem">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </div>
                                        
                                        <button class="btn-add-cart" onclick="addToCart(${product.id})">
                                            <i class="bi bi-bag-plus me-2"></i>Thêm Vào Giỏ
                                        </button>
                                    </div>
                                    
                                    <div class="product-info">
                                        <div class="product-category">${product.categoryName}</div>
                                        <h5 class="product-title">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}">${product.name}</a>
                                        </h5>
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <div class="text-warning">
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-fill small"></i>
                                                <i class="bi bi-star-half small"></i>
                                            </div>
                                            <small class="text-muted">(${status.index * 10 + 15})</small>
                                        </div>
                                        <div class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories -->
    <section class="py-5 bg-light">
        <div class="container py-4">
            <div class="section-header">
                <span class="section-badge">Danh Mục</span>
                <h2 class="section-title">Mua Sắm Theo Phong Cách</h2>
            </div>
            
            <div class="row g-4">
                <!-- Main Categories Row -->
                <div class="col-lg-6">
                    <div class="category-card category-card-large">
                        <img src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800" alt="Áo Thun">
                        <div class="category-overlay">
                            <h3 class="text-white font-serif fst-italic">Áo Thun</h3>
                            <p class="text-white-50 mb-3">Phong cách thoải mái, năng động</p>
                            <a href="${pageContext.request.contextPath}/products?id=1" class="btn btn-gold">
                                Khám Phá <i class="bi bi-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="category-card category-card-large">
                        <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=600" alt="Váy Đầm">
                        <div class="category-overlay">
                            <h3 class="text-white font-serif fst-italic">Váy Đầm Thanh Lịch</h3>
                            <p class="text-white-50 mb-3">Nữ tính, quyến rũ mọi hoàn cảnh</p>
                            <a href="${pageContext.request.contextPath}/products?id=4" class="btn btn-gold">
                                Khám Phá <i class="bi bi-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Secondary Categories Row -->
                <div class="col-lg-6 col-md-6">
                    <div class="category-card category-card-medium">
                        <img src="https://images.unsplash.com/photo-1542272604-787c3835535d?w=500" alt="Quần Jean">
                        <div class="category-overlay">
                            <h4 class="text-white font-serif">Quần Jean</h4>
                            <p class="text-white-50 small mb-2">Phong cách trẻ trung, năng động</p>
                            <a href="${pageContext.request.contextPath}/products?id=2" class="btn btn-outline-light btn-sm">
                                Xem Ngay
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="category-card category-card-medium">
                        <img src="https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500" alt="Áo Khoác">
                        <div class="category-overlay">
                            <h4 class="text-white font-serif">Áo Khoác</h4>
                            <p class="text-white-50 small mb-2">Ấm áp, thời thượng cho mọi mùa</p>
                            <a href="${pageContext.request.contextPath}/products?id=3" class="btn btn-outline-light btn-sm">
                                Xem Ngay
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Special Collections -->
                <div class="col-12 mt-4">
                    <div class="row g-3">
                        <div class="col-lg-3 col-md-6">
                            <div class="collection-card">
                                <div class="collection-icon">
                                    <i class="bi bi-star-fill"></i>
                                </div>
                                <h5>Bộ Sưu Tập Mới</h5>
                                <p class="text-muted small">Xu hướng thời trang 2026</p>
                                <a href="${pageContext.request.contextPath}/products" class="stretched-link"></a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="collection-card">
                                <div class="collection-icon">
                                    <i class="bi bi-fire"></i>
                                </div>
                                <h5>Bán Chạy Nhất</h5>
                                <p class="text-muted small">Được yêu thích nhất</p>
                                <a href="${pageContext.request.contextPath}/products" class="stretched-link"></a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="collection-card">
                                <div class="collection-icon">
                                    <i class="bi bi-gem"></i>
                                </div>
                                <h5>Cao Cấp</h5>
                                <p class="text-muted small">Chất lượng premium</p>
                                <a href="${pageContext.request.contextPath}/products" class="stretched-link"></a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="collection-card">
                                <div class="collection-icon">
                                    <i class="bi bi-percent"></i>
                                </div>
                                <h5>Khuyến Mãi</h5>
                                <p class="text-muted small">Giá ưu đãi đặc biệt</p>
                                <a href="${pageContext.request.contextPath}/products" class="stretched-link"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features -->
    <section class="py-5">
        <div class="container py-4">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card h-100">
                        <div class="feature-icon">
                            <i class="bi bi-truck"></i>
                        </div>
                        <h5>Miễn Phí Vận Chuyển</h5>
                        <p>Cho đơn hàng từ 500K</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card h-100">
                        <div class="feature-icon">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </div>
                        <h5>Đổi Trả 30 Ngày</h5>
                        <p>Không cần lý do</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card h-100">
                        <div class="feature-icon">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <h5>Thanh Toán An Toàn</h5>
                        <p>Bảo mật SSL 256-bit</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card h-100">
                        <div class="feature-icon">
                            <i class="bi bi-headset"></i>
                        </div>
                        <h5>Hỗ Trợ 24/7</h5>
                        <p>Tư vấn tận tâm</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter -->
    <section class="newsletter-section" id="newsletter">
        <div class="container">
            <div class="newsletter-box">
                <div class="row align-items-center">
                    <div class="col-lg-6 mb-4 mb-lg-0">
                        <h3 class="newsletter-title">Đăng Ký Nhận Ưu Đãi</h3>
                        <p class="newsletter-text">
                            Nhận ngay <strong class="text-gold">giảm giá 20%</strong> cho đơn hàng đầu tiên.
                        </p>
                    </div>
                    <div class="col-lg-6">
                        <form action="${pageContext.request.contextPath}/newsletter/subscribe" method="post" class="newsletter-form d-flex gap-2">
                            <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn..." required>
                            <button class="btn btn-gold px-4" type="submit">Đăng Ký</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    
    <script>
        // Toggle All Products Section
        function toggleAllProducts() {
            var section = document.getElementById('allProductsSection');
            var button = document.getElementById('btnShowAllProducts');
            var icon = button.querySelector('i');
            
            if (section.style.display === 'none') {
                section.style.display = 'block';
                button.innerHTML = 'Ẩn Bớt Sản Phẩm <i class="bi bi-arrow-up ms-2"></i>';
                // Scroll to the section
                section.scrollIntoView({ behavior: 'smooth', block: 'start' });
            } else {
                section.style.display = 'none';
                button.innerHTML = 'Xem Tất Cả Sản Phẩm <i class="bi bi-arrow-down ms-2"></i>';
            }
        }
    </script>
</body>
</html>