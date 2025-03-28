<%-- 
    Document   : staff_sidebar
    Created on : 19 Mar 2025, 20:23:30
    Author     : Rinaaaa
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Sidebar Example</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            /* Để trang chiếm toàn bộ chiều cao trình duyệt */
            html, body {
                height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* Header */
            header {
                background: #E3F2FD;
                color: #0D47A1;
                text-align: center;
                padding: 15px;
                font-size: 24px;
                font-weight: bold;
                border-bottom: 3px solid #BBDEFB;
            }

            /* Wrapper chứa sidebar và nội dung */
            .wrapper {
                display: flex;
                flex: 1;
                height: 100%;
            }

            /* Sidebar */
            .sidebar {
                width: 250px;
                background: #E3F2FD;
                color: #0D47A1;
                height: 100%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                border-right: 3px solid #BBDEFB;
            }

            .sidebar h2 {
                margin-bottom: 20px;
                font-size: 20px;
                text-align: center;
                font-weight: bold;
            }

            .sidebar a {
                display: block;
                color: #0D47A1;
                text-decoration: none;
                padding: 12px;
                margin-bottom: 8px;
                background: #BBDEFB;
                border-radius: 5px;
                text-align: center;
                font-weight: bold;
                transition: 0.3s;
            }

            .sidebar a:hover {
                background: #90CAF9;
                transform: scale(1.05);
            }

            /* Nội dung chính */
            .content {
                flex: 1;
                padding: 20px;
                overflow-y: auto; /* Thêm thanh cuộn nếu nội dung dài */
            }
        </style>
        <script>
            function loadPage(page) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "admin-sidebar?page=" + page, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        document.getElementById("content").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }
        </script>
    </head>
    <body>
        <header>
            Admin Home Page
        </header>
        <div class="wrapper">
            <!-- Sidebar -->
            <div class="sidebar">
                <h2>Menu</h2>
                <a onclick="loadPage('account-list')">Manage Account</a>
            </div>

            <!-- Nội dung động -->
            <div class="content" id="content">
                <h2>Chào mừng!</h2>
                <p>Chọn một mục từ menu để hiển thị nội dung.</p>
            </div>
        </div>
    </body>
</html>
