<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.techblog.entities.User" %>
<%
    User u = (User) session.getAttribute("currentUser");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">

        <!-- Logo -->
        <a class="navbar-brand fw-bold" href="posts">TechBlog</a>

        <!-- RIGHT SIDE -->
        <div class="d-flex align-items-center ms-auto gap-2">

            <!-- 🌙 TOGGLE -->
            <button type="button" class="theme-toggle" id="themeBtn">
            </button>

            <!-- MOBILE MENU -->
            <button class="navbar-toggler" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

        </div>

        <!-- MENU -->
        <div class="collapse navbar-collapse mt-3 mt-lg-0" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">

                <li class="nav-item">
                    <a class="nav-link" href="posts">Home</a>
                </li>

                <% if (u != null) { %>

                <li class="nav-item">
                    <a class="nav-link" href="add_post.jsp">Write Post</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="profile.jsp">
                        <%= u.getName().split(" ")[0] %>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-danger" href="logout">Logout</a>
                </li>

                <% } else { %>

                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>

                <li class="nav-item mt-2 mt-lg-0">
                    <a class="btn btn-primary px-3" href="register.jsp">Register</a>
                </li>

                <% } %>

            </ul>
        </div>

    </div>
</nav>

<!-- 🌙 SAFE SCRIPT (NO JSP ERROR) -->
<script>
    document.addEventListener("DOMContentLoaded", function () {

        const btn = document.getElementById("themeBtn");
        const body = document.body;

        // Apply saved theme
        const savedTheme = localStorage.getItem("theme");

        if (savedTheme === "dark") {
            body.classList.add("dark-mode");
            if (btn) btn.innerText = "☀️";
        }

        // Click event (SAFE WAY)
        if (btn) {
            btn.addEventListener("click", function () {
                body.classList.toggle("dark-mode");

                if (body.classList.contains("dark-mode")) {
                    localStorage.setItem("theme", "dark");
                    btn.innerText = "☀️";
                } else {
                    localStorage.setItem("theme", "light");
                    btn.innerText = "🌙";
                }
            });
        }

    });
</script>