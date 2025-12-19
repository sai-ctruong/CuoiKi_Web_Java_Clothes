<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="fas fa-tag me-2"></i>Quản Lý Thương Hiệu</h1>
        <a href="${pageContext.request.contextPath}/admin/brands?action=add" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Thêm Thương Hiệu Mới
        </a>
    </div>
    
    <div class="card">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty brands}">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên Thương Hiệu</th>
                                <th>Logo URL</th>
                                <th>Xuất Xứ</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="brand" items="${brands}">
                                <tr>
                                    <td>${brand.id}</td>
                                    <td>${brand.name}</td>
                                    <td>
                                        <c:if test="${not empty brand.logoUrl}">
                                            <img src="${brand.logoUrl}" alt="${brand.name}" style="max-width: 50px; max-height: 50px;">
                                        </c:if>
                                        <c:if test="${empty brand.logoUrl}">-</c:if>
                                    </td>
                                    <td>${brand.origin != null ? brand.origin : '-'}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/brands?action=edit&id=${brand.id}" 
                                           class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/brands?action=delete&id=${brand.id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa thương hiệu này?')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>Chưa có thương hiệu nào. 
                        <a href="${pageContext.request.contextPath}/admin/brands?action=add">Thêm thương hiệu đầu tiên</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
