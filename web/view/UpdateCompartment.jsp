<%-- 
    Document   : UpdateCompartment
    Created on : Mar 10, 2025, 11:39:29 AM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Compartment</title>
    </head>
    <body>
        <form action="<%= request.getContextPath() %>/updateC" method="post">
            <p>Id</p>
            <input type="text" name="id" value="${com.id}" readonly>
            <p>Name</p>
            <input type="text" name="name" value="${com.name}" readonly>
            <p>Type id</p>
            <input type="text" name="typeid" value="${com.type.id}" readonly>
            <p>Capacity</p>
            <input type="text" name="capacity" value="${com.capacity}"  required>
            <p>${errnumber}</p>
            <input type="submit" value="Update">
        </form>
    </body>
</html>
