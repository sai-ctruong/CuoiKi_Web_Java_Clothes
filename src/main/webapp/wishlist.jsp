<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Yêu Thích - Clothing Shop</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages.css">
    <style>body { padding-top: 80px; }</style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <section class="wishlist-section">
        <div class="container">
            <!-- Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <h1 class="wishlist-title">
                <i class="bi bi-heart me-2" style="color: #dc3545;"></i>
                Danh Sách Yêu Thích
                <c:if test="${wishlistCount > 0}">
                    <span class="badge bg-secondary ms-2" style="font-size: 0.875rem;">${wishlistCount}</span>
                </c:if>
            </h1>

            <c:choose>
                <c:when test="${not empty wishlistItems and wishlistItems.size() > 0}">
                    <div class="wishlist-grid">
                        <c:forEach var="item" items="${wishlistItems}">
                            <div class="wishlist-card" data-wishlist-id="${item.id}" data-product-id="${item.product.id}">
                                <div class="wishlist-img">
                                    <img src="${not empty item.product.thumbnailUrl ? pageContext.request.contextPath.concat(item.product.thumbnailUrl) : 'https://via.placeholder.com/300x400'}" 
                                         alt="${item.product.name}">
                                    <button type="button" class="wishlist-remove-btn" 
                                            onclick="removeFromWishlist(${item.product.id}, this)"
                                            title="Xóa khỏi yêu thích">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </div>
                                <div class="wishlist-info">
                                    <div class="wishlist-category">${item.product.categoryName}</div>
                                    <h5 class="wishlist-name">
                                        <a href="${pageContext.request.contextPath}/product?id=${item.product.id}">
                                            ${item.product.name}
                                        </a>
                                    </h5>
                                    <div class="wishlist-price">
                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                    </div>
                                    <button type="button" class="wishlist-btn-add-to-cart" 
                                            onclick="addToCart(${item.product.id})">
                                        <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/products" class="text-decoration-none">
                            <i class="bi bi-arrow-left me-1"></i>Tiếp tục mua sắm
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-wishlist">
                        <i class="bi bi-heart"></i>
                        <h5>Danh sách yêu thích trống</h5>
                        <p>Bạn chưa có sản phẩm nào trong danh sách yêu thích.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-gold" style="width: auto; display: inline-block;">
                            <i class="bi bi-bag me-2"></i>Khám phá sản phẩm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    
    <script>
    const contextPath = '${pageContext.request.contextPath}';
    
    function removeFromWishlist(productId, button) {
        fetch(contextPath + '/wishlist/toggle?productId=' + productId + '&ajax=true', {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                // Remove the card with animation
                const card = button.closest('.wishlist-card');
                card.style.transition = 'all 0.3s ease';
                card.style.opacity = '0';
                card.style.transform = 'scale(0.8)';
                
                setTimeout(() => {
                    card.remove();
                    
                    // Check if wishlist is empty
                    if (document.querySelectorAll('.wishlist-card').length === 0) {
                        location.reload();
                    }
                    
                    // Update badge count
                    const badge = document.querySelector('.wishlist-title .badge');
                    if (badge) {
                        const count = parseInt(badge.textContent) - 1;
                        if (count > 0) {
                            badge.textContent = count;
                        } else {
                            badge.remove();
                        }
                    }
                }, 300);
                
                showToast('Đã xóa khỏi danh sách yêu thích', 'success');
            }
        });
    }
    
    function showToast(message, type) {
        const toast = document.createElement('div');
        toast.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' position-fixed';
        toast.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 280px;';
        toast.innerHTML = '<i class="bi bi-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + ' me-2"></i>' + message;
        document.body.appendChild(toast);
        setTimeout(() => { toast.remove(); }, 2500);
    }
    </script>
</body>
</html>
