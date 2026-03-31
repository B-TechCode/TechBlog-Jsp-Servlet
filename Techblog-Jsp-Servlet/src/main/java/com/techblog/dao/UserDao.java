package com.techblog.dao;

import com.techblog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // ================= REGISTER USER =================
    public boolean saveUser(User user) {
        boolean f = false;

        try {
            String q = "INSERT INTO users(name,email,password,gender,about) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(q);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // hashed password
            ps.setString(4, user.getGender());
            ps.setString(5, user.getAbout());

            ps.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // ================= GET USER BY EMAIL (FOR LOGIN) =================
    public User getUserByEmail(String email) {

        User user = null;

        try {
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = this.con.prepareStatement(query);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // hashed password
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}