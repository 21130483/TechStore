<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Quản lý người dùng</title>
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
    <link rel="stylesheet" href="<c:url value='/css/managerproduct.css'/>" />
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
                                <h4 class="card-title">Quản lý người dùng</h4>
                                <a href="<c:url value='/admin/users/add'/>" class="btn btn-primary btn-round ml-auto">
                                    <i class="fa fa-plus"></i> Thêm người dùng
                                </a>
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
                                <table id="basic-datatables" class="display table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Email</th>
                                            <th>Tên</th>
                                            <th>Số điện thoại</th>
                                            <th>Ngày sinh</th>
                                            <th>Chức vụ</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${users}" var="user">
                                            <tr>
                                                <td>${user.email}</td>
                                                <td>${user.fullName}</td>
                                                <td>${user.phoneNumbers}</td>
                                                <td><fmt:formatDate value="${user.dob}" pattern="dd/MM/yyyy"/></td>
                                                <td>
                                                    <span class="badge ${user.role == 'ADMIN' ? 'badge-primary' : 'badge-info'}">
                                                        ${user.role}
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge ${user.access == 'ACTIVE' ? 'badge-success' : 'badge-danger'}">
                                                        ${user.access}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="form-button-action">
                                                        <a href="<c:url value='/admin/users/edit/${user.email}'/>" class="btn btn-link btn-primary btn-lg" data-toggle="tooltip" title="Chỉnh sửa">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-link btn-danger btn-lg" data-toggle="tooltip" title="Xóa" 
                                                                onclick="confirmDelete('${user.email}', '${user.fullName}')">
                                                            <i class="fa fa-times"></i>
                                                        </button>
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

        function confirmDelete(email, name) {
            swal({
                title: 'Bạn có chắc chắn?',
                text: "Bạn sẽ không thể khôi phục người dùng " + name + "!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Có, xóa nó!',
                cancelButtonText: 'Không, giữ lại',
                confirmButtonClass: "btn btn-success",
                cancelButtonClass: "btn btn-danger",
                buttonsStyling: false
            }).then(function() {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '<c:url value="/admin/users/delete/"/>' + email;
                document.body.appendChild(form);
                form.submit();
            }, function(dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                        'Đã hủy',
                        'Người dùng của bạn vẫn an toàn :)',
                        'error'
                    )
                }
            });
        }
    </script>
</body>

</html> 