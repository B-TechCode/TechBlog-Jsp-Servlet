<%
    if (session.getAttribute("currentUser") != null) {
        response.sendRedirect("profile.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration | TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="center-page">
    <div class="auth-container">
        <h2>Create Account</h2>

        <form action="register" method="post" class="auth-form">

            <input type="text" name="user_name" placeholder="Full Name" required>

            <input type="email" name="user_email" placeholder="Email Address" required>

            <input type="password" name="user_password" placeholder="Password" required>

            <select name="gender" required>
                <option value="">Select Gender</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
            </select>

            <textarea name="about" placeholder="Tell us about yourself"></textarea>

            <button type="submit">Register</button>

            <p class="switch-link">
                Already have an account?
                <a href="login.jsp">Login</a>
            </p>

        </form>
    </div>
</div>

</body>
</html>
