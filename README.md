# TechBlog – JSP & Servlet Based Blog Application

TechBlog is a full-stack Java web application built using **JSP, Servlets, JDBC, and MySQL**.  
It allows users to register, log in, create posts, like posts, comment, and manage their content.

---

## Features

-  User Authentication (Register & Login)
-  Create, Edit & Delete Blog Posts
-  Like / Unlike Posts (with count)
-  Comment System
-  Authorization (only author can edit/delete)
-  Dark Mode Toggle
-  Sound Notification on Login
-  Responsive Navbar (Mobile Friendly)
-  Clean MVC Architecture
-  Maven-based Project
 

---

## 🛠 Tech Stack

- **Backend:** Java, JSP, Servlets, JDBC  
- **Frontend:** HTML, CSS, Bootstrap  
- **Database:** MySQL  
- **Server:** Apache Tomcat 10  
- **Build Tool:** Maven  
- **IDE:** IntelliJ IDEA  

---

## Project Structure
src/main/java
└── com.techblog
├── dao
├── entities
├── servlets
└── helper

src/main/webapp
├── css
├── sounds
├── WEB-INF
└── *.jsp


---

## Setup Instructions

###  Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/techblog-jsp-servlet.git

---

CREATE DATABASE techblog;

Deploy on Server
Use Apache Tomcat 10
 Run the project
http://localhost:8080/techblog

---
 Authentication Flow
Session-based authentication

Secure password storage using BCrypt
Unauthorized users cannot:
Create posts
Like posts
Comment

Future Improvements
 Pagination
 Profile Image Upload
 Rich Text Editor
 AJAX (Like & Comment without reload)
 JWT Authentication (Upgrade to Spring Boot)


 Author

Aakash Prasad Chaurasiya
 B.Tech CSE Student
 Java & Web Development Enthusiast


