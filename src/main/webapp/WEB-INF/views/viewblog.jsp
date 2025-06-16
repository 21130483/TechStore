<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Chi tiết bài viết</title>
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
                                <h4 class="card-title">Chi tiết bài viết</h4>
                                <a href="<c:url value='/admin/blogs'/>" class="btn btn-secondary btn-round ml-auto">
                                    <i class="fa fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2 class="mb-4">${blog.title}</h2>
                                    <div class="d-flex align-items-center mb-4">
                                        <div class="mr-3">
                                            <i class="fa fa-user"></i> ${blog.author}
                                        </div>
                                        <div class="mr-3">
                                            <i class="fa fa-calendar"></i> <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </div>
                                        <div>
                                            <span class="badge badge-${blog.status == 'PUBLISHED' ? 'success' : 'warning'}">
                                                ${blog.status}
                                            </span>
                                        </div>
                                    </div>
                                    <c:if test="${not empty blog.imageUrl}">
                                        <img src="${blog.imageUrl}" alt="${blog.title}" class="img-fluid mb-4" style="max-height: 400px; width: auto;">
                                    </c:if>
                                    <div class="mb-4">
                                        <h5>Tóm tắt</h5>
                                        <p>${blog.summary}</p>
                                    </div>
                                    <div class="mb-4">
                                        <h5>Nội dung</h5>
                                        <div>${blog.content}</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="btn-group">
                                        <a href="<c:url value='/admin/blogs/edit/${blog.id}'/>" class="btn btn-warning">
                                            <i class="fa fa-edit"></i> Chỉnh sửa
                                        </a>
                                        <form action="<c:url value='/admin/blogs/toggle/${blog.id}'/>" method="POST" class="d-inline">
                                            <button type="submit" class="btn btn-${blog.status == 'PUBLISHED' ? 'secondary' : 'success'}">
                                                <i class="fa fa-${blog.status == 'PUBLISHED' ? 'ban' : 'check'}"></i> 
                                                ${blog.status == 'PUBLISHED' ? 'Ẩn bài viết' : 'Xuất bản'}
                                            </button>
                                        </form>
                                        <form action="<c:url value='/admin/blogs/delete/${blog.id}'/>" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fa fa-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </div>
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