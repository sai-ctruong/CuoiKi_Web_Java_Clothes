<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="fas fa-list me-2"></i>Quản Lý Danh Mục</h1>
        <a href="${pageContext.request.contextPath}/admin/categories?action=add" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Thêm Danh Mục Mới
        </a>
    </div>
    
    <div class="card">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty categories}">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên Danh Mục</th>
                                <th>Mô Tả</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>${category.id}</td>
                                    <td>${category.name}</td>
                                    <td>${category.description != null ? category.description : '-'}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${category.id}" 
                                           class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${category.id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
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
                        <i class="fas fa-info-circle me-2"></i>Chưa có danh mục nào. 
                        <a href="${pageContext.request.contextPath}/admin/categories?action=add">Thêm danh mục đầu tiên</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
