<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Người Dùng - Admin</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        /* Role Dropdown Styling - Black & Gold Theme */
        .role-dropdown-btn {
            border-color: var(--admin-gold) !important;
            color: var(--admin-gold) !important;
            background: transparent !important;
            position: relative;
            z-index: 1;
        }
        
        .role-dropdown-btn:hover,
        .role-dropdown-btn:focus,
        .role-dropdown-btn.show {
            background: var(--admin-gold) !important;
            color: #1a1a1a !important;
            border-color: var(--admin-gold) !important;
        }
        
        /* Dropdown container */
        .dropdown {
            position: relative;
        }
        
        .role-dropdown-menu {
            background: var(--admin-card-bg-solid) !important;
            background-color: #1a1a1a !important;
            border: 1px solid var(--admin-gold) !important;
            border-radius: 0.375rem !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.8), 0 0 20px var(--admin-gold-glow) !important;
            padding: 0.25rem 0 !important;
            min-width: auto !important;
            width: max-content !important;
            position: absolute !important;
            top: 100% !important;
            right: 13% !important;
            left: auto !important;
            z-index: 9999 !important;
            margin-top: -1px !important;
            display: none !important;
            opacity: 1 !important;
            visibility: visible !important;
            transform: translateY(0) !important;
            transition: none !important;
            pointer-events: auto !important;
        }
        
        .role-dropdown-menu.show {
            display: block !important;
            opacity: 1 !important;
            visibility: visible !important;
        }
        
        .role-form {
            margin: 0 !important;
            display: block !important;
        }
        
        .role-item {
            color: var(--admin-text) !important;
            padding: 0.4rem 0.75rem !important;
            border: none !important;
            background: transparent !important;
            transition: background-color 0.15s ease !important;
            width: 100% !important;
            text-align: left !important;
            display: block !important;
            cursor: pointer !important;
            position: relative !important;
            z-index: 1 !important;
            white-space: nowrap !important;
            font-size: 0.875rem !important;
            line-height: 1.4 !important;
        }
        
        .role-dropdown-menu li {
            margin: 0 !important;
        }
        
        .role-item:hover {
            background: rgba(201, 169, 98, 0.2) !important;
            color: var(--admin-gold) !important;
        }
        
        .role-item.active {
            background: var(--admin-gold) !important;
            color: #1a1a1a !important;
            font-weight: 600 !important;
        }
        
        .role-item.active:hover {
            background: var(--admin-gold-light) !important;
            color: #1a1a1a !important;
        }
        
        /* Prevent dropdown from being transparent or overlapping */
        .dropdown-menu.role-dropdown-menu::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: #1a1a1a;
            z-index: -1;
            border-radius: 0.5rem;
        }
        
        /* Table responsive fix */
        .table-responsive {
            overflow-x: auto !important;
            overflow-y: visible !important;
            -webkit-overflow-scrolling: touch;
        }
        
        /* Ensure card body doesn't clip dropdown */
        .card-body {
            overflow: visible !important;
        }
        
        /* Ensure table rows don't overlap dropdown */
        .table tbody tr {
            position: relative;
            z-index: 1;
        }
        
        .table tbody tr:hover {
            z-index: 2;
        }
        
        /* Ensure dropdown has proper positioning */
        .table td {
            position: relative;
            overflow: visible !important;
        }
        
        .table td .dropdown {
            position: static;
        }
        
        .table td .dropdown.show {
            z-index: 10000;
        }
        
        /* Fix dropdown menu positioning to not be clipped */
        .role-dropdown-menu {
            position: absolute !important;
        }
        
        /* Ensure parent containers don't clip */
        .card {
            overflow: visible !important;
        }
        
        .table-responsive {
            position: relative;
        }
        
        /* Compact table styling - allow text wrapping */
        .users-table {
            margin-bottom: 0;
        }
        
        .users-table thead th {
            font-weight: 600;
            padding: 0.75rem 0.5rem;
            border-bottom: 2px solid var(--admin-border);
            white-space: nowrap;
        }
        
        .users-table tbody td {
            padding: 0.75rem 0.5rem;
            vertical-align: middle;
            word-wrap: break-word;
            word-break: break-word;
            white-space: normal;
        }
        
        .card-body {
            padding: 1rem !important;
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/admin/includes/sidebar.jsp"/>
        
        <!-- Main Content -->
        <main class="admin-main">
            <div class="container-fluid py-4">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h1 class="h3 mb-0">Quản Lý Người Dùng</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                                <li class="breadcrumb-item active">Người dùng</li>
                            </ol>
                        </nav>
                    </div>
                </div>
                
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
                
                <!-- Search Box -->
                <div class="mb-3">
                    <form action="${pageContext.request.contextPath}/manage/users" method="get" class="d-flex gap-2" style="max-width: 400px;">
                        <input type="text" name="keyword" class="form-control" 
                               placeholder="Tìm kiếm theo họ tên..." value="${keyword}">
                        <button type="submit" class="btn btn-outline-warning">Tìm</button>
                    </form>
                </div>
                
                <!-- Users Table -->
                <div class="card">
                    <div class="card-body p-2">
                        <div class="table-responsive" style="overflow-x: auto; width: 100%;">
                            <table class="table table-hover align-middle table-sm users-table">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">ID</th>
                                        <th style="width: 120px;">Họ tên</th>
                                        <th style="width: 180px;">Email</th>
                                        <th style="width: 110px;">Điện thoại</th>
                                        <th style="width: 90px;">Vai trò</th>
                                        <th style="width: 100px;">Trạng thái</th>
                                        <th style="width: 100px;">Ngày tạo</th>
                                        <th class="text-center" style="width: 140px;">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${users}" var="u">
                                        <tr>
                                            <td><strong>#${u.id}</strong></td>
                                            <td style="max-width: 120px;">${u.fullName}</td>
                                            <td style="max-width: 180px;">${u.email}</td>
                                            <td>${u.phone}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.role == 'ADMIN'}">
                                                        <span class="badge bg-danger">Admin</span>
                                                    </c:when>
                                                    <c:when test="${u.role == 'STAFF'}">
                                                        <span class="badge bg-warning text-dark">Staff</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Customer</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.status}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Vô hiệu</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${u.createdAt != null}">
                                                    ${u.createdAt.toString().substring(0, 10)}
                                                </c:if>
                                            </td>
                                            <td class="text-center">
                                                <div class="d-flex gap-1 align-items-center justify-content-center">
                                                    <!-- Toggle Status -->
                                                    <form method="post" action="${pageContext.request.contextPath}/manage/users" class="d-inline">
                                                        <input type="hidden" name="action" value="toggleStatus">
                                                        <input type="hidden" name="userId" value="${u.id}">
                                                        <button type="submit" class="btn ${u.status ? 'btn-outline-danger' : 'btn-outline-success'} btn-sm" 
                                                                title="${u.status ? 'Vô hiệu hóa' : 'Kích hoạt'}"
                                                                style="width: 32px; height: 32px; padding: 0; font-size: 1.25rem; line-height: 1; display: inline-flex; align-items: center; justify-content: center;">
                                                            ${u.status ? '×' : '✓'}
                                                        </button>
                                                    </form>
                                                    
                                                    <!-- Change Role Dropdown -->
                                                    <div class="dropdown">
                                                        <button class="btn btn-outline-warning dropdown-toggle role-dropdown-btn btn-sm" type="button" 
                                                                data-bs-toggle="dropdown" title="Đổi vai trò"
                                                                style="padding: 0.25rem 0.5rem;">
                                                            Vai trò
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-end role-dropdown-menu">
                                                            <li>
                                                                <form method="post" action="${pageContext.request.contextPath}/manage/users" class="role-form">
                                                                    <input type="hidden" name="action" value="updateRole">
                                                                    <input type="hidden" name="userId" value="${u.id}">
                                                                    <input type="hidden" name="role" value="CUSTOMER">
                                                                    <button type="submit" class="dropdown-item role-item ${u.role == 'CUSTOMER' ? 'active' : ''}">
                                                                        Customer
                                                                    </button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form method="post" action="${pageContext.request.contextPath}/manage/users" class="role-form">
                                                                    <input type="hidden" name="action" value="updateRole">
                                                                    <input type="hidden" name="userId" value="${u.id}">
                                                                    <input type="hidden" name="role" value="STAFF">
                                                                    <button type="submit" class="dropdown-item role-item ${u.role == 'STAFF' ? 'active' : ''}">
                                                                        Staff
                                                                    </button>
                                                                </form>
                                                            </li>
                                                            <li>
                                                                <form method="post" action="${pageContext.request.contextPath}/manage/users" class="role-form">
                                                                    <input type="hidden" name="action" value="updateRole">
                                                                    <input type="hidden" name="userId" value="${u.id}">
                                                                    <input type="hidden" name="role" value="ADMIN">
                                                                    <button type="submit" class="dropdown-item role-item ${u.role == 'ADMIN' ? 'active' : ''}">
                                                                        Admin
                                                                    </button>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty users}">
                                        <tr>
                                            <td colspan="8" class="text-center py-5">
                                                <p class="text-muted mt-2">Chưa có người dùng nào</p>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Close dropdown when mouse leaves (with 0.15s delay) and fix positioning
        document.addEventListener('DOMContentLoaded', function() {
            const dropdowns = document.querySelectorAll('.dropdown');
            
            dropdowns.forEach(function(dropdown) {
                const button = dropdown.querySelector('.role-dropdown-btn');
                const menu = dropdown.querySelector('.role-dropdown-menu');
                
                if (button && menu) {
                    let closeTimeout = null;
                    
                    // Fix dropdown positioning when shown - align to right edge and overlap border
                    button.addEventListener('shown.bs.dropdown', function() {
                        const buttonRect = button.getBoundingClientRect();
                        const menuRect = menu.getBoundingClientRect();
                        const viewportWidth = window.innerWidth;
                        
                        // Always align to right edge of button (dropdown-menu-end)
                        menu.style.right = '13%';
                        menu.style.left = 'auto';
                        // Position to overlap border completely
                        menu.style.top = '100%';
                        menu.style.marginTop = '-1px';
                        
                        // If dropdown would be clipped on the left, flip to left side
                        if (buttonRect.right - menuRect.width < 0) {
                            menu.style.right = 'auto';
                            menu.style.left = '0';
                        }
                    });
                    
                    // When mouse leaves the dropdown area, close it after 0.15s
                    dropdown.addEventListener('mouseleave', function(e) {
                        // Check if mouse is really leaving (not just moving to child element)
                        const relatedTarget = e.relatedTarget;
                        if (!dropdown.contains(relatedTarget)) {
                            closeTimeout = setTimeout(function() {
                                const bsDropdown = bootstrap.Dropdown.getInstance(button);
                                if (bsDropdown && menu.classList.contains('show')) {
                                    bsDropdown.hide();
                                }
                            }, 150); // 0.15 seconds delay
                        }
                    });
                    
                    // Cancel timeout if mouse re-enters
                    dropdown.addEventListener('mouseenter', function() {
                        if (closeTimeout) {
                            clearTimeout(closeTimeout);
                            closeTimeout = null;
                        }
                    });
                    
                    // Also close when clicking outside (immediately)
                    document.addEventListener('click', function(e) {
                        if (!dropdown.contains(e.target) && menu.classList.contains('show')) {
                            if (closeTimeout) {
                                clearTimeout(closeTimeout);
                                closeTimeout = null;
                            }
                            const bsDropdown = bootstrap.Dropdown.getInstance(button);
                            if (bsDropdown) {
                                bsDropdown.hide();
                            }
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>
