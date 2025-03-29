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
                padding: 30px;
                font-size: 24px;
                font-weight: bold;
                border-bottom: 3px solid #BBDEFB;
                position: relative;
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
            .container {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 20px;
                gap: 20px;
            }
            .link-box {
                width: 45%; /* Chiếm 45% chiều rộng màn hình để có 2 thẻ trên 1 dòng */
                height: 30vh; /* Lớn hơn, khoảng 1/5 màn hình */
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 15px;
                text-decoration: none;
                color: #0D47A1;
                font-size: 24px;
                font-weight: bold;
                background-color: #E3F2FD; /* Màu giống header */
                border: 2px solid #BBDEFB;
                transition: 0.3s;
            }
            .link-box:hover {
                background-color: #BBDEFB;
                transform: scale(1.05);
            }
            .auth-buttons {
                position: absolute;
                left: 600px; /* Đẩy về bên phải */
                top: 50%;
                transform: translateY(-50%);
                display: flex;
                gap: 10px;
                position: relative;
                display: inline-block;
            }

            .auth-buttons a {
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 5px;
                font-weight: bold;
                transition: 0.3s;
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
        <script>
            function loadPage(page) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "staff-sidebar?page=" + page, true);
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
            Staff Home Page
            <div class="auth-buttons">
                <a href="#" class="register" id="userDropdown">${user}</a>
                <div class="dropdown-content" id="dropdownMenu">
                    <a href="profile">Profile</a>
                    <form action="logout" method="GET">
                        <button type="submit">Log out</button>
                    </form>
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
            </div>
        </header>
        <!--        <div class="wrapper">
                     Sidebar 
                    <div class="sidebar">
                        <h2>Menu</h2>
                        <a onclick="loadPage('staffTicketProcessing')">Ticket Processing</a>
                        <a onclick="loadPage('blog-manage')">Manage Blog</a>
                        <a onclick="loadPage('airplane/view')">Manage Airplane</a>
                    </div>
        
                     Nội dung động 
                    <div class="content" id="content">
                        <h2>Chào mừng!</h2>
                        <p>Chọn một mục từ menu để hiển thị nội dung.</p>
                    </div>
                </div>-->
        <div class="container">
            <a href="staffTicketProcessing" class="link-box">Ticket Processing</a>
            <a href="blog-manage" class="link-box">Manage Blog</a>
            <a href="airplane/view" class="link-box">Manage Airplane</a>
        </div>
    </body>
</html>