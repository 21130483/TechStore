<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Chỉnh sửa sản phẩm</title>
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
                                <h4 class="card-title">Chỉnh sửa sản phẩm</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:if test="${param.error != null}">
                                <div class="alert alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <i class="fa fa-exclamation-circle"></i> Có lỗi xảy ra khi cập nhật sản phẩm. Vui lòng thử lại.
                                </div>
                            </c:if>
                            <form action="<c:url value='/admin/products/edit/${product.id}'/>" method="POST" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="code">Mã sản phẩm</label>
                                            <input type="text" class="form-control" id="code" name="code" value="${product.code}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="name">Tên sản phẩm</label>
                                            <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="category">Danh mục</label>
                                            <select class="form-control" id="category" name="category" required>
                                                <option value="">Chọn danh mục</option>
                                                <option value="LAPTOP" ${product.category == 'LAPTOP' ? 'selected' : ''}>Laptop</option>
                                                <option value="PHONE" ${product.category == 'PHONE' ? 'selected' : ''}>Điện thoại</option>
                                                <option value="TABLET" ${product.category == 'TABLET' ? 'selected' : ''}>Máy tính bảng</option>
                                                <option value="ACCESSORY" ${product.category == 'ACCESSORY' ? 'selected' : ''}>Phụ kiện</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="price">Giá</label>
                                            <input type="number" class="form-control" id="price" name="price" value="${product.price}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="quantity">Số lượng</label>
                                            <input type="number" class="form-control" id="quantity" name="quantity" value="${product.quantity}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="image">Hình ảnh</label>
                                            <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                            <small class="form-text text-muted">Để trống nếu không muốn thay đổi hình ảnh</small>
                                            <c:if test="${not empty product.imageUrl}">
                                                <img src="<c:url value='${product.imageUrl}'/>" alt="${product.name}" style="max-width: 100px; margin-top: 10px;">
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="description">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="4">${product.description}</textarea>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                    <a href="<c:url value='/admin/products'/>" class="btn btn-secondary">Hủy</a>
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
    <script src="<c:url value='/assets/js/kaiadmin.min.js'/>"></script>
</body>

</html> 