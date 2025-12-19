package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deletePost")
public class DeletePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int postId = Integer.parseInt(req.getParameter("postId"));

        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        dao.deletePost(postId, user.getId());

        // Back to posts
        resp.sendRedirect("posts");
    }
}
