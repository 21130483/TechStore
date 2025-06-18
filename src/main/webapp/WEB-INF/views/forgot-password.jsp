<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="/assets/techstore/css/styleUser.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        .field-error {
            color: #ff0000;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .inputbox.error input {
            border-color: #ffaaa4;
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
    <form id="forgotPasswordForm">
        <h1>Forgot Password</h1>
        <p style="color: #fff; text-align: center; margin-bottom: 20px;">
            Enter your email address and we'll send you instructions to reset your password.
        </p>

        <div class="inputbox">
            <ion-icon name="mail-outline"></ion-icon>
            <input type="email" id="email" name="email" required>
            <label for="email">Email</label>
            <div id="email-error" class="field-error"></div>
        </div>

        <button id="submit" type="submit">Send Reset Link</button>
        <div id="loading" class="loading"></div>

        <div class="register">
            <p>Remember your password? <a href="${pageContext.request.contextPath}/req/login">Log In</a></p>
        </div>
    </form>
</section>
<script>
    $(document).ready(function() {
        let emailTimer;
        const doneTypingInterval = 500; // 500ms delay

        // Email validation
        $('#email').on('keyup', function() {
            clearTimeout(emailTimer);
            const email = $(this).val().trim();
            const inputbox = $(this).closest('.inputbox');
            //if email is not empty
            if (email.length > 0) {
                emailTimer = setTimeout(function() {
                    $.ajax({
                        url: '/req/check-email-for-reset',
                        type: 'POST',
                        data: { email: email },
                        success: function(response) {
                            if (!response.exists) {
                                $('#email-error').text('Email not found in our records').show();
                                inputbox.addClass('error');
                                $('#submit').prop('disabled', true);
                            } else {
                                $('#email-error').hide();
                                inputbox.removeClass('error');
                                $('#submit').prop('disabled', false);
                            }
                        }
                    });
                }, doneTypingInterval);//500ms delay
            } else {
                $('#email-error').hide();
                inputbox.removeClass('error');
                $('#submit').prop('disabled', false);
            }
        });

        function showNotification(message, isSuccess) {
            const notification = document.getElementById('notification');
            notification.textContent = message;
            notification.className = 'notification ' + (isSuccess ? 'success' : 'error');
            notification.style.display = 'block';
            
            setTimeout(() => {
                notification.style.display = 'none';
            }, 5000);
        }

        const forgotPasswordForm = document.getElementById("forgotPasswordForm");
        const loadingDiv = document.getElementById("loading");
        const submitButton = document.getElementById("submit");

        forgotPasswordForm.addEventListener("submit", async (e) => {
            e.preventDefault();

            const email = document.getElementById("email").value;

            // Show loading and disable submit button
            loadingDiv.style.display = 'block';
            submitButton.disabled = true;

            try {
                const response = await fetch("${pageContext.request.contextPath}/req/forgot-password", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                    body: `email=\${encodeURIComponent(email)}`
                });

                const responseText = await response.text();

                if (response.ok) {
                    showNotification(responseText, true);
                    forgotPasswordForm.reset();
                    setTimeout(() => {
                        window.location.href = "${pageContext.request.contextPath}/req/login";
                    }, 3000);
                } else {
                    showNotification(responseText || "Failed to process request.", false);
                }
            } catch (error) {
                console.error("Error:", error);
                showNotification("An error occurred. Please try again.", false);
            } finally {
                loadingDiv.style.display = 'none';
                submitButton.disabled = false;
            }
        });
    });
</script>
</body>
</html> 