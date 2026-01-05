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
                
                <!-- Users Table -->
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Điện thoại</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th class="text-center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${users}" var="u">
                                        <tr>
                                            <td><strong>#${u.id}</strong></td>
                                            <td>${u.username}</td>
                                            <td>${u.fullName}</td>
                                            <td>${u.email}</td>
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
                                                <div class="d-flex justify-content-center gap-1">
                                                    <!-- Toggle Status Button -->
                                                    <form method="post" action="${pageContext.request.contextPath}/manage/users" class="d-inline" id="toggleForm${u.id}">
                                                        <input type="hidden" name="action" value="toggleStatus">
                                                        <input type="hidden" name="userId" value="${u.id}">
                                                        <button type="submit" class="btn btn-sm ${u.status ? 'btn-outline-danger' : 'btn-outline-success'}" 
                                                                title="${u.status ? 'Vô hiệu hóa' : 'Kích hoạt'}">
                                                            <i class="bi ${u.status ? 'bi-x-circle' : 'bi-check-circle'}"></i>
                                                        </button>
                                                    </form>
                                                    
                                                    <!-- Change Role Dropdown -->
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button" 
                                                                data-bs-toggle="dropdown" aria-expanded="false" title="Đổi vai trò">
                                                            <i class="bi bi-person-gear"></i>
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-end">
                                                            <li>
                                                                <a class="dropdown-item ${u.role == 'CUSTOMER' ? 'active' : ''}" href="#"
                                                                   onclick="changeRole(${u.id}, 'CUSTOMER'); return false;">
                                                                    <i class="bi bi-person me-2"></i>Customer
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item ${u.role == 'STAFF' ? 'active' : ''}" href="#"
                                                                   onclick="changeRole(${u.id}, 'STAFF'); return false;">
                                                                    <i class="bi bi-person-badge me-2"></i>Staff
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item ${u.role == 'ADMIN' ? 'active' : ''}" href="#"
                                                                   onclick="changeRole(${u.id}, 'ADMIN'); return false;">
                                                                    <i class="bi bi-person-fill-gear me-2"></i>Admin
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                
                                                <!-- Hidden form for role change -->
                                                <form id="roleForm${u.id}" method="post" action="${pageContext.request.contextPath}/manage/users" style="display:none;">
                                                    <input type="hidden" name="action" value="updateRole">
                                                    <input type="hidden" name="userId" value="${u.id}">
                                                    <input type="hidden" name="role" id="roleInput${u.id}" value="">
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty users}">
                                        <tr>
                                            <td colspan="9" class="text-center py-5">
                                                <i class="bi bi-people fs-1 text-muted"></i>
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
        // Function to change user role via hidden form
        function changeRole(userId, role) {
            var form = document.getElementById('roleForm' + userId);
            var roleInput = document.getElementById('roleInput' + userId);
            if (form && roleInput) {
                roleInput.value = role;
                form.submit();
            }
        }
    </script>
</body>
</html>
