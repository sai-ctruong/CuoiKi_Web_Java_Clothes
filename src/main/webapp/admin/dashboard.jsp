<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Clothing Shop</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="admin-main">
            <!-- Top Bar -->
            <header class="admin-header">
                <div class="header-left">
                    <button class="btn btn-link sidebar-toggle d-lg-none">
                        <span style="font-size: 1.5rem;">☰</span>
                    </button>
                    <h4 class="page-title mb-0">
                        Dashboard
                    </h4>
                </div>
                <div class="header-right">
                    <div class="dropdown">
                        <button class="btn btn-link dropdown-toggle user-dropdown" data-bs-toggle="dropdown">
                            <div class="user-avatar">
                                ${sessionScope.user.fullName.charAt(0)}
                            </div>
                            <span class="d-none d-md-inline fw-medium">${sessionScope.user.fullName}</span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home">
                                Về trang chủ
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                Đăng xuất
                            </a></li>
                        </ul>
                    </div>
                </div>
            </header>
            
            <!-- Content -->
            <main class="admin-content">
                <!-- Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>
                
                <!-- Welcome Card -->
                <div class="welcome-card mb-4">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <h2>Xin chào, ${sessionScope.user.fullName}!</h2>
                            <p class="mb-0 opacity-90">Chào mừng bạn quay trở lại trang quản trị Clothing Shop. Hãy cùng xem những gì đang diễn ra hôm nay.</p>
                        </div>
                        <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                            <a href="${pageContext.request.contextPath}/manage/products?action=add" class="btn btn-lg">
                                Thêm sản phẩm
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4 mb-4">
                    <!-- Products -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card stat-products">
                            <div class="stat-icon">
                                <i class="bi bi-box-seam"></i>
                            </div>
                            <div class="stat-info">
                                <h3>${totalProducts}</h3>
                                <p>Sản phẩm</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/manage/products" class="stat-link">
                                Xem tất cả
                            </a>
                        </div>
                    </div>
                    
                    <!-- Categories -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card stat-categories">
                            <div class="stat-icon">
                                <i class="bi bi-grid-3x3-gap"></i>
                            </div>
                            <div class="stat-info">
                                <h3>${totalCategories}</h3>
                                <p>Danh mục</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/manage/categories" class="stat-link">
                                Xem tất cả <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Brands -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card stat-brands">
                            <div class="stat-icon">
                                <i class="bi bi-award"></i>
                            </div>
                            <div class="stat-info">
                                <h3>${totalBrands}</h3>
                                <p>Thương hiệu</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/manage/brands" class="stat-link">
                                Xem tất cả <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Orders -->
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card stat-orders">
                            <div class="stat-icon">
                                <i class="bi bi-bag-check"></i>
                            </div>
                            <div class="stat-info">
                                <h3>${totalOrders}</h3>
                                <p>Đơn hàng</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/manage/orders" class="stat-link">
                                Xem tất cả <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Additional Stats Row -->
                <div class="row g-4 mb-4">
                    <!-- Users Card -->
                    <div class="col-xl-4 col-md-6">
                        <div class="info-card h-100">
                            <div class="info-card-header">
                                <h5>Người dùng</h5>
                            </div>
                            <div class="info-card-body">
                                <div class="info-stat">
                                    <span class="stat-number text-warning">${totalUsers}</span>
                                    <span class="stat-label">Tổng số người dùng đăng ký</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pending Orders Card -->
                    <div class="col-xl-4 col-md-6">
                        <div class="info-card h-100">
                            <div class="info-card-header">
                                <h5>Đơn chờ xử lý</h5>
                            </div>
                            <div class="info-card-body">
                                <div class="info-stat">
                                    <span class="stat-number text-warning">${pendingOrders}</span>
                                    <span class="stat-label">Đơn hàng đang chờ xác nhận</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Revenue Card -->
                    <div class="col-xl-4 col-md-12">
                        <div class="info-card h-100">
                            <div class="info-card-header">
                                <h5>Doanh thu</h5>
                            </div>
                            <div class="info-card-body">
                                <div class="info-stat">
                                    <span class="stat-number text-success">
                                        <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                                    </span>
                                    <span class="stat-label">Tổng doanh thu từ đơn đã giao</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions">
                    <h5 class="mb-3">
                        Thao tác nhanh
                    </h5>
                    <div class="row g-3">
                        <div class="col-lg-3 col-md-6 col-6">
                            <a href="${pageContext.request.contextPath}/manage/products?action=add" class="quick-action-btn">
                                <span>Thêm sản phẩm</span>
                            </a>
                        </div>
                        <div class="col-lg-3 col-md-6 col-6">
                            <a href="${pageContext.request.contextPath}/manage/categories?action=add" class="quick-action-btn">
                                <span>Thêm danh mục</span>
                            </a>
                        </div>
                        <div class="col-lg-3 col-md-6 col-6">
                            <a href="${pageContext.request.contextPath}/manage/brands?action=add" class="quick-action-btn">
                                <span>Thêm thương hiệu</span>
                            </a>
                        </div>
                        <div class="col-lg-3 col-md-6 col-6">
                            <a href="${pageContext.request.contextPath}/manage/orders" class="quick-action-btn">
                                <span>Xem đơn hàng</span>
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Sidebar toggle for mobile
        document.querySelector('.sidebar-toggle')?.addEventListener('click', function() {
            document.querySelector('.admin-sidebar').classList.toggle('show');
        });
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(e) {
            const sidebar = document.querySelector('.admin-sidebar');
            const toggle = document.querySelector('.sidebar-toggle');
            if (window.innerWidth < 992 && sidebar.classList.contains('show')) {
                if (!sidebar.contains(e.target) && !toggle.contains(e.target)) {
                    sidebar.classList.remove('show');
                }
            }
        });
    </script>
</body>
</html>
