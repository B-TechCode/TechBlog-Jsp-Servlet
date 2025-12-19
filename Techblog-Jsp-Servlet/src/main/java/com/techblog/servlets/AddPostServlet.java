package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addPost")
public class AddPostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //  Get existing session (do NOT create new)
        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        // Protect page
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Read form data
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // Validation
        if (title == null || title.trim().isEmpty()
                || content == null || content.trim().isEmpty()) {
            resp.sendRedirect("add_post.jsp?error=empty");
            return;
        }

        // Create post object
        Post post = new Post(title, content, user.getId());

        // Save to DB
        PostDao dao = new PostDao(ConnectionProvider.getConnection());

        if (dao.savePost(post)) {

            // Redirect to View Posts (Timeline)
            resp.sendRedirect("posts");
        } else {
            resp.sendRedirect("add_post.jsp?error=failed");
        }
    }
}
