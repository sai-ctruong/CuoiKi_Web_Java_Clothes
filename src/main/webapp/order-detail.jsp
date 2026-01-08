<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng #${order.id} - Clothing Shop</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Montserrat:wght@300;400;500;600;700&display=swap&subset=vietnamese" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 80px; /* Account for fixed header */
        }
        .order-detail-page {
            min-height: 100vh;
            background: var(--bg-cream);
            padding: 2rem 0;
        }
        
        .page-header {
            background: var(--bg-dark);
            color: var(--text-white);
            padding: 2rem;
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
        }
        
        .page-header h1 {
            font-family: 'Cormorant Garamond', serif;
            font-style: italic;
            margin: 0;
        }
        
        .detail-card {
            background: white;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }
        
        .detail-card-header {
            background: #f8f9fa;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .detail-card-header h5 {
            margin: 0;
            font-weight: 600;
        }
        
        .detail-card-body {
            padding: 1.5rem;
        }
        
        /* Status Timeline */
        .status-timeline {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin: 2rem 0;
        }
        
        .status-timeline::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 3px;
            background: #dee2e6;
            z-index: 1;
        }
        
        .timeline-step {
            position: relative;
            z-index: 2;
            text-align: center;
            flex: 1;
        }
        
        .timeline-step .step-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #dee2e6;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.5rem;
            font-size: 1.1rem;
        }
        
        .timeline-step.active .step-icon {
            background: var(--accent-color);
        }
        
        .timeline-step.completed .step-icon {
            background: #28a745;
        }
        
        .timeline-step.cancelled .step-icon {
            background: #dc3545;
        }
        
        .timeline-step .step-label {
            font-size: 0.85rem;
            color: var(--text-muted);
        }
        
        .timeline-step.active .step-label,
        .timeline-step.completed .step-label {
            color: var(--text-dark);
            font-weight: 600;
        }
        
        /* Product items */
        .product-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: var(--radius-sm);
        }
        
        .product-info {
            flex: 1;
        }
        
        .product-name {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .product-price {
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        .product-subtotal {
            font-weight: 600;
            color: var(--accent-color);
            text-align: right;
        }
        
        /* Summary */
        .order-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: var(--radius-md);
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
        }
        
        .summary-row.total {
            border-top: 2px solid var(--accent-color);
            padding-top: 0.75rem;
            margin-top: 0.75rem;
            font-size: 1.25rem;
            font-weight: 700;
        }
        
        .summary-row.total .value {
            color: var(--accent-color);
        }
        
        /* Status badge */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .status-pending { background: #fff3e0; color: #e65100; }
        .status-shipping { background: #e3f2fd; color: #1565c0; }
        .status-delivered { background: #e8f5e9; color: #2e7d32; }
        .status-cancelled { background: #ffebee; color: #c62828; }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />
    
    <div class="order-detail-page">
        <div class="container">
            <div class="page-header d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h1><i class="bi bi-receipt me-2"></i>Chi Tiết Đơn Hàng #${order.id}</h1>
                    <p class="mb-0 mt-2">
                        <i class="bi bi-calendar3 me-1"></i>
                        Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                    </p>
                </div>
                <span class="status-badge status-${order.status.toLowerCase()}">${order.statusDisplay}</span>
            </div>
            
            <!-- Status Timeline -->
            <div class="detail-card">
                <div class="detail-card-header">
                    <h5><i class="bi bi-diagram-3 me-2"></i>Trạng thái đơn hàng</h5>
                </div>
                <div class="detail-card-body">
                    <div class="status-timeline">
                        <div class="timeline-step ${order.status == 'PENDING' ? 'active' : (order.status != 'CANCELLED' ? 'completed' : '')}">
                            <div class="step-icon"><i class="bi bi-clipboard-check"></i></div>
                            <div class="step-label">Chờ xử lý</div>
                        </div>
                        <div class="timeline-step ${order.status == 'SHIPPING' ? 'active' : (order.status == 'DELIVERED' ? 'completed' : '')} ${order.status == 'CANCELLED' ? '' : ''}">
                            <div class="step-icon"><i class="bi bi-truck"></i></div>
                            <div class="step-label">Đang giao</div>
                        </div>
                        <div class="timeline-step ${order.status == 'DELIVERED' ? 'completed' : ''} ${order.status == 'CANCELLED' ? 'cancelled' : ''}">
                            <div class="step-icon">
                                <c:choose>
                                    <c:when test="${order.status == 'CANCELLED'}">
                                        <i class="bi bi-x-lg"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-check-lg"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="step-label">
                                ${order.status == 'CANCELLED' ? 'Đã hủy' : 'Đã giao'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-8">
                    <!-- Products -->
                    <div class="detail-card">
                        <div class="detail-card-header">
                            <h5><i class="bi bi-box-seam me-2"></i>Sản phẩm đã đặt</h5>
                        </div>
                        <div class="detail-card-body">
                            <c:forEach var="item" items="${order.orderDetails}">
                                <div class="product-item">
                                    <img src="${pageContext.request.contextPath}${item.productImage != null ? item.productImage : '/assets/images/placeholder.jpg'}" 
                                         alt="${item.productName}">
                                    <div class="product-info">
                                        <div class="product-name">${item.productName}</div>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ x ${item.quantity}
                                        </div>
                                    </div>
                                    <div class="product-subtotal">
                                        <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <!-- Shipping Info -->
                    <div class="detail-card">
                        <div class="detail-card-header">
                            <h5><i class="bi bi-geo-alt me-2"></i>Thông tin giao hàng</h5>
                        </div>
                        <div class="detail-card-body">
                            <p><strong>Người nhận:</strong> ${order.fullName}</p>
                            <p><strong>Điện thoại:</strong> ${order.phone}</p>
                            <p class="mb-0"><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                        </div>
                    </div>
                    
                    <!-- Payment Summary -->
                    <div class="detail-card">
                        <div class="detail-card-header">
                            <h5><i class="bi bi-credit-card me-2"></i>Thanh toán</h5>
                        </div>
                        <div class="detail-card-body">
                            <p><strong>Phương thức:</strong> ${order.paymentMethodDisplay}</p>
                            <div class="order-summary mt-3">
                                <div class="summary-row total">
                                    <span>Tổng cộng</span>
                                    <span class="value">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Back button -->
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-2"></i>Quay lại lịch sử đơn hàng
                </a>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
