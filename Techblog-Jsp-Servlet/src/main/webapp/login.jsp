<%
    if (session.getAttribute("currentUser") != null) {
        response.sendRedirect("profile.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login | TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="center-page">
    <div class="auth-container">
        <h2>Login</h2>

        <form class="auth-form" action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>

            <button type="submit">Login</button>

            <p class="switch-link">
                Don't have an account?
                <a href="register.jsp">Register</a>
            </p>
        </form>
    </div>
</div>

</body>
</html>
