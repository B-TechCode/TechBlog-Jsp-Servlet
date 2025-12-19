package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {

    private Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    //  Add Like
    public boolean addLike(int postId, int userId) {
        try {
            String q = "INSERT INTO likes(post_id, user_id) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //  Check if user already liked the post
    public boolean isLikedByUser(int postId, int userId) {
        try {
            String q = "SELECT id FROM likes WHERE post_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            return rs.next(); // true if record exists
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Count total likes on a post
    public int countLikes(int postId) {
        try {
            String q = "SELECT COUNT(*) FROM likes WHERE post_id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    //  Remove Like (Unlike)
    public boolean removeLike(int postId, int userId) {
        try {
            String q = "DELETE FROM likes WHERE post_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
