<%-- 
    Document   : CreateNewPassword
    Created on : Mar 1, 2025, 8:55:19 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Password</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
            }
            .container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 350px;
            }
            h2 {
                margin-bottom: 20px;
                color: #333;
            }
            input {
                width: 80%;
                padding: 10px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="submit"] {
                background: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                transition: 0.3s;
            }
            input[type="submit"]:hover {
                background: #0056b3;
            }
            p {
                margin: 5px 0;
                font-size: 14px;
                color: #666;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Create New Password</h2>
            <form action="<%= request.getContextPath() %>/createpassword" method="post">
                <input type="hidden" name="email" value="<%= session.getAttribute("email") != null ? session.getAttribute("email") : ""%>">

                <p>New Password</p>
                <input type="password" name="pass" required>

                <p>Confirm Password</p>
                <input type="password" name="pass2" required>

                <input type="submit" value="Change Password">
            </form>
        </div>
    </body>
</html>
