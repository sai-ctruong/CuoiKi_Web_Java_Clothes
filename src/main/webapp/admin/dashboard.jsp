<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp" />

<div class="container-fluid">
    <h1 class="mb-4">
        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
    </h1>
    
    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-subtitle mb-2 text-white-50">Tổng Sản Phẩm</h6>
                            <h2 class="card-title mb-0">${totalProducts}</h2>
                        </div>
                        <div>
                            <i class="fas fa-tshirt fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/products" class="text-white text-decoration-none">
                        Xem chi tiết <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-subtitle mb-2 text-white-50">Danh Mục</h6>
                            <h2 class="card-title mb-0">${totalCategories}</h2>
                        </div>
                        <div>
                            <i class="fas fa-list fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="text-white text-decoration-none">
                        Xem chi tiết <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-subtitle mb-2 text-white-50">Thương Hiệu</h6>
                            <h2 class="card-title mb-0">${totalBrands}</h2>
                        </div>
                        <div>
                            <i class="fas fa-tag fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/brands" class="text-white text-decoration-none">
                        Xem chi tiết <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card bg-warning text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-subtitle mb-2 text-white-50">Đơn Hàng</h6>
                            <h2 class="card-title mb-0">${totalOrders}</h2>
                        </div>
                        <div>
                            <i class="fas fa-shopping-cart fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card bg-secondary text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-subtitle mb-2 text-white-50">Người Dùng</h6>
                            <h2 class="card-title mb-0">${totalUsers}</h2>
                        </div>
                        <div>
                            <i class="fas fa-users fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">Thao Tác Nhanh</h5>
        </div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-primary w-100">
                        <i class="fas fa-plus me-2"></i>Thêm Sản Phẩm
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/categories?action=add" class="btn btn-success w-100">
                        <i class="fas fa-plus me-2"></i>Thêm Danh Mục
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/brands?action=add" class="btn btn-info w-100">
                        <i class="fas fa-plus me-2"></i>Thêm Thương Hiệu
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
