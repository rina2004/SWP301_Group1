<%-- 
    Document   : post
    Created on : 4 Mar 2025, 05:05:28
    Author     : DUCDA
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/png" href="img/logo.jpg">
        <title>Sky Airlines</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: Arial, sans-serif;
            }
            /* Thanh điều hướng */
            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 50px;
                background: #E3F2FD;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }
            .navbar .logo {
                font-size: 24px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }
            .navbar .logo img {
                height: 30px;
                margin-right: 10px;
            }
            .navbar .menu {
                list-style: none;
                display: flex;
                gap: 20px;
            }
            .navbar .menu li {
                display: inline;
            }
            .navbar .menu a {
                text-decoration: none;
                color: black;
                font-weight: bold;
                transition: 0.3s;
            }
            .navbar .menu a:hover {
                color: #007BFF;
            }
            .auth-buttons {
                display: flex;
                gap: 10px;
            }
            .auth-buttons a {
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 5px;
                font-weight: bold;
                transition: 0.3s;
            }
            .login {
                background-color: #007BFF;
                color: white;
            }
            .signup {
                background-color: #E3F2FD;
                border: 1px solid #007BFF;
                color: #007BFF;
            }
            .auth-buttons a:hover {
                opacity: 0.8;
            }
            /* Nội dung chính */
            .container {
                width: 60%;
                margin: 20px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .comments {
                width: 100%;
                border: 2px solid black;
                border-radius: 10px;
                padding: 15px;
                margin-top: 20px;
                text-align: center;
            }
            .main-post {
                width: 100%;
                border: 2px solid black;
                border-radius: 10px;
                padding: 15px;
                margin-top: 20px;
                text-align: left; /* Căn trái */
            }
            .main-post img {
                width: 60%;  /* Giảm kích thước ảnh */
                max-height: 400px; /* Giới hạn chiều cao */
                border-radius: 5px;
                margin-top: 10px;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
            .comments {
                text-align: left;
            }
            .comment-box {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            .comment-content {
                background: #f0f2f5;
                padding: 10px;
                border-radius: 15px;
                max-width: 80%;
            }
            .like {
                color: red;
                cursor: pointer;
            }
            /* Phần Contact Us */
            .contact {
                background-color: #DBF8FE;
                padding: 50px;
                text-align: center;
                margin-top: 50px;
            }
            .contact h2 {
                font-size: 32px;
                margin-bottom: 20px;
                color: #333;
            }
            .contact-info {
                display: flex;
                justify-content: center;
                gap: 40px;
                flex-wrap: wrap;
            }
            .contact-item {
                text-align: center;
                max-width: 250px;
            }
            .contact-item h3 {
                color: #007BFF;
                margin-bottom: 10px;
            }
            .contact-item p {
                color: #666;
            }
        </style>
    </head>
    <body>
        <!-- Thanh điều hướng -->
        <div class="navbar">
            <div class="logo">
                <a href="home" style="text-decoration: none; color: inherit">
                    <img src="img/logo.jpg" alt="Logo" />
                    ️Sky Airlines
                </a>
            </div>
            <ul class="menu">
                <li><a href="flights">Flights</a></li>
                <li><a href="#">Deals</a></li>
                <li><a href="blog">Blogs</a></li>
                <li><a href="#contact">Contact Us</a></li>
            </ul>
            <div class="auth-buttons">
                <a href="login" class="login">Login</a>
                <a href="register" class="register">Register</a>
            </div>
        </div>

        <!-- Phần nội dung chính -->
        <div class="container">
            <div class="main-post">
                <h2>${post.getTitle()}</h2>
                <p>${post.getContent()}</p>
                <img src="img/${post.getImage()}" alt="${post.getTitle()}">
            </div>

            <div class="comments">
                <span class="like">❤️ 10</span>
                <h3>Comments</h3>
                <c:forEach items="${listCmt}" var="cmt">
                    <div class="comment-box">
                        <div class="comment-content">
                            <strong>${cmt.getAccount()}</strong>
                            <p>${cmt.getContent()}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Phần Contact Us -->
        <div class="contact" id="contact">
            <h2>Contact Us</h2>
            <div class="contact-info">
                <div class="contact-item">
                    <h3>Address</h3>
                    <p>Ha Noi, Vietnam</p>
                </div>
                <div class="contact-item">
                    <h3>Email</h3>
                    <p>support@skyairlines.com</p>
                </div>
                <div class="contact-item">
                    <h3>Phone</h3>
                    <p>+84 123456789</p>
                </div>
            </div>
        </div>
    </body>
</html>


