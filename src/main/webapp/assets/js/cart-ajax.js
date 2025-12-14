document.addEventListener('DOMContentLoaded', function() {
    const addToCartButtons = document.querySelectorAll('.btn-add-cart');
    
    addToCartButtons.forEach(button => {
        button.addEventListener('click', function(e) {
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
                        cartCountElement.textContent = data.totalItems;
                    }
                    
                    // Show toast
                    const toastElement = document.getElementById('cartToast');
                    const toastBody = document.getElementById('toastMessage');
                    if (toastBody && toastElement) {
                        toastBody.textContent = data.message;
                        const toast = new bootstrap.Toast(toastElement);
                        toast.show();
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
