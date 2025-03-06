<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            *{
                padding: 0px;
                margin: 0px;
                box-sizing: border-box;
            }
            body{
                display: flex;
                height: 100%;
                background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20221121/pngtree-large-passenger-airplane-boeing-fuselage-blue-photo-image_7404058.jpg");
                background-repeat: no-repeat;
                background-size: cover;
                justify-content: center;
                align-items: center;
            }

            input{
                border-radius: 5px;
                padding: 10px;
                margin: 10px;
            }
            .all {
                display: flex;
                width: 600px;
                background: hsla(205, 100%, 60%, 0.5);
                padding: 20px;
                border-radius: 10px;
                color: black;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
                margin-top: 180px;
                font-size: 15px;
            }

            .left, .right {
                flex: 1;
                padding: 20px;
                text-align: center;
            }
            .left{
                margin: 10px;
            }
            .left img{
                width: 60%;

            }
            .right input {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                border: none;
                border-radius: 5px;
            }

            .right input[type="submit"] {
                background: #ff6600;
                color: black;
                cursor: pointer;
            }
            a:hover{
                color: blue;
            }
            a:active{
                color: aqua;
            }

        </style>
    </head>
    <body>
        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="all">
                <div class="left">
                    <img alt="logo" src="img/logo1.jpg">
                    <p>Don't have an account?</p>
                    <a href="Register.jsp">Register here</a>
                </div>

                <div class="right">
                    <p>Username</p>
                    <input type="text" name="username" required="" placeholder="Enter your username">
                    <p>Password</p>
                    <input type="password" name="password" required="" placeholder="Enter your password"><br>
                    <a href="ResetPassword.jsp">Forgot Password</a>
                    <p>${error}</p>
                    <input type="submit" value="Login">
                    <p>${error}</p>
                </div>
            </div>
        </form>
    </body>
</html>