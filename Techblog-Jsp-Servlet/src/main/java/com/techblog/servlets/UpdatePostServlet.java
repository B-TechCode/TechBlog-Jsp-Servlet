package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/updatePost")
public class UpdatePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // Session check
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

        try {
            // Get form data
            int postId = Integer.parseInt(req.getParameter("postId"));
            String title = req.getParameter("title");
            String content = req.getParameter("content");

            //Validation
            if (title == null || title.trim().isEmpty()
                    || content == null || content.trim().isEmpty()) {

                resp.sendRedirect("editPost?postId=" + postId + "&error=empty");
                return;
            }

            // 🗄 Update DB
            PostDao dao = new PostDao(ConnectionProvider.getConnection());
            boolean updated = dao.updatePost(postId, title, content, user.getId());

            if (updated) {
                resp.sendRedirect("posts");
            } else {
                //  Either not author or post not found
                resp.sendRedirect("editPost?postId=" + postId + "&error=unauthorized");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("posts?error=server");
        }
    }
}
