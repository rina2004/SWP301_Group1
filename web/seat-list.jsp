<%-- 
    Document   : seat-list
    Created on : 26 Mar 2025, 07:49:02
    Author     : A A
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seat List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Seat List</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Seat ID</th>
                    <th>Compartment ID</th>
                    <th>Airplane ID</th>
                    <th>Flight Name</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="seat" items="${seats}">
                    <tr>
                        <td>${seat.id}</td>
                        <td>${seat.compartment.id}</td>
                        <td>${seat.compartment.airplane.id}</td>
                        <td>${seat.compartment.airplane.flight.name}</td>
                        <td>${seat.status}</td>
                        <td>
                            <a href="seat-details?seatId=${seat.id}" class="btn btn-primary btn-sm">View Details</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>