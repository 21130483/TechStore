<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TechStore Admin - Quản lý bài viết</title>
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
                                <h4 class="card-title">Quản lý bài viết</h4>
                                <a href="<c:url value='/admin/blogs/add'/>" class="btn btn-primary btn-round ml-auto">
                                    <i class="fa fa-plus"></i> Thêm bài viết
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
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Tiêu đề</th>
                                            <th>Tác giả</th>
                                            <th>Ngày đăng</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${blogs}" var="blog">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:if test="${not empty blog.imageUrl}">
                                                            <img src="${blog.imageUrl}" alt="${blog.title}" style="max-width: 50px; max-height: 50px; margin-right: 10px;">
                                                        </c:if>
                                                        <div>
                                                            <h6 class="mb-0">${blog.title}</h6>
                                                            <small class="text-muted">${blog.summary}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${blog.author}</td>
                                                <td><fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td>
                                                    <span class="badge badge-${blog.status == 'PUBLISHED' ? 'success' : 'warning'}">
                                                        ${blog.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="<c:url value='/admin/blogs/view/${blog.id}'/>" class="btn btn-info btn-sm">
                                                            <i class="fa fa-eye"></i>
                                                        </a>
                                                        <a href="<c:url value='/admin/blogs/edit/${blog.id}'/>" class="btn btn-warning btn-sm">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <form action="<c:url value='/admin/blogs/toggle/${blog.id}'/>" method="POST" class="d-inline">
                                                            <button type="submit" class="btn btn-${blog.status == 'PUBLISHED' ? 'secondary' : 'success'} btn-sm">
                                                                <i class="fa fa-${blog.status == 'PUBLISHED' ? 'ban' : 'check'}"></i>
                                                            </button>
                                                        </form>
                                                        <form action="<c:url value='/admin/blogs/delete/${blog.id}'/>" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
                                                            <button type="submit" class="btn btn-danger btn-sm">
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