<%-- 
    Document   : home
    Created on : Mar 2, 2025, 8:57:32 PM
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
        <a href="<%= request.getContextPath() %>/logout">Log out</a>
        <a href="<%= request.getContextPath() %>/change">Change Password</a>
    </body>
</html>
