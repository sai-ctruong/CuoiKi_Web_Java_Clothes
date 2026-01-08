<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Clothing Shop</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #c9a962;
            --accent-dark: #b8975a;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #3498db;
            --light-bg: #f8f9fa;
            --white: #ffffff;
            --text-dark: #2c3e50;
            --text-body: #495057;
            --text-muted: #6c757d;
            --border-color: #dee2e6;
            --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --shadow-md: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            --shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            --radius: 0.5rem;
            --radius-lg: 1rem;
            --radius-xl: 1.5rem;
            --transition: all 0.3s ease;
        }
        
        body {
            padding-top: 70px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }
        
        .checkout-page { 
            padding: 3rem 0 4rem; 
            min-height: calc(100vh - 70px); 
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-md);
            color: var(--white);
        }
        
        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .page-title i {
            color: var(--accent-color);
            filter: drop-shadow(1px 1px 2px rgba(0,0,0,0.3));
        }
        
        .page-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            font-weight: 400;
        }
        
        .checkout-card { 
            background: var(--white); 
            border-radius: var(--radius-xl); 
            box-shadow: var(--shadow-lg); 
            overflow: hidden; 
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .checkout-header { 
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
            color: var(--white); 
            padding: 2rem; 
            position: relative;
        }
        
        .checkout-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 20px;
            background: var(--white);
            border-radius: 50% 50% 0 0 / 100% 100% 0 0;
        }
        
        .checkout-header h4 { 
            font-family: 'Playfair Display', serif; 
            font-size: 1.6rem;
            font-weight: 600;
            margin: 0; 
            position: relative;
            z-index: 2;
            color: var(--white);
        }
        
        .checkout-body { 
            padding: 2.5rem; 
            background: var(--white);
        }
        
        .form-label { 
            font-weight: 600; 
            color: var(--text-dark); 
            margin-bottom: 0.75rem;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }
        
        .form-label i {
            color: var(--accent-color);
            margin-right: 0.5rem;
        }
        
        .form-control, .form-select { 
            border-radius: var(--radius); 
            padding: 1rem 1.25rem; 
            border: 2px solid var(--border-color); 
            transition: var(--transition);
            font-size: 1rem;
            background: var(--white);
            color: var(--text-dark);
        }
        
        .form-control:focus, .form-select:focus { 
            border-color: var(--accent-color); 
            box-shadow: 0 0 0 0.2rem rgba(201, 169, 98, 0.25); 
            background: var(--white);
            color: var(--text-dark);
        }
        
        .form-control::placeholder {
            color: var(--text-muted);
        }
        
        .required-field {
            color: var(--danger-color);
            font-weight: 700;
        }
        
        .order-item { 
            display: flex; 
            align-items: center; 
            padding: 1.5rem; 
            margin-bottom: 1rem;
            background: var(--light-bg);
            border-radius: var(--radius-lg);
            transition: var(--transition);
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .order-items {
            max-height: none; /* Bỏ giới hạn chiều cao */
        }
        
        /* Nếu có quá nhiều sản phẩm (>8), thêm scroll */
        .order-items.many-items {
            max-height: 600px;
            overflow-y: auto;
            padding-right: 0.5rem;
        }
        
        /* Custom scrollbar */
        .order-items.many-items::-webkit-scrollbar {
            width: 6px;
        }
        
        .order-items.many-items::-webkit-scrollbar-track {
            background: var(--light-bg);
            border-radius: 3px;
        }
        
        .order-items.many-items::-webkit-scrollbar-thumb {
            background: var(--accent-color);
            border-radius: 3px;
        }
        
        .order-items.many-items::-webkit-scrollbar-thumb:hover {
            background: var(--accent-dark);
        }
        
        .order-item:hover {
            background: var(--white);
            box-shadow: var(--shadow-sm);
            transform: translateY(-2px);
        }
        
        .order-item:last-child { 
            margin-bottom: 0; 
        }
        
        .order-item-img { 
            width: 80px; 
            height: 100px; 
            object-fit: cover; 
            border-radius: var(--radius); 
            margin-right: 1.25rem; 
            box-shadow: var(--shadow-sm);
        }
        
        .order-item-img-placeholder { 
            width: 80px; 
            height: 100px; 
            background: var(--border-color); 
            border-radius: var(--radius); 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin-right: 1.25rem; 
            color: var(--text-muted);
            font-size: 1.5rem;
        }
        
        .order-item-info { 
            flex: 1; 
        }
        
        .order-item-name { 
            font-weight: 600; 
            font-size: 1.1rem; 
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            line-height: 1.4;
        }
        
        .order-item-qty { 
            font-size: 0.9rem; 
            color: var(--text-body); 
            background: var(--white);
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            display: inline-block;
            border: 1px solid var(--border-color);
        }
        
        .order-item-price { 
            font-weight: 700; 
            color: var(--accent-dark); 
            font-size: 1.2rem;
        }
        
        .summary-row { 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            padding: 1rem 0; 
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }
        
        .summary-row:last-child {
            border-bottom: none;
        }
        
        .summary-row.total { 
            font-size: 1.4rem; 
            font-weight: 700; 
            color: var(--accent-dark); 
            border-top: 2px solid var(--accent-color); 
            padding: 1.5rem; 
            margin-top: 1rem; 
            background: rgba(201, 169, 98, 0.1);
            border-radius: var(--radius);
            border-bottom: none;
        }
        
        .summary-row.discount { 
            color: var(--success-color); 
            font-weight: 600;
        }
        
        .summary-label {
            color: var(--text-body);
            font-weight: 500;
            font-size: 1rem;
        }
        
        .summary-value {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 1rem;
        }
        
        .payment-option { 
            border: 2px solid var(--border-color); 
            border-radius: var(--radius-lg); 
            padding: 1.5rem; 
            cursor: pointer; 
            transition: var(--transition); 
            background: var(--white);
            height: 100%;
            text-align: center;
        }
        
        .payment-option:hover { 
            border-color: var(--accent-color); 
            box-shadow: var(--shadow-sm);
            transform: translateY(-3px);
        }
        
        .payment-option.selected { 
            border-color: var(--accent-color); 
            background: rgba(201, 169, 98, 0.1); 
            box-shadow: var(--shadow-md);
        }
        
        .payment-option input { 
            display: none; 
        }
        
        .payment-option .payment-icon { 
            font-size: 2.5rem; 
            margin-bottom: 1rem; 
            display: block;
        }
        
        .payment-option strong {
            font-size: 1.1rem;
            color: var(--text-dark) !important;
            margin-bottom: 0.5rem;
            display: block;
            font-weight: 700;
        }
        
        .payment-option.selected strong {
            color: var(--accent-dark) !important;
        }
        
        .payment-option small {
            color: var(--text-muted);
            font-size: 0.9rem;
            line-height: 1.4;
        }
        
        .btn-checkout { 
            width: 100%; 
            padding: 1.5rem; 
            background: linear-gradient(135deg, var(--accent-color) 0%, var(--accent-dark) 100%); 
            color: var(--white); 
            border: none; 
            border-radius: var(--radius); 
            font-weight: 700; 
            font-size: 1.2rem; 
            cursor: pointer; 
            transition: var(--transition); 
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .btn-checkout::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-checkout:hover::before {
            left: 100%;
        }
        
        .btn-checkout:hover { 
            background: linear-gradient(135deg, var(--accent-dark) 0%, var(--primary-color) 100%); 
            transform: translateY(-3px); 
            box-shadow: 0 10px 30px rgba(201, 169, 98, 0.4);
        }
        
        .btn-checkout:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        
        .secure-badge { 
            text-align: center; 
            padding: 2rem 1rem; 
            color: var(--text-body); 
            font-size: 0.95rem; 
            background: var(--light-bg);
            border-radius: var(--radius);
            margin-top: 1.5rem;
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .secure-badge i { 
            color: var(--success-color); 
            font-size: 1.3rem;
            margin-right: 0.5rem;
        }
        
        .trust-features {
            display: flex;
            justify-content: space-around;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .trust-item {
            text-align: center;
            flex: 1;
        }
        
        .trust-item i {
            color: var(--accent-color);
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            display: block;
        }
        
        .trust-item span {
            font-size: 0.85rem;
            color: var(--text-body);
            font-weight: 500;
        }
        
        /* Alert improvements */
        .alert {
            border-radius: var(--radius-lg);
            border: none;
            padding: 1rem 1.5rem;
            font-weight: 500;
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }
        
        /* Text color fixes */
        .text-success {
            color: var(--success-color) !important;
        }
        
        .text-muted {
            color: var(--text-muted) !important;
        }
        
        small.text-muted {
            color: var(--text-muted) !important;
            font-size: 0.875rem;
        }
        
        /* Back button */
        .btn-outline-secondary {
            color: var(--text-body);
            border-color: var(--border-color);
            background: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius);
            font-weight: 500;
            transition: var(--transition);
        }
        
        .btn-outline-secondary:hover {
            background: var(--light-bg);
            border-color: var(--accent-color);
            color: var(--accent-dark);
        }
        
        /* Responsive improvements */
        @media (max-width: 991.98px) {
            .page-title {
                font-size: 2.2rem;
            }
            
            .checkout-body {
                padding: 2rem;
            }
            
            .page-header {
                padding: 1.5rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .checkout-page {
                padding: 1.5rem 0 2rem;
            }
            
            .page-header {
                margin-bottom: 2rem;
                padding: 1.5rem 1rem;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .page-subtitle {
                font-size: 1rem;
            }
            
            .checkout-header {
                padding: 1.5rem;
            }
            
            .checkout-header h4 {
                font-size: 1.3rem;
            }
            
            .checkout-body {
                padding: 1.5rem;
            }
            
            .order-item {
                flex-direction: column;
                text-align: center;
                padding: 1.5rem;
            }
            
            .order-item-img,
            .order-item-img-placeholder {
                margin-right: 0;
                margin-bottom: 1rem;
                align-self: center;
            }
            
            .order-item-info {
                margin-bottom: 1rem;
            }
            
            .payment-option {
                margin-bottom: 1rem;
                padding: 1rem;
            }
            
            .payment-option .payment-icon {
                font-size: 2rem;
            }
            
            .trust-features {
                flex-direction: column;
                gap: 1rem;
            }
            
            .summary-row {
                padding: 0.75rem 0;
            }
            
            .summary-row.total {
                font-size: 1.2rem;
                padding: 1rem;
            }
        }
        
        /* Loading animation */
        .spin {
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        /* Form enhancements */
        .form-control[readonly] {
            background: var(--light-bg) !important;
            border-color: var(--border-color) !important;
            color: var(--text-dark) !important;
        }
        
        /* Smooth transitions - only for interactive elements */
        .btn, .form-control, .form-select, .payment-option, a {
            transition: color 0.2s ease, background-color 0.2s ease, border-color 0.2s ease;
        }
        
        /* Additional color contrast improvements */
        .payment-option small {
            color: var(--text-body) !important;
            font-weight: 500;
        }
        
        .payment-option.selected small {
            color: var(--text-dark) !important;
        }
        
        .order-item-qty {
            color: var(--text-dark) !important;
            background: rgba(255, 255, 255, 0.9) !important;
            border: 1px solid var(--border-color) !important;
        }
        
        .summary-label {
            color: var(--text-dark) !important;
            font-weight: 600;
        }
        
        .summary-value {
            color: var(--text-dark) !important;
            font-weight: 700;
        }
        
        .summary-row.discount .summary-label,
        .summary-row.discount .summary-value {
            color: var(--success-color) !important;
        }
        
        .secure-badge {
            color: var(--text-dark) !important;
            background: rgba(255, 255, 255, 0.9) !important;
            border: 1px solid var(--border-color) !important;
        }
        
        .trust-item span {
            color: var(--text-dark) !important;
            font-weight: 600;
        }
        
        /* Ensure all text in cards has proper contrast */
        .checkout-card .checkout-body {
            color: var(--text-dark);
        }
        
        .checkout-card .checkout-body * {
            color: inherit;
        }
        
        .checkout-card .checkout-body .text-muted {
            color: var(--text-body) !important;
        }
        
        .checkout-card .checkout-body .text-success {
            color: var(--success-color) !important;
            font-weight: 600;
        }
        
        /* Form placeholder improvements */
        .form-control::placeholder {
            color: var(--text-body) !important;
            opacity: 0.8;
        }
        
        /* Select option improvements */
        .form-select option {
            color: var(--text-dark);
            background: var(--white);
        }
        
        /* Button text contrast */
        .btn-outline-secondary {
            color: var(--text-dark) !important;
            font-weight: 600;
        }
        
        .btn-outline-secondary:hover {
            color: var(--accent-dark) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <section class="checkout-page">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header" data-aos="fade-down">
                <h1 class="page-title">
                    <i class="bi bi-credit-card me-3"></i>Thanh toán
                </h1>
                <p class="page-subtitle">Hoàn tất đơn hàng của bạn một cách an toàn và nhanh chóng</p>
            </div>
            
            <!-- Messages -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="shake">
                    <i class="bi bi-exclamation-circle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                <div class="row g-4">
                    <!-- Shipping Info -->
                    <div class="col-lg-7">
                        <div class="checkout-card" data-aos="fade-right">
                            <div class="checkout-header">
                                <h4><i class="bi bi-truck me-3"></i>Thông Tin Nhận Hàng</h4>
                            </div>
                            <div class="checkout-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-person me-2"></i>Họ và tên 
                                            <span class="required-field">*</span>
                                        </label>
                                        <input type="text" name="fullName" class="form-control" required
                                               value="${user.fullName}" placeholder="Nhập họ và tên đầy đủ">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-telephone me-2"></i>Số điện thoại 
                                            <span class="required-field">*</span>
                                        </label>
                                        <input type="tel" name="phone" class="form-control" required
                                               value="${user.phone}" placeholder="Nhập số điện thoại">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i class="bi bi-geo-alt me-2"></i>Địa chỉ nhận hàng 
                                            <span class="required-field">*</span>
                                        </label>
                                        <input type="text" name="address" class="form-control" required
                                               placeholder="Số nhà, tên đường, phường/xã, quận/huyện">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-building me-2"></i>Tỉnh/Thành phố 
                                            <span class="required-field">*</span>
                                        </label>
                                        <select name="city" class="form-select" required>
                                            <option value="">-- Chọn tỉnh/thành phố --</option>
                                            <option value="An Giang">An Giang</option>
                                            <option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu</option>
                                            <option value="Bắc Giang">Bắc Giang</option>
                                            <option value="Bắc Kạn">Bắc Kạn</option>
                                            <option value="Bạc Liêu">Bạc Liêu</option>
                                            <option value="Bắc Ninh">Bắc Ninh</option>
                                            <option value="Bến Tre">Bến Tre</option>
                                            <option value="Bình Định">Bình Định</option>
                                            <option value="Bình Dương">Bình Dương</option>
                                            <option value="Bình Phước">Bình Phước</option>
                                            <option value="Bình Thuận">Bình Thuận</option>
                                            <option value="Cà Mau">Cà Mau</option>
                                            <option value="Cần Thơ">Cần Thơ</option>
                                            <option value="Cao Bằng">Cao Bằng</option>
                                            <option value="Đà Nẵng">Đà Nẵng</option>
                                            <option value="Đắk Lắk">Đắk Lắk</option>
                                            <option value="Đắk Nông">Đắk Nông</option>
                                            <option value="Điện Biên">Điện Biên</option>
                                            <option value="Đồng Nai">Đồng Nai</option>
                                            <option value="Đồng Tháp">Đồng Tháp</option>
                                            <option value="Gia Lai">Gia Lai</option>
                                            <option value="Hà Giang">Hà Giang</option>
                                            <option value="Hà Nam">Hà Nam</option>
                                            <option value="Hà Nội">Hà Nội</option>
                                            <option value="Hà Tĩnh">Hà Tĩnh</option>
                                            <option value="Hải Dương">Hải Dương</option>
                                            <option value="Hải Phòng">Hải Phòng</option>
                                            <option value="Hậu Giang">Hậu Giang</option>
                                            <option value="Hòa Bình">Hòa Bình</option>
                                            <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                                            <option value="Hưng Yên">Hưng Yên</option>
                                            <option value="Khánh Hòa">Khánh Hòa</option>
                                            <option value="Kiên Giang">Kiên Giang</option>
                                            <option value="Kon Tum">Kon Tum</option>
                                            <option value="Lai Châu">Lai Châu</option>
                                            <option value="Lâm Đồng">Lâm Đồng</option>
                                            <option value="Lạng Sơn">Lạng Sơn</option>
                                            <option value="Lào Cai">Lào Cai</option>
                                            <option value="Long An">Long An</option>
                                            <option value="Nam Định">Nam Định</option>
                                            <option value="Nghệ An">Nghệ An</option>
                                            <option value="Ninh Bình">Ninh Bình</option>
                                            <option value="Ninh Thuận">Ninh Thuận</option>
                                            <option value="Phú Thọ">Phú Thọ</option>
                                            <option value="Phú Yên">Phú Yên</option>
                                            <option value="Quảng Bình">Quảng Bình</option>
                                            <option value="Quảng Nam">Quảng Nam</option>
                                            <option value="Quảng Ngãi">Quảng Ngãi</option>
                                            <option value="Quảng Ninh">Quảng Ninh</option>
                                            <option value="Quảng Trị">Quảng Trị</option>
                                            <option value="Sóc Trăng">Sóc Trăng</option>
                                            <option value="Sơn La">Sơn La</option>
                                            <option value="Tây Ninh">Tây Ninh</option>
                                            <option value="Thái Bình">Thái Bình</option>
                                            <option value="Thái Nguyên">Thái Nguyên</option>
                                            <option value="Thanh Hóa">Thanh Hóa</option>
                                            <option value="Thừa Thiên Huế">Thừa Thiên Huế</option>
                                            <option value="Tiền Giang">Tiền Giang</option>
                                            <option value="Trà Vinh">Trà Vinh</option>
                                            <option value="Tuyên Quang">Tuyên Quang</option>
                                            <option value="Vĩnh Long">Vĩnh Long</option>
                                            <option value="Vĩnh Phúc">Vĩnh Phúc</option>
                                            <option value="Yên Bái">Yên Bái</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-envelope me-2"></i>Email xác nhận
                                        </label>
                                        <input type="email" class="form-control" value="${user.email}" readonly
                                               style="background: var(--light-bg); border-color: var(--border-color); color: var(--text-dark);">
                                        <small class="text-muted">
                                            <i class="bi bi-info-circle me-1"></i>
                                            Thông tin đơn hàng sẽ được gửi đến email này
                                        </small>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i class="bi bi-chat-text me-2"></i>Ghi chú đơn hàng
                                        </label>
                                        <textarea name="note" class="form-control" rows="3" 
                                                  placeholder="Thêm ghi chú cho đơn hàng (tùy chọn)..."></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Method -->
                        <div class="checkout-card" data-aos="fade-right" data-aos-delay="200">
                            <div class="checkout-header">
                                <h4><i class="bi bi-credit-card me-3"></i>Phương Thức Thanh Toán</h4>
                            </div>
                            <div class="checkout-body">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="payment-option selected" onclick="selectPayment(this)">
                                            <input type="radio" name="paymentMethod" value="COD" checked>
                                            <div class="text-center">
                                                <span class="payment-icon">💵</span>
                                                <strong>Thanh toán khi nhận hàng</strong>
                                                <small>Trả tiền mặt khi nhận được sản phẩm</small>
                                            </div>
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="payment-option" onclick="selectPayment(this)">
                                            <input type="radio" name="paymentMethod" value="BANKING">
                                            <div class="text-center">
                                                <span class="payment-icon">🏦</span>
                                                <strong>Chuyển khoản ngân hàng</strong>
                                                <small>Chuyển khoản qua ATM hoặc Internet Banking</small>
                                            </div>
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="payment-option" onclick="selectPayment(this)">
                                            <input type="radio" name="paymentMethod" value="VNPAY">
                                            <div class="text-center">
                                                <span class="payment-icon">💳</span>
                                                <strong>VNPay</strong>
                                                <small>Thanh toán qua ví điện tử VNPay</small>
                                            </div>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-5">
                        <div class="checkout-card" data-aos="fade-left">
                            <div class="checkout-header">
                                <c:set var="totalItemCount" value="0" />
                                <c:forEach items="${cartItems}" var="cartItem">
                                    <c:set var="totalItemCount" value="${totalItemCount + cartItem.quantity}" />
                                </c:forEach>
                                <h4><i class="bi bi-bag-check me-3"></i>Đơn Hàng (${totalItemCount} sản phẩm)</h4>
                            </div>
                            <div class="checkout-body">
                                <!-- Items -->
                                <div class="order-items mb-4">
                                    <c:forEach items="${cartItems}" var="item" varStatus="status">
                                        <div class="order-item" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                                            <c:choose>
                                                <c:when test="${not empty item.productImage}">
                                                    <img src="${pageContext.request.contextPath}${item.productImage}" alt="${item.productName}" class="order-item-img">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="order-item-img-placeholder">
                                                        <i class="bi bi-image"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="order-item-info">
                                                <div class="order-item-name">${item.productName}</div>
                                                <div class="order-item-qty">Số lượng: ${item.quantity}</div>
                                            </div>
                                            <div class="order-item-price"><fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</div>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <!-- Summary -->
                                <div class="summary-row">
                                    <span class="summary-label">Tạm tính:</span>
                                    <span class="summary-value"><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</span>
                                </div>
                                <c:if test="${discount > 0}">
                                    <div class="summary-row discount">
                                        <span class="summary-label">Giảm giá (${appliedVoucher.code}):</span>
                                        <span class="summary-value">-<fmt:formatNumber value="${discount}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</span>
                                    </div>
                                </c:if>
                                <div class="summary-row">
                                    <span class="summary-label">Phí vận chuyển:</span>
                                    <span class="summary-value text-success">
                                        <i class="bi bi-truck me-1"></i>Miễn phí
                                    </span>
                                </div>
                                <div class="summary-row total">
                                    <span>Tổng thanh toán:</span>
                                    <span><fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</span>
                                </div>
                                
                                <button type="submit" class="btn-checkout">
                                    <i class="bi bi-lock-fill me-2"></i>Xác nhận đặt hàng
                                </button>
                                
                                <div class="secure-badge">
                                    <i class="bi bi-shield-check"></i>
                                    Thông tin thanh toán được mã hóa và bảo mật
                                    
                                    <div class="trust-features">
                                        <div class="trust-item">
                                            <i class="bi bi-truck"></i>
                                            <span>Giao hàng nhanh</span>
                                        </div>
                                        <div class="trust-item">
                                            <i class="bi bi-arrow-clockwise"></i>
                                            <span>Đổi trả 7 ngày</span>
                                        </div>
                                        <div class="trust-item">
                                            <i class="bi bi-headset"></i>
                                            <span>Hỗ trợ 24/7</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-4 text-center" data-aos="fade-up" data-aos-delay="400">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- AOS Animation -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true,
            offset: 100
        });
        
        // Check if there are many items and add scroll if needed
        document.addEventListener('DOMContentLoaded', function() {
            const orderItems = document.querySelector('.order-items');
            const itemCount = orderItems.querySelectorAll('.order-item').length;
            
            if (itemCount > 8) {
                orderItems.classList.add('many-items');
            }
        });
        
        function selectPayment(el) {
            document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('selected'));
            el.classList.add('selected');
            el.querySelector('input').checked = true;
            
            // Add selection animation
            el.style.transform = 'scale(1.02)';
            setTimeout(() => {
                el.style.transform = 'scale(1)';
            }, 200);
        }
        
        // Form validation and submission
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const button = this.querySelector('.btn-checkout');
            const originalText = button.innerHTML;
            
            // Show loading state
            button.innerHTML = '<i class="bi bi-arrow-repeat me-2 spin"></i>Đang xử lý...';
            button.disabled = true;
            
            // Re-enable after 3 seconds (in case of error)
            setTimeout(() => {
                button.innerHTML = originalText;
                button.disabled = false;
            }, 3000);
        });
        
        // Auto-format phone number
        document.querySelector('input[name="phone"]').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 10) value = value.slice(0, 10);
            
            if (value.length >= 7) {
                value = value.replace(/(\d{4})(\d{3})(\d{3})/, '$1 $2 $3');
            } else if (value.length >= 4) {
                value = value.replace(/(\d{4})(\d{3})/, '$1 $2');
            }
            
            e.target.value = value;
        });
        
        // City selection enhancement
        document.querySelector('select[name="city"]').addEventListener('change', function() {
            if (this.value) {
                this.style.borderColor = 'var(--accent-color)';
                this.style.background = 'rgba(201, 169, 98, 0.05)';
                this.style.color = 'var(--text-dark)';
            } else {
                this.style.borderColor = 'var(--border-color)';
                this.style.background = 'var(--white)';
                this.style.color = 'var(--text-dark)';
            }
        });
    </script>
    
    <style>
        .spin {
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        /* Responsive improvements */
        @media (max-width: 991.98px) {
            .page-title {
                font-size: 2rem;
            }
            
            .checkout-body {
                padding: 2rem 1.5rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .checkout-page {
                padding: 1rem 0 2rem;
            }
            
            .page-header {
                margin-bottom: 2rem;
            }
            
            .page-title {
                font-size: 1.75rem;
            }
            
            .checkout-header {
                padding: 1.25rem 1.5rem;
            }
            
            .checkout-body {
                padding: 1.5rem;
            }
            
            .order-item {
                flex-direction: column;
                text-align: center;
                padding: 1.5rem 1rem;
            }
            
            .order-item-img,
            .order-item-img-placeholder {
                margin-right: 0;
                margin-bottom: 1rem;
                align-self: center;
            }
            
            .order-item-info {
                margin-bottom: 0.5rem;
            }
            
            .payment-option {
                margin-bottom: 1rem;
            }
            
            .trust-features {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</body>
</html>
