<%-- 
    Document   : seat-details
    Created on : 26 Mar 2025, 07:49:32
    Author     : A A
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seat Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Seat Details</h2>
        <div class="card">
            <div class="card-header">
                <h3>Seat Information</h3>
            </div>
            <div class="card-body">
                <p><strong>Seat ID:</strong> ${seat.id}</p>
                <p><strong>Compartment ID:</strong> ${seat.compartment.id}</p>
                <p><strong>Airplane ID:</strong> ${seat.compartment.airplane.id}</p>
                <p><strong>Flight Name:</strong> ${seat.compartment.airplane.flight.name}</p>
                <p><strong>Seat Status:</strong> ${seat.status}</p>
            </div>
        </div>

        <div class="card mt-4">
            <div class="card-header">
                <h3>Account Information</h3>
            </div>
            <div class="card-body">
                <p><strong>Name:</strong> ${account.name}</p>
                <p><strong>Email:</strong> ${account.email}</p>
                <p><strong>Phone:</strong> ${account.phone}</p>
            </div>
        </div>

        <div class="card mt-4">
            <div class="card-header">
                <h3>Passenger Information</h3>
            </div>
            <div class="card-body">
                <p><strong>Full Name:</strong> ${orderPassenger.fullName}</p>
                <p><strong>Date of Birth:</strong> ${orderPassenger.dob}</p>
                <p><strong>Nationality:</strong> ${orderPassenger.nation.name}</p>
            </div>
        </div>
    </div>
</body>
</html>