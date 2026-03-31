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
    <title>Login | TechBlog</title>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/custom.css">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- ✅ Navbar -->
<%@ include file="navbar.jsp" %>

<!-- ===== PAGE WRAPPER ===== -->
<div class="page-wrapper page-center">

    <!-- ===== LOGIN CARD ===== -->
    <div class="card shadow auth-card p-4" style="width: 420px;">

        <h2 class="text-center mb-2">Welcome Back</h2>
        <p class="text-center text-muted mb-3">Sign in to your TechBlog account</p>

        <!-- ✅ MESSAGE -->
        <%
            String msg = (String) session.getAttribute("msg");
            String msgType = (String) session.getAttribute("msgType");

            if (msg != null) {
        %>

        <div class="alert alert-<%= (msgType != null ? msgType : "info") %> text-center">
            <%= msg %>
        </div>

        <%
                session.removeAttribute("msg");
                session.removeAttribute("msgType");
            }
        %>

        <!-- ===== FORM ===== -->
        <form action="login" method="post">

            <div class="mb-3">
                <input type="email" name="email" class="form-control"
                       placeholder="Email address" required>
            </div>

            <div class="mb-3">
                <input type="password" name="password" class="form-control"
                       placeholder="Password" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-success">
                    Sign In
                </button>
            </div>

        </form>

        <p class="text-center mt-3">
            Don’t have an account?
            <a href="register.jsp">Register</a>
        </p>

    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- ✅ AUTO HIDE -->
<script>
    setTimeout(() => {
        let alertBox = document.querySelector(".alert");
        if (alertBox) {
            alertBox.style.display = "none";
        }
    }, 2000);
</script>

</body>
</html>