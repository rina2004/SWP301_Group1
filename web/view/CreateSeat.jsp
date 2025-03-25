<%-- 
    Document   : CreateSeat
    Created on : Mar 9, 2025, 1:30:44 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Seat</title>
    </head>
    <body>
        <form action="crseat" method="post">
            <input type="hidden" name="id" value="${com.id}"><br>
            <input type="hidden" name="typeid" value="${com.type.id}">
            <p>Compartment Name</p>
            <input type="text" name="name" value="${com.name}" readonly>
            <p>Type Name</p>
            <input type="text" name="typeName" value="${com.type.name}" readonly>
            <p>Capacity</p>
            <input type="text" name="capacity" value="${com.capacity}" readonly>
            <p>${error}</p>
            <p>Seat Id</p>
            <input type="text" name="seatid" value="" required>
            <p>${errordata}</p>
            <p>Available</p>
            <select name="available">
                <option value="true">Available</option>
                <option value="false">Occupied</option>
            </select>
            <input type="submit" value="Create">
        </form>
    </body>
</html>
