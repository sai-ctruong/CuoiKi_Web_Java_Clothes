<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="bg-dark text-white p-3" style="min-height: 100vh; width: 250px; position: fixed; left: 0; top: 0;">
    <div class="d-flex flex-column">
        <h4 class="mb-4">
            <i class="fas fa-cog me-2"></i>Admin Panel
        </h4>
        
        <nav class="nav flex-column">
            <a class="nav-link text-white ${pageContext.request.requestURI.contains('dashboard') ? 'active bg-primary' : ''}" 
               href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
            </a>
            
            <a class="nav-link text-white ${pageContext.request.requestURI.contains('products') ? 'active bg-primary' : ''}" 
               href="${pageContext.request.contextPath}/admin/products">
                <i class="fas fa-tshirt me-2"></i>Sản Phẩm
            </a>
            
            <a class="nav-link text-white ${pageContext.request.requestURI.contains('categories') ? 'active bg-primary' : ''}" 
               href="${pageContext.request.contextPath}/admin/categories">
                <i class="fas fa-list me-2"></i>Danh Mục
            </a>
            
            <a class="nav-link text-white ${pageContext.request.requestURI.contains('brands') ? 'active bg-primary' : ''}" 
               href="${pageContext.request.contextPath}/admin/brands">
                <i class="fas fa-tag me-2"></i>Thương Hiệu
            </a>
            
            <hr class="text-white-50 my-2">
            
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/">
                <i class="fas fa-home me-2"></i>Về Trang Chủ
            </a>
            
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt me-2"></i>Đăng Xuất
            </a>
        </nav>
    </div>
</aside>

<style>
    .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1) !important;
    }
    .nav-link.active {
        font-weight: bold;
    }
</style>
