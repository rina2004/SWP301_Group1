<%-- 
    Document   : ListOrder
    Created on : Mar 25, 2025, 9:22:54 AM
    Author     : tungn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border = 1>
            <tr>
                <td>ID</td>
                <td>Status</td>
                <td>Time</td>
                <td>Action</td>
            </tr>
            <c:forEach var="l" items="${list}">
                <tr>
                    <td>${l.id}</td>
                    <td>${l.status}</td>
                    <td>${l.time}</td>
                    <td><a href="<%= request.getContextPath() %>/listTicket?orderID=${l.id}">List Ticket</a></td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
