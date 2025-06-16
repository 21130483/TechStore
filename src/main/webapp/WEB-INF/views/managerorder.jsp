<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Quản lý đơn hàng</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="<c:url value='/assets/img/favicon.ico'/>" type="image/x-icon" />

    <!-- Fonts and icons -->
    <script src="<c:url value='/assets/js/plugin/webfont/webfont.min.js'/>"></script>
    <script>
        WebFont.load({
            google: { families: ["Public Sans:300,400,500,600,700"] },
            custom: {
                families: [
                    "Font Awesome 5 Solid",
                    "Font Awesome 5 Regular",
                    "Font Awesome 5 Brands",
                    "simple-line-icons",
                ],
                urls: ["<c:url value='/assets/css/fonts.min.css'/>"],
            },
            active: function () {
                sessionStorage.fonts = true;
            },
        });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/plugins.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/kaiadmin.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/demo.css'/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>

<body>
    <div class="wrapper">
        <!-- Include Sidebar -->
        <jsp:include page="components/sidebar.jsp" />

        <div class="main-panel">
            <!-- Include Navbar -->
            <jsp:include page="components/navbar.jsp" />

            <div class="container">
                <div class="page-inner">
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex align-items-center">
                                <h4 class="card-title">Quản lý đơn hàng</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${success}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>

                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn hàng</th>
                                            <th>Khách hàng</th>
                                            <th>Sản phẩm</th>
                                            <th>Số lượng</th>
                                            <th>Tổng tiền</th>
                                            <th>Ngày đặt</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${purchases}" var="purchase">
                                            <tr>
                                                <td>#${purchase.purchaseID}</td>
                                                <td>
                                                    <div>
                                                        <strong>${purchase.user.fullName}</strong><br>
                                                        <small class="text-muted">${purchase.user.email}</small>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:if test="${not empty purchase.product.imageUrl}">
                                                            <img src="${purchase.product.imageUrl}" alt="${purchase.product.name}" style="max-width: 50px; max-height: 50px; margin-right: 10px;">
                                                        </c:if>
                                                        <div>
                                                            <h6 class="mb-0">${purchase.product.name}</h6>
                                                            <small class="text-muted">${purchase.product.code}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${purchase.quantity}</td>
                                                <td><fmt:formatNumber value="${purchase.totalPrice}" type="currency" currencySymbol="₫"/></td>
                                                <td><fmt:formatDate value="${purchase.purchaseDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td>
                                                    <c:set var="statusText" value=""/>
                                                    <c:set var="badgeClass" value="info"/>
                                                    <c:choose>
                                                        <c:when test="${purchase.status == 0}">
                                                            <c:set var="statusText" value="PENDING"/>
                                                            <c:set var="badgeClass" value="info"/>
                                                        </c:when>
                                                        <c:when test="${purchase.status == 1}">
                                                            <c:set var="statusText" value="PROCESSING"/>
                                                            <c:set var="badgeClass" value="warning"/>
                                                        </c:when>
                                                        <c:when test="${purchase.status == 2}">
                                                            <c:set var="statusText" value="SHIPPED"/>
                                                            <c:set var="badgeClass" value="primary"/>
                                                        </c:when>
                                                        <c:when test="${purchase.status == 3}">
                                                            <c:set var="statusText" value="DELIVERED"/>
                                                            <c:set var="badgeClass" value="success"/>
                                                        </c:when>
                                                        <c:when test="${purchase.status == 4}">
                                                            <c:set var="statusText" value="CANCELLED"/>
                                                            <c:set var="badgeClass" value="danger"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="statusText" value="UNKNOWN"/>
                                                            <c:set var="badgeClass" value="secondary"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="badge badge-${badgeClass}">
                                                        ${statusText}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="<c:url value='/admin/orders/view/${purchase.purchaseID}'/>" class="btn btn-info btn-sm">
                                                            <i class="fa fa-eye"></i>
                                                        </a>
                                                        <form action="<c:url value='/admin/orders/delete/${purchase.purchaseID}'/>" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa đơn hàng này?');">
                                                            <button type="submit" class="btn btn-danger btn-sm">
                                                                <i class="fa fa-trash"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Include Footer -->
            <jsp:include page="components/footer.jsp" />
        </div>
    </div>

    <!-- Core JS Files -->
    <script src="<c:url value='/assets/js/core/jquery-3.7.1.min.js'/>"></script>
    <script src="<c:url value='/assets/js/core/popper.min.js'/>"></script>
    <script src="<c:url value='/assets/js/core/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js'/>"></script>
    <script src="<c:url value='/assets/js/kaiadmin.min.js'/>"></script>
</body>

</html> 