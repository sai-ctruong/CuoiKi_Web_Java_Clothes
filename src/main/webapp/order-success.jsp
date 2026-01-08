<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công - Clothing Shop</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;1,400&family=Montserrat:wght@300;400;500;600;700&display=swap&subset=vietnamese" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 80px; /* Account for fixed header */
        }
        
        .success-page { padding: 4rem 0; background: var(--bg-cream); min-height: calc(80vh - 80px); }
        .success-card { background: #fff; border-radius: 16px; box-shadow: 0 8px 30px rgba(0,0,0,0.1); max-width: 600px; margin: 0 auto; overflow: hidden; }
        .success-header { background: linear-gradient(135deg, #28a745, #20c997); color: #fff; padding: 3rem 2rem; text-align: center; }
        .success-icon { font-size: 5rem; margin-bottom: 1rem; animation: bounceIn 0.6s ease; }
        @keyframes bounceIn { 0% { transform: scale(0); } 50% { transform: scale(1.2); } 100% { transform: scale(1); } }
        .success-header h2 { font-family: 'Cormorant Garamond', serif; font-size: 2rem; margin-bottom: 0.5rem; }
        .success-body { padding: 2rem; }
        .order-info { background: #f8f9fa; border-radius: 12px; padding: 1.5rem; margin-bottom: 1.5rem; }
        .order-info-row { display: flex; justify-content: space-between; padding: 0.5rem 0; border-bottom: 1px dashed #ddd; }
        .order-info-row:last-child { border-bottom: none; }
        .order-info-label { color: var(--text-muted); }
        .order-info-value { font-weight: 600; color: var(--text-dark); }
        .order-total { font-size: 1.25rem; color: var(--accent-dark); }
        .btn-continue { background: var(--accent-color); color: var(--text-dark); padding: 0.875rem 2rem; border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-block; transition: all 0.2s; }
        .btn-continue:hover { background: var(--accent-hover); color: var(--text-dark); transform: translateY(-2px); }
        .email-notice { background: #e8f5e9; border-radius: 8px; padding: 1rem; margin-bottom: 1.5rem; color: #2e7d32; font-size: 0.9rem; }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <section class="success-page">
        <div class="container">
            <div class="success-card">
                <div class="success-header">
                    <div class="success-icon">✓</div>
                    <h2>Đặt Hàng Thành Công!</h2>
                    <p>Cảm ơn bạn đã mua sắm tại Clothing Shop</p>
                </div>
                
                <div class="success-body">
                    <div class="email-notice">
                        <i class="bi bi-envelope-check me-2"></i>
                        Chúng tôi đã gửi email xác nhận đến địa chỉ email của bạn.
                    </div>
                    
                    <div class="order-info">
                        <div class="order-info-row">
                            <span class="order-info-label">Mã đơn hàng:</span>
                            <span class="order-info-value">#${order.id}</span>
                        </div>
                        <div class="order-info-row">
                            <span class="order-info-label">Người nhận:</span>
                            <span class="order-info-value">${order.fullName}</span>
                        </div>
                        <div class="order-info-row">
                            <span class="order-info-label">Số điện thoại:</span>
                            <span class="order-info-value">${order.phone}</span>
                        </div>
                        <div class="order-info-row">
                            <span class="order-info-label">Địa chỉ:</span>
                            <span class="order-info-value">${order.shippingAddress}</span>
                        </div>
                        <div class="order-info-row">
                            <span class="order-info-label">Thanh toán:</span>
                            <span class="order-info-value">${order.paymentMethodDisplay}</span>
                        </div>
                        <div class="order-info-row">
                            <span class="order-info-label">Trạng thái:</span>
                            <span class="order-info-value">
                                <span class="badge bg-warning text-dark">${order.statusDisplay}</span>
                            </span>
                        </div>
                        <div class="order-info-row">
                            <span class="order-info-label">Tổng tiền:</span>
                            <span class="order-info-value order-total"><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</span>
                        </div>
                    </div>
                    
                    <c:if test="${not empty order.orderDetails}">
                        <h6 class="mb-3">Chi tiết đơn hàng:</h6>
                        <div class="table-responsive mb-4">
                            <table class="table table-sm align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width: 70px;">Hình ảnh</th>
                                        <th>Sản phẩm</th>
                                        <th class="text-center">SL</th>
                                        <th class="text-end">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${order.orderDetails}" var="detail">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty detail.productImage}">
                                                        <img src="${pageContext.request.contextPath}${detail.productImage}" 
                                                             alt="${detail.productName}" 
                                                             style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px; border: 1px solid #eee;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div style="width: 60px; height: 60px; background: #f0f0f0; border-radius: 8px; display: flex; align-items: center; justify-content: center;">
                                                            <i class="bi bi-image text-muted"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${detail.productName}</td>
                                            <td class="text-center">${detail.quantity}</td>
                                            <td class="text-end"><fmt:formatNumber value="${detail.subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary me-2">
                            <i class="bi bi-list-check me-1"></i>Xem đơn hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/products" class="btn-continue">
                            <i class="bi bi-bag me-1"></i>Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
