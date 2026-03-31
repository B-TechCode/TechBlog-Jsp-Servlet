<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write Post | TechBlog</title>

    <link rel="stylesheet" href="css/custom.css">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- ✅ Navbar (GLOBAL TOGGLE HERE) -->
<%@ include file="navbar.jsp" %>

<!-- ===== PAGE WRAPPER ===== -->
<div class="page-wrapper page-center">

    <!-- ===== POST FORM CARD ===== -->
    <div class="card shadow auth-card p-4" style="width: 600px;">

        <h2 class="mb-4 text-center">Write a Post</h2>

        <form action="addPost" method="post">

            <!-- Title -->
            <div class="mb-3">
                <label class="form-label">Title</label>
                <input type="text" name="title" class="form-control"
                       placeholder="Give your post a title..." required>
            </div>

            <!-- Content -->
            <div class="mb-3">
                <label class="form-label">Content</label>
                <textarea name="content" class="form-control" rows="8"
                          placeholder="Write your post content here..." required></textarea>
            </div>

            <!-- Button -->
            <div class="d-grid mt-2">
                <button type="submit" class="btn btn-primary">
                    Publish Post
                </button>
            </div>

        </form>

    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>