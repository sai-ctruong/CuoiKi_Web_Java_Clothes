<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng - Clothing Shop Admin</title>
    
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
        .status-tabs {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        
        .status-tab {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .status-tab .count {
            background: rgba(255,255,255,0.2);
            padding: 0.1rem 0.5rem;
            border-radius: 50px;
            font-size: 0.8rem;
        }
        
        .tab-all { background: #6c757d; color: white; }
        .tab-all.active, .tab-all:hover { background: #495057; color: white; }
        
        .tab-pending { background: #fff3e0; color: #e65100; }
        .tab-pending.active, .tab-pending:hover { background: #e65100; color: white; }
        
        .tab-shipping { background: #e3f2fd; color: #1565c0; }
        .tab-shipping.active, .tab-shipping:hover { background: #1565c0; color: white; }
        
        .tab-delivered { background: #e8f5e9; color: #2e7d32; }
        .tab-delivered.active, .tab-delivered:hover { background: #2e7d32; color: white; }
        
        .tab-cancelled { background: #ffebee; color: #c62828; }
        .tab-cancelled.active, .tab-cancelled:hover { background: #c62828; color: white; }
        
        .orders-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        
        .orders-table th {
            background: #f8f9fa;
            font-weight: 600;
            white-space: nowrap;
        }
        
        .order-id {
            font-weight: 600;
            color: #1a1a2e;
        }
        
        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-pending { background: #fff3e0; color: #e65100; }
        .status-shipping { background: #e3f2fd; color: #1565c0; }
        .status-delivered { background: #e8f5e9; color: #2e7d32; }
        .status-cancelled { background: #ffebee; color: #c62828; }
        
        .status-select {
            min-width: 140px;
            font-size: 0.85rem;
        }
        
        .btn-update {
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
        }
        
        .empty-orders {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .empty-orders i {
            font-size: 3rem;
            margin-bottom: 1rem;
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
                    <h4 class="page-title mb-0">Quản Lý Đơn Hàng</h4>
                </div>
                <div class="header-right">
                    <div class="dropdown">
                        <button class="btn btn-link dropdown-toggle user-dropdown" data-bs-toggle="dropdown">
                            <div class="user-avatar">
                                ${sessionScope.user.fullName.charAt(0)}
                            </div>
                            <span class="d-none d-md-inline">${sessionScope.user.fullName}</span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house me-2"></i>Về trang chủ
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
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
                
                <!-- Status Tabs -->
                <div class="status-tabs">
                    <a href="${pageContext.request.contextPath}/manage/orders" 
                       class="status-tab tab-all ${currentStatus == 'ALL' ? 'active' : ''}">
                        <i class="bi bi-list-ul"></i> Tất cả
                        <span class="count">${countPending + countShipping + countDelivered + countCancelled}</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/manage/orders?status=PENDING" 
                       class="status-tab tab-pending ${currentStatus == 'PENDING' ? 'active' : ''}">
                        <i class="bi bi-clock"></i> Chờ xử lý
                        <span class="count">${countPending}</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/manage/orders?status=SHIPPING" 
                       class="status-tab tab-shipping ${currentStatus == 'SHIPPING' ? 'active' : ''}">
                        <i class="bi bi-truck"></i> Đang giao
                        <span class="count">${countShipping}</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/manage/orders?status=DELIVERED" 
                       class="status-tab tab-delivered ${currentStatus == 'DELIVERED' ? 'active' : ''}">
                        <i class="bi bi-check-circle"></i> Đã giao
                        <span class="count">${countDelivered}</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/manage/orders?status=CANCELLED" 
                       class="status-tab tab-cancelled ${currentStatus == 'CANCELLED' ? 'active' : ''}">
                        <i class="bi bi-x-circle"></i> Đã hủy
                        <span class="count">${countCancelled}</span>
                    </a>
                </div>
                
                <!-- Orders Table -->
                <div class="orders-table">
                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="empty-orders">
                                <i class="bi bi-inbox"></i>
                                <h5>Không có đơn hàng nào</h5>
                                <p class="text-muted">Chưa có đơn hàng nào với trạng thái này</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Mã ĐH</th>
                                        <th>Khách hàng</th>
                                        <th>SĐT</th>
                                        <th>Tổng tiền</th>
                                        <th>Thanh toán</th>
                                        <th>Ngày đặt</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td><span class="order-id">#${order.id}</span></td>
                                            <td>${order.fullName}</td>
                                            <td>${order.phone}</td>
                                            <td>
                                                <strong class="text-success">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                                </strong>
                                            </td>
                                            <td>${order.paymentMethodDisplay}</td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <span class="status-badge status-${order.status.toLowerCase()}">
                                                    ${order.statusDisplay}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1 align-items-center">
                                                    <a href="${pageContext.request.contextPath}/manage/orders?id=${order.id}" 
                                                       class="btn btn-outline-primary btn-sm" title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/manage/orders" method="POST" class="d-flex gap-1">
                                                        <input type="hidden" name="action" value="updateStatus">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <input type="hidden" name="currentStatus" value="${currentStatus}">
                                                        <select name="newStatus" class="form-select form-select-sm status-select">
                                                            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                                                            <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                                                            <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                                                            <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                                                        </select>
                                                        <button type="submit" class="btn btn-primary btn-update">
                                                            <i class="bi bi-check-lg"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
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
