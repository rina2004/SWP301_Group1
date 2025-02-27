<%-- 
    Document   : register
    Created on : Feb 6, 2025, 1:07:51 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-image: url("https://lh3.googleusercontent.com/proxy/S782oOblKcArzT7gXscDzp_MOZnAujSFvOXperK220PC14k1B9ablYr_LlnyKVQTiXdw8SK6nv9mrdmS2u5xS3prPva70afikwnyzTn2qHhnO9mgTw7HQ9M");
                background-repeat: no-repeat;
                background-size: cover;
                height: 100vh;
                width: 100vw;
                display: flex;
                justify-content: center; 
                align-items: center; 
                overflow: hidden; 
            }

            form {
                background: rgba(255, 255, 255, 0.2); 
                padding: 20px;
                border-radius: 10px;
                backdrop-filter: blur(5px);
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                width: 280px;
                text-align: center;
            }

            input {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                border: none;
                border-radius: 5px;
            }

            input[type="submit"] {
                background: #ff6600;
                color: white;
                cursor: pointer;
            }

            p {
                font-weight: bold;
                color: black;
            }
            a:hover{
                color: activecaption;
            }
            a:active{
                color: burlywood;
            }
        </style>


    </head>
    <body>
        <form action="register" method="post">
            <div>
                <p>Username</p>
                <input type="text" name="username" required="" placeholder="Enter your username">
                <p>Password</p>
                <input type="password" name="pass" required="" placeholder="Enter your password">
                <p>Confirm Password</p>
                <input type="password" name="pass2" required="" placeholder="Confirm Password">
                <p>Full Name</p>
                <input type="text" name="name" required="" >
                <p>Date of Birth</p>
                <input type="date" name="dob" required="" >
                <p>Phone</p>
                <input type="text" name="phone" required="">
                <p>Address</p>
                <input type="text" name="address" required="">
                <p>Email</p>
                <input type="text" name="email" required=""><br><br>
                <input type="submit" value="Register">
                <p>If you have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </form>
    </body>
</html>
