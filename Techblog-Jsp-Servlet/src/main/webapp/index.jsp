
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
    <title>TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h1 class="logo">TechBlog</h1>

    <a href="register.jsp" class="btn">Register</a>
</div>

</body>
</html>
