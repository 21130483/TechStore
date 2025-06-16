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

    <title>TechStore - Store</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/bootstrap.min.css'/>"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/slick.css'/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/slick-theme.css'/>"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/nouislider.min.css'/>"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="<c:url value='/static/css/font-awesome.min.css'/>">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>

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

        <!-- BREADCRUMB -->
        <div id="breadcrumb" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <ul class="breadcrumb-tree">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">All Categories</a></li>
                            <li><a href="#">Accessories</a></li>
                            <li class="active">Headphones (227,490 Results)</li>
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
                    <!-- ASIDE -->
                    <div id="aside" class="col-md-3">
                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Categories</h3>
                            <div class="checkbox-filter">
                                <c:forEach var="category" items="${categories}">
                                    <div class="input-checkbox">
                                        <input type="checkbox" id="category-${category.id}" name="category" value="${category.id}">
                                        <label for="category-${category.id}">
                                            <span></span>
                                            ${category.name}
                                            <small>(${category.productCount})</small>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Price</h3>
                            <div class="price-filter">
                                <div id="price-slider"></div>
                                <div class="input-number price-min">
                                    <input id="price-min" type="number">
                                    <span class="qty-up">+</span>
                                    <span class="qty-down">-</span>
                                </div>
                                <span>-</span>
                                <div class="input-number price-max">
                                    <input id="price-max" type="number">
                                    <span class="qty-up">+</span>
                                    <span class="qty-down">-</span>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Brand</h3>
                            <div class="checkbox-filter">
                                <c:forEach var="brand" items="${brands}">
                                    <div class="input-checkbox">
                                        <input type="checkbox" id="brand-${brand.id}" name="brand" value="${brand.id}">
                                        <label for="brand-${brand.id}">
                                            <span></span>
                                            ${brand.name}
                                            <small>(${brand.productCount})</small>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Top selling</h3>
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="${pageContext.request.contextPath}/img/product01.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>

                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="${pageContext.request.contextPath}/img/product02.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>

                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="${pageContext.request.contextPath}/img/product03.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->
                    </div>
                    <!-- /ASIDE -->

                    <!-- STORE -->
                    <div id="store" class="col-md-9">
                        <!-- store top filter -->
                        <div class="store-filter clearfix">
                            <div class="store-sort">
                                <label>
                                    Sort By:
                                    <select class="input-select">
                                        <option value="0">Popular</option>
                                        <option value="1">Position</option>
                                    </select>
                                </label>

                                <label>
                                    Show:
                                    <select class="input-select">
                                        <option value="0">20</option>
                                        <option value="1">50</option>
                                    </select>
                                </label>
                            </div>
                            <ul class="store-grid">
                                <li class="active"><i class="fa fa-th"></i></li>
                                <li><a href="#"><i class="fa fa-th-list"></i></a></li>
                            </ul>
                        </div>
                        <!-- /store top filter -->

                        <!-- store products -->
                        <div class="row">
                            <!-- product -->
                            <c:forEach var="product" items="${products}">
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="<c:url value='/static/img/product/${product.productID}/0.webp'/>" alt="">
                                            <div class="product-label">
                                                <span class="sale">-30%</span>
                                                <span class="new">NEW</span>
                                            </div>
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${product.category.name}</p>
                                            <h3 class="product-name"><a href="/product?id=${product.productID}">${product.name}</a></h3>
                                            <h4 class="product-price">${product.price}
                                                <del class="product-old-price">${product.price}</del>
                                            </h4>
                                            <div class="product-rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <div class="product-btns">
                                                <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <!-- /product -->
                        </div>
                        <!-- /store products -->

                        <!-- store bottom filter -->
                        <div class="store-filter clearfix">
                            <span class="store-qty">Showing ${products.size()} products</span>
                            <ul class="store-pagination">
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="${currentPage == i ? 'active' : ''}">
                                        <a href="/store?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <!-- /store bottom filter -->
                    </div>
                    <!-- /STORE -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

    <jsp:include page="common/footer.jsp" />

    <!-- jQuery Plugins -->
    <script type="text/javascript" src="<c:url value='/static/js/jquery.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/js/bootstrap.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/js/slick.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/js/nouislider.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/js/jquery.zoom.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/static/js/main.js'/>"></script>

</body>
</html>
