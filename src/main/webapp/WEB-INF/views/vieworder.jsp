<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Chi tiết đơn hàng</title>
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
                                <h4 class="card-title">Chi tiết đơn hàng #${purchase.id.email}-${purchase.id.productID}</h4>
                                <a href="<c:url value='/admin/orders'/>" class="btn btn-secondary btn-round ml-auto">
                                    <i class="fa fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Thông tin khách hàng</h5>
                                    <table class="table">
                                        <tr>
                                            <th>Họ và tên:</th>
                                            <td>${purchase.user.fullName}</td>
                                        </tr>
                                        <tr>
                                            <th>Email:</th>
                                            <td>${purchase.user.email}</td>
                                        </tr>
                                        <tr>
                                            <th>Số điện thoại:</th>
                                            <td>${purchase.user.phoneNumbers}</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h5>Thông tin đơn hàng</h5>
                                    <table class="table">
                                        <tr>
                                            <th>Mã đơn hàng:</th>
                                            <td>#${purchase.id.email}-${purchase.id.productID}</td>
                                        </tr>
                                        <tr>
                                            <th>Ngày đặt:</th>
                                            <td><fmt:formatDate value="${purchase.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        </tr>
                                        <tr>
                                            <th>Trạng thái:</th>
                                            <td>
                                                <c:set var="statusText" value=""/>
                                                <c:set var="badgeClass" value="info"/>
                                                <c:choose>
                                                    <c:when test="${purchase.status == 0}">
                                                        <c:set var="statusText" value="Chờ xử lý"/>
                                                        <c:set var="badgeClass" value="info"/>
                                                    </c:when>
                                                    <c:when test="${purchase.status == 1}">
                                                        <c:set var="statusText" value="Đang xử lý"/>
                                                        <c:set var="badgeClass" value="warning"/>
                                                    </c:when>
                                                    <c:when test="${purchase.status == 2}">
                                                        <c:set var="statusText" value="Đang giao"/>
                                                        <c:set var="badgeClass" value="primary"/>
                                                    </c:when>
                                                    <c:when test="${purchase.status == 3}">
                                                        <c:set var="statusText" value="Đã giao"/>
                                                        <c:set var="badgeClass" value="success"/>
                                                    </c:when>
                                                    <c:when test="${purchase.status == 4}">
                                                        <c:set var="statusText" value="Đã hủy"/>
                                                        <c:set var="badgeClass" value="danger"/>
                                                    </c:when>
                                                </c:choose>
                                                <span class="badge badge-${badgeClass}">
                                                    ${statusText}
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <h5>Chi tiết sản phẩm</h5>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th>Giá</th>
                                                <th>Số lượng</th>
                                                <th>Tổng tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
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
                                                <td><fmt:formatNumber value="${purchase.product.price}" type="currency" currencySymbol="₫"/></td>
                                                <td>${purchase.quantity}</td>
                                                <td><fmt:formatNumber value="${purchase.price}" type="currency" currencySymbol="₫"/></td>
                                            </tr>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th colspan="3" class="text-right">Tổng cộng:</th>
                                                <th><fmt:formatNumber value="${purchase.price}" type="currency" currencySymbol="₫"/></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <h5>Địa chỉ giao hàng</h5>
                                    <p>${purchase.address}</p>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <form action="<c:url value='/admin/orders/update-status/${purchase.id.email}/${purchase.id.productID}'/>" method="POST" class="form-inline">
                                        <div class="form-group mr-3">
                                            <label for="status" class="mr-2">Cập nhật trạng thái:</label>
                                            <select name="status" id="status" class="form-control" onchange="this.form.submit()">
                                                <option value="0" ${purchase.status == 0 ? 'selected' : ''}>Chờ xử lý</option>
                                                <option value="1" ${purchase.status == 1 ? 'selected' : ''}>Đang xử lý</option>
                                                <option value="2" ${purchase.status == 2 ? 'selected' : ''}>Đang giao</option>
                                                <option value="3" ${purchase.status == 3 ? 'selected' : ''}>Đã giao</option>
                                                <option value="4" ${purchase.status == 4 ? 'selected' : ''}>Đã hủy</option>
                                            </select>
                                        </div>
                                    </form>
                                </div>
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