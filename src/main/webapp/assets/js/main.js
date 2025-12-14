document.addEventListener('DOMContentLoaded', function () {
    // 1. Inject Toast HTML if not present
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

        // Append to body
        document.body.insertAdjacentHTML('beforeend', toastHTML);
    }

    // 2. Add smooth scrolling (Legacy content from footer script if any, but preserving new logic)
    // Note: The original index.jsp had this in a script tag in footer. With this file, we can centralize it.

    // 3. AJAX Add to Cart Logic
    const addToCartButtons = document.querySelectorAll('.btn-add-cart');

    addToCartButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();

            const url = this.getAttribute('href') + '&ajax=true';

            fetch(url, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        // Update cart count
                        const cartCountElement = document.getElementById('cartCount');
                        if (cartCountElement) {
                            cartCountElement.innerText = data.totalItems; // Use innerText for safety
                        }

                        // Show toast
                        const toastElement = document.getElementById('cartToast');
                        const toastBody = document.getElementById('toastMessage');
                        if (toastBody && toastElement) {
                            toastBody.textContent = data.message;
                            // Use Bootstrap's Toast API
                            // Ensure Bootstrap is loaded. If not, this might fail, but index.jsp loads it.
                            if (typeof bootstrap !== 'undefined') {
                                const toast = new bootstrap.Toast(toastElement);
                                toast.show();
                            } else {
                                console.error("Bootstrap 5 not found!");
                                alert(data.message);
                            }
                        }
                    } else {
                        // Handle error
                        alert(data.message || 'Có lỗi xảy ra');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi kết nối đến server');
                });
        });
    });
});
