# TechBlog – JSP & Servlet Based Blog Application

TechBlog is a full-stack Java web application built using **JSP, Servlets, JDBC, and MySQL**.  
It allows users to register, log in, create posts, like posts, comment, edit, and delete their own content.

---

##  Features

- User Registration & Login (Session-based authentication)
- Create, Edit & Delete Blog Posts
- Like / Unlike Posts (with count)
- Comment System
- Authorization (only author can edit/delete)
- Responsive Navbar (Hamburger menu)
- Clean MVC architecture
- Maven-based project

---

## Tech Stack

- **Backend:** Java, JSP, Servlets, JDBC
- **Frontend:** HTML, CSS
- **Database:** MySQL
- **Server:** Apache Tomcat 10
- **Build Tool:** Maven
- **IDE:** IntelliJ IDEA

---

##  Project Structure
src/main/java
└── com.techblog
├── dao
├── entities
├── servlets
└── helper

src/main/webapp
├── css
├── WEB-INF
└── *.jsp

---

##  Setup Instructions

1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/techblog-jsp-servlet.git
Import as Maven Project in IntelliJ

Configure MySQL Database

Create database: techblog

Update DB credentials in ConnectionProvider

Deploy on Apache Tomcat 10

Run and open:
http://localhost:8080/techblog
Authentication Flow

Session-based login

Unauthorized users cannot:

Add posts

Like or comment

---

Edit/Delete others’ posts
Future Improvements

Pagination

Profile image upload

Rich text editor

AJAX for likes & comments

Author

Aakash Prasad Chaurasiya
B.Tech CSE Student
Java & Web Development Enthusiast



