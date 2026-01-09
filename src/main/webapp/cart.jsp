<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Giỏ Hàng - Clothing Shop</title>

                <!-- Bootstrap 5 CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Bootstrap Icons -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <!-- Custom CSS -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css">
            </head>

            <body>
                <jsp:include page="includes/header.jsp" />

                <c:if test="${not empty sessionScope.successMessage}">
                    <c:remove var="successMessage" scope="session" />
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <section class="alert alert-danger alert-dismissible fade show" role="alert"
                        style="margin: 0; border-radius: 0; margin-top: 76px;">
                        <strong>Lỗi!</strong> ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="errorMessage" scope="session" />
                    </section>
                </c:if>

                <main class="cart-container">
                    <section class="container">
                        <header class="cart-header">
                            <h1 class="mb-0"><i class="bi bi-cart3 me-2"></i>ĐƠN HÀNG CỦA BẠN</h1>
                        </header>

                        <section class="row">
                            <!-- Cart Items Section -->
                            <section class="col-lg-8">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.cart and not empty sessionScope.cart.items}">
                                        <c:forEach var="item" items="${sessionScope.cart.items}">
                                            <article class="cart-item">
                                                <section class="row align-items-center">
                                                    <section class="col-md-2">
                                                        <img src="https://picsum.photos/200/200?random=${item.product.id}"
                                                            alt="${item.product.name}" class="product-image-cart">
                                                    </section>
                                                    <section class="col-md-4">
                                                        <h5 class="mb-1">${item.product.name}</h5>
                                                        <p class="text-muted mb-1 small">
                                                            <c:if test="${not empty item.product.size}">Size:
                                                                ${item.product.size}</c:if>
                                                            <c:if test="${not empty item.product.color}"> | Màu:
                                                                ${item.product.color}</c:if>
                                                        </p>
                                                        <c:if test="${not empty item.product.brand}">
                                                            <p class="text-muted mb-0 small">Thương hiệu:
                                                                ${item.product.brand.name}</p>
                                                        </c:if>
                                                    </section>
                                                    <section class="col-md-2 text-center">
                                                        <label class="form-label small">Số lượng</label>
                                                        <input type="number"
                                                            class="form-control form-control-sm text-center"
                                                            value="${item.quantity}" min="1"
                                                            style="max-width: 80px; margin: 0 auto;"
                                                            onchange="updateQuantity('${item.product.id}', this.value)">
                                                    </section>
                                                    <section class="col-md-2 text-center">
                                                        <p class="mb-0 fw-bold text-danger">
                                                            <fmt:formatNumber value="${item.subtotal}" type="number"
                                                                maxFractionDigits="0" /> đ
                                                        </p>
                                                        <p class="text-muted small mb-0">
                                                            <fmt:formatNumber value="${item.product.price}"
                                                                type="number" maxFractionDigits="0" /> đ
                                                        </p>
                                                    </section>
                                                    <section class="col-md-2 text-end">
                                                        <button type="button" class="btn btn-sm btn-outline-danger"
                                                            onclick="removeItem('${item.product.id}')">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </section>
                                                </section>
                                            </article>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <article class="empty-cart">
                                            <i class="bi bi-cart-x empty-cart-icon"></i>
                                            <h3>Giỏ hàng của bạn đang trống</h3>
                                            <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3">
                                                <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                                            </a>
                                        </article>
                                    </c:otherwise>
                                </c:choose>
                            </section>

                            <!-- Order Summary Section -->
                            <section class="col-lg-4">
                                <aside class="order-summary">
                                    <h4 class="mb-3">Tóm tắt đơn hàng</h4>

                                    <c:choose>
                                        <c:when
                                            test="${not empty sessionScope.cart and not empty sessionScope.cart.items}">
                                            <c:set var="cartTotal" value="${sessionScope.cart.totalPrice}" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="cartTotal" value="0" />
                                        </c:otherwise>
                                    </c:choose>

                                    <section class="summary-row">
                                        <span>Tạm tính:</span>
                                        <span>
                                            <fmt:formatNumber value="${cartTotal}" type="number"
                                                maxFractionDigits="0" /> đ
                                        </span>
                                    </section>
                                    <section class="summary-row">
                                        <span>Phí vận chuyển:</span>
                                        <span>Miễn phí</span>
                                    </section>
                                    <section class="summary-row" id="discount-row"
                                        style="${empty sessionScope.cart.voucher ? 'display: none;' : ''}">
                                        <span>Giảm giá:</span>
                                        <span class="text-danger" id="discount-amount">
                                            <c:if test="${not empty sessionScope.cart.voucher}">
                                                -
                                                <fmt:formatNumber value="${sessionScope.cart.discountAmount}"
                                                    type="number" maxFractionDigits="0" /> đ
                                            </c:if>
                                        </span>
                                    </section>

                                    <!-- Voucher Box -->
                                    <c:if test="${not empty sessionScope.voucherMessage}">
                                        <div class="alert alert-${sessionScope.voucherStatus == 'success' ? 'success' : 'danger'} alert-dismissible fade show"
                                            role="alert">
                                            ${sessionScope.voucherMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                        <c:remove var="voucherMessage" scope="session" />
                                        <c:remove var="voucherStatus" scope="session" />
                                    </c:if>

                                    <section class="mb-3 mt-3">
                                        <form action="${pageContext.request.contextPath}/cart/apply-voucher"
                                            method="post" class="input-group">
                                            <input type="text" class="form-control" name="code"
                                                placeholder="Mã giảm giá/Voucher" aria-label="Mã giảm giá"
                                                value="${sessionScope.cart.voucher.code}">
                                            <button class="btn btn-outline-primary" type="submit">Áp dụng</button>
                                        </form>

                                        <c:if test="${not empty sessionScope.cart.voucher}">
                                            <div class="mt-2">
                                                <small class="text-success">Đang dùng:
                                                    <strong>${sessionScope.cart.voucher.code}</strong></small>
                                                <form action="${pageContext.request.contextPath}/cart/remove-voucher"
                                                    method="post" class="d-inline">
                                                    <button type="submit"
                                                        class="btn btn-link btn-sm text-danger p-0 ms-2"
                                                        style="text-decoration: none;">
                                                        <i class="bi bi-x-circle"></i> Hủy
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>
                                    </section>

                                    <section class="summary-row">
                                        <span><b>Tổng cộng:</b></span>
                                        <span id="final-total">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.cart}">
                                                    <fmt:formatNumber value="${sessionScope.cart.finalTotal}"
                                                        type="number" maxFractionDigits="0" /> đ
                                                </c:when>
                                                <c:otherwise>
                                                    0 đ
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </section>

                                    <c:if test="${not empty sessionScope.cart and not empty sessionScope.cart.items}">
                                        <button type="button" class="btn btn-primary w-100 mt-4" onclick="checkout()">
                                            <i class="bi bi-credit-card me-2"></i>THANH TOÁN
                                        </button>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/"
                                        class="btn btn-outline-secondary w-100 mt-2">
                                        <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                                    </a>
                                </aside>
                            </section>
                        </section>
                    </section>
                </main>

                <!-- Footer Include -->
                <jsp:include page="includes/footer.jsp" />

                <!-- Bootstrap 5 JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    function updateQuantity(productId, quantity) {
                        if (quantity < 1) {
                            quantity = 1;
                        }
                        window.location.href = '${pageContext.request.contextPath}/cart/update?id=' + productId + '&quantity=' + quantity;
                    }

                    function removeItem(productId) {
                        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                            window.location.href = '${pageContext.request.contextPath}/cart/remove?id=' + productId;
                        }
                    }

                    function checkout() {
                        window.location.href = '${pageContext.request.contextPath}/checkout';
                    }
                </script>
            </body>

            </html>