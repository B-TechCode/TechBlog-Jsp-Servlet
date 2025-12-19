package com.techblog.servlets;

import com.techblog.dao.CommentDao;
import com.techblog.entities.Comment;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addComment")
public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Session check
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        //Get data
        int postId = Integer.parseInt(req.getParameter("postId"));
        String content = req.getParameter("comment");

        if (content == null || content.trim().isEmpty()) {
            resp.sendRedirect("posts");
            return;
        }

        // Save comment
        Comment c = new Comment();
        c.setContent(content);
        c.setPostId(postId);
        c.setUserId(user.getId());

        CommentDao dao = new CommentDao(ConnectionProvider.getConnection());
        dao.addComment(c);

        //  Back to posts
        resp.sendRedirect("posts");
    }
}
