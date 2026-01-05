<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <h5><i class="bi bi-bag-heart text-gold me-2"></i>Clothing Shop</h5>
                <p>Thời trang cao cấp với giá cả hợp lý. Phong cách hiện đại, xu hướng mới nhất.</p>
                <div class="footer-social">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-twitter-x"></i></a>
                    <a href="#"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4 mb-4">
                <h5>Liên Kết</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/products">Sản Phẩm</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/about">Giới Thiệu</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/contact">Liên Hệ</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-4 mb-4">
                <h5>Hỗ Trợ</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#">FAQ</a></li>
                    <li class="mb-2"><a href="#">Chính Sách Giao Hàng</a></li>
                    <li class="mb-2"><a href="#">Chính Sách Đổi Trả</a></li>
                    <li class="mb-2"><a href="#">Điều Khoản Sử Dụng</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-4 mb-4">
                <h5>Liên Hệ</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="bi bi-geo-alt text-gold me-2"></i>Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM</li>
                    <li class="mb-2"><i class="bi bi-telephone text-gold me-2"></i>1900 1234</li>
                    <li class="mb-2"><i class="bi bi-envelope text-gold me-2"></i>info@clothingshop.com</li>
                    <li class="mb-2"><i class="bi bi-clock text-gold me-2"></i>8:00 - 22:00 hàng ngày</li>
                </ul>
            </div>
        </div>
        <hr style="border-color: rgba(255,255,255,0.1);">
        <div class="d-flex flex-wrap justify-content-between align-items-center">
            <p class="mb-0 small">© <%= java.time.Year.now().getValue() %> Clothing Shop. All rights reserved.</p>
            <div class="d-flex gap-3">
                <img src="https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png" alt="Visa" height="24">
                <img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png" alt="Mastercard" height="24">
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>