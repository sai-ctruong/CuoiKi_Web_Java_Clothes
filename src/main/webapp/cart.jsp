<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - Clothing Shop</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 70px; /* Match header height */
        }
        
        /* Simple, Clean Cart Styles */
        .cart-section {
            padding: 2rem 0 4rem;
            background: #f8f9fa;
            min-height: calc(100vh - 280px);
        }
        
        .cart-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 1.5rem;
        }
        
        .cart-table {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        }
        
        .cart-table th {
            background: #f8f9fa;
            font-weight: 600;
            font-size: 0.875rem;
            color: #555;
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .cart-table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .cart-table tbody tr:last-child td {
            border-bottom: none;
        }
        
        .product-cell {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .product-thumb {
            width: 80px;
            height: 100px;
            object-fit: cover;
            border-radius: 6px;
            background: #f5f5f5;
        }
        
        .product-info h6 {
            font-weight: 600;
            margin-bottom: 0.25rem;
            color: #1a1a1a;
        }
        
        .product-info small {
            color: #888;
        }
        
        .qty-wrapper {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .qty-wrapper .btn {
            width: 32px;
            height: 32px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
        }
        
        .qty-wrapper input {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 0.35rem;
        }
        
        .price-text {
            font-weight: 600;
            color: #c9a962;
        }
        
        .btn-remove {
            color: #dc3545;
            background: none;
            border: none;
            padding: 0.5rem;
        }
        
        .btn-remove:hover {
            color: #a71d2a;
        }
        
        /* Summary Card */
        .summary-card {
            background: #fff;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        }
        
        .summary-card h5 {
            font-weight: 600;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
        }
        
        .summary-row.total {
            border-top: 2px solid #eee;
            margin-top: 0.5rem;
            padding-top: 1rem;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .summary-row.total .price-text {
            font-size: 1.25rem;
        }
        
        .btn-checkout {
            width: 100%;
            padding: 0.875rem;
            background: #c9a962;
            border: none;
            color: #fff;
            font-weight: 600;
            border-radius: 8px;
            margin-top: 1rem;
        }
        
        .btn-checkout:hover {
            background: #b8923b;
            color: #fff;
        }
        
        .btn-checkout:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: #fff;
            border-radius: 8px;
        }
        
        .empty-cart i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 1rem;
        }
        
        .empty-cart h5 {
            color: #555;
            margin-bottom: 0.5rem;
        }
        
        .empty-cart p {
            color: #888;
            margin-bottom: 1.5rem;
        }
        
        /* Voucher */
        .voucher-input {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .voucher-input input {
            flex: 1;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 0.5rem 0.75rem;
        }
        
        .voucher-input button {
            padding: 0.5rem 1rem;
            background: #fff;
            border: 1px solid #c9a962;
            color: #c9a962;
            border-radius: 6px;
            font-weight: 500;
        }
        
        .voucher-input button:hover {
            background: #c9a962;
            color: #fff;
        }
        
        @media (max-width: 991px) {
            .cart-table thead { display: none; }
            .cart-table td { display: block; padding: 0.75rem 1rem; }
            .cart-table tr { display: block; border-bottom: 1px solid #eee; padding: 1rem 0; }
            .product-cell { margin-bottom: 0.5rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <section class="cart-section">
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

            <h1 class="cart-title"><i class="bi bi-cart3 me-2"></i>Giỏ Hàng</h1>

            <c:choose>
                <c:when test="${not empty cartItems and cartItems.size() > 0}">
                    <div class="row g-4">
                        <!-- Cart Items -->
                        <div class="col-lg-8">
                            <div class="cart-table">
                                <table class="w-100">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th class="text-center">Đơn giá</th>
                                            <th class="text-center">Số lượng</th>
                                            <th class="text-end">Thành tiền</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${cartItems}" var="item">
                                            <tr>
                                                <td>
                                                    <div class="product-cell">
                                                        <img src="${not empty item.productImage ? pageContext.request.contextPath.concat(item.productImage) : 'https://via.placeholder.com/80x100'}" 
                                                             alt="${item.productName}" class="product-thumb">
                                                        <div class="product-info">
                                                            <h6>${item.productName}</h6>
                                                            <c:if test="${not empty item.productSize}">
                                                                <small>Size: ${item.productSize}</small>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center">
                                                    <fmt:formatNumber value="${item.productPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                                                </td>
                                                <td>
                                                    <div class="qty-wrapper justify-content-center">
                                                        <button type="button" class="btn btn-outline-secondary btn-sm qty-btn-decrease" 
                                                                data-item-id="${item.id}" 
                                                                data-current="${item.quantity}">
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                        <input type="text" value="${item.quantity}" readonly class="qty-display" data-item-id="${item.id}">
                                                        <button type="button" class="btn btn-outline-secondary btn-sm qty-btn-increase" 
                                                                data-item-id="${item.id}" 
                                                                data-current="${item.quantity}">
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                                <td class="text-end">
                                                    <span class="price-text item-subtotal" data-item-id="${item.id}" data-price="${item.productPrice}"><fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</span>
                                                </td>
                                                <td class="text-center">
                                                    <button type="button" class="btn-remove btn-remove-item" 
                                                            data-item-id="${item.id}"
                                                            title="Xóa sản phẩm">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/products" class="text-decoration-none">
                                    <i class="bi bi-arrow-left me-1"></i>Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                        
                        <!-- Order Summary -->
                        <div class="col-lg-4">
                            <div class="summary-card">
                                <h5><i class="bi bi-receipt me-2"></i>Tóm tắt đơn hàng</h5>
                                
                                <!-- Voucher -->
                                <c:choose>
                                    <c:when test="${not empty appliedVoucher}">
                                        <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                                            <span><i class="bi bi-ticket-perforated me-1"></i>${appliedVoucher.code}</span>
                                            <form action="${pageContext.request.contextPath}/cart/remove-voucher" method="post" style="margin:0;">
                                                <button type="submit" class="btn btn-sm btn-link text-danger p-0">Xóa</button>
                                            </form>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/cart/apply-voucher" method="post" class="voucher-input">
                                            <input type="text" name="code" placeholder="Mã giảm giá">
                                            <button type="submit">Áp dụng</button>
                                        </form>
                                        <c:if test="${not empty sessionScope.voucherMessage}">
                                            <div class="alert alert-${sessionScope.voucherStatus eq 'success' ? 'success' : 'danger'} py-2 mb-0" style="font-size: 0.875rem;">
                                                ${sessionScope.voucherMessage}
                                            </div>
                                            <c:remove var="voucherMessage" scope="session"/>
                                            <c:remove var="voucherStatus" scope="session"/>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="summary-row">
                                    <span>Tạm tính:</span>
                                    <span><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</span>
                                </div>
                                
                                <c:if test="${discount > 0}">
                                    <div class="summary-row text-success">
                                        <span>Giảm giá:</span>
                                        <span>-<fmt:formatNumber value="${discount}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</span>
                                    </div>
                                </c:if>
                                
                                <div class="summary-row">
                                    <span>Phí vận chuyển:</span>
                                    <span class="text-success">Miễn phí</span>
                                </div>
                                
                                <div class="summary-row total">
                                    <span>Tổng cộng:</span>
                                    <span class="price-text"><fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</span>
                                </div>
                                
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-checkout">
                                    <i class="bi bi-credit-card me-2"></i>Thanh toán
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-cart">
                        <i class="bi bi-cart-x"></i>
                        <h5>Giỏ hàng trống</h5>
                        <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-checkout" style="width: auto; display: inline-block;">
                            <i class="bi bi-bag me-2"></i>Mua sắm ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    (function() {
        'use strict';
        
        const contextPath = '${pageContext.request.contextPath}';
        
        // Format number as currency
        function formatCurrency(num) {
            return num.toLocaleString('vi-VN', { maximumFractionDigits: 0 }) + ' đ';
        }
        
        // Show toast notification
        function showToast(message, type) {
            const toast = document.createElement('div');
            toast.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' position-fixed';
            toast.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 280px;';
            toast.innerHTML = '<i class="bi bi-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + ' me-2"></i>' + message;
            document.body.appendChild(toast);
            setTimeout(function() { toast.remove(); }, 2500);
        }
        
        // Update quantity via AJAX
        function updateQuantity(itemId, action, currentQty) {
            const newQty = action === 'increase' ? currentQty + 1 : currentQty - 1;
            
            fetch(contextPath + '/cart/update?action=' + action + '&id=' + itemId + '&current=' + currentQty + '&ajax=true', {
                method: 'GET',
                headers: { 'Accept': 'application/json' }
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.status === 'success') {
                    if (newQty <= 0) {
                        // Remove the row
                        const row = document.querySelector('tr button[data-item-id="' + itemId + '"]').closest('tr');
                        if (row) row.remove();
                        showToast('Đã xóa sản phẩm', 'success');
                    } else {
                        // Update quantity display
                        const qtyInput = document.querySelector('.qty-display[data-item-id="' + itemId + '"]');
                        if (qtyInput) {
                            qtyInput.value = newQty;
                            // Update data-current on buttons
                            document.querySelectorAll('button[data-item-id="' + itemId + '"]').forEach(function(btn) {
                                btn.dataset.current = newQty;
                            });
                        }
                        
                        // Update subtotal
                        const subtotalEl = document.querySelector('.item-subtotal[data-item-id="' + itemId + '"]');
                        if (subtotalEl) {
                            const price = parseFloat(subtotalEl.dataset.price);
                            subtotalEl.textContent = formatCurrency(price * newQty);
                        }
                    }
                    updateSummary();
                } else {
                    showToast(data.message || 'Có lỗi xảy ra', 'error');
                }
            })
            .catch(function() {
                showToast('Có lỗi xảy ra', 'error');
            });
        }
        
        // Remove item via AJAX
        function removeItem(itemId) {
            if (!confirm('Xóa sản phẩm này khỏi giỏ hàng?')) return;
            
            fetch(contextPath + '/cart/update?action=remove&id=' + itemId + '&ajax=true', {
                method: 'GET',
                headers: { 'Accept': 'application/json' }
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.status === 'success') {
                    const row = document.querySelector('button.btn-remove-item[data-item-id="' + itemId + '"]').closest('tr');
                    if (row) row.remove();
                    showToast('Đã xóa sản phẩm', 'success');
                    updateSummary();
                    
                    // Check if cart is empty
                    if (document.querySelectorAll('tbody tr').length === 0) {
                        location.reload();
                    }
                }
            });
        }
        
        // Update order summary
        function updateSummary() {
            let subtotal = 0;
            document.querySelectorAll('.item-subtotal').forEach(function(el) {
                const price = parseFloat(el.dataset.price);
                const itemId = el.dataset.itemId;
                const qtyInput = document.querySelector('.qty-display[data-item-id="' + itemId + '"]');
                if (qtyInput) {
                    subtotal += price * parseInt(qtyInput.value);
                }
            });
            
            // Update summary display (simple version - just updates page)
            // For a complete solution, would need to also update discount calculation
        }
        
        // Event listeners
        document.addEventListener('click', function(e) {
            const decreaseBtn = e.target.closest('.qty-btn-decrease');
            const increaseBtn = e.target.closest('.qty-btn-increase');
            const removeBtn = e.target.closest('.btn-remove-item');
            
            if (decreaseBtn) {
                e.preventDefault();
                const itemId = decreaseBtn.dataset.itemId;
                const currentQty = parseInt(decreaseBtn.dataset.current);
                updateQuantity(itemId, 'decrease', currentQty);
            }
            
            if (increaseBtn) {
                e.preventDefault();
                const itemId = increaseBtn.dataset.itemId;
                const currentQty = parseInt(increaseBtn.dataset.current);
                updateQuantity(itemId, 'increase', currentQty);
            }
            
            if (removeBtn) {
                e.preventDefault();
                removeItem(removeBtn.dataset.itemId);
            }
        });
    })();
    </script>
</body>
</html>
