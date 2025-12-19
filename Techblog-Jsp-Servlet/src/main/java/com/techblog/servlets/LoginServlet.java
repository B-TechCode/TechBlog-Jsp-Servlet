package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDao dao = new UserDao(ConnectionProvider.getConnection());
        User user = dao.getUserByEmailAndPassword(email, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);

            resp.sendRedirect("profile.jsp");
        } else {
            resp.getWriter().print("Invalid credentials");
        }
    }
}
