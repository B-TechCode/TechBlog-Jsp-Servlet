package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/posts")
public class ViewPostsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        req.setAttribute("posts", dao.getAllPosts());

        RequestDispatcher rd = req.getRequestDispatcher("posts.jsp");
        rd.forward(req, resp);
    }
}
