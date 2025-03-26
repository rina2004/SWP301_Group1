<%-- 
    Document   : ResetPassword
    Created on : Mar 1, 2025, 8:32:24 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            }

            .container {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                width: 350px;
                text-align: center;
            }

            h2 {
                margin-bottom: 15px;
                color: #333;
            }

            p {
                font-size: 14px;
                color: #666;
                margin-bottom: 10px;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                outline: none;
                transition: 0.3s;
            }

            input[type="text"]:focus {
                border-color: #74ebd5;
                box-shadow: 0 0 5px rgba(116, 235, 213, 0.5);
            }

            .error-message {
                color: red;
                font-size: 13px;
                margin-bottom: 10px;
            }

            input[type="submit"] {
                width: 100%;
                background: #74ebd5;
                border: none;
                padding: 10px;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
            }

            input[type="submit"]:hover {
                background: #57c1af;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Quên Mật Khẩu</h2>
            <p>Vui lòng nhập email của bạn để đặt lại mật khẩu.</p>
            <form action="<%= request.getContextPath() %>/resetpassword" method="post">
                <input type="text" name="email" placeholder="Nhập email của bạn" required>
                <p class="error-message">${error}</p>
                <input type="submit" value="Tiếp Tục">
            </form>
        </div>

    </body>
</html>

