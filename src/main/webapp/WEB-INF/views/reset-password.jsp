<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleUser.css">
    <style>
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 5px;
            color: white;
            display: none;
            z-index: 1000;
            animation: slideIn 0.5s ease-in-out;
        }

        .success {
            background-color: #4CAF50;
        }

        .error {
            background-color: #f44336;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .loading {
            display: none;
            text-align: center;
            margin-top: 10px;
        }

        .loading::after {
            content: '';
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<div id="notification" class="notification"></div>
<section>
    <form id="resetPasswordForm">
        <h1>Reset Password</h1>
        <p style="color: #fff; text-align: center; margin-bottom: 20px;">
            Enter your new password below.
        </p>

        <input type="hidden" id="token" value="${token}">

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input type="password" id="password" name="password" required>
            <label for="password">New Password</label>
        </div>

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <label for="confirmPassword">Confirm Password</label>
        </div>

        <button id="submit" type="submit">Reset Password</button>
        <div id="loading" class="loading"></div>
    </form>
</section>

<script>
    function showNotification(message, isSuccess) {
        const notification = document.getElementById('notification');
        notification.textContent = message;
        notification.className = 'notification ' + (isSuccess ? 'success' : 'error');
        notification.style.display = 'block';
        
        setTimeout(() => {
            notification.style.display = 'none';
        }, 5000);
    }

    const resetPasswordForm = document.getElementById("resetPasswordForm");
    const loadingDiv = document.getElementById("loading");
    const submitButton = document.getElementById("submit");

    resetPasswordForm.addEventListener("submit", async (e) => {
        e.preventDefault();

        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;
        const token = document.getElementById("token").value;

        if (password !== confirmPassword) {
            showNotification("Passwords do not match!", false);
            return;
        }

        if (password.length < 6) {
            showNotification("Password must be at least 6 characters long!", false);
            return;
        }

        // Show loading and disable submit button
        loadingDiv.style.display = 'block';
        submitButton.disabled = true;

        try {
            const response = await fetch("${pageContext.request.contextPath}/req/reset-password", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: `token=\${encodeURIComponent(token)}&password=\${encodeURIComponent(password)}`
            });

            const responseText = await response.text();

            if (response.ok) {
                showNotification(responseText, true);
                resetPasswordForm.reset();
                setTimeout(() => {
                    window.location.href = "${pageContext.request.contextPath}/req/login";
                }, 3000);
            } else {
                showNotification(responseText || "Failed to reset password.", false);
            }
        } catch (error) {
            console.error("Error:", error);
            showNotification("An error occurred. Please try again.", false);
        } finally {
            loadingDiv.style.display = 'none';
            submitButton.disabled = false;
        }
    });
</script>
</body>
</html> 