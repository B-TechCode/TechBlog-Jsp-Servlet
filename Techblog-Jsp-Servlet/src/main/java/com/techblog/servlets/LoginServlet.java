package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

// 🔐 BCrypt
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // 🔐 CLEAN INPUT
        email = (email != null) ? email.trim() : "";

        // 🚨 VALIDATION
        if (!ValidationUtil.isValidEmail(email) || password == null || password.isEmpty()) {

            HttpSession session = req.getSession();
            session.setAttribute("msg", "Invalid Email or Password!");
            session.setAttribute("msgType", "danger"); // ✅ for bootstrap color

            resp.sendRedirect("login.jsp");
            return;
        }

        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        // 🔍 Get user by email
        User user = dao.getUserByEmail(email);

        // 🔐 VERIFY PASSWORD
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {

            // 🔐 SESSION SECURITY
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("currentUser", user);
            newSession.setMaxInactiveInterval(30 * 60);

            // ✅ SUCCESS MESSAGE
            newSession.setAttribute("msg", "Login Successful!");
            newSession.setAttribute("msgType", "success"); // ✅ IMPORTANT

            resp.sendRedirect("profile.jsp");

        } else {

            HttpSession session = req.getSession();
            session.setAttribute("msg", "Invalid Email or Password!");
            session.setAttribute("msgType", "danger");

            resp.sendRedirect("login.jsp");
        }
    }
}