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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    
    <style>
        .auth-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
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
        
        .auth-card {
            background: var(--text-white, #fff);
            border-radius: var(--radius-lg, 16px);
            box-shadow: var(--shadow-lg, 0 25px 50px -12px rgba(0,0,0,0.25));
            overflow: hidden;
            max-width: 450px;
            width: 100%;
            margin: 2rem auto;
            position: relative;
            z-index: 1;
        }
        
        .auth-header {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
        }
        
        .auth-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 20px;
            background: white;
            border-radius: 50% 50% 0 0 / 100% 100% 0 0;
        }
        
        .auth-header h2 {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            font-size: 1.75rem;
            margin-bottom: 0.5rem;
            color: white;
        }
        
        .auth-header p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            margin: 0;
        }
        
        .auth-body {
            padding: 2rem;
        }
        
        .form-floating > label {
            color: #6c757d;
        }
        
        .form-control:focus {
            border-color: #c9a962;
            box-shadow: 0 0 0 0.2rem rgba(201, 169, 98, 0.25);
        }
        
        .btn-auth {
            background: #c9a962;
            border: none;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0.875rem 1.5rem;
            width: 100%;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .btn-auth:hover {
            background: #b8943a;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(201, 169, 98, 0.3);
        }
        
        .auth-footer {
            text-align: center;
            padding: 1.25rem 2rem;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }
        
        .auth-footer a {
            color: #c9a962;
            font-weight: 600;
            text-decoration: none;
        }
        
        .auth-footer a:hover {
            color: #b8943a;
            text-decoration: underline;
        }
        
        .back-home {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            padding: 0.6rem 1.25rem;
            background: white;
            border-radius: 50px;
            color: #1a1a1a;
            font-weight: 500;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            z-index: 10;
            text-decoration: none;
        }
        
        .back-home:hover {
            background: #c9a962;
            color: white;
            transform: translateX(-5px);
        }
    </style>
</head>
<body>
    <div class="auth-page position-relative">
        <div class="auth-bg"></div>
        
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
