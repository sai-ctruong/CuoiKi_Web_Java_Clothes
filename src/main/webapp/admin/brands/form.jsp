<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h4>
                        <c:choose>
                            <c:when test="${not empty brand}">
                                <i class="fas fa-edit me-2"></i>Sửa Thương Hiệu
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus me-2"></i>Thêm Thương Hiệu Mới
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/brands">
                        <c:if test="${not empty brand}">
                            <input type="hidden" name="id" value="${brand.id}">
                            <input type="hidden" name="action" value="edit">
                        </c:if>
                        
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên Thương Hiệu <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="${brand.name != null ? brand.name : ''}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="logo_url" class="form-label">Logo URL</label>
                            <input type="url" class="form-control" id="logo_url" name="logo_url" 
                                   value="${brand.logoUrl != null ? brand.logoUrl : ''}"
                                   placeholder="https://example.com/logo.png">
                            <small class="form-text text-muted">Nhập URL của logo thương hiệu</small>
                        </div>
                        
                        <div class="mb-3">
                            <label for="origin" class="form-label">Xuất Xứ</label>
                            <input type="text" class="form-control" id="origin" name="origin" 
                                   value="${brand.origin != null ? brand.origin : ''}"
                                   placeholder="Ví dụ: Việt Nam, USA, China...">
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/brands" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
