<%-- 
    Document   : ListCompartment
    Created on : Mar 10, 2025, 9:24:25 AM
    Author     : tungn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Compartment</title>
    </head>
    <body>
            <table border = "1">
                <tr>
                    <td>Id</td>
                    <td>Name</td>
                    <td>Type Id</td>
                    <td>Capacity</td>
                    <td>Action</td>
                </tr>
                <c:forEach var="list" items="${list}">
                    <tr>
                        <td>${list.id}</td>
                        <td>${list.name}</td>
                        <td>${list.type.id}</td>
                        <td>${list.capacity}</td>
                        <td>
                            <a href="<%= request.getContextPath() %>/crseat?id=${list.id}&typeid=${list.type.id}">Create Seat</a><br>
                            <a href="">List Seat</a><br>
                            <a href="<%= request.getContextPath() %>/updateC?id=${list.id}&type=${list.type.id}">Update Compartment</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
    </body>
</html>
