<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Chỉnh sửa voucher</title>
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
                                <h4 class="card-title">Chỉnh sửa voucher</h4>
                                <a href="<c:url value='/admin/vouchers'/>" class="btn btn-secondary btn-round ml-auto">
                                    <i class="fa fa-arrow-left"></i> Quay lại
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
                            <form:form action="/admin/vouchers/edit/${voucher.voucherID}" method="post" modelAttribute="voucher" id="editVoucherForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="code">Mã voucher <span class="text-danger">*</span></label>
                                            <form:input path="code" class="form-control" readonly="true"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Tên voucher <span class="text-danger">*</span></label>
                                            <form:input path="name" class="form-control" required="required" 
                                                      minlength="3" maxlength="50"
                                                      title="Tên voucher phải từ 3 đến 50 ký tự"/>
                                            <form:errors path="name" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="type">Loại voucher <span class="text-danger">*</span></label>
                                            <form:select path="type" class="form-control" required="required">
                                                <form:option value="PERCENTAGE">Phần trăm (%)</form:option>
                                                <form:option value="FIXED_AMOUNT">Số tiền cố định</form:option>
                                            </form:select>
                                            <form:errors path="type" class="text-danger"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="value">Giá trị <span class="text-danger">*</span></label>
                                            <form:input path="value" type="number" class="form-control" required="required" 
                                                      min="0" step="0.01" id="valueInput"/>
                                            <form:errors path="value" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="quantity">Số lượng <span class="text-danger">*</span></label>
                                            <form:input path="quantity" type="number" class="form-control" required="required" 
                                                      min="1" max="1000"
                                                      title="Số lượng phải từ 1 đến 1000"/>
                                            <form:errors path="quantity" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="startDate">Ngày bắt đầu <span class="text-danger">*</span></label>
                                            <form:input path="startDate" type="datetime-local" class="form-control" required="required" 
                                                      id="startDate"/>
                                            <form:errors path="startDate" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="endDate">Ngày kết thúc <span class="text-danger">*</span></label>
                                            <form:input path="endDate" type="datetime-local" class="form-control" required="required" 
                                                      id="endDate"/>
                                            <form:errors path="endDate" class="text-danger"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-save"></i> Lưu thay đổi
                                    </button>
                                    <a href="/admin/vouchers" class="btn btn-secondary">
                                        <i class="fa fa-times"></i> Hủy
                                    </a>
                                </div>
                            </form:form>
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

    <!-- Custom validation script -->
    <script>
        $(document).ready(function() {
            // Set min date to current date
            var now = new Date();
            var year = now.getFullYear();
            var month = String(now.getMonth() + 1).padStart(2, '0');
            var day = String(now.getDate()).padStart(2, '0');
            var hours = String(now.getHours()).padStart(2, '0');
            var minutes = String(now.getMinutes()).padStart(2, '0');
            var minDateTime = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
            
            $('#startDate').attr('min', minDateTime);
            $('#endDate').attr('min', minDateTime);

            // Validate end date is after start date
            $('#startDate').change(function() {
                $('#endDate').attr('min', $(this).val());
            });

            // Validate value based on type
            $('select[name="type"]').change(function() {
                var type = $(this).val();
                var valueInput = $('#valueInput');
                
                if (type === 'PERCENTAGE') {
                    valueInput.attr('max', '100');
                    valueInput.attr('title', 'Giá trị phần trăm phải từ 0 đến 100');
                } else if (type === 'FIXED_AMOUNT') {
                    valueInput.removeAttr('max');
                    valueInput.attr('title', 'Giá trị tiền phải lớn hơn 0');
                }
            });

            // Form validation
            $('#editVoucherForm').submit(function(e) {
                var startDate = new Date($('#startDate').val());
                var endDate = new Date($('#endDate').val());
                
                if (endDate <= startDate) {
                    e.preventDefault();
                    alert('Ngày kết thúc phải sau ngày bắt đầu');
                    return false;
                }

                var type = $('select[name="type"]').val();
                var value = parseFloat($('#valueInput').val());
                
                if (type === 'PERCENTAGE' && (value <= 0 || value > 100)) {
                    e.preventDefault();
                    alert('Giá trị phần trăm phải từ 1 đến 100');
                    return false;
                }

                if (type === 'FIXED_AMOUNT' && value <= 0) {
                    e.preventDefault();
                    alert('Giá trị tiền phải lớn hơn 0');
                    return false;
                }

                return true;
            });
        });
    </script>
</body>

</html> 