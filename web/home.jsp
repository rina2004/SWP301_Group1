<%-- 
    Document   : home
    Created on : 6 Feb 2025, 21:13:20
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
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #E3F2FD; /* Nền xanh cho toàn bộ trang */
            }

            /* Thanh điều hướng */
            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 50px;
                background: white;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .navbar .logo {
                font-size: 24px;
                font-weight: bold;
            }

            .navbar .menu {
                list-style: none;
                display: flex;
                gap: 20px;
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

            /* Phần trên nền xanh */
            .top-section {
                background: #DBF8FE;
                padding: 50px;
            }

            .container {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .text-section {
                max-width: 50%;
            }

            .text-section h1 {
                font-size: 48px;
                color: #666;
            }

            .text-section span {
                font-weight: bold;
            }

            .text-section p {
                margin: 15px 0;
                color: #333;
            }

            .book-now {
                background-color: white;
                color: #007BFF;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
                font-weight: bold;
            }

            .book-now:hover {
                background-color: #0056b3;
                color: white;
            }

            .plane-image {
                width: 50%;
                text-align: right;
            }

            .plane-image img {
                width: 90%;
                max-width: 500px;
            }

            /* Phần Top Deals */
            .top-deals {
                background-color: #FFFFFF; /* Đổi màu nền thành trắng */
                text-align: center;
                padding: 50px 20px;
            }

            .top-deals h2 {
                font-size: 32px;
                margin-bottom: 20px;
                color: #333;
            }

            .deals-container {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .deal {
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                width: 280px;
                text-align: left;
            }

            .deal img {
                width: 100%;
                border-radius: 10px;
            }

            .deal h3 {
                color: #007BFF;
                margin: 10px 0;
            }

            .deal p {
                color: #666;
            }

            .deal .book-now {
                display: block;
                text-align: center;
                margin-top: 10px;
            }

            /* Phần Contact Us */
            .contact {
                background-color: #DBF8FE;
                padding: 50px;
                text-align: center;
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
            .logo {
                display: flex;
                align-items: center;
            }

            .logo img {
                height: 1em; /* Điều chỉnh chiều cao của logo để phù hợp với kích thước chữ */
                margin-right: 8px; /* Khoảng cách giữa logo và chữ */
            }

            .logo span {
                font-size: 1em; /* Kích thước chữ */
            }

            html {
                scroll-behavior: smooth;
            }
            .auth-buttons {
                position: relative;
                display: inline-block;
            }

            .register {
                cursor: pointer;
                text-decoration: none;
                padding: 10px 15px;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                top: 100%;
                right: 0;
                background-color: white;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
                border-radius: 5px;
                min-width: 150px;
                z-index: 10;
                overflow: hidden;
            }

            .dropdown-content a,
            .dropdown-content button {
                display: block;
                width: 100%;
                padding: 10px;
                text-align: left;
                background: none;
                border: none;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none;
                color: black;
                border-bottom: 1px solid #ddd;
                font-family: inherit;
            }

            .dropdown-content button {
                width: 100%;
                text-align: left;
            }

            .dropdown-content a:hover,
            .dropdown-content button:hover {
                background-color: #f1f1f1;
            }

            /* Hiện dropdown khi có class "show" */
            .dropdown-content.show {
                display: block;
            }
        </style>
    </head>
    <body>

        <!-- Thanh điều hướng -->
        <div class="navbar">
            <div class="logo">
                <img src="img/logo.jpg" alt="Logo"/>
                ️Sky Airlines
            </div>
            <ul class="menu">
                <li><a href="view/order">Flights</a></li>
                <li><a href="blog">Blogs</a></li>
                <li><a href="#contact">Contact Us</a></li>
            </ul>
            <c:set var="session" value="${sessionScope}" />
            <c:choose>
                <c:when test="${not empty session}">
                    <div class="auth-buttons">
                        <a href="#" class="register" id="userDropdown">${username}</a>
                        <div class="dropdown-content" id="dropdownMenu">
                            <a href="profile">Profile</a>
                            <form action="logout" method="GET">
                                <button type="submit">Log out</button>
                            </form>
                        </div>
                    </div>

                    <script>
                        document.getElementById("userDropdown").addEventListener("click", function (event) {
                            event.preventDefault(); // Ngăn chặn load lại trang
                            document.getElementById("dropdownMenu").classList.toggle("show");
                        });

                        // Ẩn dropdown khi click ra ngoài
                        document.addEventListener("click", function (event) {
                            if (!event.target.closest(".auth-buttons")) {
                                document.getElementById("dropdownMenu").classList.remove("show");
                            }
                        });
                    </script>
                </c:when>
                <c:otherwise>
                    <div class="auth-buttons">
                        <a href="login" class="login">Login</a>
                        <a href="register" class="register">Register</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Phần quảng cáo -->
        <div class="top-section">
            <div class="container">
                <div class="text-section">
                    <h1>Sky Airlines: <br> Soar <span>Beyond</span> <br> <span>the Clouds</span></h1>
                    <p>Soaring High, Connecting Dreams Across the Skies</p>
                    <a href="view/order" class="book-now">Book Now</a>
                </div>
                <div class="plane-image">
                    <img src="img/art.jpg" alt="Airplane"/>
                </div>
            </div>
        </div>
        <form action="home" method="get">
            <!-- Phần Blogs -->
            <div class="top-deals">
                <h2><a href="blog" style="text-decoration: none; color: inherit">Blogs</a></h2>
                <div class="deals-container">
                    <c:forEach items="${listBlog}" var="blog">
                        <div class="deal">
                            <img src="img/${blog.getImage()}" alt="${blog.getTitle()}">
                            <div class="deal-content">
                                <h3>${blog.getTitle()}</h3>
                                <p>${blog.getDescription()}</p>
                            </div>
                            <a href="post?id=${blog.getPostID()}" class="book-now">View</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </form>

        <!-- Phần Contact -->
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
