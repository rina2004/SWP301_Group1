<%-- 
    Document   : ChangePassword
    Created on : Mar 1, 2025, 8:32:04 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
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
                margin-bottom: 15px;
                color: #333;
            }
            input {
                width: 90%;
                padding: 10px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="submit"] {
                background: #28a745;
                color: white;
                border: none;
                cursor: pointer;
                transition: 0.3s;
            }
            input[type="submit"]:hover {
                background: #218838;
            }
            p {
                margin: 5px 0;
                font-size: 14px;
                color: #666;
            }
            .error {
                color: red;
                font-size: 14px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Change Password</h2>
            <form action="change" method="post">
                <p>Old Password</p>
                <input type="password" name="oldpass" required>

                <p>New Password</p>
                <input type="password" name="newpass" required> 

                <p>Confirm Password</p>
                <input type="password" name="confirm" required>

                <p class="error">${error}</p>

                <input type="submit" value="Update Password">
            </form>
        </div>

    </body>
</html>
