<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Clothing Shop - Thời trang cao cấp, phong cách hiện đại">
    <title>Clothing Shop - Thời Trang Cao Cấp</title>
    
    <!-- Google Fonts - Hỗ trợ tiếng Việt -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&family=Montserrat:wght@300;400;500;600;700&display=swap&subset=vietnamese" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="includes/header.jsp" />

    <!-- Hero Section / Banner -->
    <section class="hero-section">
        <div class="hero-bg-image"></div>
        <div class="hero-overlay"></div>
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-lg-8 col-xl-7">
                    <div class="hero-content">
                        <span class="hero-badge">BỘ SƯU TẬP MÙA THU 2024</span>
                        <h1 class="hero-title">
                            <span class="title-line">Phong Cách</span>
                            <span class="title-line">Thời Thượng</span>
                        </h1>
                        <p class="hero-description">
                            Khám phá những thiết kế độc bản, mang đậm dấu ấn cá nhân và 
                            sự tinh tế trong từng đường kim mũi chỉ.
                        </p>
                        <div class="hero-buttons">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary-custom">
                                MUA NGAY
                            </a>
                            <a href="${pageContext.request.contextPath}/about" class="btn btn-outline-custom">
                                <i class="bi bi-play-circle me-2"></i>GIỚI THIỆU
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section class="featured-products py-5">
        <div class="container">
            <!-- Section Header -->
            <div class="section-header text-center mb-5">
                <span class="section-badge">SẢN PHẨM NỔI BẬT</span>
                <h2 class="section-title">Xu Hướng Mới Nhất</h2>
                <p class="section-description">
                    Khám phá những thiết kế được yêu thích nhất từ bộ sưu tập mới nhất của chúng tôi
                </p>
            </div>

            <!-- Products Grid -->
            <div class="row g-4">
                <c:forEach begin="1" end="8" var="p">
                    <div class="col-xl-3 col-lg-4 col-md-6">
                        <div class="product-card">
                            <!-- Product Badge -->
                            <c:if test="${p % 3 == 0}">
                                <span class="product-badge badge-sale">-${p}0%</span>
                            </c:if>
                            <c:if test="${p % 4 == 0}">
                                <span class="product-badge badge-new">Mới</span>
                            </c:if>
                            <c:if test="${p == 1}">
                                <span class="product-badge badge-hot">Hot</span>
                            </c:if>
                            
                            <!-- Product Image -->
                            <div class="product-image-wrapper">
                                <img src="https://picsum.photos/400/500?random=${p}" 
                                     alt="Sản phẩm mẫu ${p}" 
                                     class="product-image">
                                
                                <!-- Quick Actions -->
                                <div class="product-actions">
                                    <button class="action-btn" title="Yêu thích">
                                        <i class="bi bi-heart"></i>
                                    </button>
                                    <button class="action-btn" title="Xem nhanh">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="action-btn" title="So sánh">
                                        <i class="bi bi-arrow-left-right"></i>
                                    </button>
                                </div>
                                
                                <!-- Add to Cart Button -->
                                <a href="${pageContext.request.contextPath}/cart/add?id=${p}" 
                                   class="btn-add-cart">
                                    <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ
                                </a>
                            </div>
                            
                            <!-- Product Info -->
                            <div class="product-info">
                                <div class="product-category">
                                    <c:choose>
                                        <c:when test="${p % 3 == 0}">Áo Thun</c:when>
                                        <c:when test="${p % 3 == 1}">Quần Jeans</c:when>
                                        <c:otherwise>Váy Đầm</c:otherwise>
                                    </c:choose>
                                </div>
                                <h5 class="product-title">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p}">
                                        Sản phẩm mẫu ${p}
                                    </a>
                                </h5>
                                <div class="product-rating">
                                    <c:forEach begin="1" end="5" var="star">
                                        <c:choose>
                                            <c:when test="${star <= (5 - p % 2)}">
                                                <i class="bi bi-star-fill"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <span class="rating-count">(${p * 12})</span>
                                </div>
                                <div class="product-price">
                                    <span class="current-price">${p}99.000 đ</span>
                                    <c:if test="${p % 3 == 0}">
                                        <span class="original-price">${p + 2}99.000 đ</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- View All Button -->
            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-view-all">
                    Xem Tất Cả Sản Phẩm
                    <i class="bi bi-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="categories-section py-5 bg-light-custom">
        <div class="container">
            <div class="section-header text-center mb-5">
                <span class="section-badge">DANH MỤC</span>
                <h2 class="section-title">Mua Sắm Theo Danh Mục</h2>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="category-card">
                        <img src="https://picsum.photos/600/400?random=10" alt="Nam">
                        <div class="category-overlay">
                            <h3>Thời Trang Nam</h3>
                            <a href="${pageContext.request.contextPath}/category/men" class="btn btn-category">
                                Khám Phá <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="category-card">
                        <img src="https://picsum.photos/600/400?random=11" alt="Nữ">
                        <div class="category-overlay">
                            <h3>Thời Trang Nữ</h3>
                            <a href="${pageContext.request.contextPath}/category/women" class="btn btn-category">
                                Khám Phá <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12">
                    <div class="category-card">
                        <img src="https://picsum.photos/600/400?random=12" alt="Phụ kiện">
                        <div class="category-overlay">
                            <h3>Phụ Kiện</h3>
                            <a href="${pageContext.request.contextPath}/category/accessories" class="btn btn-category">
                                Khám Phá <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-truck"></i>
                        </div>
                        <h5>Miễn Phí Vận Chuyển</h5>
                        <p>Cho đơn hàng từ 500K</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </div>
                        <h5>Đổi Trả Dễ Dàng</h5>
                        <p>Trong vòng 30 ngày</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <h5>Thanh Toán An Toàn</h5>
                        <p>Bảo mật 100%</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-headset"></i>
                        </div>
                        <h5>Hỗ Trợ 24/7</h5>
                        <p>Luôn sẵn sàng giúp đỡ</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section py-5">
        <div class="container">
            <div class="newsletter-wrapper">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h3>Đăng Ký Nhận Tin</h3>
                        <p>Nhận ngay ưu đãi 20% cho đơn hàng đầu tiên và cập nhật xu hướng mới nhất</p>
                    </div>
                    <div class="col-lg-6">
                        <form class="newsletter-form">
                            <div class="input-group">
                                <input type="email" class="form-control" placeholder="Nhập email của bạn...">
                                <button class="btn btn-subscribe" type="submit">
                                    Đăng Ký <i class="bi bi-send ms-2"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer Include -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>