<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Signup Form</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="/static/css/styleUser.css">
    <script src="/static/js/signup.js" defer></script>
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
    <form id="signupForm">
        <h1>Sign Up</h1>

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="username" name="username" required>
            <label for="username">Name</label>
        </div>

        <div class="inputbox">
            <ion-icon name="mail-outline"></ion-icon>
            <input type="email" id="email" name="email" required>
            <label for="email">Email</label>
        </div>

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input type="password" id="password" name="password" required>
            <label for="password">Password</label>
        </div>

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input type="password" id="passwordcon" name="passwordcon" required>
            <label for="passwordcon">Confirm Password</label>
        </div>

        <button id="submit" type="submit">Sign Up</button>
        <div id="loading" class="loading"></div>

        <div class="register">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/req/login">Log In</a>
            </p>
        </div>
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

    const signupForm = document.getElementById("signupForm");
    const loadingDiv = document.getElementById("loading");
    const submitButton = document.getElementById("submit");

    signupForm.addEventListener("submit", async (e) => {
        e.preventDefault();

        const username = document.getElementById("username").value;
        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("passwordcon").value;

        if (password !== confirmPassword) {
            showNotification("Passwords do not match!", false);
            return;
        }

        // Show loading and disable submit button
        loadingDiv.style.display = 'block';
        submitButton.disabled = true;

        const data = { username, email, password };

        try {
            const response = await fetch("${pageContext.request.contextPath}/req/signup", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            });

            const responseText = await response.text();

            if (response.ok) {
                showNotification("Registration successful! Please check your email to verify your account.", true);
                // Clear the form
                signupForm.reset();
                // Wait 3 seconds before redirecting to login
                setTimeout(() => {
                    window.location.href = "${pageContext.request.contextPath}/req/login";
                }, 3000);
            } else {
                showNotification(responseText || "Registration failed.", false);
            }
        } catch (error) {
            console.error("Error:", error);
            showNotification("An error occurred during registration.", false);
        } finally {
            // Hide loading and enable submit button
            loadingDiv.style.display = 'none';
            submitButton.disabled = false;
        }
    });
</script>
</body>
</html>