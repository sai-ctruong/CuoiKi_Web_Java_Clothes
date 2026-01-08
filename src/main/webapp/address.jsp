<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sổ Địa Chỉ - Clothing Shop</title>
    
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        body {
            padding-top: 80px; /* Account for fixed header */
        }
        
        .profile-page {
            padding-top: 100px;
            padding-bottom: 3rem;
            min-height: 100vh;
            background: var(--bg-cream);
        }
        
        .profile-sidebar {
            background: var(--text-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 1.5rem;
            position: sticky;
            top: 100px;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: var(--bg-dark);
            color: var(--accent-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 1rem;
        }
        
        .profile-name {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            text-align: center;
            margin-bottom: 0.5rem;
        }
        
        .profile-email {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .profile-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .profile-nav li {
            margin-bottom: 0.5rem;
        }
        
        .profile-nav a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            border-radius: var(--radius-sm);
            color: var(--text-dark);
            font-family: 'Montserrat', sans-serif;
            font-size: 0.9rem;
            transition: var(--transition-fast);
        }
        
        .profile-nav a:hover,
        .profile-nav a.active {
            background: var(--bg-dark);
            color: var(--text-white);
        }
        
        .profile-nav a.active i {
            color: var(--accent-color);
        }
        
        .profile-content {
            background: var(--text-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 2rem;
        }
        
        .section-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.5rem;
            font-style: italic;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .address-card {
            border: 1px solid #dee2e6;
            border-radius: var(--radius-md);
            padding: 1.25rem;
            margin-bottom: 1rem;
            position: relative;
            transition: var(--transition-fast);
        }
        
        .address-card:hover {
            border-color: var(--accent-color);
            box-shadow: var(--shadow-sm);
        }
        
        .address-card.default {
            border-color: var(--accent-color);
            background: rgba(212, 162, 76, 0.05);
        }
        
        .address-badge {
            position: absolute;
            top: 0.75rem;
            right: 0.75rem;
            background: var(--accent-color);
            color: var(--text-dark);
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
            border-radius: var(--radius-sm);
            font-weight: 600;
        }
        
        .address-name {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .address-detail {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        
        .address-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .address-actions a,
        .address-actions button {
            font-size: 0.8rem;
            padding: 0.35rem 0.75rem;
        }
        
        .btn-add-address {
            background: var(--accent-color);
            border: none;
            color: var(--text-dark);
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0.75rem 1.5rem;
            transition: var(--transition-normal);
        }
        
        .btn-add-address:hover {
            background: var(--accent-hover);
            color: var(--text-dark);
        }
        
        .address-form {
            background: var(--bg-cream);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin-top: 1.5rem;
        }
        
        .form-label {
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            font-size: 0.85rem;
            color: var(--text-dark);
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(212, 162, 76, 0.25);
        }
        
        .btn-save {
            background: var(--bg-dark);
            border: none;
            color: var(--text-white);
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            padding: 0.65rem 1.5rem;
            transition: var(--transition-normal);
        }
        
        .btn-save:hover {
            background: var(--accent-color);
            color: var(--text-dark);
        }
        
        .btn-cancel {
            color: var(--text-muted);
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-muted);
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="includes/header.jsp" />
    
    <div class="profile-page">
        <div class="container">
            <div class="row g-4">
                <!-- Sidebar -->
                <div class="col-lg-3">
                    <div class="profile-sidebar">
                        <div class="profile-avatar">
                            <i class="bi bi-person-fill"></i>
                        </div>
                        <h5 class="profile-name">${sessionScope.user.fullName}</h5>
                        <p class="profile-email">${sessionScope.user.email}</p>
                        
                        <ul class="profile-nav">
                            <li>
                                <a href="${pageContext.request.contextPath}/profile">
                                    <i class="bi bi-person"></i> Thông Tin Cá Nhân
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/address" class="active">
                                    <i class="bi bi-geo-alt"></i> Sổ Địa Chỉ
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/my-orders">
                                    <i class="bi bi-bag"></i> Đơn Hàng Của Tôi
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right"></i> Đăng Xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- Main Content -->
                <div class="col-lg-9">
                    <div class="profile-content">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3 class="section-title mb-0" style="border-bottom: none; padding-bottom: 0;">Sổ Địa Chỉ</h3>
                            <button class="btn btn-add-address" data-bs-toggle="collapse" data-bs-target="#addAddressForm">
                                <i class="bi bi-plus-lg me-2"></i>Thêm Địa Chỉ
                            </button>
                        </div>
                        
                        <!-- Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <!-- Add Address Form (Collapsible) -->
                        <div class="collapse ${not empty editAddress ? '' : ''}" id="addAddressForm">
                            <div class="address-form">
                                <h5 class="mb-3">
                                    <c:choose>
                                        <c:when test="${not empty editAddress}">Sửa Địa Chỉ</c:when>
                                        <c:otherwise>Thêm Địa Chỉ Mới</c:otherwise>
                                    </c:choose>
                                </h5>
                                
                                <form action="${pageContext.request.contextPath}/address" method="POST">
                                    <c:if test="${not empty editAddress}">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="addressId" value="${editAddress.id}">
                                    </c:if>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="recipientName">Tên người nhận <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="recipientName" name="recipientName" 
                                                   value="${editAddress.recipientName}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="phone">Số điện thoại <span class="text-danger">*</span></label>
                                            <input type="tel" class="form-control" id="phone" name="phone" 
                                                   value="${editAddress.phone}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label" for="street">Địa chỉ chi tiết <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="street" name="street" 
                                               value="${editAddress.street}" required
                                               placeholder="Số nhà, tên đường, phường/xã, quận/huyện">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label" for="city">Tỉnh/Thành phố <span class="text-danger">*</span></label>
                                        <select class="form-select" id="city" name="city" required>
                                            <option value="">-- Chọn Tỉnh/Thành phố --</option>
                                            <option value="Hà Nội" ${editAddress.city == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
                                            <option value="TP. Hồ Chí Minh" ${editAddress.city == 'TP. Hồ Chí Minh' ? 'selected' : ''}>TP. Hồ Chí Minh</option>
                                            <option value="Đà Nẵng" ${editAddress.city == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                                            <option value="Hải Phòng" ${editAddress.city == 'Hải Phòng' ? 'selected' : ''}>Hải Phòng</option>
                                            <option value="Cần Thơ" ${editAddress.city == 'Cần Thơ' ? 'selected' : ''}>Cần Thơ</option>
                                            <option value="An Giang" ${editAddress.city == 'An Giang' ? 'selected' : ''}>An Giang</option>
                                            <option value="Bà Rịa - Vũng Tàu" ${editAddress.city == 'Bà Rịa - Vũng Tàu' ? 'selected' : ''}>Bà Rịa - Vũng Tàu</option>
                                            <option value="Bắc Giang" ${editAddress.city == 'Bắc Giang' ? 'selected' : ''}>Bắc Giang</option>
                                            <option value="Bắc Kạn" ${editAddress.city == 'Bắc Kạn' ? 'selected' : ''}>Bắc Kạn</option>
                                            <option value="Bạc Liêu" ${editAddress.city == 'Bạc Liêu' ? 'selected' : ''}>Bạc Liêu</option>
                                            <option value="Bắc Ninh" ${editAddress.city == 'Bắc Ninh' ? 'selected' : ''}>Bắc Ninh</option>
                                            <option value="Bến Tre" ${editAddress.city == 'Bến Tre' ? 'selected' : ''}>Bến Tre</option>
                                            <option value="Bình Định" ${editAddress.city == 'Bình Định' ? 'selected' : ''}>Bình Định</option>
                                            <option value="Bình Dương" ${editAddress.city == 'Bình Dương' ? 'selected' : ''}>Bình Dương</option>
                                            <option value="Bình Phước" ${editAddress.city == 'Bình Phước' ? 'selected' : ''}>Bình Phước</option>
                                            <option value="Bình Thuận" ${editAddress.city == 'Bình Thuận' ? 'selected' : ''}>Bình Thuận</option>
                                            <option value="Cà Mau" ${editAddress.city == 'Cà Mau' ? 'selected' : ''}>Cà Mau</option>
                                            <option value="Cao Bằng" ${editAddress.city == 'Cao Bằng' ? 'selected' : ''}>Cao Bằng</option>
                                            <option value="Đắk Lắk" ${editAddress.city == 'Đắk Lắk' ? 'selected' : ''}>Đắk Lắk</option>
                                            <option value="Đắk Nông" ${editAddress.city == 'Đắk Nông' ? 'selected' : ''}>Đắk Nông</option>
                                            <option value="Điện Biên" ${editAddress.city == 'Điện Biên' ? 'selected' : ''}>Điện Biên</option>
                                            <option value="Đồng Nai" ${editAddress.city == 'Đồng Nai' ? 'selected' : ''}>Đồng Nai</option>
                                            <option value="Đồng Tháp" ${editAddress.city == 'Đồng Tháp' ? 'selected' : ''}>Đồng Tháp</option>
                                            <option value="Gia Lai" ${editAddress.city == 'Gia Lai' ? 'selected' : ''}>Gia Lai</option>
                                            <option value="Hà Giang" ${editAddress.city == 'Hà Giang' ? 'selected' : ''}>Hà Giang</option>
                                            <option value="Hà Nam" ${editAddress.city == 'Hà Nam' ? 'selected' : ''}>Hà Nam</option>
                                            <option value="Hà Tĩnh" ${editAddress.city == 'Hà Tĩnh' ? 'selected' : ''}>Hà Tĩnh</option>
                                            <option value="Hải Dương" ${editAddress.city == 'Hải Dương' ? 'selected' : ''}>Hải Dương</option>
                                            <option value="Hậu Giang" ${editAddress.city == 'Hậu Giang' ? 'selected' : ''}>Hậu Giang</option>
                                            <option value="Hòa Bình" ${editAddress.city == 'Hòa Bình' ? 'selected' : ''}>Hòa Bình</option>
                                            <option value="Hưng Yên" ${editAddress.city == 'Hưng Yên' ? 'selected' : ''}>Hưng Yên</option>
                                            <option value="Khánh Hòa" ${editAddress.city == 'Khánh Hòa' ? 'selected' : ''}>Khánh Hòa</option>
                                            <option value="Kiên Giang" ${editAddress.city == 'Kiên Giang' ? 'selected' : ''}>Kiên Giang</option>
                                            <option value="Kon Tum" ${editAddress.city == 'Kon Tum' ? 'selected' : ''}>Kon Tum</option>
                                            <option value="Lai Châu" ${editAddress.city == 'Lai Châu' ? 'selected' : ''}>Lai Châu</option>
                                            <option value="Lâm Đồng" ${editAddress.city == 'Lâm Đồng' ? 'selected' : ''}>Lâm Đồng</option>
                                            <option value="Lạng Sơn" ${editAddress.city == 'Lạng Sơn' ? 'selected' : ''}>Lạng Sơn</option>
                                            <option value="Lào Cai" ${editAddress.city == 'Lào Cai' ? 'selected' : ''}>Lào Cai</option>
                                            <option value="Long An" ${editAddress.city == 'Long An' ? 'selected' : ''}>Long An</option>
                                            <option value="Nam Định" ${editAddress.city == 'Nam Định' ? 'selected' : ''}>Nam Định</option>
                                            <option value="Nghệ An" ${editAddress.city == 'Nghệ An' ? 'selected' : ''}>Nghệ An</option>
                                            <option value="Ninh Bình" ${editAddress.city == 'Ninh Bình' ? 'selected' : ''}>Ninh Bình</option>
                                            <option value="Ninh Thuận" ${editAddress.city == 'Ninh Thuận' ? 'selected' : ''}>Ninh Thuận</option>
                                            <option value="Phú Thọ" ${editAddress.city == 'Phú Thọ' ? 'selected' : ''}>Phú Thọ</option>
                                            <option value="Phú Yên" ${editAddress.city == 'Phú Yên' ? 'selected' : ''}>Phú Yên</option>
                                            <option value="Quảng Bình" ${editAddress.city == 'Quảng Bình' ? 'selected' : ''}>Quảng Bình</option>
                                            <option value="Quảng Nam" ${editAddress.city == 'Quảng Nam' ? 'selected' : ''}>Quảng Nam</option>
                                            <option value="Quảng Ngãi" ${editAddress.city == 'Quảng Ngãi' ? 'selected' : ''}>Quảng Ngãi</option>
                                            <option value="Quảng Ninh" ${editAddress.city == 'Quảng Ninh' ? 'selected' : ''}>Quảng Ninh</option>
                                            <option value="Quảng Trị" ${editAddress.city == 'Quảng Trị' ? 'selected' : ''}>Quảng Trị</option>
                                            <option value="Sóc Trăng" ${editAddress.city == 'Sóc Trăng' ? 'selected' : ''}>Sóc Trăng</option>
                                            <option value="Sơn La" ${editAddress.city == 'Sơn La' ? 'selected' : ''}>Sơn La</option>
                                            <option value="Tây Ninh" ${editAddress.city == 'Tây Ninh' ? 'selected' : ''}>Tây Ninh</option>
                                            <option value="Thái Bình" ${editAddress.city == 'Thái Bình' ? 'selected' : ''}>Thái Bình</option>
                                            <option value="Thái Nguyên" ${editAddress.city == 'Thái Nguyên' ? 'selected' : ''}>Thái Nguyên</option>
                                            <option value="Thanh Hóa" ${editAddress.city == 'Thanh Hóa' ? 'selected' : ''}>Thanh Hóa</option>
                                            <option value="Thừa Thiên Huế" ${editAddress.city == 'Thừa Thiên Huế' ? 'selected' : ''}>Thừa Thiên Huế</option>
                                            <option value="Tiền Giang" ${editAddress.city == 'Tiền Giang' ? 'selected' : ''}>Tiền Giang</option>
                                            <option value="Trà Vinh" ${editAddress.city == 'Trà Vinh' ? 'selected' : ''}>Trà Vinh</option>
                                            <option value="Tuyên Quang" ${editAddress.city == 'Tuyên Quang' ? 'selected' : ''}>Tuyên Quang</option>
                                            <option value="Vĩnh Long" ${editAddress.city == 'Vĩnh Long' ? 'selected' : ''}>Vĩnh Long</option>
                                            <option value="Vĩnh Phúc" ${editAddress.city == 'Vĩnh Phúc' ? 'selected' : ''}>Vĩnh Phúc</option>
                                            <option value="Yên Bái" ${editAddress.city == 'Yên Bái' ? 'selected' : ''}>Yên Bái</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-check mb-3">
                                        <input type="checkbox" class="form-check-input" id="isDefault" name="isDefault"
                                               ${editAddress.defaultAddress ? 'checked' : ''}>
                                        <label class="form-check-label" for="isDefault">Đặt làm địa chỉ mặc định</label>
                                    </div>
                                    
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-save">
                                            <i class="bi bi-check-lg me-2"></i>Lưu Địa Chỉ
                                        </button>
                                        <button type="button" class="btn btn-cancel" data-bs-toggle="collapse" data-bs-target="#addAddressForm">
                                            Hủy
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Address List -->
                        <div class="mt-4">
                            <c:choose>
                                <c:when test="${empty addresses}">
                                    <div class="empty-state">
                                        <i class="bi bi-geo-alt"></i>
                                        <p>Bạn chưa có địa chỉ nào</p>
                                        <p class="small">Thêm địa chỉ để tiện lợi hơn khi thanh toán</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${addresses}" var="addr">
                                        <div class="address-card ${addr.defaultAddress ? 'default' : ''}">
                                            <c:if test="${addr.defaultAddress}">
                                                <span class="address-badge">Mặc định</span>
                                            </c:if>
                                            
                                            <div class="address-name">${addr.recipientName}</div>
                                            <div class="address-detail">
                                                <i class="bi bi-telephone me-1"></i>${addr.phone}
                                            </div>
                                            <div class="address-detail">
                                                <i class="bi bi-geo-alt me-1"></i>${addr.street}, ${addr.city}
                                            </div>
                                            
                                            <div class="address-actions">
                                                <a href="${pageContext.request.contextPath}/address?action=edit&id=${addr.id}" 
                                                   class="btn btn-outline-secondary btn-sm">
                                                    <i class="bi bi-pencil me-1"></i>Sửa
                                                </a>
                                                
                                                <c:if test="${!addr.defaultAddress}">
                                                    <a href="${pageContext.request.contextPath}/address?action=setDefault&id=${addr.id}" 
                                                       class="btn btn-outline-primary btn-sm">
                                                        <i class="bi bi-check-circle me-1"></i>Đặt mặc định
                                                    </a>
                                                </c:if>
                                                
                                                <a href="${pageContext.request.contextPath}/address?action=delete&id=${addr.id}" 
                                                   class="btn btn-outline-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa địa chỉ này?')">
                                                    <i class="bi bi-trash me-1"></i>Xóa
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer Include -->
    <jsp:include page="includes/footer.jsp" />
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-show form if editing
        <c:if test="${not empty editAddress}">
            document.getElementById('addAddressForm').classList.add('show');
        </c:if>
    </script>
</body>
</html>
