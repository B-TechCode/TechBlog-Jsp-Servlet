<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("currentUser") != null) {
        response.sendRedirect("profile.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | TechBlog</title>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/custom.css">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- ✅ Navbar (GLOBAL TOGGLE HERE) -->
<%@ include file="navbar.jsp" %>

<!-- ===== PAGE WRAPPER ===== -->
<div class="page-wrapper page-center">

    <!-- ===== REGISTER CARD ===== -->
    <div class="card shadow auth-card p-4" style="width: 440px;">

        <h2 class="text-center mb-2">Create Account</h2>
        <p class="text-center text-muted mb-4">Join TechBlog and start writing</p>

        <form action="register" method="post">

            <!-- Name -->
            <div class="mb-3">
                <input type="text" name="user_name" class="form-control"
                       placeholder="Full name" required>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <input type="email" name="user_email" class="form-control"
                       placeholder="Email address" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <input type="password" name="user_password" class="form-control"
                       placeholder="Password (min 6 characters)" required>
            </div>

            <!-- Gender -->
            <div class="mb-3">
                <select name="gender" class="form-select" required>
                    <option value="">Select gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <!-- Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    Create Account
                </button>
            </div>

        </form>

        <!-- Login Link -->
        <p class="text-center mt-3">
            Already have an account?
            <a href="login.jsp">Sign in</a>
        </p>

    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>