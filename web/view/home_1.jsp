<%-- 
    Document   : home
    Created on : Mar 2, 2025, 8:57:32 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        p {
            font-size: 18px;
            font-weight: bold;
        }
        .nav-links {
            margin-top: 20px;
        }
        .nav-links a {
            display: inline-block;
            margin: 10px;
            padding: 10px 15px;
            text-decoration: none;
            color: white;
            background: #007BFF;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .nav-links a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <p>Xin chào: ${sessionScope.username}</p>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/logout">Log out</a>
            <a href="<%= request.getContextPath() %>/change">Change Password</a>
            <a href="<%= request.getContextPath() %>/listOrders">List Order</a>
            <a href="<%= request.getContextPath() %>/listLuggage?id=${sessionScope.Accid}">List Luggage</a>
        </div>
    </div>
</body>
</html>

