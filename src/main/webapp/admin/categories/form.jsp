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
                            <c:when test="${not empty category}">
                                <i class="fas fa-edit me-2"></i>Sửa Danh Mục
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus me-2"></i>Thêm Danh Mục Mới
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                        <c:if test="${not empty category}">
                            <input type="hidden" name="id" value="${category.id}">
                            <input type="hidden" name="action" value="edit">
                        </c:if>
                        
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên Danh Mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="${category.name != null ? category.name : ''}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô Tả</label>
                            <textarea class="form-control" id="description" name="description" rows="4">${category.description != null ? category.description : ''}</textarea>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
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
