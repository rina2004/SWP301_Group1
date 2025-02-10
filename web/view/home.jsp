<%--
Document : home
Created on : 9 Feb 2025, 00:47:02
Author : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            h1 {
                font-size: 32px;
                color: #333;
                margin-bottom: 20px;
            }
            button {
                padding: 15px 30px;
                font-size: 18px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }
            button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>

    <body>
        <h1>Welcome Tay Chơi Số 1!</h1>
        <button onclick="window.location.href = 'list-flight'">Manage Flights</button>
    </body>

</html>
