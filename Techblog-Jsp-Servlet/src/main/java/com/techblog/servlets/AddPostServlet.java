package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addPost")
public class AddPostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔐 GET EXISTING SESSION (SECURE)
        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 🔹 GET INPUT
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // 🔐 CLEAN INPUT
        title = title != null ? title.trim() : null;
        content = content != null ? content.trim() : null;

        // 🚨 INDUSTRY VALIDATION
        if (!ValidationUtil.isValidText(title) ||
                !ValidationUtil.isValidText(content)) {

            resp.sendRedirect("add_post.jsp?error=invalid");
            return;
        }

        // 🔹 CREATE POST
        Post post = new Post(title, content, user.getId());

        PostDao dao = new PostDao(ConnectionProvider.getConnection());

        boolean saved = dao.savePost(post);

        if (saved) {
            resp.sendRedirect("posts"); // success
        } else {
            resp.sendRedirect("add_post.jsp?error=failed");
        }
    }
}