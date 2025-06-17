<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Thêm người dùng</title>
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
    <style>
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .invalid-feedback {
            display: none;
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .was-validated .form-control:invalid ~ .invalid-feedback {
            display: block;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 0.5rem 2rem;
        }
        .btn-primary:hover {
            background-color: #0069d9;
            border-color: #0062cc;
        }
        .card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border: none;
            border-radius: 0.5rem;
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            padding: 1.25rem;
        }
        .card-body {
            padding: 2rem;
        }
        .alert {
            margin-bottom: 1.5rem;
        }
    </style>
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
                                <h4 class="card-title">Thêm người dùng mới</h4>
                                <a href="<c:url value='/admin/users'/>" class="btn btn-secondary btn-round ml-auto">
                                    <i class="fa fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle mr-2"></i>${error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/admin/adduser" method="post" class="needs-validation" novalidate>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="fullName"><i class="fas fa-user mr-2"></i>Họ và tên</label>
                                            <input type="text" class="form-control" id="fullName" name="fullName" required pattern="[A-Za-zÀ-ỹ\s]+">
                                            <div class="invalid-feedback">Vui lòng nhập họ và tên (chỉ chữ cái và dấu cách)</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email"><i class="fas fa-envelope mr-2"></i>Email</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="username"><i class="fas fa-user-tag mr-2"></i>Tên đăng nhập</label>
                                            <input type="text" class="form-control" id="username" name="username" required pattern="[A-Za-z0-9_]+">
                                            <div class="invalid-feedback">Vui lòng nhập tên đăng nhập (chữ cái, số và dấu gạch dưới)</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="password"><i class="fas fa-lock mr-2"></i>Mật khẩu</label>
                                            <input type="password" class="form-control" id="password" name="password" required minlength="6">
                                            <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="phoneNumbers"><i class="fas fa-phone mr-2"></i>Số điện thoại</label>
                                            <input type="tel" class="form-control" id="phoneNumbers" name="phoneNumbers" required pattern="[0-9]{10}">
                                            <div class="invalid-feedback">Vui lòng nhập số điện thoại 10 chữ số</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="dob"><i class="fas fa-calendar-alt mr-2"></i>Ngày sinh</label>
                                            <input type="date" class="form-control" id="dob" name="dob" required>
                                            <div class="invalid-feedback">Vui lòng chọn ngày sinh</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="gender"><i class="fas fa-venus-mars mr-2"></i>Giới tính</label>
                                            <select class="form-control" id="gender" name="gender" required>
                                                <option value="">Chọn giới tính</option>
                                                <option value="MALE">Nam</option>
                                                <option value="FEMALE">Nữ</option>
                                                <option value="OTHER">Khác</option>
                                            </select>
                                            <div class="invalid-feedback">Vui lòng chọn giới tính</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="role"><i class="fas fa-user-shield mr-2"></i>Vai trò</label>
                                            <select class="form-control" id="role" name="role" required>
                                                <option value="">Chọn vai trò</option>
                                                <option value="ADMIN">Admin</option>
                                                <option value="USER">User</option>
                                            </select>
                                            <div class="invalid-feedback">Vui lòng chọn vai trò</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="access"><i class="fas fa-toggle-on mr-2"></i>Trạng thái</label>
                                            <select class="form-control" id="access" name="access" required>
                                                <option value="">Chọn trạng thái</option>
                                                <option value="ACTIVE">Hoạt động</option>
                                                <option value="INACTIVE">Không hoạt động</option>
                                            </select>
                                            <div class="invalid-feedback">Vui lòng chọn trạng thái</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group text-center mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="fas fa-user-plus mr-2"></i>Thêm người dùng
                                    </button>
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
    // Set max date for date of birth (18 years ago)
    const dobInput = document.getElementById('dob');
    const today = new Date();
    const minDate = new Date(today.getFullYear() - 100, today.getMonth(), today.getDate());
    const maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
    dobInput.min = minDate.toISOString().split('T')[0];
    dobInput.max = maxDate.toISOString().split('T')[0];

    // Form validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    } else {
                        // Log form data before submission
                        const formData = new FormData(form);
                        console.log('Form data before submission:');
                        for (let pair of formData.entries()) {
                            console.log(pair[0] + ': ' + pair[1]);
                        }
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Show success message after form submission
    $(document).ready(function() {
        var successMessage = '${success}';
        if (successMessage) {
            $.notify({
                icon: 'fas fa-check-circle',
                message: successMessage
            }, {
                type: 'success',
                placement: {
                    from: 'top',
                    align: 'right'
                },
                delay: 3000
            });
        }

        // Show error message if exists
        var errorMessage = '${error}';
        if (errorMessage) {
            $.notify({
                icon: 'fas fa-exclamation-circle',
                message: errorMessage
            }, {
                type: 'danger',
                placement: {
                    from: 'top',
                    align: 'right'
                },
                delay: 5000
            });
        }
    });
    </script>
</body>

</html> 