<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.techblog.entities.Post" %>
<%@ page import="com.techblog.entities.User" %>
<%@ page import="com.techblog.entities.Comment" %>
<%@ page import="com.techblog.dao.LikeDao" %>
<%@ page import="com.techblog.dao.CommentDao" %>
<%@ page import="com.techblog.helper.ConnectionProvider" %>

<%@ include file="navbar.jsp" %>

<%
    User currentUser = null;
    if (session != null) {
        currentUser = (User) session.getAttribute("currentUser");
    }

    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
    CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Posts | TechBlog</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="page-container">
    <h2 class="page-title">Latest Posts</h2>

    <%
        List<Post> posts = (List<Post>) request.getAttribute("posts");

        if (posts == null || posts.isEmpty()) {
    %>
    <p class="no-posts">No posts available.</p>
    <%
    } else {
        for (Post p : posts) {

            int likeCount = likeDao.countLikes(p.getId());
            boolean liked = false;

            if (currentUser != null) {
                liked = likeDao.isLikedByUser(p.getId(), currentUser.getId());
            }
    %>

    <!-- 🧾 POST CARD -->
    <div class="post-card">

        <h3 class="post-title"><%= p.getTitle() %></h3>

        <p class="post-meta">
            By <strong><%= p.getUserName() %></strong>
            • <%= p.getCreatedAt() %>
        </p>

        <p class="post-content">
            <%= p.getContent() %>
        </p>

        <!--  LIKE / UNLIKE -->
        <form action="like" method="post">
            <input type="hidden" name="postId" value="<%= p.getId() %>">
            <button type="submit" class="like-btn">
                <%= liked ? " Unlike" : " Like" %> (<%= likeCount %>)
            </button>
        </form>

        <!--  DELETE (ONLY AUTHOR) -->
        <%
            if (currentUser != null && currentUser.getId() == p.getUserId()) {
        %>
        <form action="deletePost" method="post" style="margin-top:8px;"
              onsubmit="return confirm('Are you sure you want to delete this post?');">
            <input type="hidden" name="postId" value="<%= p.getId() %>">
            <button type="submit" class="like-btn" style="background:#111;">
                🗑 Delete
            </button>
        </form>
        <%
            }
        %>

        <!-- COMMENTS -->
        <div class="comment-section">

            <%
                List<Comment> comments = commentDao.getCommentsByPost(p.getId());
                for (Comment c : comments) {
            %>
            <div class="comment">
                <strong><%= c.getUserName() %></strong> :
                <%= c.getContent() %>
            </div>
            <%
                }
            %>

            <!-- ADD COMMENT -->
            <%
                if (currentUser != null) {
            %>
            <form action="addComment" method="post" class="comment-form">
                <input type="hidden" name="postId" value="<%= p.getId() %>">
                <input type="text" name="comment" placeholder="Write a comment..." required>
                <button type="submit">Post</button>
            </form>
            <%
                }
            %>

        </div>
    </div>
    <!-- END POST CARD -->

    <%
            }
        }
    %>

</div>

</body>
</html>
