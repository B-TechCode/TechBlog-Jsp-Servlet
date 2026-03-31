<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page import="com.techblog.entities.Post" %>
<%@ page import="com.techblog.entities.User" %>
<%@ page import="com.techblog.entities.Comment" %>
<%@ page import="com.techblog.dao.LikeDao" %>
<%@ page import="com.techblog.dao.CommentDao" %>
<%@ page import="com.techblog.helper.ConnectionProvider" %>
<%@ page import="com.techblog.helper.SecurityUtil" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Posts | TechBlog</title>

    <link rel="stylesheet" href="css/custom.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<%@ include file="navbar.jsp" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");

    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
    CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());

    String currentUserName = (currentUser != null) ? currentUser.getName() : "";
%>

<!-- ===== PAGE WRAPPER ===== -->
<div class="page-wrapper">

    <div class="container page-content">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3>Latest Posts</h3>
            <% if (currentUser != null) { %>
            <a href="add_post.jsp" class="btn btn-primary">+ Write Post</a>
            <% } %>
        </div>

        <%
            List<Post> posts = (List<Post>) request.getAttribute("posts");

            if (posts == null || posts.isEmpty()) {
        %>

        <div class="alert alert-info text-center">
            No posts yet. Be the first to write!
        </div>

        <%
        } else {
            for (Post p : posts) {
                int likeCount = likeDao.countLikes(p.getId());
                boolean liked = (currentUser != null) && likeDao.isLikedByUser(p.getId(), currentUser.getId());
        %>

        <!-- ===== POST CARD ===== -->
        <div class="card post-card mb-4 shadow">

            <div class="card-body">

                <h5 class="card-title">
                    <%= SecurityUtil.escapeHtml(p.getTitle()) %>
                </h5>

                <p class="text-muted small">
                    <strong><%= SecurityUtil.escapeHtml(p.getUserName()) %></strong> ·
                    <%= p.getCreatedAt() %>
                </p>

                <p class="card-text">
                    <%= SecurityUtil.escapeHtml(p.getContent()) %>
                </p>

                <!-- ACTIONS -->
                <div class="d-flex align-items-center gap-2 mb-3 flex-wrap">

                    <!-- LIKE -->
                    <form onsubmit="handleLike(event, <%= p.getId() %>)">
                        <button type="submit"
                                class="btn btn-sm <%= liked ? "btn-primary" : "btn-outline-primary" %>"
                                id="like-btn-<%= p.getId() %>">
                            ❤ <span class="like-text"><%= liked ? "Unlike" : "Like" %></span>
                            (<span id="like-count-<%= p.getId() %>"><%= likeCount %></span>)
                        </button>
                    </form>

                    <% if (currentUser != null && currentUser.getId() == p.getUserId()) { %>

                    <a href="editPost?postId=<%= p.getId() %>" class="btn btn-sm btn-outline-secondary">
                        Edit
                    </a>

                    <form action="deletePost" method="post"
                          onsubmit="return confirm('Delete this post?');">
                        <input type="hidden" name="postId" value="<%= p.getId() %>">
                        <button type="submit" class="btn btn-sm btn-outline-danger">
                            Delete
                        </button>
                    </form>

                    <% } %>
                </div>

                <!-- COMMENTS -->
                <div id="comments-<%= p.getId() %>">

                    <%
                        List<Comment> comments = commentDao.getCommentsByPost(p.getId());
                        for (Comment c : comments) {
                    %>

                    <!-- COMMENT -->
                    <div class="comment-box rounded p-2 mb-2">
                        <strong><%= SecurityUtil.escapeHtml(c.getUserName()) %></strong>:
                        <%= SecurityUtil.escapeHtml(c.getContent()) %>
                    </div>

                    <% } %>

                    <% if (currentUser != null) { %>

                    <!-- ADD COMMENT -->
                    <form onsubmit="handleComment(event, <%= p.getId() %>)" class="d-flex mt-2">
                        <input type="text"
                               id="comment-input-<%= p.getId() %>"
                               class="form-control me-2"
                               placeholder="Write a comment..."
                               required>

                        <button class="btn btn-success">Post</button>
                    </form>

                    <% } %>

                </div>

            </div>
        </div>

        <% } } %>

    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    var currentUserName = "<%= currentUserName.replace("\"", "\\\"") %>";

    function handleLike(event, postId) {
        event.preventDefault();
        fetch("like", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "postId=" + postId
        })
            .then(res => res.text())
            .then(() => {
                let btn = document.getElementById("like-btn-" + postId);
                let count = document.getElementById("like-count-" + postId);
                let text = btn.querySelector(".like-text");

                let n = parseInt(count.innerText);

                if (btn.classList.contains("btn-primary")) {
                    btn.classList.remove("btn-primary");
                    btn.classList.add("btn-outline-primary");
                    text.innerText = "Like";
                    count.innerText = n - 1;
                } else {
                    btn.classList.remove("btn-outline-primary");
                    btn.classList.add("btn-primary");
                    text.innerText = "Unlike";
                    count.innerText = n + 1;
                }
            });
    }

    function handleComment(event, postId) {
        event.preventDefault();

        let input = document.getElementById("comment-input-" + postId);
        let text = input.value.trim();
        if (!text) return;

        fetch("addComment", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "postId=" + postId + "&comment=" + encodeURIComponent(text)
        })
            .then(res => res.text())
            .then(() => {
                let container = document.getElementById("comments-" + postId);

                let div = document.createElement("div");
                div.className = "comment-box rounded p-2 mb-2";
                div.innerHTML = "<strong>" + currentUserName + "</strong>: " + text;

                container.insertBefore(div, container.lastElementChild);
                input.value = "";
            });
    }
</script>

</body>
</html>