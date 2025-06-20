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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
<!-- HEADER -->
<header>
    <jsp:include page="common/header.jsp" />

<%--        <!-- BREADCRUMB -->--%>
<%--        <div id="breadcrumb" class="section">--%>
<%--            <!-- container -->--%>
<%--            <div class="container">--%>
<%--                <!-- row -->--%>
<%--                <div class="row">--%>
<%--                    <div class="col-md-12">--%>
<%--                        <h3 class="breadcrumb-header">Gior</h3>--%>
<%--                        <ul class="breadcrumb-tree">--%>
<%--                            <li><a href="#">Home</a></li>--%>
<%--                            <li class="active">Cart</li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <!-- /row -->--%>
<%--            </div>--%>
<%--            <!-- /container -->--%>
<%--        </div>--%>
<%--        <!-- /BREADCRUMB -->--%>
    <!-- SECTION -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">

                <div class="col-md-8">
                    <div class="">
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
                                            <button onclick="window.location.href='/addcart?productId=${cart.product.productID}'"><i class="fa-solid fa-plus"></i></button>
                                            <span class="qty">Số lượng<br>${cart.quantity}</span>
                                            <button onclick="window.location.href='/minuscart?productId=${cart.product.productID}'"><i class="fa-solid fa-minus"></i></button>
                                        </div>

                                        <h4 class="product-price">Giá<br><fmt:formatNumber value="${cart.product.price}" type="number" groupingUsed="true"/> Đồng</h4>

                                        <div>
                                            <button class="delete" onclick="window.location.href='/removeCart?productId=${cart.product.productID}'"><img src="/assets/techstore/img/cart/bin.png"></button>
                                        </div>
                                    </div>

                                </div>
                            </c:forEach>
                        </div>

                    </div>
                </div>


                <!-- Order Details -->
                <div class="col-md-4 order-details">
                    <div class="section-title text-center">
                        <h3 class="title">Hóa đơn của bạn</h3>
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
<%--                    <div class="payment-method">--%>
<%--                        <div class="input-radio">--%>
<%--                            <input type="radio" name="payment" id="payment-1">--%>
<%--                            <label for="payment-1">--%>
<%--                                <span></span>--%>
<%--                                Chuyển khoản--%>
<%--                            </label>--%>
<%--                            <div class="caption">--%>
<%--                                <p>Thanh toán qua ngân hàng.</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="input-radio">--%>
<%--                            <input type="radio" name="payment" id="payment-2">--%>
<%--                            <label for="payment-2">--%>
<%--                                <span></span>--%>
<%--                                Thanh toán khi nhận hàng--%>
<%--                            </label>--%>
<%--                            <div class="caption">--%>
<%--                                <p>Khi sản phẩm đến tay bạn. Vui lòng thanh toán trước khi nhận hàng.</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="input-radio">--%>
<%--                            <input type="radio" name="payment" id="payment-3">--%>
<%--                            <label for="payment-3">--%>
<%--                                <span></span>--%>
<%--                                Paypal System--%>
<%--                            </label>--%>
<%--                            <div class="caption">--%>
<%--                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor--%>
<%--                                    incididunt ut labore et dolore magna aliqua.</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="input-checkbox">--%>
<%--                        <input type="checkbox" id="terms">--%>
<%--                        <label for="terms">--%>
<%--                            <span></span>--%>
<%--                            Tôi đã đọc và chấp nhận <a href="#">điều khoản và điều kiện</a>--%>
<%--                        </label>--%>
<%--                    </div>--%>
                    <a href="/checkout" class="primary-btn order-submit">Thanh toán</a>
                </div>
                <!-- /Order Details -->
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->

    <jsp:include page="common/footer.jsp" />

<!-- jQuery Plugins -->
        <script src="/assets/techstore/js/jquery.min.js"></script>
        <script src="/assets/techstore/js/bootstrap.min.js"></script>
        <script src="/assets/techstore/js/slick.min.js"></script>
        <script src="/assets/techstore/js/nouislider.min.js"></script>
        <script src="/assets/techstore/js/jquery.zoom.min.js"></script>
        <script src="/assets/techstore/js/main.js"></script>


</body>
</html>