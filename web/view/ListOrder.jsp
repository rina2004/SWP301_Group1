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
        <title>List Order</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .table-container {
                max-width: 900px;
                margin: 50px auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .table th {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container table-container">
            <h2 class="text-center mb-4">Ticket Orders</h2>
            <table class="table table-hover text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Status</th>
                        <th>Time</th>
                        <th>Final Price</th>
                        <th>Final Number</th>
                        <th>Type</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="l" items="${list}">
                        <tr>
                            <td>${l.id}</td>
                            <td>${l.status}</td>
                            <td>${l.time}</td>
                            <td>${l.finalPrice}</td>
                            <td>${l.finalNum}</td>
                            <td>${l.tt.type}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/orderPassengerCheckIn?id=${l.id}" class="btn btn-success btn-sm">List Order Passenger</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
