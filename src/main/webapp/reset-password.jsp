<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - Clothing Shop</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    
    <style>
        .reset-page {
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
                url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1920') center/cover no-repeat;
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
            text-decoration: none;
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
            max-width: 450px;
            width: 100%;
            z-index: 1;
        }
        
        .auth-header {
            text-align: center;
            padding: 2.5rem 2rem 2rem;
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
            width: 70px;
            height: 70px;
            background: var(--gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.75rem;
            color: white;
            box-shadow: 0 10px 30px rgba(201, 169, 98, 0.3);
        }
        
        .auth-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: white;
        }
        
        .auth-header p {
            color: rgba(255, 255, 255, 0.8);
            margin: 0;
            font-size: 0.9rem;
        }
        
        .auth-body {
            padding: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.25rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .form-control {
            padding: 0.875rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: var(--radius);
            transition: var(--transition);
            font-size: 0.95rem;
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
        
        .btn-auth {
            padding: 1rem;
            background: var(--gold);
            border: none;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            border-radius: var(--radius);
            transition: var(--transition);
            width: 100%;
        }
        
        .btn-auth:hover {
            background: var(--gold-dark);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(201, 169, 98, 0.3);
        }
        
        .auth-footer {
            padding: 1.25rem 2rem;
            background: var(--bg-light);
            text-align: center;
            border-top: 1px solid #e9ecef;
        }
        
        .auth-footer a {
            color: var(--gold-dark);
            text-decoration: none;
            font-weight: 500;
        }
        
        .auth-footer a:hover {
            color: var(--gold);
            text-decoration: underline;
        }
        
        .password-strength {
            height: 4px;
            border-radius: 2px;
            background: #e9ecef;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: all 0.3s ease;
        }
        
        .strength-weak { width: 33%; background: #dc3545; }
        .strength-medium { width: 66%; background: #ffc107; }
        .strength-strong { width: 100%; background: #28a745; }
        
        .password-requirements {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 0.5rem;
        }
        
        @media (max-width: 767.98px) {
            .reset-page {
                padding: 1rem;
            }
            
            .back-home-btn {
                top: 1rem;
                left: 1rem;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }
            
            .auth-header {
                padding: 2rem 1.5rem 1.5rem;
            }
            
            .auth-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="reset-page">
        <div class="auth-bg"></div>
        
        <a href="${pageContext.request.contextPath}/home" class="back-home-btn">
            <i class="bi bi-arrow-left me-2"></i>Về trang chủ
        </a>
        
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-xl-4">
                    <div class="auth-card">
                        <div class="auth-header">
                            <div class="brand-logo">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                            <h2>Đặt Lại Mật Khẩu</h2>
                            <p>Nhập mật khẩu mới cho tài khoản của bạn</p>
                        </div>
                        
                        <div class="auth-body">
                            <!-- Error Message -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/reset-password" method="POST" id="resetForm">
                                <input type="hidden" name="token" value="${token}">
                                
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-lock me-2"></i>Mật khẩu mới
                                    </label>
                                    <div class="password-input">
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Nhập mật khẩu mới" required minlength="6">
                                        <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                    <div class="password-strength">
                                        <div class="password-strength-bar" id="strengthBar"></div>
                                    </div>
                                    <div class="password-requirements">Tối thiểu 6 ký tự</div>
                                </div>
                                
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
                                    <div id="passwordMatch" class="small mt-1"></div>
                                </div>
                                
                                <button type="submit" class="btn btn-auth" id="submitBtn">
                                    <i class="bi bi-check-circle me-2"></i>Đặt Lại Mật Khẩu
                                </button>
                            </form>
                        </div>
                        
                        <div class="auth-footer">
                            <a href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5.3.3 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
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
        
        // Password strength indicator
        const passwordInput = document.getElementById('password');
        const strengthBar = document.getElementById('strengthBar');
        
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            let strength = 0;
            
            if (password.length >= 6) strength++;
            if (password.length >= 8) strength++;
            if (/[A-Z]/.test(password) || /[0-9]/.test(password) || /[^a-zA-Z0-9]/.test(password)) strength++;
            
            strengthBar.className = 'password-strength-bar';
            if (strength === 1) strengthBar.classList.add('strength-weak');
            else if (strength === 2) strengthBar.classList.add('strength-medium');
            else if (strength === 3) strengthBar.classList.add('strength-strong');
        });
        
        // Password match validation
        const confirmInput = document.getElementById('confirmPassword');
        const matchText = document.getElementById('passwordMatch');
        
        confirmInput.addEventListener('input', function() {
            if (this.value === '') {
                matchText.textContent = '';
            } else if (this.value === passwordInput.value) {
                matchText.innerHTML = '<span class="text-success"><i class="bi bi-check-circle me-1"></i>Mật khẩu khớp</span>';
            } else {
                matchText.innerHTML = '<span class="text-danger"><i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp</span>';
            }
        });
        
        // Form validation
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            const password = passwordInput.value;
            const confirm = confirmInput.value;
            
            if (password !== confirm) {
                e.preventDefault();
                matchText.innerHTML = '<span class="text-danger"><i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp</span>';
                confirmInput.focus();
                return false;
            }
            
            // Show loading state
            const btn = document.getElementById('submitBtn');
            btn.innerHTML = '<i class="bi bi-arrow-repeat me-2 spin"></i>Đang xử lý...';
            btn.disabled = true;
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
    </style>
</body>
</html>
