package com.techblog.entities;

import java.sql.Timestamp;

public class Comment {

    private int id;
    private String content;
    private int postId;
    private int userId;
    private Timestamp createdAt;

    // Extra (showing author name)
    private String userName;

    public Comment() {
    }

    public Comment(String content, int postId, int userId) {
        this.content = content;
        this.postId = postId;
        this.userId = userId;
    }

    //  GETTERS & SETTERS

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
