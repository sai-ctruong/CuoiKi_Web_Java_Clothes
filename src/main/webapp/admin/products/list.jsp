<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="fas fa-tshirt me-2"></i>Quản Lý Sản Phẩm</h1>
        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Thêm Sản Phẩm Mới
        </a>
    </div>
    
    <div class="card">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty products}">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Hình Ảnh</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Danh Mục</th>
                                <th>Thương Hiệu</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>${product.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty product.thumbnail}">
                                                <img src="${pageContext.request.contextPath}/${product.thumbnail}" 
                                                     alt="${product.name}" 
                                                     style="width: 50px; height: 50px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/50" 
                                                     alt="${product.name}" 
                                                     style="width: 50px; height: 50px; object-fit: cover;">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${product.name}</td>
                                    <td>
                                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" /> đ
                                    </td>
                                    <td>${product.category != null ? product.category.name : '-'}</td>
                                    <td>${product.brand != null ? product.brand.name : '-'}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}" 
                                           class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${product.id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
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
                        <i class="fas fa-info-circle me-2"></i>Chưa có sản phẩm nào. 
                        <a href="${pageContext.request.contextPath}/admin/products?action=add">Thêm sản phẩm đầu tiên</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
