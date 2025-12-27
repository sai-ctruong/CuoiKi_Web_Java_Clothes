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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,500;1,500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages.css">
    
    <style>
        body {
            padding-top: 70px; /* Match header height */
        }
        
        .products-page {
            min-height: calc(100vh - 70px);
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="mb-2">
                <i class="bi bi-grid me-2"></i>
                <c:choose>
                    <c:when test="${not empty currentCategory}">${currentCategory.name}</c:when>
                    <c:otherwise>Tất Cả Sản Phẩm</c:otherwise>
                </c:choose>
            </h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-gold">Trang chủ</a></li>
                    <li class="breadcrumb-item active text-white-50">Sản phẩm</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="products-page py-4">
        <div class="container">
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
                    <div class="filter-sidebar shadow-sm">
                        <h5 class="filter-title"><i class="bi bi-funnel me-2"></i>Danh Mục</h5>
                        <ul class="filter-list">
                            <li>
                                <a href="${pageContext.request.contextPath}/products" class="${empty currentCategory ? 'active fw-bold' : ''}">
                                    <i class="bi bi-grid-3x3-gap me-2"></i>Tất cả
                                </a>
                            </li>
                            <c:forEach var="cat" items="${categories}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/category?id=${cat.id}" 
                                       class="${currentCategory.id == cat.id ? 'active fw-bold' : ''}">
                                        ${cat.name}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                
                <!-- Products -->
                <div class="col-lg-9">
                    <!-- Toolbar -->
                    <div class="d-flex justify-content-between align-items-center mb-4 p-3 bg-white rounded shadow-sm">
                        <p class="mb-0 text-muted">
                            <c:choose>
                                <c:when test="${not empty products}">
                                    Hiển thị <strong>${products.size()}</strong> sản phẩm
                                </c:when>
                                <c:otherwise>Không tìm thấy sản phẩm</c:otherwise>
                            </c:choose>
                        </p>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary btn-sm dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="bi bi-sort-down me-1"></i>Sắp xếp
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#">Mới nhất</a></li>
                                <li><a class="dropdown-item" href="#">Giá thấp → cao</a></li>
                                <li><a class="dropdown-item" href="#">Giá cao → thấp</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="text-center py-5 bg-white rounded shadow-sm">
                                <i class="bi bi-inbox display-1 text-muted"></i>
                                <h4 class="mt-3">Không có sản phẩm</h4>
                                <p class="text-muted">Chưa có sản phẩm nào trong danh mục này.</p>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-gold">
                                    <i class="bi bi-arrow-left me-2"></i>Xem Tất Cả
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="product-grid">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <div class="product-card">
                                        <c:if test="${status.index % 4 == 0}">
                                            <span class="product-badge badge-hot">Hot</span>
                                        </c:if>
                                        
                                        <div class="product-img-wrapper">
                                            <img src="${not empty product.thumbnailUrl ? pageContext.request.contextPath.concat(product.thumbnailUrl) : 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400'}" 
                                                 alt="${product.name}" class="product-img">
                                            <div class="product-actions">
                                                <button class="action-btn wishlist-btn" 
                                                        onclick="toggleWishlist('${product.id}', this)" 
                                                        title="Thêm vào yêu thích">
                                                    <i class="bi bi-heart"></i>
                                                </button>
                                                <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="action-btn" title="Xem chi tiết"><i class="bi bi-eye"></i></a>
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
                                            <div class="d-flex align-items-center gap-2 mb-2">
                                                <div class="text-warning">
                                                    <i class="bi bi-star-fill small"></i>
                                                    <i class="bi bi-star-fill small"></i>
                                                    <i class="bi bi-star-fill small"></i>
                                                    <i class="bi bi-star-fill small"></i>
                                                    <i class="bi bi-star-half small"></i>
                                                </div>
                                                <small class="text-muted">(${status.index * 8 + 20})</small>
                                            </div>
                                            <div class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    
    <script>
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
            
            // Here you would make an AJAX call to update the wishlist
            // fetch('/wishlist/toggle', { method: 'POST', body: JSON.stringify({productId}) })
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
    </script>
    
    <style>
        .wishlist-active {
            background: #e74c3c !important;
            color: white !important;
        }
        
        .wishlist-btn {
            transition: all 0.3s ease;
        }
        
        .wishlist-btn:hover {
            transform: scale(1.1);
        }
    </style>
</body>
</html>
