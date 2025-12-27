<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Get current page for active menu highlighting
    String uri = request.getRequestURI();
    String currentPage = "";
    if (uri.contains("dashboard")) currentPage = "dashboard";
    else if (uri.contains("products") || uri.contains("product-form")) currentPage = "products";
    else if (uri.contains("categories") || uri.contains("category-form")) currentPage = "categories";
    else if (uri.contains("brands") || uri.contains("brand-form")) currentPage = "brands";
    else if (uri.contains("orders")) currentPage = "orders";
    else if (uri.contains("users")) currentPage = "users";
    request.setAttribute("currentPage", currentPage);
%>
<!-- Admin Sidebar -->
<aside class="admin-sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-brand">
            <i class="bi bi-bag-heart"></i>
            <span>Clothing Shop</span>
        </a>
    </div>
    
    <nav class="sidebar-nav">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/dashboard">
                    <i class="bi bi-speedometer2"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <li class="nav-section">QUẢN LÝ SẢN PHẨM</li>
            
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'products' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manage/products">
                    <i class="bi bi-box-seam"></i>
                    <span>Sản phẩm</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'categories' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manage/categories">
                    <i class="bi bi-grid"></i>
                    <span>Danh mục</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'brands' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manage/brands">
                    <i class="bi bi-award"></i>
                    <span>Thương hiệu</span>
                </a>
            </li>
            
            <li class="nav-section">QUẢN LÝ ĐƠN HÀNG</li>
            
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'orders' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manage/orders">
                    <i class="bi bi-cart-check"></i>
                    <span>Đơn hàng</span>
                </a>
            </li>
            
            <li class="nav-section">HỆ THỐNG</li>
            
            <li class="nav-item">
                <a class="nav-link ${currentPage == 'users' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/manage/users">
                    <i class="bi bi-people"></i>
                    <span>Người dùng</span>
                </a>
            </li>
        </ul>
    </nav>
    
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm w-100">
            <i class="bi bi-house me-2"></i>Về trang chủ
        </a>
    </div>
</aside>
