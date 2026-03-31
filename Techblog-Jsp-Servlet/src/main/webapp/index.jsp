<%@ page import="com.techblog.entities.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TechBlog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/custom.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<!-- Navbar -->
<%@ include file="navbar.jsp" %>

<!-- Hero Section -->
<div class="container text-center mt-5">

    <h1 class="display-4 fw-bold">Welcome to TechBlog</h1>
    <p class="lead mt-3">
        Share your ideas, explore posts, and connect with developers.
    </p>

    <div class="mt-4">
        <a href="posts" class="btn btn-primary me-2">View Posts</a>
        <a href="add_post.jsp" class="btn btn-success">Write a Post</a>
    </div>

</div>

<!-- Optional Cards Section -->
<div class="container mt-5">
    <div class="row text-center">

        <div class="col-md-4 mb-3">
            <div class="card shadow-sm p-3">
                <h5>Create</h5>
                <p>Write and publish your own posts easily.</p>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card shadow-sm p-3">
                <h5>Explore</h5>
                <p>Read posts from other users.</p>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card shadow-sm p-3">
                <h5>Connect</h5>
                <p>Engage with the community.</p>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>