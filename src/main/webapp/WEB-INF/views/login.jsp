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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        #username-error {
            color: #ff0000;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
<section>
        <form action="/checklogin" method="post" id="loginForm">
            <h1>Login</h1>
            <c:if test="${param.error != null}">
                <div class="error-message">
                    <c:choose>
                        <c:when test="${param.error == 'empty_username'}">
                            Username cannot be empty.
                        </c:when>
                        <c:when test="${param.error == 'empty_password'}">
                            Password cannot be empty.
                        </c:when>
                        <c:when test="${param.error == 'username_not_found'}">
                            Username does not exist.
                        </c:when>
                        <c:when test="${param.error == 'server'}">
                            Server error occurred. Please try again later.
                        </c:when>
                        <c:otherwise>
                            Invalid username or password.
                        </c:otherwise>
                    </c:choose>
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
                <div id="username-error"></div>
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
<script>
$(document).ready(function() {
    let typingTimer;
    const doneTypingInterval = 500; // 500ms delay

    $('#username').on('keyup', function() {
        clearTimeout(typingTimer);
        const username = $(this).val().trim();
        
        if (username.length > 0) {
            typingTimer = setTimeout(function() {
                $.ajax({
                    url: '/check-username',
                    type: 'POST',
                    data: { username: username },
                    success: function(response) {
                        if (!response.exists) {
                            $('#username-error').text('Username does not exist').show();
                            $('#loginForm button[type="submit"]').prop('disabled', true);
                        } else {
                            $('#username-error').hide();
                            $('#loginForm button[type="submit"]').prop('disabled', false);
                        }
                    }
                });
            }, doneTypingInterval);
        } else {
            $('#username-error').hide();
            $('#loginForm button[type="submit"]').prop('disabled', false);
        }
    });
});
</script>
</body>
</html>
