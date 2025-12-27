<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${product.name}"/> - Clothing Shop</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
</head>
<body>
    <jsp:include page="/includes/header.jsp" />
    
    <!-- Breadcrumb -->
    <div class="breadcrumb-section">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="bi bi-house"></i> Trang Chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản Phẩm</a></li>
                    <li class="breadcrumb-item active"><c:out value="${product.name}"/></li>
                </ol>
            </nav>
        </div>
    </div>
    
    <!-- Product Detail Main -->
    <section class="product-detail-section">
        <div class="container">
            <!-- Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i><c:out value="${sessionScope.successMessage}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i><c:out value="${sessionScope.errorMessage}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>
            
            <div class="row g-5">
                <!-- Product Gallery - Left -->
                <div class="col-lg-6">
                    <div class="product-gallery">
                        <!-- Main Image -->
                        <div class="main-image-box">
                            <div class="product-badge-wrapper">
                                <span class="badge-new">Mới</span>
                            </div>
                            <button class="wishlist-btn" onclick="toggleWishlist(${product.id}, this)">
                                <i class="bi bi-heart"></i>
                            </button>
                            <img id="mainImage" 
                                 src="${pageContext.request.contextPath}${product.thumbnailUrl != null ? product.thumbnailUrl : '/assets/images/placeholder.jpg'}" 
                                 alt="<c:out value='${product.name}'/>" 
                                 class="main-image">
                        </div>
                        
                        <!-- Thumbnails -->
                        <div class="thumbnails-row">
                            <div class="thumbnail-item active" onclick="changeMainImage(this)">
                                <img src="${pageContext.request.contextPath}${product.thumbnailUrl != null ? product.thumbnailUrl : '/assets/images/placeholder.jpg'}" alt="Hình chính">
                            </div>
                            <div class="thumbnail-item" onclick="changeMainImage(this)">
                                <img src="https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=200&q=80" alt="Chi tiết 1">
                            </div>
                            <div class="thumbnail-item" onclick="changeMainImage(this)">
                                <img src="https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=200&q=80" alt="Chi tiết 2">
                            </div>
                            <div class="thumbnail-item" onclick="changeMainImage(this)">
                                <img src="https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=200&q=80" alt="Chi tiết 3">
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Product Info - Right -->
                <div class="col-lg-6">
                    <div class="product-info">
                        <!-- Category & Title -->
                        <div class="product-meta">
                            <span class="product-category">Thời Trang</span>
                            <h1 class="product-title"><c:out value="${product.name}"/></h1>
                        </div>
                        
                        <!-- Rating -->
                        <div class="product-rating">
                            <div class="stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= avgRating}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:when>
                                        <c:when test="${i - 0.5 <= avgRating}">
                                            <i class="bi bi-star-half"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <span class="rating-text">
                                <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/> 
                                <span class="divider">|</span> 
                                ${reviewCount} Đánh giá
                            </span>
                        </div>
                        
                        <!-- Price -->
                        <div class="product-price-box">
                            <span class="price-label">Giá:</span>
                            <span class="price-value"><fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>₫</span>
                        </div>
                        
                        <!-- Description -->
                        <div class="product-desc">
                            <p><c:out value="${product.description}"/></p>
                        </div>
                        
                        <!-- Options Form -->
                        <form action="${pageContext.request.contextPath}/cart/add" method="POST" class="product-form" id="productForm">
                            <input type="hidden" name="productId" value="${product.id}">
                            
                            <!-- Color -->
                            <div class="option-group">
                                <label class="option-label">Màu sắc:</label>
                                <div class="color-options">
                                    <label class="color-item" title="Đen">
                                        <input type="radio" name="color" value="black" checked>
                                        <span class="color-circle" style="background: #1a1a1a;"></span>
                                    </label>
                                    <label class="color-item" title="Trắng">
                                        <input type="radio" name="color" value="white">
                                        <span class="color-circle" style="background: #ffffff; border: 1px solid #ddd;"></span>
                                    </label>
                                    <label class="color-item" title="Navy">
                                        <input type="radio" name="color" value="navy">
                                        <span class="color-circle" style="background: #1e3a5f;"></span>
                                    </label>
                                    <label class="color-item" title="Nâu">
                                        <input type="radio" name="color" value="brown">
                                        <span class="color-circle" style="background: #8b5a2b;"></span>
                                    </label>
                                    <label class="color-item" title="Be">
                                        <input type="radio" name="color" value="beige">
                                        <span class="color-circle" style="background: #d4c4a8;"></span>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Size -->
                            <div class="option-group">
                                <label class="option-label">Kích thước:</label>
                                <div class="size-options">
                                    <label class="size-item">
                                        <input type="radio" name="size" value="S" required>
                                        <span>S</span>
                                    </label>
                                    <label class="size-item">
                                        <input type="radio" name="size" value="M" checked required>
                                        <span>M</span>
                                    </label>
                                    <label class="size-item">
                                        <input type="radio" name="size" value="L" required>
                                        <span>L</span>
                                    </label>
                                    <label class="size-item">
                                        <input type="radio" name="size" value="XL" required>
                                        <span>XL</span>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Quantity -->
                            <div class="option-group">
                                <label class="option-label">Số lượng:</label>
                                <div class="qty-selector">
                                    <button type="button" class="qty-btn" onclick="changeQty(-1)">
                                        <i class="bi bi-dash"></i>
                                    </button>
                                    <input type="number" name="quantity" id="qtyInput" value="1" min="1" max="99" readonly>
                                    <button type="button" class="qty-btn" onclick="changeQty(1)">
                                        <i class="bi bi-plus"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="action-buttons">
                                <button type="submit" class="btn-cart">
                                    <i class="bi bi-bag-plus"></i>
                                    Thêm vào giỏ hàng
                                </button>
                                <button type="button" class="btn-buy" onclick="buyNow()">
                                    <i class="bi bi-lightning-fill"></i>
                                    Mua ngay
                                </button>
                            </div>
                        </form>
                        
                        <!-- Features -->
                        <div class="product-features">
                            <div class="feature">
                                <i class="bi bi-truck"></i>
                                <span>Miễn phí giao hàng</span>
                            </div>
                            <div class="feature">
                                <i class="bi bi-arrow-repeat"></i>
                                <span>Đổi trả 7 ngày</span>
                            </div>
                            <div class="feature">
                                <i class="bi bi-shield-check"></i>
                                <span>Bảo hành chính hãng</span>
                            </div>
                            <div class="feature">
                                <i class="bi bi-headset"></i>
                                <span>Hỗ trợ 24/7</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reviews Section -->
            <div class="reviews-section mt-5">
                <div class="reviews-header">
                    <h3 class="section-title">
                        <i class="bi bi-chat-quote me-2"></i>Đánh Giá Sản Phẩm
                        <span class="review-count">(${reviewCount} đánh giá)</span>
                    </h3>
                </div>
                
                <!-- Review Summary -->
                <div class="review-summary mb-4">
                    <div class="row align-items-center">
                        <div class="col-md-4 text-center">
                            <div class="avg-rating-display">
                                <span class="big-rating"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></span>
                                <span class="out-of">/5</span>
                            </div>
                            <div class="stars-display mb-2">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= avgRating}">
                                            <i class="bi bi-star-fill text-warning"></i>
                                        </c:when>
                                        <c:when test="${i - 0.5 <= avgRating}">
                                            <i class="bi bi-star-half text-warning"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star text-warning"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <p class="text-muted mb-0">${reviewCount} đánh giá</p>
                        </div>
                        <div class="col-md-8">
                            <!-- Write Review Form -->
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <div class="alert alert-info">
                                        <i class="bi bi-info-circle me-2"></i>
                                        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để đánh giá sản phẩm này.
                                    </div>
                                </c:when>
                                <c:when test="${hasReviewed}">
                                    <div class="alert alert-success">
                                        <i class="bi bi-check-circle me-2"></i>
                                        Bạn đã đánh giá sản phẩm này. Cảm ơn bạn!
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="write-review-box">
                                        <h5><i class="bi bi-pencil-square me-2"></i>Viết Đánh Giá</h5>
                                        <form action="${pageContext.request.contextPath}/review" method="POST" id="reviewForm">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            
                                            <div class="mb-3">
                                                <label class="form-label">Đánh giá của bạn:</label>
                                                <div class="star-rating-input">
                                                    <input type="radio" name="rating" value="5" id="star5" required>
                                                    <label for="star5" title="5 sao"><i class="bi bi-star-fill"></i></label>
                                                    <input type="radio" name="rating" value="4" id="star4">
                                                    <label for="star4" title="4 sao"><i class="bi bi-star-fill"></i></label>
                                                    <input type="radio" name="rating" value="3" id="star3">
                                                    <label for="star3" title="3 sao"><i class="bi bi-star-fill"></i></label>
                                                    <input type="radio" name="rating" value="2" id="star2">
                                                    <label for="star2" title="2 sao"><i class="bi bi-star-fill"></i></label>
                                                    <input type="radio" name="rating" value="1" id="star1">
                                                    <label for="star1" title="1 sao"><i class="bi bi-star-fill"></i></label>
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label for="comment" class="form-label">Nhận xét:</label>
                                                <textarea class="form-control" name="comment" id="comment" rows="3" 
                                                    placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
                                            </div>
                                            
                                            <button type="submit" class="btn btn-gold">
                                                <i class="bi bi-send me-2"></i>Gửi Đánh Giá
                                            </button>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <!-- Reviews List -->
                <div class="reviews-list">
                    <c:choose>
                        <c:when test="${empty reviews}">
                            <div class="no-reviews text-center py-4">
                                <i class="bi bi-chat-dots display-4 text-muted"></i>
                                <p class="text-muted mt-2">Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="review" items="${reviews}">
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="reviewer-info">
                                            <div class="reviewer-avatar">
                                                ${review.user.fullName.charAt(0)}
                                            </div>
                                            <div>
                                                <strong class="reviewer-name">${review.user.fullName}</strong>
                                                <div class="review-meta">
                                                    <span class="review-stars">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="bi bi-star${i <= review.rating ? '-fill' : ''} text-warning"></i>
                                                        </c:forEach>
                                                    </span>
                                                    <span class="review-date">
                                                        <i class="bi bi-calendar3 me-1"></i>
                                                        <fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="review-content">
                                        <p><c:out value="${review.comment}"/></p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Review Section Styles -->
    <style>
        .reviews-section {
            background: #fff;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #1a1a2e;
        }
        
        .review-count {
            font-size: 1rem;
            font-weight: normal;
            color: #6c757d;
        }
        
        .avg-rating-display {
            font-size: 3rem;
            font-weight: 700;
            color: #1a1a2e;
        }
        
        .avg-rating-display .out-of {
            font-size: 1.5rem;
            color: #6c757d;
        }
        
        .write-review-box {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
        }
        
        .write-review-box h5 {
            margin-bottom: 1rem;
            color: #1a1a2e;
        }
        
        /* Star Rating Input */
        .star-rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 0.25rem;
        }
        
        .star-rating-input input {
            display: none;
        }
        
        .star-rating-input label {
            cursor: pointer;
            font-size: 1.5rem;
            color: #ddd;
            transition: color 0.2s;
        }
        
        .star-rating-input label:hover,
        .star-rating-input label:hover ~ label,
        .star-rating-input input:checked ~ label {
            color: #ffc107;
        }
        
        .btn-gold {
            background: linear-gradient(135deg, #c9a227, #daa520);
            border: none;
            color: #fff;
            padding: 0.6rem 1.5rem;
            font-weight: 500;
        }
        
        .btn-gold:hover {
            background: linear-gradient(135deg, #b8922a, #c9a227);
            color: #fff;
        }
        
        /* Review Items */
        .review-item {
            padding: 1.5rem;
            border-bottom: 1px solid #eee;
        }
        
        .review-item:last-child {
            border-bottom: none;
        }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .reviewer-avatar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #c9a227, #daa520);
            color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .reviewer-name {
            color: #1a1a2e;
        }
        
        .review-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
        
        .review-stars i {
            font-size: 0.85rem;
        }
        
        .review-content {
            margin-top: 1rem;
            padding-left: 60px;
        }
        
        .review-content p {
            color: #555;
            line-height: 1.6;
            margin: 0;
        }
        
        .no-reviews {
            color: #6c757d;
        }
    </style>
    
    <jsp:include page="/includes/footer.jsp" />
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    
    <script>
        // ISOLATED MANUAL DROPDOWN TOGGLE
        document.addEventListener('DOMContentLoaded', function() {
            // Tìm nút user menu
            const userBtn = document.querySelector('.user-menu .dropdown-toggle');
            if (userBtn) {
                // Remove bootstrap trigger để tránh xung đột
                userBtn.removeAttribute('data-bs-toggle');
                
                // Add sự kiện click thủ công
                userBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    const menu = this.nextElementSibling;
                    const isShown = menu.classList.contains('show');
                    
                    // Đóng tất cả menu đang mở
                    document.querySelectorAll('.dropdown-menu.show').forEach(m => {
                        m.classList.remove('show');
                        m.style.display = 'none';
                    });
                    
                    // Toggle menu hiện tại
                    if (!isShown) {
                        menu.classList.add('show');
                        menu.style.display = 'block';
                        // Đảm bảo z-index cao nhất
                        menu.style.zIndex = '99999';
                    }
                });
            }
            
            // Đóng khi click ra ngoài
            document.addEventListener('click', function(e) {
                if (!e.target.closest('.user-menu')) {
                    document.querySelectorAll('.user-menu .dropdown-menu.show').forEach(m => {
                        m.classList.remove('show');
                        m.style.display = 'none';
                    });
                }
            });
        });
    </script>
    
    <script>
        // Header scroll
        window.addEventListener('scroll', function() {
            const header = document.querySelector('.main-header');
            header.classList.toggle('scrolled', window.scrollY > 50);
        });
        
        // Change main image
        function changeMainImage(el) {
            const img = el.querySelector('img');
            document.getElementById('mainImage').src = img.src.replace('w=150', 'w=800');
            document.querySelectorAll('.thumbnail-item').forEach(t => t.classList.remove('active'));
            el.classList.add('active');
        }
        
        // Quantity
        function changeQty(delta) {
            const input = document.getElementById('qtyInput');
            let val = parseInt(input.value) + delta;
            if (val >= 1 && val <= 99) input.value = val;
        }
        
        // Buy now
        function buyNow() {
            const form = document.getElementById('productForm');
            form.action = '${pageContext.request.contextPath}/checkout';
            form.submit();
        }
        
        // Wishlist
        function toggleWishlist(id, btn) {
            const icon = btn.querySelector('i');
            btn.classList.toggle('active');
            icon.classList.toggle('bi-heart');
            icon.classList.toggle('bi-heart-fill');
        }
    </script>
</body>
</html>