<%@ page import="org.example.techstore.model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML>
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
    <jsp:include page="common/header.jsp"/>

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="/assets/techstore/img/shop01.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3><spring:message code='nav.laptops'/></h3>
                        <a href="/search?category=1" class="cta-btn"><spring:message code='home.shopNow'/> <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="/assets/techstore/img/product07.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3><spring:message code='nav.phones'/></h3>
                        <a href="/search?category=2" class="cta-btn"><spring:message code='home.shopNow'/> <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="/assets/techstore/img/shop03.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3><spring:message code='nav.headphones'/></h3>
                        <a href="/search?category=5" class="cta-btn"><spring:message code='home.shopNow'/> <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <!-- section title -->
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title"><spring:message code='home.newProducts'/></h3>
                </div>
            </div>
            <!-- /section title -->

            <!-- Products tab & slick -->
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab1" class="tab-pane active">
                            <div class="products-slick" data-nav="#slick-nav-1">
                                <c:forEach var="product" items="${newproducts}">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category"><spring:message code='category.${product.category.categoryID}' text='${product.category.name}'/></p>
                                            <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                            <div class="product-rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="product-btns">
                                                <button class="add-to-wishlist" data-product-id="${product.productID}">
                                                    <i class="fa fa-heart-o"></i>
                                                    <span class="tooltipp"><spring:message code='product.addToWishlist'/></span>
                                                </button>
                                                <button class="add-to-compare">
                                                    <i class="fa fa-exchange"></i>
                                                    <span class="tooltipp"><spring:message code='product.addToCompare'/></span>
                                                </button>
                                                <button class="quick-view">
                                                    <i class="fa fa-eye"></i>
                                                    <span class="tooltipp"><spring:message code='product.quickView'/></span>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn" data-product-id="${product.productID}">
                                                <i class="fa fa-shopping-cart"></i> <spring:message code='product.addToCart'/>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div id="slick-nav-1" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- /Products tab & slick -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- HOT DEAL SECTION -->
<div id="hot-deal" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <div class="hot-deal">
                    <h2 class="text-uppercase"><spring:message code='home.hotDeal'/></h2>
                    <p><spring:message code='home.hotDealDesc'/></p>
                </div>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /HOT DEAL SECTION -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <!-- section title -->
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title"><spring:message code='home.topSelling'/></h3>
                </div>
            </div>
            <!-- /section title -->

            <!-- Products tab & slick -->
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab2" class="tab-pane fade in active">
                            <div class="products-slick" data-nav="#slick-nav-2">
                                <c:forEach var="product" items="${topsellproducts}">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category"><spring:message code='category.${product.category.categoryID}' text='${product.category.name}'/></p>
                                            <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                            <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> <spring:message code='product.currency'/></h4>
                                            <div class="product-rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="product-btns">
                                                <button class="add-to-wishlist" data-product-id="${product.productID}">
                                                    <i class="fa fa-heart-o"></i>
                                                    <span class="tooltipp"><spring:message code='product.addToWishlist'/></span>
                                                </button>
                                                <button class="add-to-compare">
                                                    <i class="fa fa-exchange"></i>
                                                    <span class="tooltipp"><spring:message code='product.addToCompare'/></span>
                                                </button>
                                                <button class="quick-view">
                                                    <i class="fa fa-eye"></i>
                                                    <span class="tooltipp"><spring:message code='product.quickView'/></span>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn" data-product-id="${product.productID}">
                                                <i class="fa fa-shopping-cart"></i> <spring:message code='product.addToCart'/>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div id="slick-nav-2" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- /Products tab & slick -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-4 col-xs-6">
                <div class="section-title">
                    <h4 class="title">Điện thoại</h4>
                    <div class="section-nav">
                        <div id="slick-nav-3" class="products-slick-nav"></div>
                    </div>
                </div>

                <div class="products-widget-slick" data-nav="#slick-nav-3">
                    <div>
                        <c:forEach var="product" items="${phones1}">
                            <!-- product widget -->
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                </div>
                            </div>
                            <!-- /product widget -->
                        </c:forEach>
                    </div>
                    <div>
                        <c:forEach var="product" items="${phones2}">
                            <!-- product widget -->
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                </div>
                            </div>
                            <!-- /product widget -->
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-xs-6">
                <div class="section-title">
                    <h4 class="title">Laptop</h4>
                    <div class="section-nav">
                        <div id="slick-nav-4" class="products-slick-nav"></div>
                    </div>
                </div>

                <div class="products-widget-slick" data-nav="#slick-nav-4">
                    <div>
                        <c:forEach var="product" items="${laptops1}">
                            <!-- product widget -->
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                </div>
                            </div>
                            <!-- /product widget -->
                        </c:forEach>
                    </div>
                    <div>
                        <c:forEach var="product" items="${laptops2}">
                            <!-- product widget -->
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                </div>
                            </div>
                            <!-- /product widget -->
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="clearfix visible-sm visible-xs"></div>

            <div class="col-md-4 col-xs-6">
                <div class="section-title">
                    <h4 class="title">Máy tính bảng</h4>
                    <div class="section-nav">
                        <div id="slick-nav-5" class="products-slick-nav"></div>
                    </div>
                </div>

                <div class="products-widget-slick" data-nav="#slick-nav-5">
                    <div>
                        <c:forEach var="product" items="${tabs1}">
                            <!-- product widget -->
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                </div>
                            </div>
                            <!-- /product widget -->
                        </c:forEach>
                    </div>
                    <div>
                        <c:forEach var="product" items="${tabs2}">
                            <!-- product widget -->
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="">
                                </div>
                                <div class="product-body">
                                    <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                    <h4 class="product-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> Đồng</h4>
                                </div>
                            </div>
                            <!-- /product widget -->
                        </c:forEach>
                    </div>
                </div>
            </div>

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
<script src="/assets/techstore/js/addcart.js"></script>


</body>
</html>
