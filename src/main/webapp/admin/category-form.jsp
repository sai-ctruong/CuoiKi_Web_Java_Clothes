<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${formAction == 'add' ? 'Thêm' : 'Sửa'} Danh mục - Admin</title>
    
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
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manage/categories">Danh mục</a></li>
                            <li class="breadcrumb-item active">${formAction == 'add' ? 'Thêm mới' : 'Chỉnh sửa'}</li>
                        </ol>
                    </nav>
                </div>
            </header>
            
            <main class="admin-content">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="admin-form">
                            <h5 class="mb-4">
                                <i class="bi bi-${formAction == 'add' ? 'folder-plus' : 'pencil'} me-2"></i>
                                ${formAction == 'add' ? 'Thêm danh mục mới' : 'Chỉnh sửa danh mục'}
                            </h5>
                            
                            <form action="${pageContext.request.contextPath}/manage/categories" method="post">
                                <input type="hidden" name="action" value="${formAction}">
                                <c:if test="${formAction == 'edit'}">
                                    <input type="hidden" name="id" value="${category.id}">
                                </c:if>
                                
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${category.name}" required placeholder="Ví dụ: Áo Thun, Quần Jean...">
                                </div>
                                
                                <div class="mb-4">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="3" 
                                              placeholder="Mô tả ngắn về danh mục">${category.description}</textarea>
                                </div>
                                
                                <hr style="border-color: var(--admin-border);">
                                
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-lg me-2"></i>${formAction == 'add' ? 'Thêm danh mục' : 'Lưu thay đổi'}
                                    </button>
                                    <a href="${pageContext.request.contextPath}/manage/categories" class="btn btn-secondary">
                                        <i class="bi bi-x-lg me-2"></i>Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.querySelector('.sidebar-toggle')?.addEventListener('click', function() {
            document.querySelector('.admin-sidebar').classList.toggle('show');
        });
    </script>
</body>
</html>
