<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng - Clothing Shop</title>
    
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
        .order-history-page {
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
        
        .order-card {
            background: white;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            margin-bottom: 1.5rem;
            overflow: hidden;
            transition: var(--transition-normal);
        }
        
        .order-card:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }
        
        .order-header {
            background: #f8f9fa;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .order-id {
            font-weight: 600;
            color: var(--primary-dark);
        }
        
        .order-date {
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        .order-body {
            padding: 1.5rem;
        }
        
        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .order-info-item {
            display: flex;
            flex-direction: column;
        }
        
        .order-info-item label {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }
        
        .order-info-item span {
            font-weight: 500;
        }
        
        .order-footer {
            padding: 1rem 1.5rem;
            background: #f8f9fa;
            border-top: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-total {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--accent-color);
        }
        
        /* Status badges */
        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-pending {
            background: #fff3e0;
            color: #e65100;
        }
        
        .status-shipping {
            background: #e3f2fd;
            color: #1565c0;
        }
        
        .status-delivered {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .status-cancelled {
            background: #ffebee;
            color: #c62828;
        }
        
        .empty-orders {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: var(--radius-lg);
        }
        
        .empty-orders i {
            font-size: 4rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />
    
    <div class="order-history-page">
        <div class="container">
            <div class="page-header">
                <h1><i class="bi bi-bag-check me-2"></i>Lịch Sử Đơn Hàng</h1>
                <p class="mb-0 mt-2">Theo dõi trạng thái và chi tiết các đơn hàng của bạn</p>
            </div>
            
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="empty-orders">
                        <i class="bi bi-bag-x"></i>
                        <h4>Chưa có đơn hàng nào</h4>
                        <p class="text-muted">Hãy bắt đầu mua sắm để có đơn hàng đầu tiên!</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">
                            <i class="bi bi-shop me-2"></i>Mua sắm ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <span class="order-id">Đơn hàng #${order.id}</span>
                                    <span class="order-date ms-3">
                                        <i class="bi bi-calendar3 me-1"></i>
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>
                                <span class="status-badge status-${order.status.toLowerCase()}">${order.statusDisplay}</span>
                            </div>
                            
                            <div class="order-body">
                                <div class="order-info">
                                    <div class="order-info-item">
                                        <label>Người nhận</label>
                                        <span>${order.fullName}</span>
                                    </div>
                                    <div class="order-info-item">
                                        <label>Số điện thoại</label>
                                        <span>${order.phone}</span>
                                    </div>
                                    <div class="order-info-item">
                                        <label>Địa chỉ giao hàng</label>
                                        <span>${order.shippingAddress}</span>
                                    </div>
                                    <div class="order-info-item">
                                        <label>Thanh toán</label>
                                        <span>${order.paymentMethodDisplay}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="order-footer">
                                <span class="order-total">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                </span>
                                <a href="${pageContext.request.contextPath}/orders?id=${order.id}" class="btn btn-outline-primary">
                                    <i class="bi bi-eye me-1"></i>Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
