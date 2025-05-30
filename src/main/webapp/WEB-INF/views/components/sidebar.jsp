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
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/admin.jsp' ? 'active' : ''}">
                    <a href="<c:url value='/admin'/>">
                        <i class="fas fa-home"></i>
                        <p>Trang chủ</p>
                    </a>
                </li>
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/managerproduct.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#base">
                        <i class="fas fa-layer-group"></i>
                        <p>Sản phẩm</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/managerproduct.jsp' ? 'show' : ''}" id="base">
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
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/manageruser.jsp' || pageContext.request.servletPath == '/WEB-INF/views/bloguser.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#sidebarLayouts">
                        <i class="fa-solid fa-user"></i>
                        <p>Thành viên</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/manageruser.jsp' || pageContext.request.servletPath == '/WEB-INF/views/bloguser.jsp' ? 'show' : ''}" id="sidebarLayouts">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/manageruser.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/users'/>">
                                    <span class="sub-item">Danh sách</span>
                                </a>
                            </li>
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/bloguser.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/users/blogs'/>">
                                    <span class="sub-item">Blog</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item ${pageContext.request.servletPath == '/WEB-INF/views/managervoucher.jsp' ? 'active' : ''}">
                    <a data-bs-toggle="collapse" href="#forms">
                        <i class="fa-solid fa-ticket"></i>
                        <p>Voucher</p>
                        <span class="caret"></span>
                    </a>
                    <div class="collapse ${pageContext.request.servletPath == '/WEB-INF/views/managervoucher.jsp' ? 'show' : ''}" id="forms">
                        <ul class="nav nav-collapse">
                            <li class="${pageContext.request.servletPath == '/WEB-INF/views/managervoucher.jsp' ? 'active' : ''}">
                                <a href="<c:url value='/admin/vouchers'/>">
                                    <span class="sub-item">Danh sách</span>
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value='/admin/vouchers/add'/>">
                                    <span class="sub-item">Thêm Voucher</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a href="<c:url value='/'/>">
                        <i class="fa-solid fa-pager"></i>
                        <p>Trang web</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div> 