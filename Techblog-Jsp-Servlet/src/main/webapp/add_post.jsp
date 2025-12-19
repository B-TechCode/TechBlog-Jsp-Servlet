<%@ page import="com.techblog.entities.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Post | TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- enter fix -->
<div class="center-page">
    <div class="auth-container">
        <h2>Create New Post</h2>

        <form action="addPost" method="post" class="auth-form">
            <input type="text" name="title" placeholder="Enter post title" required>
            <textarea name="content" placeholder="Write your blog content here..." required></textarea>
            <button type="submit">Publish Post</button>
        </form>
    </div>
</div>

</body>
</html>
