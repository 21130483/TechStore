<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Quản lý voucher</title>
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
                                <h4 class="card-title">Danh sách voucher</h4>
                                <a href="/admin/vouchers/add" class="btn btn-primary btn-round ml-auto">
                                    <i class="fa fa-plus"></i> Thêm voucher
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <i class="fa fa-exclamation-circle"></i> ${error}
                                </div>
                            </c:if>
                            <c:if test="${not empty success}">
                                <div class="alert alert-success">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <i class="fa fa-check-circle"></i> ${success}
                                </div>
                            </c:if>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Mã</th>
                                            <th>Tên</th>
                                            <th>Loại</th>
                                            <th>Giá trị</th>
                                            <th>Số lượng</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${vouchers}" var="voucher">
                                            <tr>
                                                <td>${voucher.voucherID}</td>
                                                <td>${voucher.code}</td>
                                                <td>${voucher.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${voucher.type == 'PERCENTAGE'}">
                                                            Phần trăm (%)
                                                        </c:when>
                                                        <c:when test="${voucher.type == 'FIXED_AMOUNT'}">
                                                            Số tiền cố định
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${voucher.value}</td>
                                                <td>${voucher.quantity}</td>
                                                <td>
                                                    <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${voucher.active}">
                                                            <span class="badge badge-success">Đang hoạt động</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-danger">Đã hết hạn</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="/admin/vouchers/edit/${voucher.voucherID}" class="btn btn-sm btn-info">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <form action="/admin/vouchers/delete/${voucher.voucherID}" method="post" style="display: inline;">
                                                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa voucher này?')">
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