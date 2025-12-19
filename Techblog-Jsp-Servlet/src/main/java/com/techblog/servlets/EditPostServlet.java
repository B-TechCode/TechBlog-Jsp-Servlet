package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/editPost")
public class EditPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        // Session check
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }


        int postId = Integer.parseInt(req.getParameter("postId"));


        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        Post post = dao.getPostById(postId);

        // Security: only author can edit
        if (post == null || post.getUserId() != user.getId()) {
            resp.sendRedirect("posts");
            return;
        }

        //Send post to JSP
        req.setAttribute("post", post);
        RequestDispatcher rd = req.getRequestDispatcher("edit_post.jsp");
        rd.forward(req, resp);
    }
}
