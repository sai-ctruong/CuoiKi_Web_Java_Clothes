<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng #${order.id} - Admin</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    
    <style>
        .order-detail-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            margin-bottom: 1.5rem;
        }
        
        .card-header-custom {
            background: #f8f9fa;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #dee2e6;
            font-weight: 600;
        }
        
        .card-body-custom {
            padding: 1.5rem;
        }
        
        .info-row {
            display: flex;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            width: 150px;
            font-weight: 500;
            color: #6c757d;
        }
        
        .info-value {
            flex: 1;
            color: #1a1a2e;
        }
        
        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-pending { background: #fff3e0; color: #e65100; }
        .status-shipping { background: #e3f2fd; color: #1565c0; }
        .status-delivered { background: #e8f5e9; color: #2e7d32; }
        .status-cancelled { background: #ffebee; color: #c62828; }
        
        .product-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 1rem;
        }
        
        .product-info {
            flex: 1;
        }
        
        .product-name {
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 0.25rem;
        }
        
        .product-meta {
            font-size: 0.85rem;
            color: #6c757d;
        }
        
        .product-price {
            text-align: right;
        }
        
        .price-unit {
            font-size: 0.85rem;
            color: #6c757d;
        }
        
        .price-total {
            font-weight: 600;
            color: #2e7d32;
        }
        
        .order-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
        }
        
        .summary-row.total {
            border-top: 2px solid #dee2e6;
            margin-top: 0.5rem;
            padding-top: 1rem;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .status-update-form {
            background: #fff;
            padding: 1.5rem;
            border-radius: 10px;
            border: 2px solid #e0e0e0;
        }
        
        /* Timeline */
        .order-timeline {
            position: relative;
            padding-left: 30px;
        }
        
        .timeline-item {
            position: relative;
            padding-bottom: 1.5rem;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -24px;
            top: 8px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #dee2e6;
        }
        
        .timeline-item.active::before {
            background: #2e7d32;
        }
        
        .timeline-item::after {
            content: '';
            position: absolute;
            left: -19px;
            top: 20px;
            width: 2px;
            height: calc(100% - 12px);
            background: #dee2e6;
        }
        
        .timeline-item:last-child::after {
            display: none;
        }
    </style>
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
                        <i class="bi bi-list"></i>
                    </button>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manage/orders">Đơn hàng</a></li>
                            <li class="breadcrumb-item active">Chi tiết #${order.id}</li>
                        </ol>
                    </nav>
                </div>
            </header>
            
            <!-- Content -->
            <main class="admin-content">
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
                
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0">
                        <i class="bi bi-receipt me-2"></i>Đơn hàng #${order.id}
                        <span class="status-badge status-${order.status.toLowerCase()} ms-2">${order.statusDisplay}</span>
                    </h4>
                    <a href="${pageContext.request.contextPath}/manage/orders" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-1"></i>Quay lại
                    </a>
                </div>
                
                <div class="row">
                    <!-- Left Column -->
                    <div class="col-lg-8">
                        <!-- Customer Info -->
                        <div class="order-detail-card">
                            <div class="card-header-custom">
                                <i class="bi bi-person me-2"></i>Thông Tin Khách Hàng
                            </div>
                            <div class="card-body-custom">
                                <div class="info-row">
                                    <div class="info-label">Họ tên:</div>
                                    <div class="info-value">${order.fullName}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Số điện thoại:</div>
                                    <div class="info-value">${order.phone}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Email:</div>
                                    <div class="info-value">${order.email}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Địa chỉ:</div>
                                    <div class="info-value">${order.shippingAddress}</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Items -->
                        <div class="order-detail-card">
                            <div class="card-header-custom">
                                <i class="bi bi-bag me-2"></i>Sản Phẩm Đặt Mua
                            </div>
                            <div class="card-body-custom p-0">
                                <c:forEach var="item" items="${order.orderDetails}">
                                    <div class="product-item">
                                        <img src="${pageContext.request.contextPath}${item.product.thumbnailUrl != null ? item.product.thumbnailUrl : '/assets/images/placeholder.jpg'}" 
                                             alt="${item.product.name}" class="product-img">
                                        <div class="product-info">
                                            <div class="product-name">${item.product.name}</div>
                                            <div class="product-meta">
                                                Size: ${item.size} | Số lượng: ${item.quantity}
                                            </div>
                                        </div>
                                        <div class="product-price">
                                            <div class="price-unit">
                                                <fmt:formatNumber value="${item.price}" maxFractionDigits="0"/>đ x ${item.quantity}
                                            </div>
                                            <div class="price-total">
                                                <fmt:formatNumber value="${item.price * item.quantity}" maxFractionDigits="0"/>đ
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Order Notes -->
                        <c:if test="${not empty order.note}">
                            <div class="order-detail-card">
                                <div class="card-header-custom">
                                    <i class="bi bi-sticky me-2"></i>Ghi Chú
                                </div>
                                <div class="card-body-custom">
                                    <p class="mb-0">${order.note}</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- Right Column -->
                    <div class="col-lg-4">
                        <!-- Order Summary -->
                        <div class="order-detail-card">
                            <div class="card-header-custom">
                                <i class="bi bi-calculator me-2"></i>Tổng Thanh Toán
                            </div>
                            <div class="card-body-custom">
                                <div class="order-summary">
                                    <div class="summary-row">
                                        <span>Tạm tính:</span>
                                        <span><fmt:formatNumber value="${order.totalAmount - order.shippingFee + order.discount}" maxFractionDigits="0"/>đ</span>
                                    </div>
                                    <div class="summary-row">
                                        <span>Phí vận chuyển:</span>
                                        <span><fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="0"/>đ</span>
                                    </div>
                                    <c:if test="${order.discount > 0}">
                                        <div class="summary-row text-success">
                                            <span>Giảm giá:</span>
                                            <span>-<fmt:formatNumber value="${order.discount}" maxFractionDigits="0"/>đ</span>
                                        </div>
                                    </c:if>
                                    <div class="summary-row total">
                                        <span>Tổng cộng:</span>
                                        <span class="text-success"><fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="0"/>đ</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Info -->
                        <div class="order-detail-card">
                            <div class="card-header-custom">
                                <i class="bi bi-credit-card me-2"></i>Thanh Toán
                            </div>
                            <div class="card-body-custom">
                                <div class="info-row">
                                    <div class="info-label">Phương thức:</div>
                                    <div class="info-value">${order.paymentMethodDisplay}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Ngày đặt:</div>
                                    <div class="info-value">
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Update Status -->
                        <div class="status-update-form">
                            <h6 class="mb-3"><i class="bi bi-arrow-repeat me-2"></i>Cập Nhật Trạng Thái</h6>
                            <form action="${pageContext.request.contextPath}/manage/orders" method="POST">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <input type="hidden" name="returnTo" value="detail">
                                
                                <div class="mb-3">
                                    <select name="newStatus" class="form-select">
                                        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>
                                            ⏳ Chờ xử lý
                                        </option>
                                        <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>
                                            🚚 Đang giao hàng
                                        </option>
                                        <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>
                                            ✅ Đã giao hàng
                                        </option>
                                        <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>
                                            ❌ Đã hủy
                                        </option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-check-lg me-1"></i>Cập Nhật
                                </button>
                            </form>
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
    </script>
</body>
</html>
