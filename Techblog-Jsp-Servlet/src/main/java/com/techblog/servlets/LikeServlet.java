package com.techblog.servlets;

import com.techblog.dao.LikeDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/like")
public class LikeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // Session check (safe)
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

        // Get postId safely
        String postIdStr = req.getParameter("postId");
        if (postIdStr == null) {
            resp.sendRedirect("posts");
            return;
        }

        int postId = Integer.parseInt(postIdStr);

        LikeDao dao = new LikeDao(ConnectionProvider.getConnection());

        //LIKE / UNLIKE TOGGLE
        if (dao.isLikedByUser(postId, user.getId())) {
            dao.removeLike(postId, user.getId());
        } else {
            dao.addLike(postId, user.getId());
        }

        // Redirect back to posts page
        resp.sendRedirect("posts");
    }
}
