<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục - Admin</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="admin-wrapper">
        <jsp:include page="includes/sidebar.jsp" />
        
        <div class="admin-main">
            <header class="admin-header">
                <div class="header-left">
                    <button class="btn btn-link sidebar-toggle d-lg-none">
                        <i class="bi bi-list"></i>
                    </button>
                    <h4 class="page-title mb-0">Quản lý Danh mục</h4>
                </div>
                <div class="header-right">
                    <a href="${pageContext.request.contextPath}/manage/categories?action=add" class="btn btn-primary">
                        <i class="bi bi-plus-lg me-2"></i>Thêm mới
                    </a>
                </div>
            </header>
            
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
                
                <div class="data-table">
                    <div class="data-table-header">
                        <h5><i class="bi bi-grid me-2"></i>Danh sách danh mục (${categories.size()})</h5>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 60px;">ID</th>
                                    <th>Tên danh mục</th>
                                    <th>Mô tả</th>
                                    <th>Số sản phẩm</th>
                                    <th style="width: 120px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty categories}">
                                        <tr>
                                            <td colspan="5">
                                                <div class="empty-state">
                                                    <i class="bi bi-inbox"></i>
                                                    <p>Chưa có danh mục nào</p>
                                                    <a href="${pageContext.request.contextPath}/manage/categories?action=add" class="btn btn-primary">
                                                        <i class="bi bi-plus-lg me-2"></i>Thêm danh mục đầu tiên
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${categories}" var="cat">
                                            <tr>
                                                <td><strong>#${cat.id}</strong></td>
                                                <td>
                                                    <i class="bi bi-folder text-primary me-2"></i>
                                                    <strong>${cat.name}</strong>
                                                </td>
                                                <td class="text-muted">
                                                    ${not empty cat.description ? cat.description : '-'}
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary">${cat.productCount} sản phẩm</span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/manage/categories?action=edit&id=${cat.id}" 
                                                       class="btn btn-action btn-edit" title="Sửa">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-action btn-delete" 
                                                            onclick="confirmDelete(${cat.id}, '${cat.name}', ${cat.productCount})" title="Xóa">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content" style="background: var(--admin-card-bg); border: 1px solid var(--admin-border);">
                <div class="modal-header border-bottom" style="border-color: var(--admin-border) !important;">
                    <h5 class="modal-title"><i class="bi bi-exclamation-triangle text-danger me-2"></i>Xác nhận xóa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa danh mục "<span id="deleteName"></span>"?</p>
                    <p id="warningMessage" class="text-danger mb-0"></p>
                </div>
                <div class="modal-footer border-top" style="border-color: var(--admin-border) !important;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <a href="#" id="deleteConfirmBtn" class="btn btn-danger">
                        <i class="bi bi-trash me-2"></i>Xóa
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id, name, productCount) {
            document.getElementById('deleteName').textContent = name;
            document.getElementById('deleteConfirmBtn').href = '${pageContext.request.contextPath}/manage/categories?action=delete&id=' + id;
            
            var warning = document.getElementById('warningMessage');
            if (productCount > 0) {
                warning.innerHTML = '<i class="bi bi-exclamation-circle me-1"></i>Danh mục này đang có ' + productCount + ' sản phẩm. Không thể xóa!';
                document.getElementById('deleteConfirmBtn').classList.add('disabled');
            } else {
                warning.innerHTML = '<small>Hành động này không thể hoàn tác!</small>';
                document.getElementById('deleteConfirmBtn').classList.remove('disabled');
            }
            
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        document.querySelector('.sidebar-toggle')?.addEventListener('click', function() {
            document.querySelector('.admin-sidebar').classList.toggle('show');
        });
    </script>
</body>
</html>
