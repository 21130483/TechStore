<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/plugins.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/kaiadmin.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/assets/css/demo.css'/>" />
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center" style="height: 100vh;">
            <div class="col-md-6 text-center">
                <h1 class="display-1">404</h1>
                <h2>Page Not Found</h2>
                <p class="lead">The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
                <a href="<c:url value='/'/>" class="btn btn-primary">Go to Homepage</a>
            </div>
        </div>
    </div>
</body>
</html> 