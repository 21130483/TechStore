document.querySelectorAll('.add-to-cart-btn').forEach(button => {
    button.addEventListener('click', function (e) {
        e.preventDefault(); // Ngăn form hoặc button load lại

        const productId = this.getAttribute('data-product-id');

        fetch('/addcart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ productId })
        })
            .then(response => response.json())
            .then(data => {
            if (data.success) {
                // Cập nhật số lượng trên giỏ hàng
                document.getElementById('cartnumber').innerText = data.cartSize;
            } else if (data.redirect) {
                // Chuyển hướng tới trang login
                window.location.href = data.redirect;
            }
        });


    });
});


