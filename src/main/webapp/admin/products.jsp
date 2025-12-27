<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm - Admin</title>
    
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
                    <h4 class="page-title mb-0">Quản lý Sản phẩm</h4>
                </div>
                <div class="header-right">
                    <a href="${pageContext.request.contextPath}/manage/products?action=add" class="btn btn-primary">
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
                
                <!-- Data Table -->
                <div class="data-table">
                    <div class="data-table-header">
                        <h5><i class="bi bi-box-seam me-2"></i>Danh sách sản phẩm (${products.size()})</h5>
                        <form action="${pageContext.request.contextPath}/manage/products" method="get" class="d-flex gap-2" style="max-width: 400px;">
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Tìm kiếm..." value="${keyword}">
                            <button type="submit" class="btn btn-outline-warning">Tìm</button>
                        </form>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 60px;">Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Danh mục</th>
                                    <th>Thương hiệu</th>
                                    <th>Giá</th>
                                    <th>Size</th>
                                    <th>Màu</th>
                                    <th style="width: 120px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty products}">
                                        <tr>
                                            <td colspan="8">
                                                <div class="empty-state">
                                                    <i class="bi bi-inbox"></i>
                                                    <p>Chưa có sản phẩm nào</p>
                                                    <a href="${pageContext.request.contextPath}/manage/products?action=add" class="btn btn-primary">
                                                        <i class="bi bi-plus-lg me-2"></i>Thêm sản phẩm đầu tiên
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${products}" var="p">
                                            <tr>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty p.thumbnailUrl}">
                                                            <img src="${pageContext.request.contextPath}${p.thumbnailUrl}" alt="${p.name}" class="product-thumb">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="product-thumb d-flex align-items-center justify-content-center" 
                                                                 style="background: var(--admin-border);">
                                                                <i class="bi bi-image text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <strong>${p.name}</strong>
                                                    <c:if test="${not empty p.description}">
                                                        <br><small class="text-muted">${p.description.length() > 50 ? p.description.substring(0, 50).concat("...") : p.description}</small>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty p.categoryName}">
                                                        <span class="badge-category">${p.categoryName}</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty p.brandName}">
                                                        <span class="badge-brand">${p.brandName}</span>
                                                    </c:if>
                                                </td>
                                                <td class="price-display">
                                                    <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                                                </td>
                                                <td>${p.size}</td>
                                                <td>${p.color}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/manage/products?action=edit&id=${p.id}" 
                                                       class="btn btn-action btn-edit" title="Sửa">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-action btn-delete" 
                                                            onclick="confirmDelete(${p.id}, '${p.name}')" title="Xóa">
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

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content" style="background: var(--admin-card-bg); border: 1px solid var(--admin-border);">
                <div class="modal-header border-bottom" style="border-color: var(--admin-border) !important;">
                    <h5 class="modal-title"><i class="bi bi-exclamation-triangle text-danger me-2"></i>Xác nhận xóa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa sản phẩm "<span id="deleteProductName"></span>"?</p>
                    <p class="text-danger mb-0"><small>Hành động này không thể hoàn tác!</small></p>
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
        function confirmDelete(id, name) {
            document.getElementById('deleteProductName').textContent = name;
            document.getElementById('deleteConfirmBtn').href = '${pageContext.request.contextPath}/manage/products?action=delete&id=' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        document.querySelector('.sidebar-toggle')?.addEventListener('click', function() {
            document.querySelector('.admin-sidebar').classList.toggle('show');
        });
    </script>
</body>
</html>
