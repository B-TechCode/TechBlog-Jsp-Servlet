<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.techblog.entities.User" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String initial = (user.getName() != null && !user.getName().isEmpty())
            ? user.getName().substring(0,1).toUpperCase() : "U";

    String msg = (String) session.getAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile | TechBlog</title>

    <link rel="stylesheet" href="css/custom.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- ✅ Navbar -->
<%@ include file="navbar.jsp" %>

<!-- ✅ SMALL SUCCESS MESSAGE -->
<% if (msg != null) { %>

<div class="d-flex justify-content-center mt-3">
    <div id="loginAlert"
         class="alert alert-success text-center py-2 px-3"
         style="min-width: 220px; max-width: 350px; font-size: 14px; border-radius: 8px;">
        <%= msg %>
    </div>
</div>

<%
    session.removeAttribute("msg");
%>

<% } %>

<!-- 🔊 SOUND -->
<audio id="successSound" src="<%= request.getContextPath() %>/sounds/success.mp3"></audio>

<!-- ===== PAGE WRAPPER ===== -->
<div class="page-wrapper page-center">

    <!-- ===== PROFILE CARD ===== -->
    <div class="card shadow auth-card text-center p-4" style="width: 420px;">

        <!-- Avatar -->
        <div class="rounded-circle bg-primary text-white d-flex justify-content-center align-items-center mx-auto mb-3"
             style="width: 90px; height: 90px; font-size: 34px;">
            <%= initial %>
        </div>

        <!-- Name -->
        <h3 class="fw-bold mb-1"><%= user.getName() %></h3>

        <!-- Email -->
        <p class="text-muted mb-3"><%= user.getEmail() %></p>

        <!-- About -->
        <div class="mb-4">
            <p>
                <%= (user.getAbout() != null && !user.getAbout().isEmpty())
                        ? user.getAbout()
                        : "No bio added yet." %>
            </p>
        </div>

        <!-- Actions -->
        <div class="d-grid gap-2">
            <a href="posts" class="btn btn-primary">View All Posts</a>
            <a href="add_post.jsp" class="btn btn-success">Write a Post</a>
            <a href="logout" class="btn btn-danger">Sign Out</a>
        </div>

    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- ✅ SOUND + AUTO HIDE -->
<script>
    window.addEventListener("DOMContentLoaded", () => {

        let alertBox = document.getElementById("loginAlert");

        if (alertBox) {
            // 🔊 play sound
            let sound = document.getElementById("successSound");
            if (sound) {
                sound.play().catch(() => {});
            }

            // fade out effect
            setTimeout(() => {
                alertBox.style.transition = "opacity 0.5s ease";
                alertBox.style.opacity = "0";
                setTimeout(() => alertBox.remove(), 500);
            }, 2000);
        }
    });
</script>

</body>
</html>