<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Signup Form</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleUser.css">
    <script src="${pageContext.request.contextPath}/js/signup.js" defer></script>
</head>
<body>
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

        <div class="register">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/req/login">Log In</a>
            </p>
        </div>
    </form>
</section>

<script>
    const signupForm = document.getElementById("signupForm");
    signupForm.addEventListener("submit", (e) => {
        e.preventDefault();

        const username = document.getElementById("username").value;
        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("passwordcon").value;

        if (password !== confirmPassword) {
            alert("Passwords do not match!");
            return;
        }

        const data = { username, email, password };
        const jsonData = JSON.stringify(data);

        fetch("${pageContext.request.contextPath}/req/signup", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: jsonData
        })
            .then(response => {
                if (response.ok) {
                    alert("Signup successful!");
                    window.location.href = "${pageContext.request.contextPath}/req/login";
                } else {
                    alert("Signup failed.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("An error occurred.");
            });
    });
</script>
</body>
</html>
