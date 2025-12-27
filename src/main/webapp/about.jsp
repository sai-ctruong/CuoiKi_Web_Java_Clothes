<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới Thiệu - Clothing Shop</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Montserrat:wght@300;400;500;600;700&display=swap&subset=vietnamese" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages.css">
    
    <style>
        body {
            padding-top: 70px; /* Match header height */
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="about-header">
        <div class="container">
            <h1>Về Chúng Tôi</h1>
            <p class="lead mt-3">Câu chuyện về Clothing Shop</p>
        </div>
    </div>
    
    <div class="about-page">
        <!-- Story Section -->
        <section class="about-section">
            <div class="container">
                <div class="row align-items-center g-5">
                    <div class="col-lg-6">
                        <img src="https://picsum.photos/600/400?random=20" alt="About Us" class="img-fluid about-image">
                    </div>
                    <div class="col-lg-6 about-content">
                        <h2>Câu Chuyện Của Chúng Tôi</h2>
                        <p>Clothing Shop được thành lập với sứ mệnh mang đến những sản phẩm thời trang chất lượng cao, 
                        phong cách hiện đại với giá cả hợp lý cho người tiêu dùng Việt Nam.</p>
                        <p>Chúng tôi tin rằng mọi người đều xứng đáng được mặc đẹp và tự tin. 
                        Đó là lý do chúng tôi không ngừng tìm kiếm và chọn lọc những thiết kế tốt nhất, 
                        những chất liệu tốt nhất để mang đến cho khách hàng.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Values Section -->
        <section class="about-section bg-white">
            <div class="container">
                <h2 class="text-center mb-5" style="font-family: 'Cormorant Garamond', serif;">Giá Trị Cốt Lõi</h2>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="value-card">
                            <div class="value-icon"><i class="bi bi-heart"></i></div>
                            <h5>Chất Lượng</h5>
                            <p class="text-muted">Cam kết mang đến sản phẩm chất lượng cao nhất</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="value-card">
                            <div class="value-icon"><i class="bi bi-star"></i></div>
                            <h5>Phong Cách</h5>
                            <p class="text-muted">Thiết kế độc đáo, theo xu hướng thời trang mới nhất</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="value-card">
                            <div class="value-icon"><i class="bi bi-people"></i></div>
                            <h5>Khách Hàng</h5>
                            <p class="text-muted">Sự hài lòng của khách hàng là ưu tiên hàng đầu</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
