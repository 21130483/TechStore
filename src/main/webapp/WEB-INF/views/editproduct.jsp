<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <i class="fa fa-exclamation-circle"></i> ${error}
                                </div>
                            </c:if>
                            <form:form action="/admin/products/edit/${product.productID}" method="post" modelAttribute="product" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="name">Tên sản phẩm <span class="text-danger">*</span></label>
                                            <form:input path="name" class="form-control" required="required"/>
                                            <form:errors path="name" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="category">Danh mục <span class="text-danger">*</span></label>
                                            <form:select path="category.categoryID" class="form-control" required="required">
                                                <form:option value="">-- Chọn danh mục --</form:option>
                                                <c:forEach items="${categories}" var="category">
                                                    <form:option value="${category.categoryID}">${category.name}</form:option>
                                                </c:forEach>
                                            </form:select>
                                            <form:errors path="category" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="price">Giá <span class="text-danger">*</span></label>
                                            <form:input path="price" type="number" class="form-control" required="required" min="0"/>
                                            <form:errors path="price" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="sale">Giảm giá</label>
                                            <form:input path="sale" type="number" class="form-control" min="0"/>
                                            <form:errors path="sale" class="text-danger"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="quantity">Số lượng <span class="text-danger">*</span></label>
                                            <form:input path="quantity" type="number" class="form-control" required="required" min="0"/>
                                            <form:errors path="quantity" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="trademark">Thương hiệu <span class="text-danger">*</span></label>
                                            <form:input path="trademark" class="form-control" required="required"/>
                                            <form:errors path="trademark" class="text-danger"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="imageFile">Hình ảnh</label>
                                            <input type="file" name="imageFile" class="form-control" accept="image/*"/>
                                            <small class="form-text text-muted">Để trống nếu không muốn thay đổi hình ảnh</small>
                                            <c:if test="${not empty product.imageUrl}">
                                                <img src="<c:url value='${product.imageUrl}'/>" alt="${product.name}" style="max-width: 100px; margin-top: 10px;"/>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="content">Mô tả <span class="text-danger">*</span></label>
                                    <form:textarea path="content" class="form-control" rows="5" required="required"/>
                                    <form:errors path="content" class="text-danger"/>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-save"></i> Cập nhật
                                    </button>
                                    <a href="/admin/products" class="btn btn-secondary">
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
</body>

</html> 