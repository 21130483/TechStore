<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Chỉnh sửa người dùng</title>
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
                                <h4 class="card-title">Chỉnh sửa người dùng</h4>
                                <a href="<c:url value='/admin/users'/>" class="btn btn-secondary btn-round ml-auto">
                                    <i class="fa fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>

                            <form action="<c:url value='/admin/users/edit/${user.email}'/>" method="POST" id="editUserForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="fullName">Họ và tên <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required
                                                   pattern="[A-Za-zÀ-ỹ\s]+" title="Chỉ chấp nhận chữ cái và dấu cách">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" id="email" value="${user.email}" readonly>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="username">Tên đăng nhập</label>
                                            <input type="text" class="form-control" id="username" value="${user.username}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="password">Mật khẩu mới (để trống nếu không muốn thay đổi)</label>
                                            <input type="password" class="form-control" id="password" name="password"
                                                   minlength="6" title="Mật khẩu phải có ít nhất 6 ký tự">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="phoneNumbers">Số điện thoại <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="phoneNumbers" name="phoneNumbers" value="${user.phoneNumbers}" required
                                                   pattern="[0-9]{10}" title="Số điện thoại phải có 10 chữ số">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="dob">Ngày sinh <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="dob" name="dob" value="<fmt:formatDate value='${user.dob}' pattern='yyyy-MM-dd'/>" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="gender">Giới tính <span class="text-danger">*</span></label>
                                            <select class="form-control" id="gender" name="gender" required>
                                                <option value="MALE" ${user.gender == 'MALE' ? 'selected' : ''}>Nam</option>
                                                <option value="FEMALE" ${user.gender == 'FEMALE' ? 'selected' : ''}>Nữ</option>
                                                <option value="OTHER" ${user.gender == 'OTHER' ? 'selected' : ''}>Khác</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="role">Vai trò <span class="text-danger">*</span></label>
                                            <select class="form-control" id="role" name="role" required>
                                                <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Người dùng</option>
                                                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="access">Trạng thái <span class="text-danger">*</span></label>
                                            <select class="form-control" id="access" name="access" required>
                                                <option value="ACTIVE" ${user.access == 'ACTIVE' ? 'selected' : ''}>Hoạt động</option>
                                                <option value="INACTIVE" ${user.access == 'INACTIVE' ? 'selected' : ''}>Không hoạt động</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Cập nhật thông tin</button>
                                    <button type="reset" class="btn btn-secondary">Đặt lại</button>
                                </div>
                            </form>
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
    <script src="<c:url value='/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js'/>"></script>
    <script src="<c:url value='/assets/js/plugin/sweetalert/sweetalert.min.js'/>"></script>
    <script src="<c:url value='/assets/js/kaiadmin.min.js'/>"></script>

    <script>
        $(document).ready(function() {
            // Set max date for date of birth (18 years ago)
            var today = new Date();
            var maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
            $('#dob').attr('max', maxDate.toISOString().split('T')[0]);

            // Form validation
            $('#editUserForm').on('submit', function(e) {
                if (!this.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                }
                $(this).addClass('was-validated');
            });
        });
    </script>
</body>

</html> 