package com.techblog.dao;

import com.techblog.entities.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {

    private Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }


    public boolean addComment(Comment c) {
        try {
            String q = "INSERT INTO comments(comment, post_id, user_id) VALUES (?,?,?)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, c.getContent());
            ps.setInt(2, c.getPostId());
            ps.setInt(3, c.getUserId());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all comments for a post
    public List<Comment> getCommentsByPost(int postId) {

        List<Comment> list = new ArrayList<>();

        try {
            String q =
                    "SELECT c.*, u.name " +
                            "FROM comments c " +
                            "JOIN users u ON c.user_id = u.id " +
                            "WHERE c.post_id = ? " +
                            "ORDER BY c.id DESC";

            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Comment c = new Comment();
                c.setId(rs.getInt("id"));
                c.setContent(rs.getString("comment"));
                c.setPostId(rs.getInt("post_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setUserName(rs.getString("name"));

                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
