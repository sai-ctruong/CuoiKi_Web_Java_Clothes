<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên Hệ - Clothing Shop</title>
    
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 70px; /* Match header height */
            background: var(--bg-light);
        }
        
        .contact-hero {
            background: linear-gradient(135deg, var(--dark) 0%, var(--dark-surface) 100%);
            padding: 4rem 0 3rem;
            margin-bottom: 3rem;
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
            box-shadow: var(--shadow-lg);
        }
        
        .contact-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 600;
            color: white;
            margin-bottom: 1rem;
        }
        
        .contact-hero p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            margin: 0;
        }
        
        .contact-section {
            padding: 2rem 0 4rem;
        }
        
        .contact-info-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            height: 100%;
            border: 2px solid transparent;
        }
        
        .contact-info-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: var(--gold);
        }
        
        .contact-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--gold), var(--gold-light));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
            box-shadow: 0 10px 30px rgba(201, 169, 98, 0.3);
        }
        
        .contact-info-card h5 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1rem;
        }
        
        .contact-info-card p {
            color: var(--text-body);
            font-size: 1rem;
            line-height: 1.6;
            margin: 0;
        }
        
        .contact-form-wrapper {
            background: white;
            border-radius: var(--radius-xl);
            padding: 3rem 2.5rem;
            box-shadow: var(--shadow-lg);
            margin-bottom: 3rem;
        }
        
        .contact-form-wrapper h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 2rem;
        }
        
        .form-control {
            padding: 1rem 1.25rem;
            border: 2px solid #e9ecef;
            border-radius: var(--radius);
            transition: var(--transition);
            font-size: 1rem;
        }
        
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 0.2rem rgba(201, 169, 98, 0.15);
        }
        
        .btn-submit {
            background: var(--gold);
            border: none;
            color: white;
            font-weight: 600;
            padding: 1rem 3rem;
            font-size: 1.1rem;
            border-radius: var(--radius);
            transition: var(--transition);
        }
        
        .btn-submit:hover {
            background: var(--gold-dark);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(201, 169, 98, 0.3);
        }
        
        .map-section {
            background: white;
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }
        
        .map-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .map-header h4 {
            font-family: 'Playfair Display', serif;
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }
        
        .map-header p {
            color: var(--text-body);
            font-size: 1.1rem;
            margin: 0;
        }
        
        .map-container {
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            position: relative;
        }
        
        .map-container iframe {
            width: 100%;
            height: 400px;
            border: none;
            filter: grayscale(20%);
            transition: var(--transition);
        }
        
        .map-container:hover iframe {
            filter: grayscale(0%);
        }
        
        .address-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: white;
            padding: 0.75rem 1.25rem;
            border-radius: 50px;
            box-shadow: var(--shadow-md);
            font-weight: 600;
            color: var(--text-dark);
            font-size: 0.9rem;
            z-index: 10;
        }
        
        .address-badge i {
            color: var(--gold);
            margin-right: 0.5rem;
        }
        
        .business-hours {
            background: linear-gradient(135deg, var(--bg-light) 0%, #f8f9fa 100%);
            border-radius: var(--radius-xl);
            padding: 2rem;
            margin-top: 2rem;
            border: 2px solid rgba(201, 169, 98, 0.1);
        }
        
        .business-hours h5 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .hours-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .hours-list li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            color: var(--text-body);
        }
        
        .hours-list li:last-child {
            border-bottom: none;
        }
        
        .hours-list .day {
            font-weight: 600;
        }
        
        .hours-list .time {
            color: var(--gold-dark);
            font-weight: 500;
        }
        
        /* Responsive */
        @media (max-width: 767.98px) {
            .contact-hero {
                padding: 2rem 0;
            }
            
            .contact-hero h1 {
                font-size: 2rem;
            }
            
            .contact-info-card {
                padding: 2rem 1.5rem;
            }
            
            .contact-form-wrapper {
                padding: 2rem 1.5rem;
            }
            
            .map-container iframe {
                height: 300px;
            }
            
            .address-badge {
                position: static;
                margin-bottom: 1rem;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <!-- Contact Hero Section -->
    <div class="contact-hero" data-aos="fade-down">
        <div class="container">
            <div class="text-center">
                <h1><i class="bi bi-envelope-heart me-3"></i>Liên Hệ Với Chúng Tôi</h1>
                <p>Chúng tôi luôn sẵn sàng hỗ trợ và tư vấn cho bạn</p>
            </div>
        </div>
    </div>
    
    <!-- Contact Section -->
    <section class="contact-section">
        <div class="container">
            <!-- Info Cards Row -->
            <div class="row g-4 mb-5">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="contact-info-card">
                        <div class="contact-icon">
                            <i class="bi bi-geo-alt-fill"></i>
                        </div>
                        <h5>Địa Chỉ Cửa Hàng</h5>
                        <p>Số 1 Võ Văn Ngân<br>Thủ Đức, TP. Hồ Chí Minh<br>Việt Nam</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="contact-info-card">
                        <div class="contact-icon">
                            <i class="bi bi-telephone-fill"></i>
                        </div>
                        <h5>Điện Thoại</h5>
                        <p>Hotline: 1900 1234<br>Tel: (028) 1234 5678<br>Zalo: 0901 234 567</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12" data-aos="fade-up" data-aos-delay="300">
                    <div class="contact-info-card">
                        <div class="contact-icon">
                            <i class="bi bi-envelope-fill"></i>
                        </div>
                        <h5>Email</h5>
                        <p>info@clothingshop.com<br>support@clothingshop.com<br>order@clothingshop.com</p>
                    </div>
                </div>
            </div>
            
            <!-- Contact Form and Map Row -->
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-right">
                    <div class="contact-form-wrapper">
                        <h3 class="text-center">
                            <i class="bi bi-chat-dots me-2"></i>Gửi Tin Nhắn
                        </h3>
                        <form action="${pageContext.request.contextPath}/contact" method="POST">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="name" 
                                           placeholder="Họ và tên *" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="email" class="form-control" name="email" 
                                           placeholder="Email *" required>
                                </div>
                                <div class="col-12">
                                    <input type="text" class="form-control" name="subject" 
                                           placeholder="Tiêu đề">
                                </div>
                                <div class="col-12">
                                    <textarea class="form-control" name="message" rows="5" 
                                              placeholder="Nội dung tin nhắn *" required></textarea>
                                </div>
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn-submit">
                                        <i class="bi bi-send-fill me-2"></i>Gửi Tin Nhắn
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="map-section">
                        <div class="map-header">
                            <h4><i class="bi bi-pin-map me-2"></i>Vị Trí Cửa Hàng</h4>
                            <p>Tìm chúng tôi trên bản đồ</p>
                        </div>
                        
                        <div class="map-container">
                            <div class="address-badge">
                                <i class="bi bi-geo-alt-fill"></i>
                                Số 1 Võ Văn Ngân, Thủ Đức
                            </div>
                            <iframe 
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.4544374621546!2d106.76933897480535!3d10.850632789302647!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752797e321f8e9%3A0xb4b0f6b8b4b0f6b8!2zMSBWw7UgVsSDbiBOZ8OibiwgTGluaCBDaGnhu4F1LCBUaOG7pyDEkOG7qWMsIFRow6BuaCBwaOG7kSBI4buTIENow60gTWluaCwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1703123456789!5m2!1svi!2s"
                                allowfullscreen="" 
                                loading="lazy" 
                                referrerpolicy="no-referrer-when-downgrade">
                            </iframe>
                        </div>
                        
                        <div class="business-hours">
                            <h5><i class="bi bi-clock me-2"></i>Giờ Mở Cửa</h5>
                            <ul class="hours-list">
                                <li>
                                    <span class="day">Thứ 2 - Thứ 6</span>
                                    <span class="time">8:00 - 22:00</span>
                                </li>
                                <li>
                                    <span class="day">Thứ 7 - Chủ Nhật</span>
                                    <span class="time">8:00 - 23:00</span>
                                </li>
                                <li>
                                    <span class="day">Ngày Lễ</span>
                                    <span class="time">9:00 - 21:00</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="includes/footer.jsp" />
    
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
        
        // Form submission with loading state
        document.querySelector('form').addEventListener('submit', function(e) {
            const button = this.querySelector('.btn-submit');
            const originalText = button.innerHTML;
            
            // Show loading state
            button.innerHTML = '<i class="bi bi-arrow-repeat me-2 spin"></i>Đang gửi...';
            button.disabled = true;
            
            // Simulate form submission (remove this in production)
            setTimeout(() => {
                button.innerHTML = '<i class="bi bi-check me-2"></i>Đã gửi!';
                button.style.background = '#28a745';
                
                // Reset after 3 seconds
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.style.background = '';
                    button.disabled = false;
                }, 3000);
            }, 1000);
        });
        
        // Spin animation
        const style = document.createElement('style');
        style.textContent = `
            .spin {
                animation: spin 1s linear infinite;
            }
            @keyframes spin {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>

