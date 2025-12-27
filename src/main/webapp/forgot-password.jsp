<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Clothing Shop</title>
    
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
    
    <style>
        .auth-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
        }
        
        .auth-card {
            background: var(--text-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
            margin: 2rem auto;
        }
        
        .auth-header {
            background: var(--bg-dark);
            color: var(--text-white);
            padding: 2rem;
            text-align: center;
        }
        
        .auth-header h2 {
            font-family: 'Cormorant Garamond', serif;
            font-style: italic;
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: var(--text-white);
        }
        
        .auth-header p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin: 0;
        }
        
        .auth-body {
            padding: 2rem;
        }
        
        .form-floating > label {
            font-family: 'Montserrat', sans-serif;
            color: var(--text-muted);
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(212, 162, 76, 0.25);
        }
        
        .btn-auth {
            background: var(--accent-color);
            border: none;
            color: var(--text-dark);
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0.8rem 1.5rem;
            width: 100%;
            transition: var(--transition-normal);
        }
        
        .btn-auth:hover {
            background: var(--accent-hover);
            color: var(--text-dark);
            transform: translateY(-2px);
        }
        
        .auth-footer {
            text-align: center;
            padding: 1.5rem 2rem;
            background: var(--bg-cream);
            border-top: 1px solid #dee2e6;
        }
        
        .auth-footer a {
            color: var(--accent-color);
            font-weight: 600;
        }
        
        .auth-footer a:hover {
            color: var(--accent-dark);
            text-decoration: underline;
        }
        
        .back-home {
            position: absolute;
            top: 1rem;
            left: 1rem;
            color: var(--text-white);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .back-home:hover {
            color: var(--accent-color);
        }
    </style>
</head>
<body>
    <div class="auth-page position-relative">
        <a href="${pageContext.request.contextPath}/home" class="back-home">
            <i class="bi bi-arrow-left"></i> Về trang chủ
        </a>
        
        <div class="container">
            <div class="auth-card">
                <div class="auth-header">
                    <h2><i class="bi bi-key me-2"></i>Quên Mật Khẩu</h2>
                    <p>Nhập email để nhận hướng dẫn đặt lại mật khẩu</p>
                </div>
                
                <div class="auth-body">
                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-circle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <!-- Success Message -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/forgot-password" method="POST">
                        <div class="form-floating mb-4">
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="Địa chỉ email" required>
                            <label for="email"><i class="bi bi-envelope me-2"></i>Địa chỉ email</label>
                        </div>
                        
                        <button type="submit" class="btn btn-auth">
                            <i class="bi bi-send me-2"></i>Gửi yêu cầu
                        </button>
                    </form>
                </div>
                
                <div class="auth-footer">
                    <a href="${pageContext.request.contextPath}/login"><i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
