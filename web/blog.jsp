<%-- 
    Document   : blog
    Created on : 10 Feb 2025, 08:16:00
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
                background: #E3F2FD;
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
                flex-direction: column;
                align-items: center;
                gap: 20px;
            }

            .deal {
                display: flex;
                align-items: center;
                width: 80%; /* Kéo dài theo chiều ngang */
                max-width: 800px; /* Giới hạn chiều rộng */
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .deal img {
                width: 200px; /* Kích thước cố định cho ảnh */
                height: 120px; /* Đảm bảo tỷ lệ đẹp */
                border-radius: 10px;
                object-fit: cover;
                margin-right: 15px;
            }

            .deal-content {
                flex: 1;
            }

            .deal h3 {
                color: #007BFF;
                margin-bottom: 5px;
            }

            .deal p {
                color: #666;
            }

            .deal .book-now {
                display: inline-block;
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
            ul {
                padding: 0;
                list-style: none;
            }
            li {
                display: inline-block; /* Hoặc display: inline; */
                margin-right: 10px; /* Khoảng cách giữa các mục */
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
            .pagination {
                text-align: center;
                margin-top: 20px;
            }

            .pagination ul {
                list-style: none;
                padding: 0;
                display: flex;
                justify-content: center;
                gap: 8px;
            }

            .pagination li {
                display: inline-block;
            }

            .pagination a {
                display: block;
                padding: 8px 12px;
                border: 1px solid #007bff;
                border-radius: 5px;
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #007bff;
                color: white;
            }

            .pagination a.active {
                background-color: #007bff;
                color: white;
                pointer-events: none;
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
                <li><a href="view/order">Flights</a></li>
                <li><a href="blog">Blogs</a></li>
                <li><a href="#contact">Contact Us</a></li>
            </ul>
            <c:set var="session" value="${sessionScope}" />
            <c:choose>
                <c:when test="${not empty session}">
                    <div class="auth-buttons">
                        <a href="#" class="register" id="userDropdown">${user}</a>
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

        <!-- Phần Blogs -->
        <div class="top-deals">
            <h2><a href="blog" style="text-decoration: none; color: inherit">Blogs</a></h2>
            <!-- Thanh tìm kiếm -->
            <form action="blog" method="get" style="margin-bottom: 30px;">
                <input 
                    type="text" 
                    name="search"
                    placeholder="Searching blogs..."
                    value="${searchQuery}"
                    style="padding: 10px; width: 80%; max-width: 600px; border: 1px solid #ccc; border-radius: 5px;" 
                    >
                <input 
                    type="submit"
                    value="Search"
                    style="padding: 10px 20px; background-color: #007BFF; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer;"
                    >
            </form>
            <c:forEach items="${listBlog}" var="blog">
                <div class="deals-container">
                    <div class="deal">
                        <img src="img/${blog.getImage()}" alt="${blog.getTitle()}">
                        <div class="deal-content">
                            <h3>${blog.getTitle()}</h3>
                            <p>${blog.getDescription()}</p>
                        </div>
                        <a href="post?id=${blog.getPostID()}" class="book-now">View</a>
                    </div>
                </div>
            </c:forEach>
            <div class="pagination">
                <ul>
                    <c:forEach begin="1" end="${pageControl.getTotalPage()}" var="pageNumber">
                        <li>
                            <c:choose>
                                <c:when test="${pageNumber == pageControl.getPage()}">
                                    <a href="${pageControl.getUrlPattern()}page=${pageNumber}" class="active">${pageNumber}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageControl.getUrlPattern()}page=${pageNumber}">${pageNumber}</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
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
