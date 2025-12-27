<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${formAction == 'add' ? 'Thêm' : 'Sửa'} Sản phẩm - Admin</title>
    
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
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manage/products">Sản phẩm</a></li>
                            <li class="breadcrumb-item active">${formAction == 'add' ? 'Thêm mới' : 'Chỉnh sửa'}</li>
                        </ol>
                    </nav>
                </div>
            </header>
            
            <main class="admin-content">
                <div class="admin-form">
                    <h5 class="mb-4">
                        <i class="bi bi-${formAction == 'add' ? 'plus-circle' : 'pencil'} me-2"></i>
                        ${formAction == 'add' ? 'Thêm sản phẩm mới' : 'Chỉnh sửa sản phẩm'}
                    </h5>
                    
                    <form action="${pageContext.request.contextPath}/manage/products" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="${formAction}">
                        <c:if test="${formAction == 'edit'}">
                            <input type="hidden" name="id" value="${product.id}">
                        </c:if>
                        
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${product.name}" required placeholder="Nhập tên sản phẩm">
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" 
                                              placeholder="Nhập mô tả sản phẩm">${product.description}</textarea>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="price" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control" id="price" name="price" 
                                                   value="${product.price}" required min="0" step="1000" placeholder="0">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="size" class="form-label">Size</label>
                                            <select class="form-select" id="size" name="size">
                                                <option value="">-- Chọn size --</option>
                                                <option value="XS" ${product.size == 'XS' ? 'selected' : ''}>XS</option>
                                                <option value="S" ${product.size == 'S' ? 'selected' : ''}>S</option>
                                                <option value="M" ${product.size == 'M' ? 'selected' : ''}>M</option>
                                                <option value="L" ${product.size == 'L' ? 'selected' : ''}>L</option>
                                                <option value="XL" ${product.size == 'XL' ? 'selected' : ''}>XL</option>
                                                <option value="XXL" ${product.size == 'XXL' ? 'selected' : ''}>XXL</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="color" class="form-label">Màu sắc</label>
                                            <input type="text" class="form-control" id="color" name="color" 
                                                   value="${product.color}" placeholder="Ví dụ: Đen, Trắng...">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="categoryId" class="form-label">Danh mục</label>
                                            <select class="form-select" id="categoryId" name="categoryId">
                                                <option value="">-- Chọn danh mục --</option>
                                                <c:forEach items="${categories}" var="cat">
                                                    <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="brandId" class="form-label">Thương hiệu</label>
                                            <select class="form-select" id="brandId" name="brandId">
                                                <option value="">-- Chọn thương hiệu --</option>
                                                <c:forEach items="${brands}" var="brand">
                                                    <option value="${brand.id}" ${product.brandId == brand.id ? 'selected' : ''}>${brand.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4">
                                <div class="mb-3">
                                    <label class="form-label">Ảnh sản phẩm</label>
                                    <div class="image-upload-wrapper ${not empty product.thumbnailUrl ? 'has-image' : ''}" onclick="document.getElementById('image').click()">
                                        <c:choose>
                                            <c:when test="${not empty product.thumbnailUrl}">
                                                <img src="${pageContext.request.contextPath}${product.thumbnailUrl}" alt="Product Image" id="imagePreview">
                                            </c:when>
                                            <c:otherwise>
                                                <div id="uploadPlaceholder">
                                                    <i class="bi bi-cloud-upload" style="font-size: 3rem; color: var(--admin-text-muted);"></i>
                                                    <p class="mt-2 mb-0 text-muted">Click để chọn ảnh</p>
                                                    <small class="text-muted">JPG, PNG, GIF (Max 10MB)</small>
                                                </div>
                                                <img src="" alt="Product Image" id="imagePreview" style="display: none;">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <input type="file" class="d-none" id="image" name="image" accept="image/*" onchange="previewImage(this)">
                                </div>
                            </div>
                        </div>
                        
                        <hr style="border-color: var(--admin-border);">
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-2"></i>${formAction == 'add' ? 'Thêm sản phẩm' : 'Lưu thay đổi'}
                            </button>
                            <a href="${pageContext.request.contextPath}/manage/products" class="btn btn-secondary">
                                <i class="bi bi-x-lg me-2"></i>Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var preview = document.getElementById('imagePreview');
                    var placeholder = document.getElementById('uploadPlaceholder');
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    if (placeholder) placeholder.style.display = 'none';
                    document.querySelector('.image-upload-wrapper').classList.add('has-image');
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        document.querySelector('.sidebar-toggle')?.addEventListener('click', function() {
            document.querySelector('.admin-sidebar').classList.toggle('show');
        });
    </script>
</body>
</html>
