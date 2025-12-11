   <%@page contentType="text/html" pageEncoding="UTF-8"%>
   <!-- Footer -->
    <footer class="bg-dark text-light py-5 mt-5">
        <section class="container">
            <section class="row">
                <section class="col-lg-4 col-md-6 mb-4">
                    <h5 class="mb-3">
                        <i class="fas fa-tshirt me-2"></i>Clothing Shop
                    </h5>
                    <p>Chúng tôi cung cấp những sản phẩm thời trang chất lượng cao với giá cả hợp lý. Phong cách hiện đại, xu hướng mới nhất.</p>
                    <section class="social-links">
                        <a href="#" class="text-light me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-light"><i class="fab fa-youtube"></i></a>
                    </section>
                </section>
                
                <section class="col-lg-2 col-md-6 mb-4">
                    <h6 class="mb-3">Liên Kết</h6>
                    <ul class="list-unstyled">
                        <li><a href="home" class="text-light-50">Trang Chủ</a></li>
                        <li><a href="products" class="text-light-50">Sản Phẩm</a></li>
                        <li><a href="about" class="text-light-50">Giới Thiệu</a></li>
                        <li><a href="contact" class="text-light-50">Liên Hệ</a></li>
                    </ul>
                </section>
                
                <section class="col-lg-3 col-md-6 mb-4">
                    <h6 class="mb-3">Hỗ Trợ</h6>
                    <ul class="list-unstyled">
                        <li><a href="faq" class="text-light-50">Câu Hỏi Thường Gặp</a></li>
                        <li><a href="shipping" class="text-light-50">Chính Sách Giao Hàng</a></li>
                        <li><a href="returns" class="text-light-50">Đổi Trả</a></li>
                        <li><a href="privacy" class="text-light-50">Chính Sách Bảo Mật</a></li>
                    </ul>
                </section>
                
                <section class="col-lg-3 col-md-6 mb-4">
                    <h6 class="mb-3">Liên Hệ</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM
                        </li>
                        <li class="mb-2">
                            <i class="fas fa-phone me-2"></i>
                            (028) 1234 5678
                        </li>
                        <li class="mb-2">
                            <i class="fas fa-envelope me-2"></i>
                            info@clothingshop.com
                        </li>
                        <li>
                            <i class="fas fa-clock me-2"></i>
                            8:00 - 22:00 (Thứ 2 - CN)
                        </li>
                    </ul>
                </section>
            </section>
            
            <hr class="my-4">
            
            <section class="row align-items-center">
                <section class="col-md-6">
                    <p class="mb-0">&copy; 2024 Clothing Shop. Tất cả quyền được bảo lưu.</p>
                </section>
                <section class="col-md-6 text-md-end">
                    <p class="mb-0">Thiết kế bởi <strong>Your Team</strong></p>
                </section>
            </section>
        </section>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
        
        // Add fade-in animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in-up');
                }
            });
        }, observerOptions);
        
        document.querySelectorAll('.product-card, .feature-item').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>