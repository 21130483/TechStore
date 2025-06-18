<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <link type="text/css" rel="stylesheet" href="/assets/techstore/css/profile.css"/>

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
                <!-- ASIDE -->
                <div id="aside" class="col-md-3">
                    <ul class="list-unstyled profile-menu">
                        <li onclick="showContent(this,'info')">
                            <i class="fa fa-user"></i> Thông tin cá nhân
                        </li>
                        <li onclick="showContent(this,'orders')">
                            <i class="fa fa-shopping-cart"></i> Đơn hàng đã đặt
                        </li>
                        <li onclick="showContent(this,'favorites')">

                            <i class="fa fa-heart"></i> Sản phẩm yêu thích
                        </li>
                        <li onclick="showContent(this,'password')">
                            <i class="fa fa-lock"></i> Đổi mật khẩu
                        </li>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <li onclick="linkToAdmin()">
                                <i class="fa fa-lock"></i> Quản lý trang web
                            </li>
                        </c:if>

                        <li class="menu" onclick="linkLogout()">
                            <i class="fa fa-sign-out" ></i> Đăng xuất
                        </li>
                    </ul>
                </div>
                <!-- /ASIDE -->
                <!-- Main content -->
                <div class="col-md-9 profile-content">
                    <div id="info" class="active">
                        <h3>Thông tin cá nhân</h3>
                        <p><strong>Họ tên:</strong> ${user.fullName}</p>
                        <p><strong>Email:</strong> ${user.email}</p>
<%--                        <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>--%>
                    </div>
                    <div id="orders">
                        <h3>Đơn hàng đã đặt</h3>
                        <c:forEach var="purchase" items="${purchases}">
                            <!-- product -->
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="/assets/techstore/img/product/${purchase.product.productID}/0.webp" alt="">
                                        <div class="product-label">
                                            <span class="sale">Số lượng : ${purchase.quantity}</span>
                                            <span class="new">
                                                <c:choose>
                                                    <c:when test="${purchase.status == 0}">Chờ xác nhận</c:when>
                                                    <c:when test="${purchase.status == 1}">Đã xác nhận</c:when>
                                                    <c:when test="${purchase.status == 2}">Đang giao</c:when>
                                                    <c:when test="${purchase.status == 3}">Đã giao</c:when>
                                                    <c:when test="${purchase.status == 4}">Đã hủy</c:when>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="product-body">
                                        <p class="product-category">${purchase.product.category.name}</p>
                                        <h3 class="product-name"><a  href="/product?id=${purchase.product.productID}">${purchase.product.name}</a></h3>
                                        <h4 class="product-price">
                                            <fmt:formatNumber value="${purchase.price}" type="number" groupingUsed="true"/> Đồng
                                                <%--                                            <del class="product-old-price">$990.00</del>--%>
                                        </h4>
<%--                                        <div class="product-rating">--%>
<%--                                            <i class="fa fa-star"></i>--%>
<%--                                            <i class="fa fa-star"></i>--%>
<%--                                            <i class="fa fa-star"></i>--%>
<%--                                            <i class="fa fa-star"></i>--%>
<%--                                            <i class="fa fa-star"></i>--%>
<%--                                        </div>--%>
                                        <div class="product-btns">
<%--                                            <button class="add-to-wishlist" data-product-id="${purchase.product.productID}"><i class="fa fa-heart-o"></i><span--%>
<%--                                                    class="tooltipp">add to wishlist</span></button>--%>
<%--                                            <button class="add-to-compare"><i class="fa fa-exchange"></i><span--%>
<%--                                                    class="tooltipp">add to compare</span></button>--%>
<%--                                            <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span>--%>
<%--                                            </button>--%>
                                        </div>
                                    </div>
<%--                                    <div class="add-to-cart">--%>
<%--                                        <button class="add-to-cart-btn" data-product-id="${purchase.product.productID}">--%>
<%--                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng--%>
<%--                                        </button>--%>
<%--                                    </div>--%>
                                </div>
                            </div>
                            <!-- /product -->
                        </c:forEach>

                    </div>
                    <div id="favorites">
                        <h3>Sản phẩm yêu thích</h3>
                        <c:forEach var="wish" items="${wishes}">
                            <!-- product -->
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="/assets/techstore/img/product/${wish.product.productID}/0.webp" alt="">
<%--                                        <div class="product-label">--%>
<%--                                            <span class="sale">-30%</span>--%>
<%--                                            <span class="new">NEW</span>--%>
<%--                                        </div>--%>
                                    </div>
                                    <div class="product-body">
                                        <p class="product-category">${wish.product.category.name}</p>
                                        <h3 class="product-name"><a href="/product?id=${wish.product.productID}">${wish.product.name}</a></h3>
                                        <h4 class="product-price">
                                            <fmt:formatNumber value="${wish.product.price}" type="number" groupingUsed="true"/> Đồng
<%--                                            <del class="product-old-price">$990.00</del>--%>
                                        </h4>
                                        <div class="product-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                        <div class="product-btns">
                                            <button class="add-to-wishlist" data-product-id="${wish.product.productID}"><i class="fa fa-heart-o"></i><span
                                                    class="tooltipp">add to wishlist</span></button>
                                            <button class="add-to-compare"><i class="fa fa-exchange"></i><span
                                                    class="tooltipp">add to compare</span></button>
                                            <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="add-to-cart">
                                        <button class="add-to-cart-btn" data-product-id="${wish.product.productID}">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!-- /product -->
                        </c:forEach>

                    </div>
                    <div id="password">
                        <h3>Đổi mật khẩu</h3>
                        <form action="/change_password" method="post">
                            <div class="form-group">
                                <label>Mật khẩu hiện tại</label>
                                <input type="password" class="form-control" name="currentPassword">
                            </div>
                            <div class="form-group">
                                <label>Mật khẩu mới</label>
                                <input type="password" class="form-control" name="newPassword">
                            </div>
                            <div class="form-group">
                                <label>Nhập lại mật khẩu mới</label>
                                <input type="password" class="form-control" name="confirmPassword">
                            </div>
                            <button class="btn btn-primary" type="submit">Xác nhận</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->

    <!-- FOOTER -->
    <footer>
        <!-- Bạn có thể dùng lại phần footer từ index.html nếu muốn -->
    </footer>


    <jsp:include page="common/footer.jsp"/>


    <!-- jQuery Plugins -->
        <script src="/assets/techstore/js/jquery.min.js"></script>
        <script src="/assets/techstore/js/bootstrap.min.js"></script>
        <script src="/assets/techstore/js/slick.min.js"></script>
        <script src="/assets/techstore/js/nouislider.min.js"></script>
        <script src="/assets/techstore/js/jquery.zoom.min.js"></script>
        <script src="/assets/techstore/js/main.js"></script>
        <script src="/assets/techstore/js/addcart.js"></script>

    <!-- Script chuyển đổi nội dung -->
    <script>
        function showContent(element, id) {
            console.log('showContent gọi với id:', id);
            const menus = document.querySelectorAll('.profile-menu > li');
            menus.forEach(menu => {
                menu.classList.remove('active');
            });

            const selectmenu = element;
            selectmenu.classList.add('active');

            const sections = document.querySelectorAll('.profile-content > div');
            sections.forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(id).classList.add('active');
        }

        function linkToAdmin() {
            window.location.href = '/admin';
        }

        function linkLogout() {
            window.location.href = '/logout';
        }



    </script>

</body>
</html>
