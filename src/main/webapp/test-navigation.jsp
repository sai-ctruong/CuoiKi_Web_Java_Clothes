<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Navigation - Clothing Shop</title>
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <style>
        .test-section {
            margin: 2rem 0;
            padding: 1.5rem;
            border: 1px solid #dee2e6;
            border-radius: 0.5rem;
        }
        .test-link {
            display: inline-block;
            margin: 0.25rem;
            padding: 0.5rem 1rem;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            text-decoration: none;
            color: #495057;
        }
        .test-link:hover {
            background: #e9ecef;
            color: #495057;
            text-decoration: none;
        }
        .status-ok { border-color: #28a745; background: #d4edda; }
        .status-error { border-color: #dc3545; background: #f8d7da; }
    </style>
</head>
<body>
    <div class="container my-5">
        <h1 class="mb-4">Navigation Test Page</h1>
        <p class="text-muted">Click on each link to test if it works correctly. This page helps identify any 404 errors.</p>
        
        <!-- Main Navigation Links -->
        <div class="test-section">
            <h3>Main Navigation</h3>
            <a href="${pageContext.request.contextPath}/home" class="test-link">
                <i class="bi bi-house me-1"></i>Home (/home)
            </a>
            <a href="${pageContext.request.contextPath}/products" class="test-link">
                <i class="bi bi-grid me-1"></i>Products (/products)
            </a>
            <a href="${pageContext.request.contextPath}/about" class="test-link">
                <i class="bi bi-info-circle me-1"></i>About (/about)
            </a>
            <a href="${pageContext.request.contextPath}/contact" class="test-link">
                <i class="bi bi-telephone me-1"></i>Contact (/contact)
            </a>
        </div>
        
        <!-- Category Links -->
        <div class="test-section">
            <h3>Category Links</h3>
            <a href="${pageContext.request.contextPath}/category?id=1" class="test-link">
                Category 1 (/category?id=1)
            </a>
            <a href="${pageContext.request.contextPath}/category?id=2" class="test-link">
                Category 2 (/category?id=2)
            </a>
            <a href="${pageContext.request.contextPath}/category?id=3" class="test-link">
                Category 3 (/category?id=3)
            </a>
            <a href="${pageContext.request.contextPath}/category?id=4" class="test-link">
                Category 4 (/category?id=4)
            </a>
        </div>
        
        <!-- User Pages -->
        <div class="test-section">
            <h3>User Pages</h3>
            <a href="${pageContext.request.contextPath}/login" class="test-link">
                <i class="bi bi-box-arrow-in-right me-1"></i>Login (/login)
            </a>
            <a href="${pageContext.request.contextPath}/register" class="test-link">
                <i class="bi bi-person-plus me-1"></i>Register (/register)
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="test-link">
                <i class="bi bi-person me-1"></i>Profile (/profile)
            </a>
            <a href="${pageContext.request.contextPath}/forgot-password" class="test-link">
                <i class="bi bi-key me-1"></i>Forgot Password (/forgot-password)
            </a>
            <a href="${pageContext.request.contextPath}/orders" class="test-link">
                <i class="bi bi-box me-1"></i>Orders (/orders)
            </a>
            <a href="${pageContext.request.contextPath}/address" class="test-link">
                <i class="bi bi-geo-alt me-1"></i>Address (/address)
            </a>
        </div>
        
        <!-- Shopping Pages -->
        <div class="test-section">
            <h3>Shopping Pages</h3>
            <a href="${pageContext.request.contextPath}/cart" class="test-link">
                <i class="bi bi-bag me-1"></i>Cart (/cart)
            </a>
            <a href="${pageContext.request.contextPath}/wishlist" class="test-link">
                <i class="bi bi-heart me-1"></i>Wishlist (/wishlist)
            </a>
            <a href="${pageContext.request.contextPath}/checkout" class="test-link">
                <i class="bi bi-credit-card me-1"></i>Checkout (/checkout)
            </a>
            <a href="${pageContext.request.contextPath}/search" class="test-link">
                <i class="bi bi-search me-1"></i>Search (/search)
            </a>
            <a href="${pageContext.request.contextPath}/product?id=1" class="test-link">
                <i class="bi bi-eye me-1"></i>Product Detail (/product?id=1)
            </a>
        </div>
        
        <!-- Admin Pages (may require login) -->
        <div class="test-section">
            <h3>Admin Pages (May Require Login)</h3>
            <a href="${pageContext.request.contextPath}/dashboard" class="test-link">
                <i class="bi bi-speedometer2 me-1"></i>Dashboard (/dashboard)
            </a>
            <a href="${pageContext.request.contextPath}/manage/products" class="test-link">
                <i class="bi bi-grid me-1"></i>Manage Products (/manage/products)
            </a>
            <a href="${pageContext.request.contextPath}/manage/categories" class="test-link">
                <i class="bi bi-tags me-1"></i>Manage Categories (/manage/categories)
            </a>
            <a href="${pageContext.request.contextPath}/manage/brands" class="test-link">
                <i class="bi bi-award me-1"></i>Manage Brands (/manage/brands)
            </a>
            <a href="${pageContext.request.contextPath}/manage/orders" class="test-link">
                <i class="bi bi-box me-1"></i>Manage Orders (/manage/orders)
            </a>
            <a href="${pageContext.request.contextPath}/manage/users" class="test-link">
                <i class="bi bi-people me-1"></i>Manage Users (/manage/users)
            </a>
        </div>
        
        <!-- Error Testing -->
        <div class="test-section">
            <h3>Error Testing</h3>
            <a href="${pageContext.request.contextPath}/nonexistent-page" class="test-link">
                <i class="bi bi-exclamation-triangle me-1"></i>404 Test (/nonexistent-page)
            </a>
            <a href="${pageContext.request.contextPath}/error" class="test-link">
                <i class="bi bi-exclamation-circle me-1"></i>Error Page (/error)
            </a>
        </div>
        
        <div class="alert alert-info mt-4">
            <h5>Testing Instructions:</h5>
            <ul class="mb-0">
                <li>Click each link to verify it loads without 404 errors</li>
                <li>Admin pages may redirect to login if not authenticated</li>
                <li>Some pages may show empty content if no data exists</li>
                <li>The 404 test link should show the custom error page</li>
                <li>If any link shows a 404 error, there's a mapping issue to fix</li>
            </ul>
        </div>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                <i class="bi bi-house me-2"></i>Back to Home
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>