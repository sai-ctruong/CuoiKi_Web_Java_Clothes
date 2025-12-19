<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />

<div class="container-fluid">
    <div class="row">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header">
                    <h4>
                        <c:choose>
                            <c:when test="${not empty product}">
                                <i class="fas fa-edit me-2"></i>Sửa Sản Phẩm
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus me-2"></i>Thêm Sản Phẩm Mới
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/products" 
                          enctype="multipart/form-data">
                        <c:if test="${not empty product}">
                            <input type="hidden" name="id" value="${product.id}">
                            <input type="hidden" name="action" value="edit">
                        </c:if>
                        
                        <div class="row">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${product.name != null ? product.name : ''}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô Tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="5">${product.description != null ? product.description : ''}</textarea>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="price" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control" id="price" name="price" 
                                                   value="${product.price != null ? product.price : ''}" 
                                                   min="0" step="1000" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label for="size" class="form-label">Size</label>
                                            <input type="text" class="form-control" id="size" name="size" 
                                                   value="${product.size != null ? product.size : ''}"
                                                   placeholder="S, M, L, XL...">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label for="color" class="form-label">Màu</label>
                                            <input type="text" class="form-control" id="color" name="color" 
                                                   value="${product.color != null ? product.color : ''}"
                                                   placeholder="Đỏ, Xanh, Đen...">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="category_id" class="form-label">Danh Mục</label>
                                            <select class="form-select" id="category_id" name="category_id">
                                                <option value="">-- Chọn danh mục --</option>
                                                <c:forEach var="category" items="${categories}">
                                                    <option value="${category.id}" 
                                                            ${product.category != null && product.category.id == category.id ? 'selected' : ''}>
                                                        ${category.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="brand_id" class="form-label">Thương Hiệu</label>
                                            <select class="form-select" id="brand_id" name="brand_id">
                                                <option value="">-- Chọn thương hiệu --</option>
                                                <c:forEach var="brand" items="${brands}">
                                                    <option value="${brand.id}" 
                                                            ${product.brand != null && product.brand.id == brand.id ? 'selected' : ''}>
                                                        ${brand.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="images" class="form-label">
                                        <c:choose>
                                            <c:when test="${not empty product}">
                                                Thêm Ảnh Mới
                                            </c:when>
                                            <c:otherwise>
                                                Hình Ảnh Sản Phẩm <span class="text-danger">*</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </label>
                                    <input type="file" class="form-control" id="images" name="images" 
                                           accept="image/*" multiple>
                                    <small class="form-text text-muted">
                                        Chọn một hoặc nhiều ảnh (JPG, PNG, GIF). Kích thước tối đa 5MB mỗi ảnh.
                                    </small>
                                    <c:if test="${empty product}">
                                        <div class="mt-2">
                                            <label class="form-label">Chọn ảnh đại diện:</label>
                                            <select class="form-select" id="thumbnail_image_id" name="thumbnail_image_id" disabled>
                                                <option value="">Chọn sau khi upload</option>
                                            </select>
                                            <small class="form-text text-muted">
                                                Vui lòng chọn ảnh trước, sau đó chọn ảnh đại diện
                                            </small>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- Existing Images (for edit mode) -->
                            <c:if test="${not empty product and not empty product.images}">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label class="form-label">Ảnh Hiện Tại</label>
                                        <div class="row g-2">
                                            <c:forEach var="image" items="${product.images}">
                                                <div class="col-6">
                                                    <div class="card position-relative">
                                                        <img src="${pageContext.request.contextPath}/${image.imageUrl}" 
                                                             class="card-img-top" 
                                                             style="height: 100px; object-fit: cover;"
                                                             alt="Product image">
                                                        <c:if test="${image.isThumbnail}">
                                                            <span class="badge bg-success position-absolute top-0 start-0 m-1">
                                                                <i class="fas fa-star"></i> Đại diện
                                                            </span>
                                                        </c:if>
                                                        <div class="card-body p-2">
                                                            <div class="btn-group btn-group-sm w-100" role="group">
                                                                <a href="${pageContext.request.contextPath}/admin/products?action=set-thumbnail&imageId=${image.id}&productId=${product.id}" 
                                                                   class="btn btn-sm btn-warning" title="Đặt làm ảnh đại diện">
                                                                    <i class="fas fa-star"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/admin/products?action=delete-image&imageId=${image.id}&productId=${product.id}" 
                                                                   class="btn btn-sm btn-danger"
                                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa ảnh này?')" 
                                                                   title="Xóa ảnh">
                                                                    <i class="fas fa-trash"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Enable thumbnail selection after file selection (for add mode)
    document.getElementById('images')?.addEventListener('change', function(e) {
        const thumbnailSelect = document.getElementById('thumbnail_image_id');
        if (thumbnailSelect && this.files.length > 0) {
            thumbnailSelect.disabled = false;
            thumbnailSelect.innerHTML = '<option value="">-- Chọn ảnh đại diện --</option>';
            for (let i = 0; i < this.files.length; i++) {
                const option = document.createElement('option');
                option.value = i;
                option.textContent = 'Ảnh ' + (i + 1) + ': ' + this.files[i].name;
                thumbnailSelect.appendChild(option);
            }
        }
    });
</script>

<jsp:include page="../includes/footer.jsp" />
