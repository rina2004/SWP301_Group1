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
        <title>JSP Page</title>
    </head>
    <body>
        <form>
            <p>Old Password</p>
            <input type="password" name="oldpass" required="">
            <p>New Password</p>
            <input type="password" name="newpass" required=""> 
            <p>Confirm Password</p>
            <input type="password" name="confirm" required=""><br><br>
            <input type="submit" value="Update Password">
        </form>
    </body>
</html>
