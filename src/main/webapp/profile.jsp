<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài Khoản Của Tôi - Clothing Shop</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Montserrat:wght@300;400;500;600;700&display=swap&subset=vietnamese" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 80px; /* Account for fixed header */
        }
        
        .profile-page {
            padding-top: 100px;
            padding-bottom: 3rem;
            min-height: 100vh;
            background: var(--bg-cream);
        }
        
        .profile-sidebar {
            background: var(--text-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 1.5rem;
            position: sticky;
            top: 100px;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: var(--bg-dark);
            color: var(--accent-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 1rem;
        }
        
        .profile-name {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            text-align: center;
            margin-bottom: 0.5rem;
        }
        
        .profile-email {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .profile-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .profile-nav li {
            margin-bottom: 0.5rem;
        }
        
        .profile-nav a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            border-radius: var(--radius-sm);
            color: var(--text-dark);
            font-family: 'Montserrat', sans-serif;
            font-size: 0.9rem;
            transition: var(--transition-fast);
        }
        
        .profile-nav a:hover,
        .profile-nav a.active {
            background: var(--bg-dark);
            color: var(--text-white);
        }
        
        .profile-nav a.active i {
            color: var(--accent-color);
        }
        
        .profile-content {
            background: var(--text-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 2rem;
        }
        
        .section-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.5rem;
            font-style: italic;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .form-label {
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            font-size: 0.85rem;
            color: var(--text-dark);
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(212, 162, 76, 0.25);
        }
        
        .btn-save {
            background: var(--accent-color);
            border: none;
            color: var(--text-dark);
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0.75rem 2rem;
            transition: var(--transition-normal);
        }
        
        .btn-save:hover {
            background: var(--accent-hover);
            color: var(--text-dark);
        }
        
        .password-section {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="includes/header.jsp" />
    
    <div class="profile-page">
        <div class="container">
            <div class="row g-4">
                <!-- Sidebar -->
                <div class="col-lg-3">
                    <div class="profile-sidebar">
                        <div class="profile-avatar">
                            <i class="bi bi-person-fill"></i>
                        </div>
                        <h5 class="profile-name">${user.fullName}</h5>
                        <p class="profile-email">${user.email}</p>
                        
                        <ul class="profile-nav">
                            <li>
                                <a href="${pageContext.request.contextPath}/profile" class="active">
                                    <i class="bi bi-person"></i> Thông Tin Cá Nhân
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/address">
                                    <i class="bi bi-geo-alt"></i> Sổ Địa Chỉ
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/my-orders">
                                    <i class="bi bi-bag"></i> Đơn Hàng Của Tôi
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right"></i> Đăng Xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- Main Content -->
                <div class="col-lg-9">
                    <div class="profile-content">
                        <h3 class="section-title">Thông Tin Cá Nhân</h3>
                        
                        <!-- Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <!-- Profile Form -->
                        <form action="${pageContext.request.contextPath}/profile" method="POST">
                            <input type="hidden" name="action" value="updateProfile">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" value="${user.username}" disabled>
                                    <small class="text-muted">Không thể thay đổi tên đăng nhập</small>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label" for="email">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${user.email}" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label" for="fullName">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${user.fullName}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label" for="phone">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${user.phone}">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Vai trò</label>
                                    <input type="text" class="form-control" value="${user.role}" disabled>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày tham gia</label>
                                    <input type="text" class="form-control" value="${user.createdAt}" disabled>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-save">
                                <i class="bi bi-check-lg me-2"></i>Lưu Thay Đổi
                            </button>
                        </form>
                        
                        <!-- Change Password Section -->
                        <div class="password-section">
                            <h3 class="section-title">Đổi Mật Khẩu</h3>
                            
                            <form action="${pageContext.request.contextPath}/profile" method="POST">
                                <input type="hidden" name="action" value="changePassword">
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="currentPassword">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="currentPassword" 
                                               name="currentPassword" required>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="newPassword">Mật khẩu mới <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="newPassword" 
                                               name="newPassword" required minlength="6">
                                        <small class="text-muted">Tối thiểu 6 ký tự</small>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="confirmPassword" 
                                               name="confirmPassword" required>
                                    </div>
                                </div>
                                
                                <button type="submit" class="btn btn-save">
                                    <i class="bi bi-shield-lock me-2"></i>Đổi Mật Khẩu
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer Include -->
    <jsp:include page="includes/footer.jsp" />
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
