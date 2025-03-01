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
    </head>
    <body>
        <form action="<%= request.getContextPath() %>/createpassword" method="post">
            <input type="hidden" name="email" value="">
            <p>New Password</p>
            <input type="text" name="pass" required>
            <p>Confirm Password</p>
            <input type="text" name="pass2" required>
            <input type="submit" value="Change Password">
        </form>
    </body>
</html>
