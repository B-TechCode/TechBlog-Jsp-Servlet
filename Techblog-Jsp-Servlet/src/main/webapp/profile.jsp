<%@ include file="navbar.jsp" %>
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
    <title>Profile | TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="center-page">
    <div class="container">
        <h1>Welcome, <%= user.getName() %></h1>
        <p>Email: <%= user.getEmail() %></p>
        <p>About: <%= user.getAbout() %></p>

        <a href="add_post.jsp" class="btn">Add New Post</a>
        <a href="logout" class="btn">Logout</a>
    </div>
</div>

</body>
</html>
