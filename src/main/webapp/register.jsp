<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Clothing Shop</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
</head>
<body>
    <div class="register-page">
        <!-- Background Pattern -->
        <div class="auth-bg"></div>
        
        <!-- Back to Home -->
        <a href="${pageContext.request.contextPath}/home" class="back-home-btn">
            <i class="bi bi-arrow-left me-2"></i>Về trang chủ
        </a>
        
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-xl-4">
                    <div class="auth-card" data-aos="fade-up" data-aos-duration="800">
                        <div class="auth-header">
                            <div class="brand-logo">
                                <i class="bi bi-bag-heart"></i>
                            </div>
                            <h2>Tạo tài khoản mới</h2>
                            <p>Tham gia cộng đồng thời trang của chúng tôi</p>
                        </div>
                
                        <div class="auth-body">
                            <!-- Error Message -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="shake">
                                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/register" method="POST" class="auth-form">
                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="bi bi-person me-2"></i>Tên đăng nhập
                                            </label>
                                            <input type="text" class="form-control" name="username" 
                                                   placeholder="Nhập tên đăng nhập" value="${username}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="bi bi-envelope me-2"></i>Email
                                            </label>
                                            <input type="email" class="form-control" name="email" 
                                                   placeholder="Nhập email" value="${email}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="bi bi-person-badge me-2"></i>Họ và tên
                                            </label>
                                            <input type="text" class="form-control" name="fullName" 
                                                   placeholder="Nhập họ và tên đầy đủ" value="${fullName}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="bi bi-lock me-2"></i>Mật khẩu
                                            </label>
                                            <div class="password-input">
                                                <input type="password" class="form-control" id="password" name="password" 
                                                       placeholder="Nhập mật khẩu" required minlength="6">
                                                <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="bi bi-lock-fill me-2"></i>Xác nhận mật khẩu
                                            </label>
                                            <div class="password-input">
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                                       placeholder="Nhập lại mật khẩu" required>
                                                <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="bi bi-telephone me-2"></i>Số điện thoại (tùy chọn)
                                            </label>
                                            <input type="tel" class="form-control" name="phone" 
                                                   placeholder="Nhập số điện thoại" value="${phone}">
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="terms" name="terms" required>
                                            <label class="form-check-label" for="terms">
                                                Tôi đồng ý với <a href="${pageContext.request.contextPath}/terms.jsp" class="link-gold" target="_blank">điều khoản sử dụng</a> và 
                                                <a href="${pageContext.request.contextPath}/privacy.jsp" class="link-gold" target="_blank">chính sách bảo mật</a>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-auth w-100">
                                            <i class="bi bi-person-plus me-2"></i>Tạo tài khoản
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="auth-footer">
                            <p class="mb-0">
                                Đã có tài khoản? 
                                <a href="${pageContext.request.contextPath}/login" class="link-gold fw-600">Đăng nhập ngay</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5.3.3 JS -->
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
        
        // Toggle password visibility
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const button = input.nextElementSibling;
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }
        
        // Validate password match
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
                this.classList.add('is-invalid');
            } else {
                this.setCustomValidity('');
                this.classList.remove('is-invalid');
            }
        });
        
        // Form validation feedback
        const form = document.querySelector('.auth-form');
        form.addEventListener('submit', function(e) {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    </script>
    
    <style>
        /* Register Page Styles */
        .register-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
            position: relative;
            overflow: hidden;
        }
        
        .auth-bg {
            position: absolute;
            inset: 0;
            background: 
                linear-gradient(135deg, rgba(26, 26, 26, 0.85) 0%, rgba(26, 26, 26, 0.75) 100%),
                url('https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=1920') center/cover no-repeat;
            filter: blur(2px);
            transform: scale(1.02);
            pointer-events: none;
        }
        
        .auth-bg::after {
            content: '';
            position: absolute;
            inset: 0;
            background: 
                radial-gradient(circle at 20% 50%, rgba(201, 169, 98, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(201, 169, 98, 0.2) 0%, transparent 50%);
        }
        
        .back-home-btn {
            position: absolute;
            top: 2rem;
            left: 2rem;
            padding: 0.75rem 1.5rem;
            background: white;
            border-radius: 50px;
            color: var(--text-dark);
            font-weight: 500;
            box-shadow: var(--shadow);
            transition: var(--transition);
            z-index: 10;
        }
        
        .back-home-btn:hover {
            background: var(--gold);
            color: white;
            transform: translateX(-5px);
        }
        
        .auth-card {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            position: relative;
        }
        
        .auth-header {
            text-align: center;
            padding: 2rem 2rem 1.5rem;
            background: linear-gradient(135deg, var(--dark) 0%, var(--dark-surface) 100%);
            color: white;
            position: relative;
        }
        
        .auth-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 25px;
            background: white;
            border-radius: 50% 50% 0 0 / 100% 100% 0 0;
        }
        
        .brand-logo {
            width: 60px;
            height: 60px;
            background: var(--gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: white;
            box-shadow: 0 10px 30px rgba(201, 169, 98, 0.3);
        }
        
        .auth-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
            color: white;
        }
        
        .auth-header p {
            color: rgba(255, 255, 255, 0.8);
            margin: 0;
            font-size: 0.9rem;
        }
        
        .auth-body {
            padding: 2rem 2rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .form-control {
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: var(--radius);
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.2rem rgba(201, 169, 98, 0.15);
        }
        
        .password-input {
            position: relative;
        }
        
        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0.5rem;
            transition: var(--transition);
        }
        
        .password-toggle:hover {
            color: var(--gold);
        }
        
        .form-text {
            color: var(--text-muted);
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: block;
        }
        
        .form-check {
            padding-left: 1.75rem;
        }
        
        .form-check-input {
            width: 1.25rem;
            height: 1.25rem;
            border: 2px solid #dee2e6;
            margin-top: 0.125rem;
        }
        
        .form-check-input:checked {
            background-color: var(--gold);
            border-color: var(--gold);
        }
        
        .form-check-label {
            color: var(--text-body);
            font-size: 0.9rem;
        }
        
        .link-gold {
            color: var(--gold-dark);
            text-decoration: none;
            font-weight: 500;
        }
        
        .link-gold:hover {
            color: var(--gold);
            text-decoration: underline;
        }
        
        .btn-auth {
            padding: 1rem;
            background: var(--gold);
            border: none;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            border-radius: var(--radius);
            transition: var(--transition);
        }
        
        .btn-auth:hover {
            background: var(--gold-dark);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(201, 169, 98, 0.3);
        }
        
        .auth-footer {
            padding: 1.5rem 2rem;
            background: var(--bg-light);
            text-align: center;
            border-top: 1px solid #e9ecef;
        }
        
        .auth-footer p {
            color: var(--text-body);
            margin: 0;
        }
        
        .fw-600 {
            font-weight: 600;
        }
        
        /* Responsive */
        @media (max-width: 767.98px) {
            .register-page {
                padding: 1rem;
            }
            
            .back-home-btn {
                top: 1rem;
                left: 1rem;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }
            
            .auth-header {
                padding: 1.5rem 1.5rem 1rem;
            }
            
            .brand-logo {
                width: 50px;
                height: 50px;
                font-size: 1.25rem;
                margin-bottom: 0.75rem;
            }
            
            .auth-header h2 {
                font-size: 1.25rem;
            }
            
            .auth-body {
                padding: 1.5rem;
            }
            
            .form-group {
                margin-bottom: 0.75rem;
            }
            
            .form-control {
                padding: 0.625rem 0.875rem;
                font-size: 0.875rem;
            }
        }
    </style>
</body>
</html>
