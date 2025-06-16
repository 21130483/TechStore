<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar" data-background-color="dark">
    <div class="sidebar-logo">
        <!-- Logo Header -->
        <div class="logo-header" data-background-color="dark">
            <a href="<c:url value='/admin'/>" class="logo">
                <img src="<c:url value='/assets/img/logo_light.svg'/>" alt="navbar brand" class="navbar-brand" height="20" />
            </a>
            <div class="nav-toggle">
                <button class="btn btn-toggle toggle-sidebar">
                    <i class="gg-menu-right"></i>
                </button>
                <button class="btn btn-toggle sidenav-toggler">
                    <i class="gg-menu-left"></i>
                </button>
            </div>
            <button class="topbar-toggler more">
                <i class="gg-more-vertical-alt"></i>
            </button>
        </div>
    </div>
    <div class="sidebar-wrapper scrollbar scrollbar-inner">
        <div class="sidebar-content">
            <ul class="nav nav-secondary">
                <!-- Dashboard -->
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/admin.jsp' ? 'active' : ''}">
                    <a href="<c:url value='/admin'/>">
                        <i class="fas fa-home"></i>
                        <p>Trang chủ</p>
                    </a>
                </li>

                <!-- Product Management -->
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/managerproduct.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#products">
                        <i class="fas fa-box"></i>
                        <p>Sản phẩm</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/managerproduct.jsp' ? 'show' : ''}" id="products">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/managerproduct.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/products'/>">
                                    <span class="sub-item">Danh sách</span>
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/admin/products/add'/>">
                                    <span class="sub-item">Thêm sản phẩm</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- Order Management -->
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/managerorder.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#orders">
                        <i class="fas fa-shopping-cart"></i>
                        <p>Đơn hàng</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/managerorder.jsp' ? 'show' : ''}" id="orders">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/managerorder.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/orders'/>">
                                    <span class="sub-item">Danh sách đơn hàng</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- User Management -->
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/manageruser.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#users">
                        <i class="fas fa-users"></i>
                        <p>Thành viên</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/manageruser.jsp' ? 'show' : ''}" id="users">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/manageruser.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/users'/>">
                                    <span class="sub-item">Danh sách</span>
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/admin/users/add'/>">
                                    <span class="sub-item">Thêm thành viên</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- Blog Management -->
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/bloguser.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#blogs">
                        <i class="fas fa-blog"></i>
                        <p>Blog</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/bloguser.jsp' ? 'show' : ''}" id="blogs">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/bloguser.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/blogs'/>">
                                    <span class="sub-item">Danh sách</span>
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/admin/blogs/add'/>">
                                    <span class="sub-item">Thêm bài viết</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- Voucher Management -->
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/managervoucher.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#vouchers">
                        <i class="fas fa-ticket-alt"></i>
                        <p>Voucher</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/managervoucher.jsp' ? 'show' : ''}" id="vouchers">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/managervoucher.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/vouchers'/>">
                                    <span class="sub-item">Danh sách</span>
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/admin/vouchers/add'/>">
                                    <span class="sub-item">Thêm voucher</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- Back to Website -->
                <li class="nav-item">
                    <a href="<c:url value='/'/>">
                        <i class="fas fa-globe"></i>
                        <p>Trang web</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div> 