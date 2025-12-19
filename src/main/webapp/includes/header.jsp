<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Clothing Shop - Thời Trang Đẳng Cấp</title>

            <!-- Bootstrap 5 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <!-- Custom CSS -->
            <link rel="stylesheet" href="assets/css/main.css">
        </head>

        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
                <section class="container">
                    <a class="navbar-brand fw-bold" href="home">
                        <i class="fas fa-tshirt me-2"></i>Clothing Shop
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <nav class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="home">Trang Chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="products">Sản Phẩm</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    Danh Mục
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="category?id=1">Áo Nam</a></li>
                                    <li><a class="dropdown-item" href="category?id=2">Áo Nữ</a></li>
                                    <li><a class="dropdown-item" href="category?id=3">Quần Nam</a></li>
                                    <li><a class="dropdown-item" href="category?id=4">Quần Nữ</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="about">Giới Thiệu</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="contact">Liên Hệ</a>
                            </li>
                        </ul>

                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="search">
                                    <i class="fas fa-search"></i>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link position-relative" href="cart">
                                    <i class="fas fa-shopping-cart"></i>
                                    <span id="cartCount"
                                        class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                        ${empty sessionScope.cart ? 0 : sessionScope.cart.totalItems}
                                    </span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="login">
                                    <i class="fas fa-user"></i> Đăng Nhập
                                </a>
                            </li>
                        </ul>
                    </nav>
                </section>
            </nav>

            <!-- Add padding to body to account for fixed navbar -->
            <section style="padding-top: 76px;">
                <div class="container mt-3">
                    <!-- Server-side Messages -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="successMessage" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session" />
                    </c:if>
                </div>
            </section>