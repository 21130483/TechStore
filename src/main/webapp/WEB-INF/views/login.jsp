<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="/assets/techstore/css/styleUser.css">
    <style>
        .error-message {
            color: #ff0000;
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .forgot-password {
            text-align: right;
            margin-bottom: 15px;
        }
        .forgot-password a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<section>
        <form action="/checklogin" method="post">
            <h1>Login</h1>
            <c:if test="${param.error != null}">
                <div class="error-message">
                    Invalid username or password.
                </div>
            </c:if>
            <c:if test="${param.expired != null}">
                <div class="error-message">
                    Your session has expired. Please log in again.
                </div>
            </c:if>
            <div class="inputbox">
                <ion-icon name="person-outline"></ion-icon>
                <input name="username" id="username" type="text" required>
                <label for="username">Username</label>
            </div>
            <div class="inputbox">
                <ion-icon name="lock-closed-outline"></ion-icon>
                <input name="password" type="password" id="password" required>
                <label for="password">Password</label>
            </div>
            <div class="forgot-password">
                <a href="${pageContext.request.contextPath}/req/forgot-password">Forgot Password?</a>
            </div>
            <button type="submit">Log in</button>
            <div class="register">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/req/signup">Register!!</a></p>
            </div>
        </form>
</section>
</body>
</html>
