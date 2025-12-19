<%@ page import="com.techblog.entities.User" %>
<%
    User u = (User) session.getAttribute("currentUser");
%>

<div class="navbar">
    <div class="nav-logo">TechBlog</div>

    <!-- hamburger -->
    <div class="menu-toggle" onclick="toggleMenu()">☰</div>

    <div class="nav-links" id="navLinks">
        <a href="posts">Home</a>

        <% if (u != null) { %>
        <a href="add_post.jsp">Add Post</a>
        <a href="logout">Logout</a>
        <% } else { %>
        <a href="login.jsp">Login</a>
        <% } %>
    </div>
</div>

<script>
    function toggleMenu() {
        document.getElementById("navLinks").classList.toggle("show");
    }
</script>
