<%-- 
    Document   : blog-manage
    Created on : Mar 24, 2025, 3:03:20 PM
    Author     : DUCDA
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                justify-content: center; /* Căn giữa nội dung */
                align-items: center;
                padding: 15px 50px;
                background: #E3F2FD;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* Phần Top Deals */
            .top-deals {
                background-color: #FFFFFF;
                text-align: center;
                padding: 50px 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .top-deals h2 {
                font-size: 32px;
                margin-bottom: 20px;
                color: #333;
                text-align: left;
            }

            .top-deals form {
                text-align: center;
                width: 80%;
                max-width: 600px;
            }

            .deals-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 20px;
                width: 80%;
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
                padding: 10px 20px; /* Đảm bảo kích thước đồng nhất */
                background-color: #007BFF;
                color: white;
                font-weight: bold;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease, transform 0.2s ease;
                border: none;
                cursor: pointer;
                text-align: center;
                width: 100px; /* Cố định kích thước */
            }

            .deal .book-now:hover {
                background-color: #0056b3;
                transform: scale(1.05);
            }

            .deal .book-now:active {
                transform: scale(0.95);
            }

            .deal-buttons {
                display: flex;
                gap: 3px; /* Tạo khoảng cách giữa các nút */
            }

            html {
                scroll-behavior: smooth;
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
            /* Căn chỉnh thanh tìm kiếm và nút mới */
            .search-container {
                display: flex;
                justify-content: flex-end; /* Đẩy về bên phải */
                gap: 10px; /* Tạo khoảng cách giữa các phần tử */
                width: 1000%;
            }

            .search-container input[type="text"] {
                padding: 10px;
                width: 60%;
                max-width: 500px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .search-container input[type="submit"],
            .search-container .new-page-btn {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
                text-align: center;
            }

            .search-container input[type="submit"] {
                background-color: #007BFF;
                color: white;
            }

            .search-container .new-page-btn {
                background-color: #28a745;
                color: white;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <!-- Thanh điều hướng -->
        <div class="navbar">
            <h1>Manage Blogs</h1>
        </div>

        <!-- Phần Blogs -->
        <div class="top-deals">
            <h2><a href="blog" style="text-decoration: none; color: inherit">Blogs</a></h2>
            <!-- Thanh tìm kiếm -->
            <form action="blog-manage" method="get" class="search-container" style="margin-bottom: 30px;">
                <input 
                    type="text" 
                    name="search"
                    placeholder="Searching blogs..."
                    value="${searchQuery}"
                    >
                <input 
                    type="submit"
                    value="Search"
                    >
                <a href="addblog" class="new-page-btn">Add new blog</a>
            </form>
            <c:forEach items="${listBlog}" var="blog">
                <div class="deals-container">
                    <div class="deal">
                        <img src="img/${blog.getImage()}" alt="${blog.getTitle()}">
                        <div class="deal-content">
                            <h3>${blog.getTitle()}</h3>
                            <p>${blog.getDescription()}</p>
                        </div>
                        <div class="deal-buttons">
                            <a href="updateblog?id=${blog.getPostID()}" class="book-now">Edit</a>
                            <form action="blog-manage" method="post" onsubmit="return confirm('Are you sure you want to delete this blog?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="blogTitle" value="${blog.getTitle()}">
                                <input type="submit" class="book-now" value="Delete">
                            </form>
                        </div>
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
    </body>
</html>
