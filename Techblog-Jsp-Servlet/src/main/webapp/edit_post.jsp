<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.techblog.entities.Post" %>
<%@ page import="com.techblog.entities.User" %>

<%@ include file="navbar.jsp" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect("posts");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Post | TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="page-container">
    <div class="auth-container">
        <h2>Edit Post</h2>

        <!-- Update Post -->
        <form action="updatePost" method="post" class="auth-form">

            <!-- hidden post id -->
            <input type="hidden" name="postId" value="<%= post.getId() %>">

            <input
                    type="text"
                    name="title"
                    placeholder="Post title"
                    value="<%= post.getTitle().replace("\"","&quot;") %>"
                    required
            >

            <textarea
                    name="content"
                    placeholder="Post content"
                    required
            ><%= post.getContent() %></textarea>

            <button type="submit">Update Post</button>
        </form>
    </div>
</div>

</body>
</html>
