package com.techblog.entities;

import java.sql.Timestamp;

public class Post {

    private int id;
    private String title;
    private String content;
    private int userId;
    private String userName;     // author name
    private Timestamp createdAt;

    // Default constructor
    public Post() {
    }

    // Constructor for saving post
    public Post(String title, String content, int userId) {
        this.title = title;
        this.content = content;
        this.userId = userId;
    }

    //  Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
