<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Quick View Modal -->
<div class="modal fade" id="quickViewModal" tabindex="-1" aria-labelledby="quickViewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="quickViewModalLabel">
                    <i class="bi bi-eye me-2"></i>Xem Nhanh Sản Phẩm
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <div class="container-fluid">
                    <div class="row g-0">
                        <!-- Product Images -->
                        <div class="col-lg-6">
                            <div class="product-gallery">
                                <div class="main-image mb-3">
                                    <img src="https://picsum.photos/600/700?random=1" 
                                         alt="Product" 
                                         class="img-fluid rounded" 
                                         id="quickViewMainImage">
                                </div>
                                <div class="thumbnail-images">
                                    <div class="row g-2">
                                        <div class="col-3">
                                            <img src="https://picsum.photos/150/150?random=1" 
                                                 class="img-fluid rounded thumbnail-img active" 
                                                 onclick="changeQuickViewImage(this.src)">
                                        </div>
                                        <div class="col-3">
                                            <img src="https://picsum.photos/150/150?random=2" 
                                                 class="img-fluid rounded thumbnail-img" 
                                                 onclick="changeQuickViewImage(this.src)">
                                        </div>
                                        <div class="col-3">
                                            <img src="https://picsum.photos/150/150?random=3" 
                                                 class="img-fluid rounded thumbnail-img" 
                                                 onclick="changeQuickViewImage(this.src)">
                                        </div>
                                        <div class="col-3">
                                            <img src="https://picsum.photos/150/150?random=4" 
                                                 class="img-fluid rounded thumbnail-img" 
                                                 onclick="changeQuickViewImage(this.src)">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Product Details -->
                        <div class="col-lg-6">
                            <div class="product-details p-4">
                                <!-- Product Badge -->
                                <div class="product-badges mb-3">
                                    <span class="badge bg-danger me-2">
                                        <i class="bi bi-fire me-1"></i>Hot
                                    </span>
                                    <span class="badge bg-success">
                                        <i class="bi bi-star me-1"></i>Mới
                                    </span>
                                </div>
                                
                                <!-- Product Info -->
                                <span class="product-category text-muted d-block mb-2">Áo Thun Nam</span>
                                <h4 class="product-title mb-3" id="quickViewTitle">Áo Thun Premium Cotton Cao Cấp</h4>
                                
                                <!-- Rating -->
                                <div class="product-rating mb-3">
                                    <div class="d-flex align-items-center">
                                        <div class="stars me-2">
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star text-warning"></i>
                                        </div>
                                        <span class="rating-text">4.0</span>
                                        <span class="rating-count text-muted ms-2">(24 đánh giá)</span>
                                    </div>
                                </div>
                                
                                <!-- Price -->
                                <div class="product-price mb-4">
                                    <span class="h3 text-gold mb-0" id="quickViewPrice">299.000 đ</span>
                                    <span class="text-muted text-decoration-line-through ms-2 h5">399.000 đ</span>
                                    <span class="badge bg-danger ms-2">-25%</span>
                                </div>
                                
                                <!-- Description -->
                                <div class="product-description mb-4">
                                    <p class="text-muted" id="quickViewDescription">
                                        Áo thun cao cấp được làm từ 100% cotton tự nhiên, mang lại cảm giác thoải mái và thoáng mát. 
                                        Thiết kế hiện đại, phù hợp cho nhiều dịp khác nhau.
                                    </p>
                                </div>
                                
                                <!-- Product Options -->
                                <div class="product-options mb-4">
                                    <!-- Size Selection -->
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Kích thước:</label>
                                        <div class="size-options">
                                            <input type="radio" class="btn-check" name="quickViewSize" id="qv-size-s" autocomplete="off">
                                            <label class="btn btn-outline-secondary" for="qv-size-s">S</label>
                                            
                                            <input type="radio" class="btn-check" name="quickViewSize" id="qv-size-m" autocomplete="off" checked>
                                            <label class="btn btn-outline-secondary" for="qv-size-m">M</label>
                                            
                                            <input type="radio" class="btn-check" name="quickViewSize" id="qv-size-l" autocomplete="off">
                                            <label class="btn btn-outline-secondary" for="qv-size-l">L</label>
                                            
                                            <input type="radio" class="btn-check" name="quickViewSize" id="qv-size-xl" autocomplete="off">
                                            <label class="btn btn-outline-secondary" for="qv-size-xl">XL</label>
                                        </div>
                                        <small class="text-muted">
                                            <i class="bi bi-info-circle me-1"></i>
                                            <a href="#" class="text-decoration-none">Hướng dẫn chọn size</a>
                                        </small>
                                    </div>
                                    
                                    <!-- Color Selection -->
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Màu sắc:</label>
                                        <div class="color-options">
                                            <input type="radio" class="btn-check" name="quickViewColor" id="qv-color-black" autocomplete="off" checked>
                                            <label class="btn color-option" for="qv-color-black" style="background: #000;" title="Đen"></label>
                                            
                                            <input type="radio" class="btn-check" name="quickViewColor" id="qv-color-white" autocomplete="off">
                                            <label class="btn color-option" for="qv-color-white" style="background: #fff; border: 1px solid #ddd;" title="Trắng"></label>
                                            
                                            <input type="radio" class="btn-check" name="quickViewColor" id="qv-color-blue" autocomplete="off">
                                            <label class="btn color-option" for="qv-color-blue" style="background: #007bff;" title="Xanh"></label>
                                            
                                            <input type="radio" class="btn-check" name="quickViewColor" id="qv-color-red" autocomplete="off">
                                            <label class="btn color-option" for="qv-color-red" style="background: #dc3545;" title="Đỏ"></label>
                                        </div>
                                    </div>
                                    
                                    <!-- Quantity -->
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Số lượng:</label>
                                        <div class="quantity-selector">
                                            <div class="input-group" style="width: 140px;">
                                                <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(-1)">
                                                    <i class="bi bi-dash"></i>
                                                </button>
                                                <input type="number" class="form-control text-center" value="1" min="1" max="99" id="quickViewQuantity">
                                                <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(1)">
                                                    <i class="bi bi-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <small class="text-success">
                                            <i class="bi bi-check-circle me-1"></i>Còn 15 sản phẩm trong kho
                                        </small>
                                    </div>
                                </div>
                                
                                <!-- Action Buttons -->
                                <div class="product-actions">
                                    <div class="d-flex gap-2 mb-3">
                                        <button class="btn btn-gold flex-fill btn-lg" onclick="addToCartFromQuickView()">
                                            <i class="bi bi-cart-plus me-2"></i>Thêm Vào Giỏ
                                        </button>
                                        <button class="btn btn-outline-secondary btn-lg" onclick="toggleWishlistFromQuickView()">
                                            <i class="bi bi-heart"></i>
                                        </button>
                                    </div>
                                    <button class="btn btn-outline-gold w-100" onclick="viewProductDetail()">
                                        <i class="bi bi-eye me-2"></i>Xem Chi Tiết Đầy Đủ
                                    </button>
                                </div>
                                
                                <!-- Product Features -->
                                <div class="product-features mt-4">
                                    <div class="row g-3">
                                        <div class="col-6">
                                            <div class="feature-item d-flex align-items-center">
                                                <i class="bi bi-truck text-success me-2"></i>
                                                <small>Miễn phí vận chuyển</small>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="feature-item d-flex align-items-center">
                                                <i class="bi bi-arrow-counterclockwise text-info me-2"></i>
                                                <small>Đổi trả 30 ngày</small>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="feature-item d-flex align-items-center">
                                                <i class="bi bi-shield-check text-warning me-2"></i>
                                                <small>Bảo hành chính hãng</small>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="feature-item d-flex align-items-center">
                                                <i class="bi bi-headset text-primary me-2"></i>
                                                <small>Hỗ trợ 24/7</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Quick View Modal Functions
function changeQuickViewImage(src) {
    document.getElementById('quickViewMainImage').src = src;
    
    // Update active thumbnail
    document.querySelectorAll('.thumbnail-img').forEach(img => {
        img.classList.remove('active');
    });
    event.target.classList.add('active');
}

function changeQuantity(delta) {
    const quantityInput = document.getElementById('quickViewQuantity');
    let currentValue = parseInt(quantityInput.value);
    let newValue = currentValue + delta;
    
    if (newValue >= 1 && newValue <= 99) {
        quantityInput.value = newValue;
    }
}

function addToCartFromQuickView() {
    const quantity = document.getElementById('quickViewQuantity').value;
    const size = document.querySelector('input[name="quickViewSize"]:checked')?.nextElementSibling?.textContent;
    const color = document.querySelector('input[name="quickViewColor"]:checked')?.getAttribute('title');
    
    // Add loading state
    const btn = event.target;
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="bi bi-arrow-repeat spin me-2"></i>Đang thêm...';
    btn.disabled = true;
    
    setTimeout(() => {
        btn.innerHTML = originalText;
        btn.disabled = false;
        
        showToast(`Đã thêm ${quantity} sản phẩm (${size}, ${color}) vào giỏ hàng!`, 'success');
        
        // Close modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('quickViewModal'));
        modal.hide();
        
        // Update cart count
        updateCartCount();
    }, 1500);
}

function toggleWishlistFromQuickView() {
    const btn = event.target;
    const icon = btn.querySelector('i');
    
    if (icon.classList.contains('bi-heart')) {
        icon.classList.remove('bi-heart');
        icon.classList.add('bi-heart-fill');
        btn.classList.remove('btn-outline-secondary');
        btn.classList.add('btn-danger');
        showToast('Đã thêm vào danh sách yêu thích', 'info');
    } else {
        icon.classList.remove('bi-heart-fill');
        icon.classList.add('bi-heart');
        btn.classList.remove('btn-danger');
        btn.classList.add('btn-outline-secondary');
        showToast('Đã xóa khỏi danh sách yêu thích', 'info');
    }
}

function viewProductDetail() {
    // This would navigate to the full product detail page
    showToast('Chuyển đến trang chi tiết sản phẩm...', 'info');
    
    setTimeout(() => {
        // window.location.href = '/product-detail';
    }, 1000);
}

// Add spin animation for loading
const style = document.createElement('style');
style.textContent = `
    .spin {
        animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
    
    .thumbnail-img {
        cursor: pointer;
        border: 2px solid transparent;
        transition: all 0.3s ease;
    }
    
    .thumbnail-img:hover,
    .thumbnail-img.active {
        border-color: var(--gold);
        transform: scale(1.05);
    }
`;
document.head.appendChild(style);
</script>