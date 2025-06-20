<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Quản lý sản phẩm</title>
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
                                <h4 class="card-title">Quản lý sản phẩm</h4>
                                <a href="<c:url value='/admin/products/add'/>" class="btn btn-primary btn-round ml-auto">
                                    <i class="fa fa-plus"></i>
                                    Thêm sản phẩm
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty success}">
                                <div class="alert alert-success">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <i class="fa fa-check"></i> ${success}
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <i class="fa fa-exclamation-circle"></i> ${error}
                                </div>
                            </c:if>
                            <div class="table-responsive">
                                <table id="basic-datatables" class="display table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Ảnh</th>
                                            <th>Tên</th>
                                            <th>Danh mục</th>
                                            <th>Giá</th>
                                            <th>Giảm giá</th>
                                            <th>Số lượng</th>
                                            <th>Đã bán</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${products}" var="product">
                                            <tr>
                                                <td>${product.productID}</td>
                                                <td>
                                                    <c:if test="${not empty product.imageUrl}">
                                                        <img src="<c:url value='${product.imageUrl}'/>" alt="${product.name}" style="width: 50px; height: 50px; object-fit: cover;"/>
                                                    </c:if>
                                                    <img src="/assets/techstore/img/product/${product.productID}/0.webp" alt="" style="width: 50px; height: 50px; object-fit: cover;"/>
                                                </td>
                                                <td>${product.name}</td>
                                                <td>${product.category.name}</td>
                                                <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/></td>
                                                <td><fmt:formatNumber value="${product.sale}" type="currency" currencySymbol="₫"/></td>
                                                <td>${product.quantity}</td>
                                                <td>${product.orderedNumbers}</td>
                                                <td>
                                                    <div class="form-button-action">
                                                        <a href="<c:url value='/admin/products/edit/${product.productID}'/>" class="btn btn-link btn-primary btn-lg">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <a href="#" onclick="confirmDelete(${product.productID})" class="btn btn-link btn-danger">
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
            $('#basic-datatables').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json"
                }
            });
        });

        function confirmDelete(productId) {
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
                    window.location.href = "<c:url value='/admin/products/delete/'/>" + productId;
                }
            });
        }
    </script>
</body>

</html> 