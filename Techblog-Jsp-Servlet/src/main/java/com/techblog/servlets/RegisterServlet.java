package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("user_name");
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");
        String gender = req.getParameter("gender");
        String about = req.getParameter("about");

        User user = new User(name, email, password, gender, about);

        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        resp.setContentType("text/plain");

        if (dao.saveUser(user)) {
            resp.getWriter().write("done");
        } else {
            resp.getWriter().write("error");
        }
    }
}
