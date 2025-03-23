<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <title>Order History</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
            .btn {
                padding: 6px 12px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <h2>My Orders</h2>

        <c:if test="${empty orders}">
            <p>You have no orders yet.</p>
        </c:if>

        <c:if test="${not empty orders}">
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Flight Name</th>
                    <th>Departure Date</th>
                    <th>Landing Date</th>
                    <th>Tickets</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.flightName}</td>
                        <td>${order.departureDate}</td>
                        <td>${order.landingDate}</td>
                        <td>${order.ticketCount}</td>
                        <td>${order.status}</td>
                        <td>
                            <a class="btn" href="history-detail?orderId=${order.id}">View</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <a href="view/Home.jsp">Back to Home</a>
    </body>
</html>
