<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Electro - HTML Ecommerce Template</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="/assets/techstore/css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="/assets/techstore/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="/assets/techstore/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="/assets/techstore/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="/assets/techstore/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="/assets/techstore/css/style.css"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<!-- HEADER -->
<header>
    <jsp:include page="common/header.jsp" />
    <form action="checkout" method="POST">

        <!-- BREADCRUMB -->
        <div id="breadcrumb" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="breadcrumb-header">Checkout</h3>
                        <ul class="breadcrumb-tree">
                            <li><a href="#">Home</a></li>
                            <li class="active">Checkout</li>
                        </ul>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /BREADCRUMB -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <div class="col-md-8">
                        <div class="section-title">
                            <h3 class="title">Giỏ hàng</h3>
                        </div>
                        <div class="cart-list">
                            <c:forEach var="cart" items="${carts}">

                                <div class="product-widget">
                                    <div class="product-img">
                                        <img src="/assets/techstore/img/product/${cart.product.productID}/0.webp" alt="">
                                    </div>
                                    <div class="product-body">
                                        <h3 class="product-name"><a
                                                href="/product?id=${cart.product.productID}">${cart.product.name}</a></h3>
                                        <div class="quantity">
<%--                                            <button onclick="window.location.href='/addcart?productId=${cart.product.productID}'"><i class="fa-solid fa-plus"></i></button>--%>
                                            <span class="qty">Số lượng<br>${cart.quantity}</span>
<%--                                            <button onclick="window.location.href='/minuscart?productId=${cart.product.productID}'"><i class="fa-solid fa-minus"></i></button>--%>
                                        </div>

                                        <h4 class="product-price">Giá<br><fmt:formatNumber value="${cart.product.price}" type="number" groupingUsed="true"/> Đồng</h4>

                                        <div>
<%--                                            <button class="delete" onclick="window.location.href='/removeCart?productId=${cart.product.productID}'"><img src="/assets/techstore/img/cart/bin.png"></button>--%>
                                        </div>
                                    </div>

                                </div>
                            </c:forEach>
                        </div>
                        <!-- Billing Details -->
                        <div class="billing-details">
                            <div class="section-title">
                                <h3 class="title">Địa chỉ nhận hàng</h3>
                            </div>
                            <div class="form-group">
                                <label>Thành phố:</label>
                                <select name="city" id="city" class="input" required="required">
                                    <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Quận:</label>
                                <select name="district" id="district" class="input" required="required">
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Phường:</label>
                                <select name="ward" id="ward" class="input" required="required">
                                    <option value="" selected>Chọn phường xã</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Địa chỉ chi tiết:</label>
                                <input class="input" type="tel" name="addressdetail">
                            </div>
                        </div>
                    </div>

                    <!-- Order Details -->
                    <div class="col-md-4 order-details">
                        <div class="section-title text-center">
                            <h3 class="title">Your Order</h3>
                        </div>
                        <div class="order-summary">
                            <div class="order-col">
                                <div><strong>Sản phẩm</strong></div>
                                <div><strong>Tổng</strong></div>
                            </div>
                            <div class="order-products">
                                <c:forEach var="cart" items="${carts}">
                                    <div class="order-col">
                                        <div>${cart.quantity}x ${cart.product.name}</div>
                                        <div>
                                            <fmt:formatNumber value="${cart.product.price * cart.quantity}" type="number" groupingUsed="true"/> Đồng
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="order-col">
                                <div><strong>Phí ship</strong></div>
                                <div>
                                    <strong>
                                        <fmt:formatNumber value="${25000}" type="number" groupingUsed="true"/> Đồng
                                    </strong>
                                </div>
                            </div>
                            <div class="order-col">
                                <div><strong>Tổng cộng</strong></div>
                                <div>
                                    <strong class="order-total">
                                        <fmt:formatNumber value="${total +25000}" type="number" groupingUsed="true"/> Đồng
                                    </strong>
                                </div>
                            </div>
                        </div>
                        <div class="payment-method">
                            <div class="input-radio">
                                <input type="radio" name="payment" id="payment-1" required="required">
                                <label for="payment-1">
                                    <span></span>
                                    Chuyển khoản
                                </label>
                                <div class="caption">
                                    <p>Thanh toán qua ngân hàng.</p>
                                </div>
                            </div>
                            <div class="input-radio">
                                <input type="radio" name="payment" id="payment-2" required="required">
                                <label for="payment-2">
                                    <span></span>
                                    Thanh toán khi nhận hàng
                                </label>
                                <div class="caption">
                                    <p>Khi sản phẩm đến tay bạn. Vui lòng thanh toán trước khi nhận hàng.</p>
                                </div>
                            </div>
                        </div>
                        <div class="input-checkbox">
                            <input type="checkbox" id="terms" required>
                            <label for="terms">
                                <span></span>
                                Tôi đã đọc và chấp nhận <a href="#">điều khoản và điều kiện</a>
                            </label>
                        </div>
                        <button class="primary-btn order-submit" type="submit">Đặt hàng</button>
                    </div>
                    <!-- /Order Details -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

    </form>
    <jsp:include page="common/footer.jsp" />

    <!-- jQuery Plugins -->
        <script src="/assets/techstore/js/jquery.min.js"></script>
        <script src="/assets/techstore/js/bootstrap.min.js"></script>
        <script src="/assets/techstore/js/slick.min.js"></script>
        <script src="/assets/techstore/js/nouislider.min.js"></script>
        <script src="/assets/techstore/js/jquery.zoom.min.js"></script>
        <script src="/assets/techstore/js/main.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
            var citis = document.getElementById("city");
            var districts = document.getElementById("district");
            var wards = document.getElementById("ward");
            var Parameter = {
                url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                method: "GET",
                responseType: "application/json",
            };
            var promise = axios(Parameter);
            promise.then(function (result) {
                renderCity(result.data);
            });

            function renderCity(data) {
                for (const x of data) {
                    var opt = document.createElement('option');
                    opt.value = x.Name;
                    opt.text = x.Name;
                    opt.setAttribute('data-id', x.Id);
                    citis.options.add(opt);
                }
                citis.onchange = function () {
                    district.length = 1;
                    ward.length = 1;
                    if(this.options[this.selectedIndex].dataset.id != ""){
                        const result = data.filter(n => n.Id === this.options[this.selectedIndex].dataset.id);

                        for (const k of result[0].Districts) {
                            var opt = document.createElement('option');
                            opt.value = k.Name;
                            opt.text = k.Name;
                            opt.setAttribute('data-id', k.Id);
                            district.options.add(opt);
                        }
                    }
                };
                district.onchange = function () {
                    ward.length = 1;
                    const dataCity = data.filter((n) => n.Id === citis.options[citis.selectedIndex].dataset.id);
                    if (this.options[this.selectedIndex].dataset.id != "") {
                        const dataWards = dataCity[0].Districts.filter(n => n.Id === this.options[this.selectedIndex].dataset.id)[0].Wards;

                        for (const w of dataWards) {
                            var opt = document.createElement('option');
                            opt.value = w.Name;
                            opt.text = w.Name;
                            opt.setAttribute('data-id', w.Id);
                            wards.options.add(opt);
                        }
                    }
                };
            }
        </script>

</body>
</html>