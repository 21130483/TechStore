<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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

    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li><a href="#"><i class="fa fa-phone"></i> +021-95-51-84</a></li>
                <li><a href="#"><i class="fa fa-envelope-o"></i> email@email.com</a></li>
                <li><a href="#"><i class="fa fa-map-marker"></i> 1734 Stonecoal Road</a></li>
            </ul>
            <ul class="header-links pull-right">
                <!-- Language -->
                <div class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white">
                        <i class="fa fa-globe"></i>
                        <span>
                             <c:choose>
                                 <c:when test="${pageContext.response.locale == 'vi'}">Tiếng Việt</c:when>
                                 <c:otherwise>English</c:otherwise>
                             </c:choose>
                        </span>
                    </a>
                    <div class="dropdown-menu" style="padding: 10px;">
                        <a href="?lang=vi" class="dropdown-item">Tiếng Việt</a>
                        <a href="?lang=en" class="dropdown-item" style="margin-left: 10px">English</a>
                    </div>
                </div>
                <!-- /Language -->
            </ul>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="/" class="logo">
                            <img src="/assets/techstore/img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <form action="/search" method="get">
                            <input name="search" class="input" placeholder="<spring:message code='header.search'/>">
                            <button class="search-btn"><spring:message code='header.search'/></button>
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">


                        <!-- Cart -->
                        <div class="dropdown">
                            <a href="/cart" aria-expanded="true">
                                <i class="fa fa-shopping-cart"></i>
                                <span><spring:message code='header.cart'/></span>
                                <div class="qty" id="cartnumber">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.cartsize}">
                                            ${sessionScope.cartsize}
                                        </c:when>
                                        <c:otherwise>
                                            0
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </a>
                        </div>
                        <!-- /Cart -->

                        <!-- Profile -->
                        <div>
                            <a href="profile">
                                <i class="fa fa-user-o"></i>
                                <span>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            ${sessionScope.user.fullName}
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code='header.login'/>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                        </div>
                        <!-- /Profile -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->

<!-- NAVIGATION -->
<nav id="navigation">
    <!-- container -->
    <div class="container">
        <!-- responsive-nav -->
        <div id="responsive-nav">
            <!-- NAV -->
            <ul class="main-nav nav navbar-nav">
                <li><a href="/"><spring:message code='nav.home'/></a></li>
<%--                <li><a href="/store">Điện thoại</a></li>--%>
<%--                <li><a href="/store">Laptop</a></li>--%>
<%--                <li><a href="/store">PC</a></li>--%>
<%--                <li><a href="/store">Tai nghe</a></li>--%>
<%--                <li><a href="/store">Máy tính bảng</a></li>--%>
<%--                <li><a href="/store">Tivi</a></li>--%>
                <c:forEach var="category" items="${categories}">
                    <li><a href="/search?category=${category.categoryID}"><spring:message code='category.${category.categoryID}' text='${category.name}'/></a></li>
                </c:forEach>
            </ul>
            <!-- /NAV -->
        </div>
        <!-- /responsive-nav -->
    </div>
    <!-- /container -->
</nav>
<!-- /NAVIGATION -->

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