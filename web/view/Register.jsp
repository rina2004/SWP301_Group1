<%-- 
    Document   : Register
    Created on : Feb 28, 2025, 2:34:26 PM
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
        <form action="<%= request.getContextPath() %>/register" method="post">
            <div>
                <p>Username</p>
                <input type="text" name="username" required="" value="<%= session.getAttribute("username") != null ? session.getAttribute("username") : "" %>" placeholder="Enter your username">
                <p>${errorUsername}</p>
                <p>Password</p>
                <input type="password" name="pass" required="" value="<%= session.getAttribute("pass") != null ? session.getAttribute("pass") : "" %>" placeholder="Enter your password">
                <p>Confirm Password</p>
                <input type="password" name="pass2" required="" value="<%= session.getAttribute("pass2") != null ? session.getAttribute("pass2") : "" %>" placeholder="Confirm Password">
                <p>${errorPassword}</p>
                <p>Full Name</p>
                <input type="text" name="name" required="" value="<%= session.getAttribute("name") != null ? session.getAttribute("name") : "" %>" placeholder="Enter your fullname">
                <p>Date of Birth</p>
                <input type="date" name="dob" value="<%= session.getAttribute("dob") != null ? session.getAttribute("dob") : "" %>"required>
                <p>Phone</p>
                <input type="text" name="phone" required="" value="<%= session.getAttribute("phone") != null ? session.getAttribute("phone") : "" %>" placeholder="Enter your phone">
                <p>Address</p>
                <input type="text" name="address" required="" value="<%= session.getAttribute("address") != null ? session.getAttribute("address") : "" %>" placeholder="Enter your address">
                <p>Email</p>
                <input type="text" name="email" required="" value="<%= session.getAttribute("email") != null ? session.getAttribute("email") : ""%>" placeholder="Enter your email">
                <p>${errorEmail}</p><br><br>
                <input type="submit" value="Register">
                <p>If you have an account? <a href="<%= request.getContextPath() %>/login">Login here</a></p>
            </div>
        </form>
    </body>
</html>
