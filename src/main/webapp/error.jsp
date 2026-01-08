<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${errorTitle}"/> - Clothing Shop</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    
    <style>
        .error-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--bg-light) 0%, var(--bg-white) 100%);
            padding: 2rem 0;
        }
        
        .error-container {
            text-align: center;
            max-width: 600px;
            padding: 3rem;
            background: var(--bg-white);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
        }
        
        .error-icon {
            font-size: 6rem;
            color: var(--gold);
            margin-bottom: 2rem;
        }
        
        .error-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.1rem;
            color: var(--text-body);
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .error-code {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: var(--bg-light);
            color: var(--text-muted);
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        @media (max-width: 767.98px) {
            .error-container {
                margin: 1rem;
                padding: 2rem;
            }
            
            .error-icon {
                font-size: 4rem;
            }
            
            .error-title {
                font-size: 2rem;
            }
            
            .error-actions {
                flex-direction: column;
            }
            
            .error-code {
                position: static;
                margin-bottom: 1rem;
                display: inline-block;
            }
        }
    </style>
</head>
<body>
    <div class="error-page">
        <div class="error-container">
            <c:if test="${not empty statusCode}">
                <div class="error-code">Error ${statusCode}</div>
            </c:if>
            
            <div class="error-icon">
                <c:choose>
                    <c:when test="${statusCode == 404}">
                        <i class="bi bi-search"></i>
                    </c:when>
                    <c:when test="${statusCode == 500}">
                        <i class="bi bi-exclamation-triangle"></i>
                    </c:when>
                    <c:when test="${statusCode == 403}">
                        <i class="bi bi-shield-x"></i>
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-exclamation-circle"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <h1 class="error-title">
                <c:out value="${errorTitle}"/>
            </h1>
            
            <p class="error-message">
                <c:out value="${errorMessage}"/>
            </p>
            
            <c:if test="${not empty requestUri}">
                <p class="text-muted mb-3">
                    <small>Đường dẫn: <code><c:out value="${requestUri}"/></code></small>
                </p>
            </c:if>
            
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-gold">
                    <i class="bi bi-house me-2"></i>Về Trang Chủ
                </a>
                <a href="javascript:history.back()" class="btn btn-outline-gold">
                    <i class="bi bi-arrow-left me-2"></i>Quay Lại
                </a>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                    <i class="bi bi-grid me-2"></i>Xem Sản Phẩm
                </a>
            </div>
            
            <div class="mt-4">
                <p class="text-muted">
                    <small>
                        Nếu vấn đề vẫn tiếp tục, vui lòng 
                        <a href="${pageContext.request.contextPath}/contact" class="text-gold">liên hệ với chúng tôi</a>.
                    </small>
                </p>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>