<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản Phẩm - Clothing Shop</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 70px;
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
        }
        
        /* Hero Section */
        .products-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0 60px;
            position: relative;
            overflow: hidden;
        }
        
        .products-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200') center/cover;
            opacity: 0.1;
        }
        
        .products-hero .container {
            position: relative;
            z-index: 2;
        }
        
        .products-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .products-hero .breadcrumb {
            background: rgba(255,255,255,0.1);
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            backdrop-filter: blur(10px);
        }
        
        .products-hero .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        
        .products-hero .breadcrumb-item.active {
            color: white;
        }
        
        /* Filter Sidebar */
        .filter-sidebar {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            position: sticky;
            top: 90px;
            max-height: calc(100vh - 110px);
            overflow-y: auto;
        }
        
        /* Custom scrollbar for filter sidebar */
        .filter-sidebar::-webkit-scrollbar {
            width: 6px;
        }
        
        .filter-sidebar::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }
        
        .filter-sidebar::-webkit-scrollbar-thumb {
            background: var(--gold, #c9a962);
            border-radius: 3px;
        }
        
        .filter-sidebar::-webkit-scrollbar-thumb:hover {
            background: #b8923b;
        }
        
        .filter-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .filter-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .filter-list li {
            margin-bottom: 0.5rem;
        }
        
        .filter-list a {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: #666;
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .filter-list a:hover {
            background: rgba(201, 169, 98, 0.1);
            color: var(--gold);
            transform: translateX(5px);
        }
        
        .filter-list a.active {
            background: linear-gradient(135deg, var(--gold) 0%, #d4af37 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(201, 169, 98, 0.3);
        }
        
        .filter-list a i {
            margin-right: 0.5rem;
            font-size: 1.1rem;
        }
        
        /* Price Filter */
        .price-filter {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid #f8f9fa;
        }
        
        .price-quick-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.5rem;
        }
        
        .price-btn {
            font-size: 0.8rem;
            padding: 0.4rem 0.6rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .price-btn:hover {
            background: var(--gold);
            border-color: var(--gold);
            color: white;
        }
        
        .price-btn.active {
            background: var(--gold);
            border-color: var(--gold);
            color: white;
        }
        
        .custom-price-range {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        
        .price-input-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0.5rem 0;
        }
        
        .price-input-wrapper {
            position: relative;
            flex: 1;
        }
        
        .price-input-wrapper input {
            padding-right: 25px;
            font-size: 0.9rem;
        }
        
        .price-input-wrapper input:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.2rem rgba(201, 169, 98, 0.25);
        }
        
        .price-unit {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 0.8rem;
            pointer-events: none;
        }
        
        .price-separator {
            color: #666;
            font-weight: 500;
        }
        
        .current-filter {
            background: rgba(201, 169, 98, 0.1);
            border: 1px solid var(--gold);
            border-radius: 8px;
            padding: 0.5rem;
            margin-top: 1rem;
            font-size: 0.85rem;
            color: var(--gold);
        }
        
        .current-filter .filter-text {
            font-weight: 500;
        }
        
        .current-filter .clear-filter {
            background: none;
            border: none;
            color: var(--gold);
            font-size: 0.8rem;
            padding: 0;
            margin-left: 0.5rem;
            cursor: pointer;
        }
        
        /* Sort dropdown active state */
        .dropdown-item.active {
            background: var(--gold);
            color: white;
        }
        
        .dropdown-item.active:hover {
            background: var(--gold-dark);
            color: white;
        }
        
        /* Toolbar */
        .products-toolbar {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
        }
        
        .view-toggle {
            display: flex;
            gap: 0.5rem;
        }
        
        .view-btn {
            width: 40px;
            height: 40px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .view-btn.active {
            background: var(--gold);
            color: white;
            border-color: var(--gold);
        }
        
        .view-btn:hover {
            border-color: var(--gold);
            color: var(--gold);
        }
        
        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
        .product-grid.list-view {
            grid-template-columns: 1fr;
        }
        
        .product-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
        }
        
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        
        .product-img-wrapper {
            position: relative;
            overflow: hidden;
            aspect-ratio: 1;
        }
        
        .product-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .product-card:hover .product-img {
            transform: scale(1.1);
        }
        
        .product-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: #e74c3c;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            z-index: 2;
        }
        
        .product-badge.badge-new {
            background: #27ae60;
        }
        
        .product-badge.badge-sale {
            background: #f39c12;
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
            transition: all 0.3s ease;
        }
        
        .product-card:hover .product-actions {
            opacity: 1;
            transform: translateX(0);
        }
        
        .action-btn {
            width: 40px;
            height: 40px;
            background: rgba(255,255,255,0.9);
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .action-btn:hover {
            background: var(--gold);
            color: white;
            transform: scale(1.1);
        }
        
        .wishlist-active {
            background: #e74c3c !important;
            color: white !important;
        }
        
        .btn-add-cart {
            position: absolute;
            bottom: 1rem;
            left: 1rem;
            right: 1rem;
            background: linear-gradient(135deg, var(--gold) 0%, #d4af37 100%);
            color: white;
            border: none;
            padding: 0.75rem;
            border-radius: 12px;
            font-weight: 600;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .product-card:hover .btn-add-cart {
            opacity: 1;
            transform: translateY(0);
        }
        
        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(201, 169, 98, 0.3);
        }
        
        .product-info {
            padding: 1.5rem;
        }
        
        .product-category {
            color: var(--gold);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }
        
        .product-title {
            margin-bottom: 1rem;
        }
        
        .product-title a {
            color: #2c3e50;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .product-title a:hover {
            color: var(--gold);
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .rating-stars {
            color: #ffc107;
        }
        
        .rating-count {
            color: #666;
            font-size: 0.9rem;
        }
        
        .product-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--gold);
        }
        
        /* List View */
        .product-card.list-view {
            display: flex;
            align-items: center;
            padding: 1.5rem;
        }
        
        .product-card.list-view .product-img-wrapper {
            width: 150px;
            height: 150px;
            flex-shrink: 0;
            margin-right: 2rem;
            aspect-ratio: 1;
        }
        
        .product-card.list-view .product-info {
            flex: 1;
            padding: 0;
        }
        
        .product-card.list-view .product-actions {
            position: static;
            opacity: 1;
            transform: none;
            flex-direction: row;
            margin-left: 1rem;
        }
        
        .product-card.list-view .btn-add-cart {
            position: static;
            opacity: 1;
            transform: none;
            margin-left: 1rem;
            width: auto;
            padding: 0.5rem 1rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 1.5rem;
        }
        
        .empty-state h4 {
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        
        .empty-state p {
            color: #666;
            margin-bottom: 2rem;
        }
        
        /* Loading Animation */
        .loading-skeleton {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }
        
        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .products-hero h1 {
                font-size: 2.2rem;
            }
            
            .filter-sidebar {
                margin-bottom: 2rem;
            }
            
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
            }
            
            .products-toolbar {
                flex-direction: column;
                gap: 1rem;
            }
            
            .product-card.list-view {
                flex-direction: column;
                text-align: center;
            }
            
            .product-card.list-view .product-img-wrapper {
                margin-right: 0;
                margin-bottom: 1rem;
            }
            
            .product-card.list-view .product-actions,
            .product-card.list-view .btn-add-cart {
                margin-left: 0;
                margin-top: 1rem;
            }
        }
        
        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .animate-on-scroll {
            animation: fadeInUp 0.6s ease forwards;
        }
        
        /* Filter Animation */
        .filter-animation {
            animation: filterFade 0.5s ease;
        }
        
        @keyframes filterFade {
            0% { opacity: 0.5; transform: scale(0.95); }
            100% { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <!-- Hero Section -->
    <section class="products-hero">
        <div class="container">
            <h1 class="text-center mb-3">
                <c:choose>
                    <c:when test="${not empty currentCategory}">${currentCategory.name}</c:when>
                    <c:otherwise>Bộ Sưu Tập Thời Trang</c:otherwise>
                </c:choose>
            </h1>
            <nav aria-label="breadcrumb" class="d-flex justify-content-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="breadcrumb-item active">Sản phẩm</li>
                </ol>
            </nav>
        </div>
    </section>
    
    <div class="container py-5">
        <!-- Messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="filter-sidebar">
                    <h5 class="filter-title">
                        <i class="bi bi-funnel me-2"></i>Danh Mục
                    </h5>
                    <ul class="filter-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/products" 
                               class="${empty currentCategory ? 'active' : ''}">
                                <i class="bi bi-grid-3x3-gap"></i>Tất cả sản phẩm
                            </a>
                        </li>
                        <c:forEach var="cat" items="${categories}">
                            <li>
                                <a href="${pageContext.request.contextPath}/category?id=${cat.id}" 
                                   class="${currentCategory.id == cat.id ? 'active' : ''}">
                                    <i class="bi bi-tag"></i>${cat.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    
                    <!-- Price Filter -->
                    <div class="price-filter">
                        <h6 class="filter-title">
                            <i class="bi bi-currency-dollar me-2"></i>Khoảng Giá
                        </h6>
                        
                        <!-- Quick Price Buttons -->
                        <div class="price-quick-buttons mb-3">
                            <a href="?minPrice=0&maxPrice=200000${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}" 
                               class="btn btn-outline-secondary btn-sm price-btn ${currentMinPrice == 0 && currentMaxPrice == 200000 ? 'active' : ''}">
                                Dưới 200K
                            </a>
                            <a href="?minPrice=200000&maxPrice=500000${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}" 
                               class="btn btn-outline-secondary btn-sm price-btn ${currentMinPrice == 200000 && currentMaxPrice == 500000 ? 'active' : ''}">
                                200K - 500K
                            </a>
                            <a href="?minPrice=500000&maxPrice=1000000${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}" 
                               class="btn btn-outline-secondary btn-sm price-btn ${currentMinPrice == 500000 && currentMaxPrice == 1000000 ? 'active' : ''}">
                                500K - 1M
                            </a>
                            <a href="?minPrice=1000000${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}" 
                               class="btn btn-outline-secondary btn-sm price-btn ${currentMinPrice == 1000000 && empty currentMaxPrice ? 'active' : ''}">
                                Trên 1M
                            </a>
                        </div>
                        
                        <!-- Custom Price Range -->
                        <div class="custom-price-range">
                            <label class="form-label small text-muted">Hoặc nhập khoảng giá tùy chỉnh:</label>
                            <form method="GET" action="${pageContext.request.contextPath}/products" id="priceFilterForm">
                                <c:if test="${not empty currentCategory}">
                                    <input type="hidden" name="id" value="${currentCategory.id}">
                                </c:if>
                                <div class="price-input-group">
                                    <div class="price-input-wrapper">
                                        <input type="text" placeholder="Từ" name="minPrice" id="priceMin" 
                                               class="form-control form-control-sm" 
                                               value="${not empty currentMinPrice ? currentMinPrice : ''}">
                                        <span class="price-unit">₫</span>
                                    </div>
                                    <span class="price-separator">-</span>
                                    <div class="price-input-wrapper">
                                        <input type="text" placeholder="Đến" name="maxPrice" id="priceMax" 
                                               class="form-control form-control-sm"
                                               value="${not empty currentMaxPrice ? currentMaxPrice : ''}">
                                        <span class="price-unit">₫</span>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-sm w-100 mt-2">
                                    <i class="bi bi-funnel me-1"></i>Áp dụng
                                </button>
                            </form>
                            <a href="${pageContext.request.contextPath}/products${not empty currentCategory ? '?id='.concat(currentCategory.id) : ''}" 
                               class="btn btn-outline-secondary btn-sm w-100 mt-1">
                                <i class="bi bi-x me-1"></i>Xóa bộ lọc
                            </a>
                        </div>
                        
                        <!-- Current Filter Display -->
                        <c:if test="${not empty currentMinPrice || not empty currentMaxPrice}">
                            <div class="current-filter">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="filter-text">
                                        Giá: 
                                        <c:choose>
                                            <c:when test="${not empty currentMinPrice && not empty currentMaxPrice}">
                                                <fmt:formatNumber value="${currentMinPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫ - 
                                                <fmt:formatNumber value="${currentMaxPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                            </c:when>
                                            <c:when test="${not empty currentMinPrice}">
                                                Từ <fmt:formatNumber value="${currentMinPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                            </c:when>
                                            <c:when test="${not empty currentMaxPrice}">
                                                Dưới <fmt:formatNumber value="${currentMaxPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                            </c:when>
                                        </c:choose>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/products${not empty currentCategory ? '?id='.concat(currentCategory.id) : ''}" 
                                       class="clear-filter">
                                        <i class="bi bi-x"></i>
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- Products -->
            <div class="col-lg-9">
                <!-- Toolbar -->
                <div class="products-toolbar d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center gap-3">
                        <p class="mb-0 text-muted">
                            <c:choose>
                                <c:when test="${not empty products}">
                                    Hiển thị <strong>${products.size()}</strong> sản phẩm
                                </c:when>
                                <c:otherwise>Không tìm thấy sản phẩm</c:otherwise>
                            </c:choose>
                        </p>
                        
                        <!-- View Toggle -->
                        <div class="view-toggle">
                            <button class="view-btn active" onclick="toggleView('grid')" title="Lưới">
                                <i class="bi bi-grid"></i>
                            </button>
                            <button class="view-btn" onclick="toggleView('list')" title="Danh sách">
                                <i class="bi bi-list"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Sort Dropdown -->
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="bi bi-sort-down me-1"></i>
                            <c:choose>
                                <c:when test="${currentSort == 'newest'}">Mới nhất</c:when>
                                <c:when test="${currentSort == 'price-asc'}">Giá thấp → cao</c:when>
                                <c:when test="${currentSort == 'price-desc'}">Giá cao → thấp</c:when>
                                <c:when test="${currentSort == 'name'}">Tên A → Z</c:when>
                                <c:when test="${currentSort == 'name-desc'}">Tên Z → A</c:when>
                                <c:otherwise>Sắp xếp</c:otherwise>
                            </c:choose>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item ${empty currentSort ? 'active' : ''}" 
                                   href="?${not empty currentCategory ? 'id='.concat(currentCategory.id) : ''}${not empty currentMinPrice ? '&minPrice='.concat(currentMinPrice) : ''}${not empty currentMaxPrice ? '&maxPrice='.concat(currentMaxPrice) : ''}">
                                <i class="bi bi-list me-2"></i>Mặc định
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item ${currentSort == 'newest' ? 'active' : ''}" 
                                   href="?sort=newest${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}${not empty currentMinPrice ? '&minPrice='.concat(currentMinPrice) : ''}${not empty currentMaxPrice ? '&maxPrice='.concat(currentMaxPrice) : ''}">
                                <i class="bi bi-clock me-2"></i>Mới nhất
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item ${currentSort == 'price-asc' ? 'active' : ''}" 
                                   href="?sort=price-asc${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}${not empty currentMinPrice ? '&minPrice='.concat(currentMinPrice) : ''}${not empty currentMaxPrice ? '&maxPrice='.concat(currentMaxPrice) : ''}">
                                <i class="bi bi-sort-numeric-up me-2"></i>Giá thấp → cao
                            </a></li>
                            <li><a class="dropdown-item ${currentSort == 'price-desc' ? 'active' : ''}" 
                                   href="?sort=price-desc${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}${not empty currentMinPrice ? '&minPrice='.concat(currentMinPrice) : ''}${not empty currentMaxPrice ? '&maxPrice='.concat(currentMaxPrice) : ''}">
                                <i class="bi bi-sort-numeric-down me-2"></i>Giá cao → thấp
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item ${currentSort == 'name' ? 'active' : ''}" 
                                   href="?sort=name${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}${not empty currentMinPrice ? '&minPrice='.concat(currentMinPrice) : ''}${not empty currentMaxPrice ? '&maxPrice='.concat(currentMaxPrice) : ''}">
                                <i class="bi bi-sort-alpha-down me-2"></i>Tên A → Z
                            </a></li>
                            <li><a class="dropdown-item ${currentSort == 'name-desc' ? 'active' : ''}" 
                                   href="?sort=name-desc${not empty currentCategory ? '&id='.concat(currentCategory.id) : ''}${not empty currentMinPrice ? '&minPrice='.concat(currentMinPrice) : ''}${not empty currentMaxPrice ? '&maxPrice='.concat(currentMaxPrice) : ''}">
                                <i class="bi bi-sort-alpha-up me-2"></i>Tên Z → A
                            </a></li>
                        </ul>
                    </div>
                </div>
                
                <!-- Products Grid -->
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="empty-state">
                            <i class="bi bi-inbox"></i>
                            <h4>Không có sản phẩm</h4>
                            <p>Chưa có sản phẩm nào trong danh mục này. Hãy thử tìm kiếm danh mục khác.</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-gold">
                                <i class="bi bi-arrow-left me-2"></i>Xem Tất Cả Sản Phẩm
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="product-grid" id="productGrid">
                            <c:forEach var="product" items="${products}" varStatus="status">
                                <div class="product-card animate-on-scroll" data-price="${product.price}" data-name="${product.name}">
                                    <c:choose>
                                        <c:when test="${status.index % 5 == 0}">
                                            <span class="product-badge">Hot</span>
                                        </c:when>
                                        <c:when test="${status.index % 3 == 0}">
                                            <span class="product-badge badge-new">Mới</span>
                                        </c:when>
                                        <c:when test="${status.index % 4 == 0}">
                                            <span class="product-badge badge-sale">-20%</span>
                                        </c:when>
                                    </c:choose>
                                    
                                    <div class="product-img-wrapper">
                                        <img src="${not empty product.thumbnailUrl ? pageContext.request.contextPath.concat(product.thumbnailUrl) : 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400&h=400&fit=crop'}" 
                                             alt="${product.name}" class="product-img">
                                        
                                        <div class="product-actions">
                                            <button class="action-btn wishlist-btn" 
                                                    onclick="toggleWishlist('${product.id}', this)" 
                                                    title="Thêm vào yêu thích">
                                                <i class="bi bi-heart"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}" 
                                               class="action-btn" title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <button class="action-btn" onclick="quickView('${product.id}')" title="Xem nhanh">
                                                <i class="bi bi-zoom-in"></i>
                                            </button>
                                        </div>
                                        
                                        <button class="btn-add-cart" onclick="addToCart('${product.id}')">
                                            <i class="bi bi-bag-plus me-2"></i>Thêm vào giỏ
                                        </button>
                                    </div>
                                    
                                    <div class="product-info">
                                        <div class="product-category">${product.categoryName}</div>
                                        <h5 class="product-title">
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
                                            <span class="rating-count">(${status.index * 8 + 20})</span>
                                        </div>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    
    <script>
        // View Toggle
        function toggleView(view) {
            const grid = document.getElementById('productGrid');
            const buttons = document.querySelectorAll('.view-btn');
            
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.closest('.view-btn').classList.add('active');
            
            if (view === 'list') {
                grid.classList.add('list-view');
                grid.querySelectorAll('.product-card').forEach(card => {
                    card.classList.add('list-view');
                });
            } else {
                grid.classList.remove('list-view');
                grid.querySelectorAll('.product-card').forEach(card => {
                    card.classList.remove('list-view');
                });
            }
        }
        
        // Sort Products
        function sortProducts(type) {
            const grid = document.getElementById('productGrid');
            const cards = Array.from(grid.querySelectorAll('.product-card'));
            
            cards.sort((a, b) => {
                switch(type) {
                    case 'price-asc':
                        return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                    case 'price-desc':
                        return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
                    case 'name':
                        return a.dataset.name.localeCompare(b.dataset.name);
                    default:
                        return 0;
                }
            });
            
            // Add animation
            grid.style.opacity = '0.5';
            setTimeout(() => {
                cards.forEach(card => grid.appendChild(card));
                grid.style.opacity = '1';
                grid.classList.add('filter-animation');
                setTimeout(() => grid.classList.remove('filter-animation'), 500);
            }, 200);
        }
        
        // Format price inputs as user types
        document.addEventListener('DOMContentLoaded', function() {
            const priceInputs = document.querySelectorAll('#priceMin, #priceMax');
            
            priceInputs.forEach(input => {
                input.addEventListener('input', function() {
                    let value = this.value.replace(/\D/g, '');
                    if (value) {
                        // Format with dots for thousands
                        value = parseInt(value).toLocaleString('vi-VN');
                        this.value = value;
                    }
                });
                
                input.addEventListener('keypress', function(e) {
                    // Only allow numbers
                    if (!/[\d]/.test(e.key) && !['Backspace', 'Delete', 'Tab', 'Enter'].includes(e.key)) {
                        e.preventDefault();
                    }
                });
            });
            
            // Handle form submission - convert formatted numbers back to plain numbers
            const priceForm = document.getElementById('priceFilterForm');
            if (priceForm) {
                priceForm.addEventListener('submit', function(e) {
                    const minInput = document.getElementById('priceMin');
                    const maxInput = document.getElementById('priceMax');
                    
                    // Convert formatted values back to numbers
                    if (minInput.value) {
                        minInput.value = minInput.value.replace(/\./g, '');
                    }
                    if (maxInput.value) {
                        maxInput.value = maxInput.value.replace(/\./g, '');
                    }
                });
            }
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
                
                // Heart animation
                button.style.transform = 'scale(1.3)';
                setTimeout(() => {
                    button.style.transform = 'scale(1)';
                }, 200);
            }
        }
        
        // Quick View
        function quickView(productId) {
            showToast('Tính năng xem nhanh đang được phát triển', 'info');
        }
        
        // Toast notification
        function showToast(message, type = 'info') {
            const toast = document.createElement('div');
            const alertType = type === 'success' ? 'success' : type === 'error' ? 'danger' : 'info';
            const iconType = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle';
            
            toast.className = `alert alert-${alertType} position-fixed`;
            toast.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 300px; animation: slideInRight 0.3s ease;';
            toast.innerHTML = `<i class="bi bi-${iconType} me-2"></i>${message}`;
            
            document.body.appendChild(toast);
            
            setTimeout(() => {
                toast.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
        
        // Scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationDelay = Math.random() * 0.3 + 's';
                    entry.target.classList.add('animate-on-scroll');
                }
            });
        }, observerOptions);
        
        // Observe product cards
        document.querySelectorAll('.product-card').forEach(card => {
            observer.observe(card);
        });
        
        // Add slide animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideInRight {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes slideOutRight {
                from { transform: translateX(0); opacity: 1; }
                to { transform: translateX(100%); opacity: 0; }
            }
        `;
        document.head.appendChild(style);
    </script>
    
    <!-- Bootstrap JS Bundle (Required for dropdowns) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Toast Notifications -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/toast.css">
    <script src="${pageContext.request.contextPath}/assets/js/toast.js"></script>
</body>
</html>
