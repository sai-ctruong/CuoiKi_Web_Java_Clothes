document.addEventListener('DOMContentLoaded', function () {
    // --------------------------------------------------------------------------
    // 1. DYNAMIC HTML INJECTION
    // --------------------------------------------------------------------------

    // 1.1 Inject Toast HTML if not present
    if (!document.getElementById('cartToast')) {
        const toastHTML = `
            <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1055">
                <div id="cartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-success text-white">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <strong class="me-auto">Thành công</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body" id="toastMessage">
                        Sản phẩm đã được thêm vào giỏ hàng.
                    </div>
                </div>
            </div>`;
        document.body.insertAdjacentHTML('beforeend', toastHTML);
    }

    // 1.2 Inject Mini Cart Modal HTML
    if (!document.getElementById('miniCartModal')) {
        const miniCartHTML = `
            <div class="modal fade" id="miniCartModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered"> <!-- Centered or just top right style -->
                    <div class="modal-content">
                        <div class="modal-header border-0 pb-0">
                            <h5 class="modal-title fw-bold">GIỎ HÀNG.</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="miniCartBody">
                            <!-- Items will be injected here -->
                            <div class="text-center py-4">
                                <div class="spinner-border text-secondary" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 d-block pt-0" id="miniCartFooter">
                            <hr>
                            <div class="d-flex justify-content-between mb-3 align-items-center">
                                <span class="text-muted">Tổng tiền tạm tính:</span>
                                <span class="fs-5 fw-bold" id="miniCartTotal">0 đ</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 align-items-center">
                                <span class="fw-bold">TỔNG HÓA ĐƠN</span>
                                <span class="fs-5 fw-bold" id="miniCartFinalTotal">0 đ</span>
                            </div>
                            <button type="button" class="btn btn-dark w-100 py-3 text-uppercase fw-bold" onclick="window.location.href='cart'">
                                Đi tới đặt hàng
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <style>
                /* Mini Cart Specific Styles to match image */
                #miniCartModal .modal-dialog {
                    max-width: 500px;
                    margin-top: 5rem; /* Adjust to be near header if possible */
                }
                .mini-cart-item {
                    display: flex;
                    gap: 15px;
                    margin-bottom: 20px;
                    position: relative;
                }
                .mini-cart-img {
                    width: 100px;
                    height: 120px; /* Portrait aspect ratio */
                    object-fit: cover;
                }
                .mini-cart-info {
                    flex: 1;
                }
                .mini-cart-title {
                    font-size: 0.9rem;
                    text-transform: uppercase;
                    margin-bottom: 5px;
                    padding-right: 20px;
                }
                .mini-cart-remove {
                    position: absolute;
                    top: 0;
                    right: 0;
                    cursor: pointer;
                    color: #999;
                    font-size: 1.2rem;
                }
                .mini-cart-details {
                    font-size: 0.9rem;
                    color: #555;
                }
                .mini-cart-price {
                    font-weight: 500;
                    text-align: right;
                }
            </style>
        `;
        document.body.insertAdjacentHTML('beforeend', miniCartHTML);
    }

    // --------------------------------------------------------------------------
    // 2. EVENT LISTENERS & INITIALIZATION
    // --------------------------------------------------------------------------

    // 2.0 Identify Cart Badge Element
    // Since header.jsp might lack the ID, we find it relative to the cart link
    let cartBadge = document.getElementById('cartCount');
    if (!cartBadge) {
        const cartLink = document.querySelector('a[href*="cart"]');
        if (cartLink) {
            cartBadge = cartLink.querySelector('.badge');
            if (cartBadge) {
                cartBadge.id = 'cartCount'; // Assign ID for future easier access
            }
        }
    }

    // 2.0.1 Fetch Initial Cart State (fix for hardcoded 0 in header)
    if (cartBadge) {
        fetch(getContextPath() + '/cart/api/get')
            .then(res => res.json())
            .then(data => {
                cartBadge.innerText = data.totalItems;
            })
            .catch(err => console.error("Failed to load initial cart count", err));
    }

    // 2.1 Mini Cart Trigger (Cart Icon Click)
    const cartIconLink = document.querySelector('a[href*="cart"]');
    if (cartIconLink) {
        cartIconLink.addEventListener('click', function (e) {
            e.preventDefault();
            const myModal = new bootstrap.Modal(document.getElementById('miniCartModal'));
            myModal.show();
            loadMiniCartData();
        });
    }

    function loadMiniCartData() {
        const body = document.getElementById('miniCartBody');
        const footer = document.getElementById('miniCartFooter');

        fetch(getContextPath() + '/cart/api/get')
            .then(res => res.json())
            .then(data => {
                const items = data.items;
                const total = data.totalPrice;

                // Also update badge in case it desynced
                if (cartBadge) cartBadge.innerText = data.totalItems;

                if (items.length === 0) {
                    body.innerHTML = '<p class="text-center py-4">Giỏ hàng của bạn đang trống.</p>';
                    footer.style.display = 'none';
                    return;
                }

                footer.style.display = 'block';

                let html = '';
                items.forEach(item => {
                    const priceFormatted = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(item.price);
                    const subtotalFormatted = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(item.price * item.quantity);

                    html += `
                    <div class="mini-cart-item border-bottom pb-3">
                        <img src="${item.thumbnail}" alt="${item.name}" class="mini-cart-img">
                        <div class="mini-cart-info">
                            <div class="mini-cart-title">${item.name}</div>
                            <span class="mini-cart-remove" onclick="removeCartItem(${item.productId})">&times;</span>
                            
                            <div class="row mini-cart-details">
                                <div class="col-4">Màu:</div>
                                <div class="col-8">${item.color || 'N/A'}</div>
                                
                                <div class="col-4">Size:</div>
                                <div class="col-8">${item.size || 'N/A'}</div>
                                
                                <div class="col-4">Số lượng:</div>
                                <div class="col-4">${item.quantity}</div>
                                <div class="col-4 text-end mini-cart-price">${subtotalFormatted}</div>
                            </div>
                        </div>
                    </div>
                    `;
                });

                body.innerHTML = html;

                const totalFormatted = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(total);
                document.getElementById('miniCartTotal').textContent = totalFormatted;
                document.getElementById('miniCartFinalTotal').textContent = totalFormatted;
            })
            .catch(err => {
                console.error(err);
                body.innerHTML = '<p class="text-center text-danger">Có lỗi khi tải giỏ hàng.</p>';
            });
    }

    // Helper to remove item
    window.removeCartItem = function (id) {
        if (!confirm('Bạn có chắc muốn xóa sản phẩm này?')) return;
        window.location.href = getContextPath() + '/cart/remove?id=' + id;
    };

    // Helper to get Context Path
    function getContextPath() {
        return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
    }

    // 2.2 AJAX Add to Cart Logic
    const addToCartButtons = document.querySelectorAll('.btn-add-cart');
    addToCartButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            const url = this.getAttribute('href') + '&ajax=true';
            fetch(url, {
                method: 'GET',
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        // Use our dynamically identified badge
                        if (cartBadge) {
                            cartBadge.innerText = data.totalItems;
                        }
                        const toastElement = document.getElementById('cartToast');
                        const toastBody = document.getElementById('toastMessage');
                        if (toastBody && toastElement) {
                            toastBody.textContent = data.message;
                            if (typeof bootstrap !== 'undefined') {
                                const toast = new bootstrap.Toast(toastElement);
                                toast.show();
                            }
                        }
                    } else {
                        alert(data.message || 'Có lỗi xảy ra');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi kết nối đến server');
                });
        });
    });

    // 2.3 Apply Voucher Logic
    window.applyVoucher = function () {
        const codeInput = document.getElementById('voucherCode');
        const code = codeInput ? codeInput.value : '';
        const messageDiv = document.getElementById('voucher-message');

        if (!messageDiv) return;

        // Reset message
        messageDiv.className = 'form-text mt-1';
        messageDiv.innerText = '';

        if (!code || code.trim() === '') {
            messageDiv.innerText = 'Vui lòng nhập mã giảm giá';
            messageDiv.className = 'form-text mt-1 text-danger';
            return;
        }

        fetch(getContextPath() + '/cart/apply-voucher', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'code=' + encodeURIComponent(code)
        })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    messageDiv.innerText = data.message;
                    messageDiv.className = 'form-text mt-1 text-success';

                    // Update Discount Row
                    const discountRow = document.getElementById('discount-row');
                    const discountAmountSpan = document.getElementById('discount-amount');
                    const finalTotalSpan = document.getElementById('final-total');

                    if (discountRow) discountRow.style.display = 'flex';

                    const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }); // default has symbol
                    // Custom format used in JSP is manual "xxxxx đ". JS Intl gives "xxxxx ₫" or "xxxxx đ" depending on locale.
                    // To match strictly JSP fmt:formatNumber, we might want just number. But currency format is fine.
                    // Let's match the JSP style "number đ"

                    const formatCurrency = (val) => {
                        return new Intl.NumberFormat('vi-VN').format(val) + ' đ';
                    };

                    if (discountAmountSpan) {
                        discountAmountSpan.innerText = '- ' + formatCurrency(data.discountAmount);
                    }

                    if (finalTotalSpan) {
                        finalTotalSpan.innerText = formatCurrency(data.finalTotal);
                    }

                } else {
                    messageDiv.innerText = data.message;
                    messageDiv.className = 'form-text mt-1 text-danger';
                }
            })
            .catch(err => {
                console.error(err);
                messageDiv.innerText = 'Có lỗi xảy ra khi áp dụng mã.';
                messageDiv.className = 'form-text mt-1 text-danger';
            });
    };
});
