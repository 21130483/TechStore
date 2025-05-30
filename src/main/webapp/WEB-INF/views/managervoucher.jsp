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
                                <h4 class="card-title">Quản lý voucher</h4>
                                <a href="<c:url value='/admin/vouchers/add'/>" class="btn btn-primary btn-round ml-auto">
                                    <i class="fa fa-plus"></i>
                                    Thêm voucher
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="basic-datatables" class="display table table-striped table-hover">
                                    <thead>
                                        <tr>
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
                                                <td>${voucher.code}</td>
                                                <td>${voucher.name}</td>
                                                <td>${voucher.type}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${voucher.type == 'PERCENTAGE'}">
                                                            ${voucher.value}%
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${voucher.value}" type="currency" currencySymbol="$"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${voucher.quantity}</td>
                                                <td><fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td><fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td>
                                                    <span class="badge badge-${voucher.active ? 'success' : 'danger'}">
                                                        ${voucher.active ? 'Active' : 'Inactive'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="form-button-action">
                                                        <a href="<c:url value='/admin/vouchers/edit/${voucher.id}'/>" class="btn btn-link btn-primary btn-lg">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <a href="#" onclick="toggleStatus(${voucher.id})" class="btn btn-link btn-warning btn-lg">
                                                            <i class="fa fa-toggle-on"></i>
                                                        </a>
                                                        <a href="#" onclick="confirmDelete(${voucher.id})" class="btn btn-link btn-danger">
                                                            <i class="fa fa-times"></i>
                                                        </a>
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
    <script src="<c:url value='/assets/js/plugin/datatables/datatables.min.js'/>"></script>
    <script src="<c:url value='/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js'/>"></script>
    <script src="<c:url value='/assets/js/plugin/sweetalert/sweetalert.min.js'/>"></script>
    <script src="<c:url value='/assets/js/kaiadmin.min.js'/>"></script>

    <script>
        $(document).ready(function() {
            $('#basic-datatables').DataTable();
        });

        function toggleStatus(voucherId) {
            swal({
                title: 'Bạn có chắc chắn muốn thay đổi trạng thái?',
                type: 'warning',
                buttons:{
                    confirm: {
                        text : 'Đồng ý',
                        className : 'btn btn-success'
                    },
                    cancel: {
                        visible: true,
                        className: 'btn btn-danger'
                    }
                }
            }).then((Toggle) => {
                if (Toggle) {
                    window.location.href = "<c:url value='/admin/vouchers/toggle/'/>" + voucherId;
                }
            });
        }

        function confirmDelete(voucherId) {
            swal({
                title: 'Bạn có chắc chắn muốn xóa?',
                text: "Bạn sẽ không thể khôi phục lại dữ liệu này!",
                type: 'warning',
                buttons:{
                    confirm: {
                        text : 'Xóa',
                        className : 'btn btn-success'
                    },
                    cancel: {
                        visible: true,
                        className: 'btn btn-danger'
                    }
                }
            }).then((Delete) => {
                if (Delete) {
                    window.location.href = "<c:url value='/admin/vouchers/delete/'/>" + voucherId;
                }
            });
        }
    </script>
</body>

</html> 