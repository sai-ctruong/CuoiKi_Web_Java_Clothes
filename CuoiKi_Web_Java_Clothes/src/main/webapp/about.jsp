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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 70px;
            font-family: 'Inter', sans-serif;
        }
        
        /* Hero Section */
        .about-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }
        
        .about-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200') center/cover;
            opacity: 0.1;
        }
        
        .about-hero .container {
            position: relative;
            z-index: 2;
        }
        
        .about-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .about-hero .lead {
            font-size: 1.3rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* Story Section */
        .story-section {
            padding: 100px 0;
            background: #fff;
        }
        
        .story-image {
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .story-image:hover {
            transform: translateY(-10px);
        }
        
        .story-content h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 2rem;
        }
        
        .story-content p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
            margin-bottom: 1.5rem;
        }
        
        /* Values Section */
        .values-section {
            padding: 100px 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        
        .values-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            color: #2c3e50;
            margin-bottom: 3rem;
        }
        
        .value-card {
            background: white;
            padding: 3rem 2rem;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .value-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        
        .value-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--gold) 0%, #d4af37 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
        }
        
        .value-card h5 {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        
        .value-card p {
            color: #666;
            line-height: 1.6;
        }
        
        /* Stats Section */
        .stats-section {
            padding: 80px 0;
            background: #2c3e50;
            color: white;
        }
        
        .stat-item {
            text-align: center;
            padding: 2rem 1rem;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: var(--gold);
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        /* Team Section */
        .team-section {
            padding: 100px 0;
            background: #fff;
        }
        
        .team-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            color: #2c3e50;
            margin-bottom: 3rem;
        }
        
        .team-card {
            text-align: center;
            padding: 2rem 1rem;
            transition: transform 0.3s ease;
        }
        
        .team-card:hover {
            transform: translateY(-10px);
        }
        
        .team-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            background: linear-gradient(135deg, var(--gold) 0%, #d4af37 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            font-weight: 600;
        }
        
        .team-card h5 {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .team-card .position {
            color: var(--gold);
            font-weight: 500;
            margin-bottom: 1rem;
        }
        
        .team-card p {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.6;
        }
        
        /* Mission Section */
        .mission-section {
            padding: 100px 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
        }
        
        .mission-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.8rem;
            margin-bottom: 2rem;
        }
        
        .mission-section p {
            font-size: 1.2rem;
            line-height: 1.8;
            max-width: 800px;
            margin: 0 auto 2rem;
            opacity: 0.95;
        }
        
        .mission-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }
        
        .mission-feature {
            padding: 1.5rem;
            background: rgba(255,255,255,0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        
        .mission-feature i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--gold);
        }
        
        .mission-feature h6 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        /* CTA Section */
        .cta-section {
            padding: 80px 0;
            background: #f8f9fa;
            text-align: center;
        }
        
        .cta-section h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        
        .cta-section p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 2rem;
        }
        
        .btn-gold {
            background: linear-gradient(135deg, var(--gold) 0%, #d4af37 100%);
            border: none;
            color: white;
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        
        .btn-gold:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(201, 169, 98, 0.3);
            color: white;
        }
        
        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .animate-on-scroll {
            animation: fadeInUp 0.8s ease forwards;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .about-hero h1 {
                font-size: 2.5rem;
            }
            
            .about-hero .lead {
                font-size: 1.1rem;
            }
            
            .story-content h2,
            .values-section h2,
            .team-section h2,
            .mission-section h2 {
                font-size: 2.2rem;
            }
            
            .stat-number {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <!-- Hero Section -->
    <section class="about-hero">
        <div class="container text-center">
            <h1 class="animate-on-scroll">Về Clothing Shop</h1>
            <p class="lead animate-on-scroll">Nơi phong cách gặp gỡ chất lượng, tạo nên những trải nghiệm thời trang đặc biệt</p>
        </div>
    </section>
    
    <!-- Story Section -->
    <section class="story-section">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600&h=400&fit=crop" 
                         alt="Clothing Shop Story" class="img-fluid story-image">
                </div>
                <div class="col-lg-6 story-content">
                    <h2>Câu Chuyện Của Chúng Tôi</h2>
                    <p>Clothing Shop ra đời từ niềm đam mê với thời trang và mong muốn mang đến cho mọi người những sản phẩm chất lượng cao với giá cả hợp lý.</p>
                    <p>Chúng tôi tin rằng thời trang không chỉ là trang phục, mà còn là cách thể hiện cá tính, phong cách sống và sự tự tin của mỗi người.</p>
                    <p>Với đội ngũ thiết kế tài năng và kinh nghiệm nhiều năm trong ngành, chúng tôi không ngừng sáng tạo để mang đến những bộ sưu tập độc đáo, phù hợp với xu hướng thời trang hiện đại.</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <span class="stat-number">50K+</span>
                        <span class="stat-label">Khách hàng hài lòng</span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <span class="stat-number">1000+</span>
                        <span class="stat-label">Sản phẩm chất lượng</span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <span class="stat-number">5</span>
                        <span class="stat-label">Năm kinh nghiệm</span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                        <span class="stat-number">99%</span>
                        <span class="stat-label">Đánh giá tích cực</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Values Section -->
    <section class="values-section">
        <div class="container">
            <h2 class="text-center">Giá Trị Cốt Lõi</h2>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="bi bi-gem"></i>
                        </div>
                        <h5>Chất Lượng Cao</h5>
                        <p>Chúng tôi cam kết sử dụng những chất liệu tốt nhất, quy trình sản xuất nghiêm ngặt để đảm bảo mỗi sản phẩm đều đạt tiêu chuẩn cao nhất.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="bi bi-palette"></i>
                        </div>
                        <h5>Thiết Kế Độc Đáo</h5>
                        <p>Mỗi thiết kế của chúng tôi đều mang dấu ấn riêng, kết hợp giữa xu hướng thời trang quốc tế và nét đẹp truyền thống Việt Nam.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card">
                        <div class="value-icon">
                            <i class="bi bi-heart-fill"></i>
                        </div>
                        <h5>Khách Hàng Là Trung Tâm</h5>
                        <p>Sự hài lòng của khách hàng là động lực để chúng tôi không ngừng cải tiến và phát triển, mang đến trải nghiệm mua sắm tuyệt vời nhất.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Team Section -->
    <section class="team-section">
        <div class="container">
            <h2 class="text-center">Đội Ngũ Của Chúng Tôi</h2>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="team-card">
                        <div class="team-avatar">AN</div>
                        <h5>Nguyễn Văn An</h5>
                        <div class="position">Giám Đốc Sáng Tạo</div>
                        <p>Với hơn 10 năm kinh nghiệm trong ngành thời trang, An là người đứng sau những thiết kế độc đáo và xu hướng mới của Clothing Shop.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="team-card">
                        <div class="team-avatar">LY</div>
                        <h5>Trần Thị Ly</h5>
                        <div class="position">Trưởng Phòng Marketing</div>
                        <p>Ly chịu trách nhiệm xây dựng thương hiệu và kết nối Clothing Shop với khách hàng thông qua các chiến dịch sáng tạo.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="team-card">
                        <div class="team-avatar">DUC</div>
                        <h5>Lê Minh Đức</h5>
                        <div class="position">Quản Lý Chất Lượng</div>
                        <p>Đức đảm bảo mọi sản phẩm của Clothing Shop đều đạt tiêu chuẩn chất lượng cao nhất trước khi đến tay khách hàng.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Mission Section -->
    <section class="mission-section">
        <div class="container">
            <h2>Sứ Mệnh Của Chúng Tôi</h2>
            <p>Mang đến cho mọi người những sản phẩm thời trang chất lượng cao, giúp họ thể hiện phong cách cá nhân và tự tin trong cuộc sống hàng ngày.</p>
            
            <div class="mission-features">
                <div class="mission-feature">
                    <i class="bi bi-shield-check"></i>
                    <h6>Cam Kết Chất Lượng</h6>
                    <p>100% sản phẩm được kiểm tra nghiêm ngặt</p>
                </div>
                <div class="mission-feature">
                    <i class="bi bi-truck"></i>
                    <h6>Giao Hàng Nhanh</h6>
                    <p>Miễn phí ship toàn quốc cho đơn từ 500K</p>
                </div>
                <div class="mission-feature">
                    <i class="bi bi-arrow-counterclockwise"></i>
                    <h6>Đổi Trả Dễ Dàng</h6>
                    <p>Chính sách đổi trả trong 30 ngày</p>
                </div>
                <div class="mission-feature">
                    <i class="bi bi-headset"></i>
                    <h6>Hỗ Trợ 24/7</h6>
                    <p>Đội ngũ tư vấn nhiệt tình, chuyên nghiệp</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <h3>Khám Phá Bộ Sưu Tập Mới Nhất</h3>
            <p>Cùng Clothing Shop tạo nên phong cách riêng của bạn</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-gold btn-lg">
                <i class="bi bi-bag me-2"></i>Mua Sắm Ngay
            </a>
        </div>
    </section>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animate elements on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-on-scroll');
                }
            });
        }, observerOptions);
        
        // Observe all sections
        document.querySelectorAll('section').forEach(section => {
            observer.observe(section);
        });
        
        // Counter animation for stats
        function animateCounter(element, target) {
            let current = 0;
            const increment = target / 100;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }
                
                if (target >= 1000) {
                    element.textContent = Math.floor(current / 1000) + 'K+';
                } else if (target >= 100) {
                    element.textContent = Math.floor(current) + '%';
                } else {
                    element.textContent = Math.floor(current);
                }
            }, 20);
        }
        
        // Animate stats when visible
        const statsObserver = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const statNumbers = entry.target.querySelectorAll('.stat-number');
                    statNumbers.forEach(stat => {
                        const text = stat.textContent;
                        let target = parseInt(text.replace(/[^\d]/g, ''));
                        
                        if (text.includes('K+')) target *= 1000;
                        if (text.includes('%')) target = parseInt(text);
                        
                        animateCounter(stat, target);
                    });
                    statsObserver.unobserve(entry.target);
                }
            });
        }, { threshold: 0.5 });
        
        const statsSection = document.querySelector('.stats-section');
        if (statsSection) {
            statsObserver.observe(statsSection);
        }
    </script>
</body>
</html>
