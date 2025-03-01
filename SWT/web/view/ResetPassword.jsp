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
        <title>Forget Password</title>
    </head>
    <body>
        <form action="<%= request.getContextPath() %>/resetpassword" method="post">
            <p>Enter Email</p>
            <input type="text" name="email" required><br><br>
            <input type="submit" value="Continue">
        </form>
    </body>
</html>
