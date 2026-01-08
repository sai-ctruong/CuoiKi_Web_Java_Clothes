<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điều Khoản Sử Dụng - Clothing Shop</title>
    
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
                                <i class="bi bi-file-text me-2"></i>Điều Khoản Sử Dụng
                            </h1>
                        </div>
                        <div class="card-body p-4 p-lg-5">
                            <p class="text-muted mb-4">Cập nhật lần cuối: 01/01/2026</p>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">1. Giới Thiệu</h2>
                                <p>Chào mừng bạn đến với Clothing Shop. Bằng việc truy cập và sử dụng website này, bạn đồng ý tuân thủ các điều khoản và điều kiện sau đây.</p>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">2. Tài Khoản Người Dùng</h2>
                                <ul>
                                    <li>Bạn phải cung cấp thông tin chính xác khi đăng ký tài khoản</li>
                                    <li>Bạn chịu trách nhiệm bảo mật thông tin đăng nhập của mình</li>
                                    <li>Mỗi người chỉ được sở hữu một tài khoản</li>
                                    <li>Chúng tôi có quyền khóa hoặc xóa tài khoản vi phạm</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">3. Đặt Hàng & Thanh Toán</h2>
                                <ul>
                                    <li>Giá sản phẩm có thể thay đổi mà không báo trước</li>
                                    <li>Đơn hàng chỉ được xác nhận sau khi thanh toán thành công</li>
                                    <li>Chúng tôi hỗ trợ nhiều phương thức thanh toán an toàn</li>
                                    <li>Voucher giảm giá có điều kiện sử dụng riêng</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">4. Giao Hàng & Đổi Trả</h2>
                                <ul>
                                    <li>Thời gian giao hàng từ 2-5 ngày làm việc</li>
                                    <li>Miễn phí vận chuyển cho đơn hàng từ 500,000đ</li>
                                    <li>Hỗ trợ đổi trả trong vòng 30 ngày</li>
                                    <li>Sản phẩm đổi trả phải còn nguyên tem, mác</li>
                                </ul>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">5. Quyền Sở Hữu Trí Tuệ</h2>
                                <p>Tất cả nội dung trên website bao gồm hình ảnh, văn bản, logo thuộc quyền sở hữu của Clothing Shop và được bảo vệ bởi luật sở hữu trí tuệ.</p>
                            </section>
                            
                            <section class="mb-5">
                                <h2 class="h5 fw-bold mb-3">6. Liên Hệ</h2>
                                <p>Nếu có bất kỳ câu hỏi nào về điều khoản sử dụng, vui lòng liên hệ:</p>
                                <ul class="list-unstyled">
                                    <li><i class="bi bi-envelope me-2"></i>Email: support@clothingshop.vn</li>
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
