<%-- 
    Document   : Home
    Created on : Mar 2, 2025, 9:22:58 PM
    Author     : anhbu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>This is home page</h1>
        <form action="<%= request.getContextPath() %>/logout" method="get">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <form action="<%= request.getContextPath() %>/profile" method="get">
            <button type="submit" class="logout-btn">Profile</button>
        </form>
         <p>Xin chào: ${sessionScope.username}</p>
    </body>
</html>
