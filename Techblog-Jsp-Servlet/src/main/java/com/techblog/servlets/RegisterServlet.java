package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.ValidationUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;

// 🔐 BCrypt
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔹 Get data
        String name = req.getParameter("user_name");
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");
        String gender = req.getParameter("gender");
        String about = req.getParameter("about");

        // 🔐 CLEAN INPUT
        name = (name != null) ? name.trim() : "";
        email = (email != null) ? email.trim() : "";
        about = (about != null) ? about.trim() : "";

        // 🚨 VALIDATION
        if (!ValidationUtil.isValidText(name) ||
                !ValidationUtil.isValidEmail(email) ||
                !ValidationUtil.isValidPassword(password)) {

            HttpSession session = req.getSession();
            session.setAttribute("msg", "Invalid input! Please check your details.");
            session.setAttribute("msgType", "danger");

            resp.sendRedirect("register.jsp");
            return;
        }

        // 🔐 HASH PASSWORD
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

        // 🔹 Create user
        User user = new User(name, email, hashedPassword, gender, about);

        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        // 🔹 Save user
        boolean saved = dao.saveUser(user);

        if (saved) {

            HttpSession session = req.getSession();

            // ✅ SUCCESS MESSAGE
            session.setAttribute("msg", "Registration Successful! Please Login.");
            session.setAttribute("msgType", "success");

            // ✅ REDIRECT TO LOGIN PAGE
            resp.sendRedirect("login.jsp");

        } else {

            HttpSession session = req.getSession();

            session.setAttribute("msg", "Registration Failed! Try again.");
            session.setAttribute("msgType", "danger");

            resp.sendRedirect("register.jsp");
        }
    }
}