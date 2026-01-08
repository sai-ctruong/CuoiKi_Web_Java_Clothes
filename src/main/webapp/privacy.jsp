<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chính Sách Bảo Mật - Clothing Shop</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,500;0,600;1,500&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <main class="py-5" style="min-height: 80vh; background: var(--bg-light);">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-dark text-white py-4">
                            <h1 class="h3 mb-0">
                                <i class="bi bi-shield-lock me-2"></i>Chính Sách Bảo Mật
                            </h1>
                        </div>
                        <div class="card-body p-4 p-lg-5">
                            <p class="text-muted mb-4">Cập nhật lần cuối: 01/01/2026</p>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">1. Thu Thập Thông Tin</h2>
                                <p>Chúng tôi thu thập các thông tin sau khi bạn sử dụng dịch vụ:</p>
                                <ul>
                                    <li>Thông tin cá nhân: họ tên, email, số điện thoại, địa chỉ</li>
                                    <li>Thông tin đăng nhập: tên đăng nhập, mật khẩu (được mã hóa)</li>
                                    <li>Thông tin giao dịch: lịch sử đơn hàng, thanh toán</li>
                                    <li>Thông tin thiết bị: địa chỉ IP, trình duyệt, cookies</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">2. Mục Đích Sử Dụng</h2>
                                <ul>
                                    <li>Xử lý đơn hàng và giao hàng</li>
                                    <li>Liên hệ hỗ trợ khách hàng</li>
                                    <li>Gửi thông tin khuyến mãi (nếu bạn đồng ý)</li>
                                    <li>Cải thiện trải nghiệm mua sắm</li>
                                    <li>Phát hiện và ngăn chặn gian lận</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">3. Bảo Mật Thông Tin</h2>
                                <ul>
                                    <li>Mật khẩu được mã hóa bằng thuật toán BCrypt</li>
                                    <li>Kết nối SSL/TLS cho mọi giao dịch</li>
                                    <li>Không chia sẻ thông tin với bên thứ ba không được ủy quyền</li>
                                    <li>Nhân viên được đào tạo về bảo mật thông tin</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">4. Cookies</h2>
                                <p>Website sử dụng cookies để:</p>
                                <ul>
                                    <li>Duy trì phiên đăng nhập</li>
                                    <li>Lưu giỏ hàng của bạn</li>
                                    <li>Phân tích lưu lượng truy cập</li>
                                </ul>
                                <p>Bạn có thể tắt cookies trong cài đặt trình duyệt, nhưng một số tính năng có thể không hoạt động đúng.</p>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">5. Quyền Của Bạn</h2>
                                <ul>
                                    <li>Xem và chỉnh sửa thông tin cá nhân</li>
                                    <li>Yêu cầu xóa tài khoản và dữ liệu</li>
                                    <li>Hủy đăng ký nhận email marketing</li>
                                    <li>Yêu cầu xuất dữ liệu cá nhân</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">6. Liên Hệ</h2>
                                <p>Nếu có câu hỏi về chính sách bảo mật, vui lòng liên hệ:</p>
                                <ul class="list-unstyled">
                                    <li><i class="bi bi-envelope me-2"></i>Email: privacy@clothingshop.vn</li>
                                    <li><i class="bi bi-telephone me-2"></i>Hotline: 1900 1234</li>
                                </ul>
                            </section>
                            
                            <div class="text-center pt-4 border-top">
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-gold">
                                    <i class="bi bi-arrow-left me-2"></i>Quay lại đăng ký
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
