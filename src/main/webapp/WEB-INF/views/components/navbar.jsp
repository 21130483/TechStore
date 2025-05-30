<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="main-header">
    <div class="container-fluid">
        <nav class="navbar navbar-header navbar-expand-lg">
            <div class="container-fluid">
                <div class="collapse" id="search-nav">
                    <form class="navbar-left navbar-form nav-search me-md-3">
                        <div class="input-group">
                            <input type="text" placeholder="Search ..." class="form-control">
                            <button type="submit" class="btn btn-search">
                                <i class="fa fa-search search-icon"></i>
                            </button>
                        </div>
                    </form>
                </div>
                <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
                    <li class="nav-item toggle-nav-search hidden-caret">
                        <a class="nav-link" data-toggle="collapse" href="#search-nav" role="button" aria-expanded="false" aria-controls="search-nav">
                            <i class="fa fa-search"></i>
                        </a>
                    </li>
                    
                    <li class="nav-item dropdown hidden-caret">
                        <a class="nav-link dropdown-toggle" href="#" id="notifDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-bell"></i>
                            <span class="notification">4</span>
                        </a>
                        <ul class="dropdown-menu notifications" aria-labelledby="notifDropdown">
                            <li>
                                <div class="notif-scroll scrollbar-outer">
                                    <div class="notif-center">
                                        <a href="#">
                                            <div class="notif-icon notif-primary"> <i class="fa fa-user-plus"></i> </div>
                                            <div class="notif-content">
                                                <span class="block">New user registered</span>
                                                <span class="time">5 minutes ago</span>
                                            </div>
                                        </a>
                                        <!-- Add more notifications here -->
                                    </div>
                                </div>
                            </li>
                            <li>
                                <a class="see-all" href="javascript:void(0);">See all notifications<i class="fa fa-angle-right"></i> </a>
                            </li>
                        </ul>
                    </li>
                    
                    <li class="nav-item dropdown hidden-caret">
                        <a class="dropdown-toggle profile-pic" data-bs-toggle="dropdown" href="#" aria-expanded="false">
                            <div class="avatar-sm">
                                <img src="<c:url value='/assets/img/profile.jpg'/>" alt="..." class="avatar-img rounded-circle">
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-user animated fadeIn">
                            <div class="dropdown-user-scroll scrollbar-outer">
                                <li>
                                    <div class="user-box">
                                        <div class="avatar-lg">
                                            <img src="<c:url value='/assets/img/profile.jpg'/>" alt="image profile" class="avatar-img rounded">
                                        </div>
                                        <div class="u-text">
                                            <sec:authorize access="isAuthenticated()">
                                                <h4><sec:authentication property="principal.username" /></h4>
                                                <p class="text-muted"><sec:authentication property="principal.username" /></p>
                                            </sec:authorize>
                                            <sec:authorize access="!isAuthenticated()">
                                                <h4>Guest</h4>
                                                <p class="text-muted">Not logged in</p>
                                            </sec:authorize>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="dropdown-divider"></div>
                                    <sec:authorize access="isAuthenticated()">
                                        <a class="dropdown-item" href="<c:url value='/profile'/>">My Profile</a>
                                        <div class="dropdown-divider"></div>
                                        <form action="<c:url value='/logout'/>" method="post" style="margin: 0;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button type="submit" class="dropdown-item">Logout</button>
                                        </form>
                                    </sec:authorize>
                                    <sec:authorize access="!isAuthenticated()">
                                        <a class="dropdown-item" href="<c:url value='/req/login'/>">Login</a>
                                        <a class="dropdown-item" href="<c:url value='/req/signup'/>">Sign Up</a>
                                    </sec:authorize>
                                </li>
                            </div>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div> 