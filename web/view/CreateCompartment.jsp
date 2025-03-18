<%-- 
    Document   : CreateCompartment
    Created on : Mar 9, 2025, 1:30:37 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Compartment</title>
    </head>
    <body>
        <form action="<%= request.getContextPath() %>/createCompartment" method="post">
            <p>Id</p>
            <input type="text" name="id" required>
            <p>${error}</p>
            <p>Name</p>
            <input type="text" name="name" required>
            <p>${existed}</p>
            <p>Type id</p>
            <input type="text" name="typeid" value="${typeID}" required>
            <p>Capacity</p>
            <input type="text" name="capacity" required>
            <p>${errnumber}</p>
            <input type="submit" value="Create">
        </form>
    </body>
</html>
