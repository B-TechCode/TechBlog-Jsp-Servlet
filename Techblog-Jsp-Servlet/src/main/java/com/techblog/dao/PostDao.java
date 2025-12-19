package com.techblog.dao;

import com.techblog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    private Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    //  Save Post
    public boolean savePost(Post post) {
        boolean status = false;

        try {
            String q = "INSERT INTO posts(title, content, user_id) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(q);

            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getUserId());

            ps.executeUpdate();
            status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    //  Fetch all posts with author name
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        try {
            String q =
                    "SELECT p.id, p.title, p.content, p.created_at, " +
                            "u.id AS user_id, u.name AS user_name " +
                            "FROM posts p INNER JOIN users u ON p.user_id = u.id " +
                            "ORDER BY p.created_at DESC";

            PreparedStatement ps = con.prepareStatement(q);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();

                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserName(rs.getString("user_name"));
                post.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //  Get single post by ID
    public Post getPostById(int postId) {

        Post post = null;

        try {
            String q = "SELECT * FROM posts WHERE id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setUserId(rs.getInt("user_id"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return post;
    }

    //  Update post (ONLY AUTHOR)
    public boolean updatePost(int postId, String title, String content, int userId) {
        boolean success = false;

        try {
            String q = "UPDATE posts SET title=?, content=? WHERE id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, postId);
            ps.setInt(4, userId);

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

    // Delete post (ONLY AUTHOR)
    public boolean deletePost(int postId, int userId) {
        try {
            String q = "DELETE FROM posts WHERE id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setInt(1, postId);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
